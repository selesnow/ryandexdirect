yadirGetReport <- function(ReportType = "CAMPAIGN_PERFORMANCE_REPORT", 
                           DateRangeType = "LAST_MONTH", 
                           DateFrom = NULL, 
                           DateTo = NULL, 
                           FieldNames = c("CampaignName","Impressions","Clicks","Cost"), 
                           FilterList = NULL,
                           IncludeVAT = "NO",
                           IncludeDiscount = "NO",
                           Login = NULL,
                           Token = NULL){
  
  #Запуск таймера начала работы функции
  proc_start <- Sys.time()
  #Форммируем список полей
  Fields <- paste0("<FieldNames>",FieldNames, "</FieldNames>", collapse = "")
  
  #Формируем фильтр
  if(!is.null(FilterList)){
    fil_list <- NA
    filt <- FilterList
    for(fil in filt){
      fil_list <- paste0(fil_list[!is.na(fil_list)],
                         paste0("<Filter>",
                                paste0("<Field>",strsplit(fil ," ")[[1]][1], "</Field>"),
                                paste0("<Operator>",strsplit(fil ," ")[[1]][2], "</Operator>"),
                                paste0("<Values>",strsplit(fil ," ")[[1]][3], "</Values>"),"</Filter>"))
    }}
  
  #Формируем тело запроса
  queryBody <- paste0('
                      <ReportDefinition xmlns="http://api.direct.yandex.com/v5/reports">
                      <SelectionCriteria>',
                      ifelse(DateRangeType == "CUSTOM_DATE",paste0("<DateFrom>",DateFrom,"</DateFrom>","<DateTo>",DateTo,"</DateTo>") ,"" ),
                      ifelse(is.null(FilterList),"",fil_list),
                      '
                      </SelectionCriteria>',
                      Fields,'
                      <ReportName>',paste0("MyReport ", Sys.time()),'</ReportName>
                      <ReportType>',ReportType,'</ReportType>
                      <DateRangeType>',DateRangeType ,'</DateRangeType>
                      <Format>TSV</Format>
                      <IncludeVAT>',IncludeVAT,'</IncludeVAT>
                      <IncludeDiscount>',IncludeDiscount,'</IncludeDiscount>
                      </ReportDefinition>')
  
  #Создаём результирующий dataframe
  result <- data.frame()
 
  for(login in Login){
    #Выодим сообщение о том какой проект в работе
    packageStartupMessage("-----------------------------------------------------------")
    packageStartupMessage(paste0("Загрузка данных по ",login))
    #Отправляем запрос на сервер Яндекса
    #Фиксируем время начала ожидания ответа
    serv_start_time <- Sys.time()
    
    answer <- POST("https://api.direct.yandex.com/v5/reports", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru", skipReportHeader = "true" ,skipReportSummary = "true" , 'Client-Login' = login, returnMoneyInMicros = "false", processingMode = "auto"))
    
    if(answer$status_code == 400){
      packageStartupMessage(paste0(login," - ",xml_text(content(answer, "parsed","text/xml",encoding = "UTF-8"))))
      packageStartupMessage("Ошибка в параметрах запроса либо превышено ограничение на количество запросов или отчетов в очереди. В этом случае проанализируйте сообщение об ошибке, скорректируйте запрос и отправьте его снова.")
      next
    }
    
    if(answer$status_code == 500){
      packageStartupMessage(paste0(login," - ",xml_text(content(answer, "parsed","text/xml",encoding = "UTF-8"))))
      packageStartupMessage("При формировании отчета произошла ошибка на сервере. Если для этого отчета ошибка на сервере возникла впервые, попробуйте сформировать отчет заново. Если ошибка повторяется, обратитесь в службу поддержки.")
      next
    }
    
    if(answer$status_code == 201){
      packageStartupMessage("Отчет успешно поставлен в очередь на формирование в режиме офлайн.", appendLF = T)
      packageStartupMessage("Proccesing", appendLF = F)
      packageStartupMessage("|", appendLF = F)
    }
    
    if(answer$status_code == 202){
      packageStartupMessage("Формирование отчета еще не завершено.", appendLF = F)
    }
    
    
    while(answer$status_code != 200){
      answer <- POST("https://api.direct.yandex.com/v5/reports", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru", skipReportHeader = "true" ,skipReportSummary = "true" , 'Client-Login' = login, returnMoneyInMicros = "false", processingMode = "auto"))
      packageStartupMessage("=", appendLF = F)
      if(answer$status_code == 500){
        stop("При формировании отчета произошла ошибка на сервере. Если для этого отчета ошибка на сервере возникла впервые, попробуйте сформировать отчет заново. Если ошибка повторяется, обратитесь в службу поддержки.")
      }
      if(answer$status_code == 502){
        stop("Время обработки запроса превысило серверное ограничение.")
      }
      Sys.sleep(5)
    }
    packageStartupMessage("|", appendLF = T)
    #Сообщаем что отчёт был сформирован.
    server_time <- round(difftime(Sys.time(), serv_start_time , units ="secs"),0)
    packageStartupMessage("Отчет успешно сформирован и передан в теле ответа.", appendLF = T)
    packageStartupMessage(paste0("Время ожидания ответа от сервера: ",server_time , " сек."), appendLF = T)
    
    #Фиксируем время начала парсинга ответа
    pasr_start_time <- Sys.time()
    
    if(answer$status_code == 200){
      df_new <- suppressMessages(content(answer,  "parsed", "text/tab-separated-values", encoding = "UTF-8"))

      #Проверка вернулись ли какие то данные
      if(nrow(df_new) == 0){
        packageStartupMessage("Ваш запрос не вернул никаких данных, внимательно проверьте заданный фильтр и период отч та, после чего повторите попытку.")
        next
      }
      #Сообщаем о том сколько времени длился парсинг результата
      parsing_time <- round(difftime(Sys.time(), pasr_start_time , units ="secs"),0)
      packageStartupMessage(paste0("Время парсинга результата: ", parsing_time, " сек."), appendLF = T)
      #Задаём названия полей
      #names(df_new) <- names_col
      #Убираем строку итогов
      #df_new <- df_new[-nrow(df_new),]
      
      #Информация о количестве баллов.
      packageStartupMessage(paste0("Уникальный идентификатор запроса который необходимо указывать при обращении в службу поддержки: ",answer$headers$requestid), appendLF = T)
      
      #Добавляем логин
      if(length(Login) > 1){
        df_new$login <- login}
      
      #Удаляем строку итогов
      df_new <- df_new[!grepl("Total rows", df_new[,1]),]
      #присоединяем свежие данные к результирующему дата врейму
      result <- rbind(result, df_new)
      #Завершаем цикл
    }
  }
  #Выводим инфу о времени работы функции
  total_work_time <- round(difftime(Sys.time(), proc_start , units ="secs"),0)
  packageStartupMessage(paste0("Общее время работы функции: ",total_work_time, " сек."))
  packageStartupMessage(paste0(round(as.integer(server_time) / as.integer(total_work_time) * 100, 0), "% времени работы заняло ожидание ответа от сервера."))
  packageStartupMessage(paste0(round(as.integer(parsing_time) / as.integer(total_work_time) * 100, 0), "% времени работы занял парсинг полученного результата."))
  packageStartupMessage("-----------------------------------------------------------")
  #Возвращаем полученный массив
  return(result)
}

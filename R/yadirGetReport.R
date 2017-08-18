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
  
  #Отправляем запрос на сервер Яндекса 
  answer <- POST("https://api.direct.yandex.com/v5/reports", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru", 'Client-Login' = Login, returnMoneyInMicros = "false", processingMode = "auto"))
  
  if(answer$status_code == 400){
    stop("Ошибка в параметрах запроса либо превышено ограничение на количество запросов или отчетов в очереди. В этом случае проанализируйте сообщение об ошибке, скорректируйте запрос и отправьте его снова.")
  }
  
  
  if(answer$status_code == 500){
    stop("При формировании отчета произошла ошибка на сервере. Если для этого отчета ошибка на сервере возникла впервые, попробуйте сформировать отчет заново. Если ошибка повторяется, обратитесь в службу поддержки.")
  }
  
  if(answer$status_code == 201){
    packageStartupMessage("Отчет успешно поставлен в очередь на формирование в режиме офлайн.", appendLF = F)
  }
  
  if(answer$status_code == 202){
    packageStartupMessage("Формирование отчета еще не завершено.", appendLF = F)
  }
  
  
  while(answer$status_code != 200){
    answer <- POST("https://api.direct.yandex.com/v5/reports", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru", 'Client-Login' = Login, returnMoneyInMicros = "false", processingMode = "auto"))
    packageStartupMessage(".", appendLF = F)
    if(answer$status_code == 500){
      stop("При формировании отчета произошла ошибка на сервере. Если для этого отчета ошибка на сервере возникла впервые, попробуйте сформировать отчет заново. Если ошибка повторяется, обратитесь в службу поддержки.")
    }
    
    Sys.sleep(5)
  }
  
  if(answer$status_code == 200){
    #Получаем список названий полей
    names_col <- strsplit(read.csv(text = content(answer, "text"), sep = "\n", stringsAsFactors = F)[1,], "\t")[[1]]
    #получаем данные
    dataRaw <- read.csv(text = content(answer, "text"), sep = "\n", stringsAsFactors = F)[-1,]
    #Формируем результирующую таблицу
    df_new <- read.csv(text = dataRaw,header = F, sep = "\t", col.names = names_col)
    
    #Проверка вернулись ли какие то данные
    if(is.null(nrow(df_new[-nrow(df_new),]))){
      stop("Ваш запрос не вернул никаких данных, внимательно проверьте заданный фильтр и период отч та, после чего повторите попытку.")
    }
    #Задаём названия полей
    #names(df_new) <- names_col
    #Убираем строку итогов
    #df_new <- df_new[-nrow(df_new),]
    packageStartupMessage("Отчет успешно сформирован и передан в теле ответа.", appendLF = T)
    
    #Информация о количестве баллов.
    packageStartupMessage(paste0("Уникальный идентификатор запроса который необходимо указывать при обращении в службу поддержки: ",answer$headers$requestid), appendLF = T)
    #Возвращаем полученный массив
    return(df_new)
  }
}
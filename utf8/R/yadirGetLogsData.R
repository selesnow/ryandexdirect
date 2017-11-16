yadirGetLogsData <- 
function(counter = NULL, date_from = Sys.Date() - 10, date_to = Sys.Date(), fields = NULL, source = "visits", token = NULL){
  fun_start <- Sys.time()
  #Отправить запрос
  fields <- gsub("[\\s\\n\\t]","",fields,perl = TRUE) 
  logapi <- POST(paste0("https://api-metrika.yandex.ru/management/v1/counter/",counter,"/logrequests?date1=",date_from,"&date2=",date_to,"&fields=",fields,"&source=",source,"&oauth_token=",token))
  queryparam <- content(logapi, "parsed", "application/json")
  
  #Проверка на ошибки, если запрос вернул ошибку останавливаем работу функции и выводим сообщение
  if(!is.null(queryparam$errors)){
    stop(paste0(queryparam$errors[[1]][[1]]," - ",queryparam$errors[[1]][[2]], ", error code - ", queryparam$code))
  }
  
  #Сохраняем id запроса и его статус в переменную
  request_id <- queryparam$log_request$request_id
  request_status <- queryparam$log_request$status
  
  #Запускаем счётчик времени
  start_time <- Sys.time()
  
  #Остановка системы на 7 секунд для ожидания обработки запроса
  Sys.sleep(7)
  
  #Выводим сообщение о том что начат процессинг
  packageStartupMessage("Processing ", appendLF = FALSE)
  
  #Проверка статуса запроса
  while(request_status != "processed"){
    logapistatus <- GET(paste0("https://api-metrika.yandex.ru/management/v1/counter/",counter,"/logrequest/",request_id,"?oauth_token=",token))
    request_status <- content(logapistatus, "parsed", "application/json")$log_request$status
    
    #Выводим сообщение с информацией о статусе запроса и времени выполнения запроса
    #message(paste0("Query status: ", request_status," Query time: ", Sys.time() - start_time))
    packageStartupMessage(".", appendLF = FALSE)
    
    #Получаем к-во частей запроса
    partsnun <- length(content(logapistatus, "parsed", "application/json")$log_request$parts)
    
    #Если лог готов забираем его отдельно по частям
    if(request_status == "processed"){
      #Выводим сообщение о том что процессинг завершен
      packageStartupMessage(paste0(" processing time ",round(Sys.time() - start_time,2)," sec"), appendLF = TRUE)
      
      #Создаём дата фрейм для загрузки данных
      result <- data.frame()
      
      #Выводим сообщение о том что начата загрузка данных
      packageStartupMessage("Loading ", appendLF = FALSE)
      start_load_time <- Sys.time()
      for(parts in 0:partsnun-1){
        packageStartupMessage(".", appendLF = FALSE)
        #Получить данные
        logapidata <- GET(paste0("https://api-metrika.yandex.ru/management/v1/counter/",counter,"/logrequest/",request_id,"/part/",parts,"/download?oauth_token=",token))
        rawdata <- try(content(logapidata,"text","application/json",encoding = "UTF-8"), silent = T)
        df_temp <- try(read.delim(text=rawdata), silent = T)
        result <- rbind(result, df_temp)
      }
      #Возвращаем итоговый результат
      packageStartupMessage(paste0(" done! ", "loading time ",round(Sys.time() - start_load_time,2)," sec"))
      
      #Удаляем запрос с сервера
      req_delite <- POST(paste0("https://api-metrika.yandex.ru/management/v1/counter/",counter,"/logrequest/",request_id,"/clean?oauth_token=",token))
      req_delite <- content(req_delite, "parsed", "application/json")
      #Выводим общую информацию о работе функции
      packageStartupMessage("Information: ")
      packageStartupMessage(paste0("Request id: ", request_id))
      packageStartupMessage(paste0("Request status: ", req_delite$log_request$status))
      packageStartupMessage(paste0("Total time: ", round(Sys.time() - fun_start,2)," sec"))
      packageStartupMessage(paste0("Data size: ",round(req_delite$log_request$size * 1e-6,2), " Mb"))
      packageStartupMessage(paste0("Return rows: ",nrow(result)))                   
      if(exists("result")){
      packageStartupMessage("Data load successful!")
      }
      return(result)
    }
    
    #Если появилась ошибка при обработке останавливаем функцию
    if(request_status == "processing_failed"){
      stop("Ошибка при обработке запроса")
    }
    
    #Если отменён
    if(request_status == "canceled"){
      stop("Запрос был отменён")
    }
    
    #Если отменён
    if(request_status == "cleaned_by_user"|request_status == "cleaned_automatically_as_too_old"){
      stop("Запрос был удалён с сервера")
    }
    
    #5 секунд ожидания перед повторной отправкой
    Sys.sleep(5)
  }
}

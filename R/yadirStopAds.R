yadirStopAds <-  function(Login = NULL, 
                          Ids   = NULL,
                          Token = NULL,
                          AgencyAccount = NULL,
                          TokenPath     = getwd()){
  
  #Проверка заполнения токена
  #Авторизация
  Token <- tech_auth(login = Login, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  
  if(length(Ids) > 10000){
    stop(paste0("В параметр Ids переданы номера ",length(Ids), " объявлений, максимально допустимое количество объявлений в одном запросе 10000."))
  }
  
  if(is.null(Ids)){
    stop("В аргумент Ids необходимо передать вектор содержаший Id объявлений по которым необходимо остановить показ. Вы не передали ниодного Id.")
  }
  
  #Счётчик ошибок
  CounErr <- 0
  
  #Error vector
  errors_id <-  vector()
  
  #Фиксируем время начала работы
  start_time  <- Sys.time()
  
  #Задаём начальный offset
  lim <- 0
  
  #Сообщение о начале обработки данных
  packageStartupMessage("Processing", appendLF = T)
  
  IdsPast <- paste0(Ids, collapse = ",")
  #Формируем тело POST запроса
  queryBody <- paste0("{
                      \"method\": \"suspend\",
                      \"params\": { 
                      \"SelectionCriteria\": {
                      \"Ids\": [",IdsPast,"]}
}
}")
  
  #Отправка запроса
  answer <- POST("https://api.direct.yandex.com/json/v5/ads", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru","Client-Login" = Login))
  #Парсим ответ
  ans_pars <- content(answer)
  #Проверка ответа на наличие ошибки
  if(!is.null(ans_pars$error)){
    stop(paste0("Ошибка: ", ans_pars$error$error_string,". Сообщение: ",ans_pars$error$error_detail, ". ID Запроса: ",ans_pars$error$request_id))
  }
  
  #Проверка необработанных кампаний
  for(error_search in 1:length(ans_pars$result$SuspendResults)){
    if(!is.null(ans_pars$result$SuspendResults[[error_search]]$Errors)){
      CounErr <- CounErr + 1
      errors_id <- c(errors_id, Ids[error_search])
      packageStartupMessage(paste0("    AdId: ",Ids[error_search]," - ", ans_pars$result$SuspendResults[[error_search]]$Errors[[1]]$Details))
    }
  }
  
  #Подготовка сообщения про количество остановленных кампаний
  out_message <- ""
  
  TotalCampStoped <- length(Ids) - CounErr
  
  if(TotalCampStoped %in% c(2,3,4) & !(TotalCampStoped %% 100 %in% c(12,13,14))){
    out_message <- "объявления остановлено"
  } else if(TotalCampStoped %% 10 == 1 & TotalCampStoped %% 100 != 11){
    out_message <- "объявление остановлено"
  } else {
    out_message <- "объявлений остновлено"
  }
  
  #Выводим информацию
  packageStartupMessage(paste0(TotalCampStoped, " ", out_message))
  packageStartupMessage(paste0("Общее время работы функции: ", as.integer(round(difftime(Sys.time(), start_time , units ="secs"),0)), " сек."))
  return(errors_id)}
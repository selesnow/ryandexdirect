yadirGetBalance <- function(Logins        = NULL, 
                             Token         = NULL,     
                             AgencyAccount = NULL,
                             TokenPath     = getwd()){

  # результирующий фрейм
  result <- data.table()
  
  #Авторизация
  if (length(Logins) > 1 || is.null(Logins)) {
  Token <- tech_auth(login = AgencyAccount, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  } else {
  Token <- tech_auth(login = Logins, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)  
  }
 
  # стартовый элемент
  start_element <- 1
  
  # допустимое количество логинов в одном запросе
  lim <- 50
  
  # информация о последней итерации
  ended <- FALSE
  
  while(ended == FALSE) {
  
   # отделяем нужную порцию логинов
   logins_temp <- head(Logins[start_element:length(Logins)], lim)
   
   #Для правильного формирования JSON смотрим к-во логинов и в случае если логин 1 то преобразуем его в list
   if(length(logins_temp)==1){
     logins_temp <- list(logins_temp)
    }
  
  #Формируем тело запроса
  body_list <-  list(method = "AccountManagement",
                     param  = list(Action = "Get",
                                   SelectionCriteria = list(Logins = logins_temp)),
                     locale = "ru",
                     token = Token)

  #Формируем тело запроса
  body_json <- toJSON(body_list, auto_unbox = T, pretty = TRUE)
  
  #Обращаемся к API
  answer <- POST("https://api.direct.yandex.ru/live/v4/json/", body = body_json)
  
  #Оставливаем при ошибке
  stop_for_status(answer)
  
  #парсим результат
  dataRaw <- content(answer, "parsed", "application/json")
  
  #Ещё одна проверка на ошибки
  if(!is.null(dataRaw$error_code)){
    stop(paste0("Error: code - ",dataRaw$error_code, ", message - ",dataRaw$error_str, ", detail - ",dataRaw$error_detail))
  }
  
  #Преобразуем полученный результат в таблицу
  result_temp <- fromJSON(content(answer, "text", "application/json", encoding = "UTF-8"),flatten = TRUE)$data$Accounts
  
  #Проверяем все ли логины загрузились
  errors_list <- fromJSON(content(answer, "text", "application/json", encoding = "UTF-8"),flatten = TRUE)$data$ActionsResult
  
  if(length(errors_list) > 0){
  error <- data.frame(login = errors_list$Login, do.call(rbind.data.frame, errors_list$Errors))
  packageStartupMessage(paste0("Next ",nrow(error)," account",ifelse(nrow(error) > 1, "s","")," get error with try get ballance:"), appendLF = T)
  
  for(err in 1:nrow(error)){
  packageStartupMessage(paste0("Login: ", error$login[err]), appendLF = T)
  packageStartupMessage(paste0("....Code: ", error$FaultCode[err]), appendLF = T)
  packageStartupMessage(paste0("....String: ", error$FaultString[err]), appendLF = T)  
  packageStartupMessage(paste0("....Detail: ", error$FaultDetail[err]), appendLF = T)
  }}
  
  # добавляем информацию в результирующий фрейм
  result <- rbind(result, result_temp, fill = TRUE)
  
  # передвигаем начальный элемент
  start_element <- start_element + lim
  # проверяем надо ли ещё обращаться к апи сос ледующей порцией логинов
  if (start_element > length(Logins)) {
    ended <- TRUE
  }
 }    
  return(as.data.frame(result))}

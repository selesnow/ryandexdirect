yadirGetClientParam <- function(Language = "ru", login = NULL, token = NULL){
  #Проверка наличия логина и токена
  if(is.null(login)|is.null(token)) {
    stop("You must enter login and API token!")
  }
  
  
  queryBody <- paste0("{
  \"method\": \"get\",
                      \"params\": { 
                      \"FieldNames\": [
                      \"AccountQuality\",
                      \"Archived\",
                      \"ClientId\",
                      \"ClientInfo\",
                      \"CountryId\",
                      \"CreatedAt\",
                      \"Currency\",
                      \"Grants\",
                      \"Login\",
                      \"Notification\",
                      \"OverdraftSumAvailable\",
                      \"Phone\",
                      \"Representatives\",
                      \"Restrictions\",
                      \"Settings\",
                      \"VatRate\"]
}
}")
  
  #Отправка запроса на сервер
  answer <- POST("https://api.direct.yandex.com/json/v5/clients", body = queryBody, add_headers(Authorization = paste0("Bearer ",token), 'Accept-Language' = Language, "Client-Login" = login[1]))
  #Проверка результата на ошибки
  stop_for_status(answer)
  
  dataRaw <- content(answer, "parsed", "application/json")
  
  if(length(dataRaw$error) > 0){
    stop(paste0(dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
  }
  
  #Преобоазуем ответ в data frame
  
  #Парсинг справочника регионов
    dictionary_df <- data.frame()
    
    for(dr in 1:length(dataRaw$result[[1]])){
      dictionary_df_temp <- data.frame(Login = dataRaw$result[[1]][[dr]]$Login,
                                       ClientId = dataRaw$result[[1]][[dr]]$ClientId,
                                       CountryId = dataRaw$result[[1]][[dr]]$CountryId,
                                       Currency = dataRaw$result[[1]][[dr]]$Currency,
                                       CreatedAt = dataRaw$result[[1]][[dr]]$CreatedAt,
                                       ClientInfo = dataRaw$result[[1]][[dr]]$ClientInfo,
                                       AccountQuality = dataRaw$result[[1]][[dr]]$AccountQuality,
                                       CampaignsTotalPerClient = dataRaw$result[[1]][[dr]]$Restrictions[[1]]$Value,
                                       CampaignsUnarchivePerClient = dataRaw$result[[1]][[dr]]$Restrictions[[2]]$Value,
                                       APIPoints = dataRaw$result[[1]][[dr]]$Restrictions[[10]]$Value)
      
      dictionary_df <- rbind(dictionary_df, dictionary_df_temp)
      
    }

    #Выводим информаци о работе запроса и о количестве баллов
    #packageStartupMessage("Справочник успешно загружен!", appendLF = T)
    #packageStartupMessage(paste0("Быллы списаны с : " ,answer$headers$`units-used-login`), appendLF = T)
    #packageStartupMessage(paste0("К-во баллов израсходованых при выполнении запроса: " ,strsplit(answer$headers$units, "/")[[1]][1]), appendLF = T)
    #packageStartupMessage(paste0("Доступный остаток суточного лимита баллов: " ,strsplit(answer$headers$units, "/")[[1]][2]), appendLF = T)
    #packageStartupMessage(paste0("Суточный лимит баллов: " ,strsplit(answer$headers$units, "/")[[1]][3]), appendLF = T)
    #packageStartupMessage(paste0("Уникальный идентификатор запроса который необходимо указывать при обращении в службу поддержки: ",answer$headers$requestid), appendLF = T)
    #Возвращаем результат в виде Data Frame
  return(dictionary_df)
}

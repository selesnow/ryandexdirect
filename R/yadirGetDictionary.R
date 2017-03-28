yadirGetDictionary <- function(DictionaryName = "GeoRegions", Language = "ru", login = NULL, token = NULL){
    #Проверка наличия логина и токена
    if(is.null(login)|is.null(token)) {
      stop("You must enter login and API token!")
    }
    
  #Проверка верно ли указано название справочника
  if(!DictionaryName %in% c("Currencies",
                        "MetroStations",
                        "GeoRegions",
                        "TimeZones",
                        "Constants",
                        "AdCategories",
                        "OperationSystemVersions",
                        "ProductivityAssertions",
                        "SupplySidePlatforms",
                        "Interests")){
    stop("Error in DictionaryName, select one of Currencies, MetroStations, GeoRegions, TimeZones, Constants, AdCategories, OperationSystemVersions, ProductivityAssertions, SupplySidePlatforms, Interests")
  }

queryBody <- paste0("{
\"method\": \"get\",
\"params\": {
\"DictionaryNames\": [ \"",DictionaryName,"\" ]
}
}")
  
  #Отправка запроса на сервер
  answer <- POST("https://api.direct.yandex.com/json/v5/dictionaries", body = queryBody, add_headers(Authorization = paste0("Bearer ",token), 'Accept-Language' = Language, "Client-Login" = login[1]))
  #Проверка результата на ошибки
  stop_for_status(answer)
  
  dataRaw <- content(answer, "parsed", "application/json")
  
  if(length(dataRaw$error) > 0){
    stop(paste0(dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
  }
  
  #Преобразуем ответ в data frame
  dictionary_df <- do.call(rbind.data.frame, dataRaw$result[[1]])
  
  packageStartupMessage("Справочник успешно загружен!", appendLF = T)
  packageStartupMessage(paste0("Быллы списаны с : " ,answer$headers$`units-used-login`), appendLF = T)
  packageStartupMessage(paste0("К-во баллов израсходованых при выполнении запроса: " ,strsplit(answer$headers$units, "/")[[1]][1]), appendLF = T)
  packageStartupMessage(paste0("Доступный остаток суточного лимита баллов: " ,strsplit(answer$headers$units, "/")[[1]][2]), appendLF = T)
  packageStartupMessage(paste0("Суточный лимит баллов: " ,strsplit(answer$headers$units, "/")[[1]][3]), appendLF = T)
  packageStartupMessage(paste0("Уникальный идентификатор запроса который необходимо указывать при обращении в службу поддержки: ",answer$headers$requestid), appendLF = T)

  #Возвращаем результат в виде Data Frame
  return(dictionary_df)
}
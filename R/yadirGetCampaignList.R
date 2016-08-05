yadirGetCampaignList <-
function (logins = NULL, token = NULL) {
#Проверка заполнения токена
if(is.null(token)) {
  warning("Enter your API token!")
  return()
}

#Формируем тело POST запроса
queryBody <- paste0("{
  \"method\": \"get\",
  \"params\": { 
    \"SelectionCriteria\": {},
    \"FieldNames\": [
                    \"Id\",
                    \"Name\",
                    \"Type\",
                    \"StartDate\",
                    \"Status\",
                    \"State\",
                    \"Statistics\",
                    \"Currency\",
                    \"DailyBudget\",
                    \"ClientInfo\"],
    \"Page\": {  
      \"Limit\": 1000
    }
  }
}")

#Отправка запроса
if(is.null(logins)){
  #Для обычных аккаунтов
  answer <- POST("https://api.direct.yandex.com/json/v5/campaigns", body = queryBody, add_headers(Authorization = paste0("Bearer ",token), 'Accept-Language' = "ru"))
  #Обработка ответа
  stop_for_status(answer)
  dataRaw <- content(answer, "parsed", "application/json")
  
  #Парсинг ответа
  resultData <- data.frame(Id = character(),
                           Name = character(),
                           Type = character(),
                           Status = character(),
                           State = character(),
                           DailyBudget = double(),
                           Currency = character(),
                           StartDate = as.Date(character()),
                           Impressions = integer(),
                           Clicks = integer(),
                           ClientInfo = character(),
                           stringsAsFactors=FALSE)
  
  #Заполняем таблицу данными по кампаниям
  for (i in 1:length(dataRaw$result$Campaigns)){
    resultData[i,1] <- dataRaw$result$Campaigns[[i]]$Id
    resultData[i,2] <- dataRaw$result$Campaigns[[i]]$Name
    resultData[i,3] <- dataRaw$result$Campaigns[[i]]$Type
    resultData[i,4] <- dataRaw$result$Campaigns[[i]]$Status
    resultData[i,5] <- dataRaw$result$Campaigns[[i]]$State
    resultData[i,6] <- ifelse(is.null(dataRaw$result$Campaigns[[i]]$DailyBudget), NA, dataRaw$result$Campaigns[[i]]$DailyBudget)
    resultData[i,7] <- dataRaw$result$Campaigns[[i]]$Currency
    resultData[i,8] <- dataRaw$result$Campaigns[[i]]$StartDate
    resultData[i,9] <- ifelse(is.null(dataRaw$result$Campaigns[[i]]$Statistics$Impressions), NA,dataRaw$result$Campaigns[[i]]$Statistics$Impressions)
    resultData[i,10] <- ifelse(is.null(dataRaw$result$Campaigns[[i]]$Statistics$Clicks), NA,dataRaw$result$Campaigns[[i]]$Statistics$Clicks)
    resultData[i,11] <- dataRaw$result$Campaigns[[i]]$ClientInfo}
  
  resultData$DailyBudget[!is.na(as.integer(resultData$DailyBudget))] <- try(lapply(X = resultData$DailyBudget[!is.na(as.integer(resultData$DailyBudget))], FUN = function(x) {as.integer(x)/1000000}), silent = TRUE)
  
  } else {
  #Для агентских аккаунтов
    resultData <- data.frame(Id = character(),
                             Name = character(),
                             Type = character(),
                             Status = character(),
                             State = character(),
                             DailyBudget = double(),
                             Currency = character(),
                             StartDate = as.Date(character()),
                             Impressions = integer(),
                             Clicks = integer(),
                             ClientInfo = character(),
                             login = character(),
                             stringsAsFactors=FALSE)
    
    for(l in 1:length(logins)){
      answer <- POST("https://api.direct.yandex.com/json/v5/campaigns", body = queryBody, add_headers(Authorization = paste0("Bearer ",token), 'Accept-Language' = "ru","Client-Login" = logins[l]))
      #Обработка ответа
      stop_for_status(answer)
      dataRaw <- content(answer, "parsed", "application/json")
      
      #
      tempResultData <- data.frame(Id = character(),
                               Name = character(),
                               Type = character(),
                               Status = character(),
                               State = character(),
                               DailyBudget = double(),
                               Currency = character(),
                               StartDate = as.Date(character()),
                               Impressions = integer(),
                               Clicks = integer(),
                               ClientInfo = character(),
                               login = character(),
                               stringsAsFactors=FALSE)      
      
      for (i in 1:length(dataRaw$result$Campaigns)){
        try(tempResultData[i,1] <- dataRaw$result$Campaigns[[i]]$Id, silent = TRUE)
        try(tempResultData[i,2] <- dataRaw$result$Campaigns[[i]]$Name, silent = TRUE)
        try(tempResultData[i,3] <- dataRaw$result$Campaigns[[i]]$Type, silent = TRUE)
        try(tempResultData[i,4] <- dataRaw$result$Campaigns[[i]]$Status, silent = TRUE)
        try(tempResultData[i,5] <- dataRaw$result$Campaigns[[i]]$State, silent = TRUE)
        try(tempResultData[i,6] <- ifelse(is.null(dataRaw$result$Campaigns[[i]]$DailyBudget), NA, dataRaw$result$Campaigns[[i]]$DailyBudget), silent = TRUE)
        try(tempResultData[i,7] <- dataRaw$result$Campaigns[[i]]$Currency, silent = TRUE)
        try(tempResultData[i,8] <- dataRaw$result$Campaigns[[i]]$StartDate, silent = TRUE)
        try(tempResultData[i,9] <- ifelse(is.null(dataRaw$result$Campaigns[[i]]$Statistics$Impressions), NA,dataRaw$result$Campaigns[[i]]$Statistics$Impressions), silent = TRUE)
        try(tempResultData[i,10] <- ifelse(is.null(dataRaw$result$Campaigns[[i]]$Statistics$Clicks), NA,dataRaw$result$Campaigns[[i]]$Statistics$Clicks), silent = TRUE)
        try(tempResultData[i,11] <- dataRaw$result$Campaigns[[i]]$ClientInfo, silent = TRUE)
        try(tempResultData[i,12] <- logins[l], silent = TRUE)}
      
      resultData$DailyBudget[!is.na(as.integer(resultData$DailyBudget))] <- try(lapply(X = resultData$DailyBudget[!is.na(as.integer(resultData$DailyBudget))], FUN = function(x) {as.integer(x)/1000000}), silent = TRUE)
      
      try(resultData <- rbind(resultData, tempResultData))
      if(exists("tempResultData")) {rm(tempResultData)} 
    }
  }
return(resultData)
}

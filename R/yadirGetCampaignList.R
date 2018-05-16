yadirGetCampaignList <-
function (Logins          = NULL, 
          States          = c("OFF","ON","SUSPENDED","ENDED","CONVERTED","ARCHIVED"),
          Types           = c("TEXT_CAMPAIGN","MOBILE_APP_CAMPAIGN","DYNAMIC_TEXT_CAMPAIGN"),
          Statuses        = c("ACCEPTED","DRAFT","MODERATION","REJECTED"),
          StatusesPayment = c("DISALLOWED","ALLOWED"),
          Token           = NULL,
          AgencyAccount = NULL,
          TokenPath     = getwd()) {

#Фиксируем время начала работы
start_time  <- Sys.time()

#Парсинг ответа
result       <- data.frame(Id = character(0),
                           Name = character(0),
                           Type = character(0),
                           Status = character(0),
                           State = character(0),
                           DailyBudgetAmount = double(0),
                           DailyBudgetMode = character(0),
                           Currency = character(0),
                           StartDate = as.Date(character(0)),
                           Impressions = integer(0),
                           Clicks = integer(0),
                           ClientInfo = character(0),
                           Login = character(0),
                           stringsAsFactors=FALSE)

#Filters
States          <- paste("\"",States,"\"",collapse=", ",sep="")
Types           <- paste("\"",Types,"\"",collapse=", ",sep="")
Statuses        <- paste("\"",Statuses,"\"",collapse=", ",sep="")
StatusesPayment <- paste("\"",StatusesPayment,"\"",collapse=", ",sep="")

#Задаём начальный offset
lim <- 0

#Сообщение о начале обработки данных
packageStartupMessage("Processing", appendLF = F)

while(lim != "stoped"){  
#Формируем тело POST запроса
queryBody <- paste0("{
  \"method\": \"get\",
  \"params\": { 
    \"SelectionCriteria\": {
                      \"States\": [",States,"],        
                      \"Types\": [",Types,"],
                      \"StatusesPayment\": [",StatusesPayment,"],
                      \"Statuses\": [",Statuses,"]},
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
      \"Limit\": 10000,
      \"Offset\": ",lim,"
    }
  }
}")


    
    for(l in 1:length(Logins)){
      #Авторизация
      Token <- tech_auth(login = Logins[l], token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
      
      answer <- POST("https://api.direct.yandex.com/json/v5/campaigns", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru","Client-Login" = Logins[l]))
      #Обработка ответа
      stop_for_status(answer)
      dataRaw <- content(answer, "parsed", "application/json")
      
        if(length(dataRaw$error) > 0){
            stop(paste0(dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
           }
      
      #Парсинг ответа
      for (i in 1:length(dataRaw$result$Campaigns)){
        
        try(result <- rbind(result,
                        data.frame(Id                 = dataRaw$result$Campaigns[[i]]$Id,
                                   Name               = dataRaw$result$Campaigns[[i]]$Name,
                                   Type               = dataRaw$result$Campaigns[[i]]$Type,
                                   Status             = dataRaw$result$Campaigns[[i]]$Status,
                                   State              = dataRaw$result$Campaigns[[i]]$State,
                                   DailyBudgetAmount  = ifelse(is.null(dataRaw$result$Campaigns[[i]]$DailyBudget$Amount), NA, dataRaw$result$Campaigns[[i]]$DailyBudget$Amount / 1000000),
                                   DailyBudgetMode    = ifelse(is.null(dataRaw$result$Campaigns[[i]]$DailyBudget$Mode), NA, dataRaw$result$Campaigns[[i]]$DailyBudget$Mode),
                                   Currency           = dataRaw$result$Campaigns[[i]]$Currency,
                                   StartDate          = dataRaw$result$Campaigns[[i]]$StartDate,
                                   Impressions        = ifelse(is.null(dataRaw$result$Campaigns[[i]]$Statistics$Impressions), NA,dataRaw$result$Campaigns[[i]]$Statistics$Impressions),
                                   Clicks             = ifelse(is.null(dataRaw$result$Campaigns[[i]]$Statistics$Clicks), NA,dataRaw$result$Campaigns[[i]]$Statistics$Clicks),
                                   ClientInfo         = dataRaw$result$Campaigns[[i]]$ClientInfo,
                                   Login              = Logins[l])), silent = T)
        
        }
    }

  #Добавляем точку, что процесс загрузки идёт
  packageStartupMessage(".", appendLF = F)
  #Проверяем остались ли ещё строки которые надо забрать
  lim <- ifelse(is.null(dataRaw$result$LimitedBy), "stoped",dataRaw$result$LimitedBy + 1)
}

#Преобразовываем некоторые поля результирующего дата фрейма в фактор
result$Type <- as.factor(result$Type)
result$Status <- as.factor(result$Status)
result$State <- as.factor(result$State)
result$Currency <- as.factor(result$Currency)

#Фиксируем время завершения обработки
stop_time <- Sys.time()

#Сообщение о том, что загрузка данных прошла успешно
packageStartupMessage("Done", appendLF = T)
packageStartupMessage(paste0("Количество полученных рекламных кампаний: ", nrow(result)), appendLF = T)
packageStartupMessage(paste0("Длительность работы: ", round(difftime(stop_time, start_time , units ="secs"),0), " сек."), appendLF = T)
#Возвращаем результат
return(result)
}

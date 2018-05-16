yadirCurrencyRates <- 
function(Login           = NULL,
         AgencyAccount   = NULL,
         Token           = NULL,
         TokenPath       = getwd()){
  
  queryBody <- "{
  \"method\": \"get\",
  \"params\": {
  \"DictionaryNames\": [ \"Currencies\" ]
   }
  }"

  #Àâòîğèçàöèÿ
  Token <- tech_auth(login = Login, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  
answer <- POST("https://api.direct.yandex.com/json/v5/dictionaries", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru","Client-Login" = Login[1]))
#ÃÃ¡Ã°Ã Ã¡Ã®Ã²ÃªÃ  Ã®Ã²Ã¢Ã¥Ã²Ã 
stop_for_status(answer)
dataRaw <- content(answer, "parsed", "application/json")

cur <- data.frame(curName = character(),
                  fullName = character(),
                  RateWithVAT = double(),
                  Rate = double(),
                  stringsAsFactors = FALSE)

for(i in 1:length(dataRaw$result$Currencies)){
  cur[i,1] <-  dataRaw$result$Currencies[[i]]$Currency[1]
  cur[i,2] <-  dataRaw$result$Currencies[[i]]$Properties[[2]]$Value
  cur[i,3] <-  as.numeric(dataRaw$result$Currencies[[i]]$Properties[[12]]$Value)
  cur[i,4] <-  as.numeric(dataRaw$result$Currencies[[i]]$Properties[[11]]$Value)
	}
return(cur)
}

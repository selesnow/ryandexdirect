yadirGetClientParam <- function(Language = "ru", 
                                Logins = NULL, 
                                Token = NULL,
                                AgencyAccount = NULL,
                                TokenPath     = getwd()){
  
  
  #Авторизация
  Token <- tech_auth(login = Logins, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  
  #Загрузка списка клиентов если небыло задани их список
  if ( ! is.null(AgencyAccount) && is.null(Logins)) {
    Logins <- yadirGetClientList(AgencyAccount = AgencyAccount, TokenPath = TokenPath, Token = Token)$Login
  }
  
  #Формируем запрос
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
  
  result <- data.frame()
  
  for (login in Logins) {
    
    #Ioi?aaea cai?ina ia na?aa?
    answer <- POST("https://api.direct.yandex.com/json/v5/clients", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = Language, "Client-Login" = login))
    #I?iaa?ea ?acoeuoaoa ia ioeaee
    stop_for_status(answer)
    
    dataRaw <- content(answer, "parsed", "application/json")
    
    if(length(dataRaw$error) > 0){
      warning(login,paste0(": ",dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
	  next
    }
    
    #I?aia?acoai ioaao a data frame
    
    #Ia?neia ni?aai?ieea ?aaeiiia
      dictionary_df <- data.frame()
      
      for(dr in 1:length(dataRaw$result[[1]])){
        dictionary_df_temp <- data.frame(Login = dataRaw$result[[1]][[dr]]$Login,
                                         ClientId = dataRaw$result[[1]][[dr]]$ClientId,
                                         CountryId = dataRaw$result[[1]][[dr]]$CountryId,
                                         Currency = dataRaw$result[[1]][[dr]]$Currency,
                                         CreatedAt = dataRaw$result[[1]][[dr]]$CreatedAt,
                                         ClientInfo = dataRaw$result[[1]][[dr]]$ClientInfo,
                                         AccountQuality = ifelse(is.null(dataRaw$result[[1]][[dr]]$AccountQuality),NA,dataRaw$result[[1]][[dr]]$AccountQuality),
                                         CampaignsTotalPerClient = dataRaw$result[[1]][[dr]]$Restrictions[[1]]$Value,
                                         CampaignsUnarchivePerClient = dataRaw$result[[1]][[dr]]$Restrictions[[2]]$Value,
                                         APIPoints = dataRaw$result[[1]][[dr]]$Restrictions[[10]]$Value)
        
        dictionary_df <- rbind(dictionary_df, dictionary_df_temp)
        
      }
      


    #Auaiaei eioi?iaoe? i ?aaioa cai?ina e i eiee?anoaa aaeeia
     #packageStartupMessage("Ni?aai?iee oniaoii caa?o?ai!", appendLF = T)
     packageStartupMessage(paste0("Баллы списаны с : " ,answer$headers$`units-used-login`), appendLF = T)
     packageStartupMessage(paste0("К-во баллов израсходованых при выполнении запроса: " ,strsplit(answer$headers$units, "/")[[1]][1]), appendLF = T)
     packageStartupMessage(paste0("Доступный остаток суточно о лимита баллов: " ,strsplit(answer$headers$units, "/")[[1]][2]), appendLF = T)
     packageStartupMessage(paste0("Суточный лимит баллов: " ,strsplit(answer$headers$units, "/")[[1]][3]), appendLF = T)
     packageStartupMessage(paste0("Уникальный идентификатоо запроса который необходимо указывать при обращении в службу поддержки: ",answer$headers$requestid), appendLF = T)

     # прикрепляем к общему результату
     result <- rbind(result, dictionary_df)
  }
  return(result)
}

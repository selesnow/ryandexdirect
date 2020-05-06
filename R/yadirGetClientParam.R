yadirGetClientParam <- function(Language      = "ru", 
                                Logins        = getOption("ryandexdirect.user"), 
                                Token         = NULL,
                                AgencyAccount = getOption("ryandexdirect.agency_account"),
                                TokenPath     = yadirTokenPath()){
  
  
  # auth
  Token <- tech_auth(login = Logins, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  
  # loading client list
  if ( ! is.null(AgencyAccount) && is.null(Logins)) {
    Logins <- yadirGetClientList(AgencyAccount = AgencyAccount, TokenPath = TokenPath, Token = Token)$Login
  }
  
  # compose query
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
    
    # send query
    answer <- POST("https://api.direct.yandex.com/json/v5/clients", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = Language, "Client-Login" = login))
    # check for error
    stop_for_status(answer)
    
    dataRaw <- content(answer, "parsed", "application/json")
    
    if(length(dataRaw$error) > 0){
      warning(login,paste0(": ",dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
	  next
    }
       
    # result frame
      dictionary_df <- data.frame()
      
      for(dr in 1:length(dataRaw$result[[1]])){
        dictionary_df_temp <- data.frame(Login                       = dataRaw$result[[1]][[dr]]$Login,
                                         ClientId                    = dataRaw$result[[1]][[dr]]$ClientId,
                                         CountryId                   = dataRaw$result[[1]][[dr]]$CountryId,
                                         Currency                    = dataRaw$result[[1]][[dr]]$Currency,
                                         CreatedAt                   = dataRaw$result[[1]][[dr]]$CreatedAt,
                                         ClientInfo                  = dataRaw$result[[1]][[dr]]$ClientInfo,
                                         AccountQuality              = ifelse(is.null(dataRaw$result[[1]][[dr]]$AccountQuality),NA,dataRaw$result[[1]][[dr]]$AccountQuality),
                                         CampaignsTotalPerClient     = dataRaw$result[[1]][[dr]]$Restrictions[[1]]$Value,
                                         CampaignsUnarchivePerClient = dataRaw$result[[1]][[dr]]$Restrictions[[2]]$Value,
                                         APIPoints                   = dataRaw$result[[1]][[dr]]$Restrictions[[10]]$Value)
        
        dictionary_df <- rbind(dictionary_df, dictionary_df_temp)
        
      }
      


    # tech messages
     packageStartupMessage(paste0("API points write off from : " ,answer$headers$`units-used-login`), appendLF = T)
     packageStartupMessage(paste0("Number of points spent on the request: " ,strsplit(answer$headers$units, "/")[[1]][1]), appendLF = T)
     packageStartupMessage(paste0("Available balance daily about limit points: " ,strsplit(answer$headers$units, "/")[[1]][2]), appendLF = T)
     packageStartupMessage(paste0("Daily limit points: " ,strsplit(answer$headers$units, "/")[[1]][3]), appendLF = T)
     packageStartupMessage(paste0("Unique identifier of the request that must be specified when contacting support: ",answer$headers$requestid), appendLF = T)

     # binding resuilt
     result <- rbind(result, dictionary_df)
  }
  return(result)
}

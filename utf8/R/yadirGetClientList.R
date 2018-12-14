yadirGetClientList <-
function(AgencyAccount = NULL,
         Token         = NULL,
         TokenPath     = getwd()){
   
   # authorize
   Token <- tech_auth(login = Logins[l], token = Token, AgencyAccount = AgencyAccount, 
                      TokenPath = TokenPath)
   
   # prepare query body
   q <- list(method = "get",
             params = list(SelectionCriteria = NULL,
                           FieldNames = c( "AccountQuality", 
                                           "Archived", 
                                           "ClientId", 
                                           "ClientInfo", 
                                           "CountryId", 
                                           "CreatedAt", 
                                           "Currency", 
                                           "Grants", 
                                           "Login", 
                                           "Notification", 
                                           "OverdraftSumAvailable", 
                                           "Phone", 
                                           "Representatives", 
                                           "Restrictions", 
                                           "Settings", 
                                           "Type", 
                                           "VatRate"))) 
   # convert body to json format
   q_json <- toJSON(q, auto_unbox = T)
   
   # send HTTP query
   answer <- POST("https://api.direct.yandex.com/json/v5/agencyclients", 
                  body = q_json,
                  add_headers(Authorization = paste0("Bearer ",Token), 
                              'Accept-Language' = "ru"))
   
   # check query for error
   stop_for_status(answer)
   dataRaw <- content(answer, "parsed", "application/json")
   
   # check answer for error
   if ( !is.null(dataRaw$error ) ) {
     stop(dataRaw$error$error_detail, 
          call. = cat("Error detail:\n",
                      "request_id =",dataRaw$error$request_id, "\n",
                      "error_code =",dataRaw$error$error_code, "\n",
                      "error_detail =",dataRaw$error$error_detail, "\n",
                      "error_string =",dataRaw$error$error_string, "\n"))
   }
   
   # result data
   data <- list()
   
   # parse raw data
   for (i in dataRaw$result$Clients) {

     data <- append(data, list(
                            list(Login           = i$Login,
                                 FIO             = i$ClientInfo,
                                 StatusArch      = i$Archived,
                                 DateCreate      = i$CreatedAt,
                                 Role            = i$Type,
                                 Email           = i$Notification$Email,
                                 Phone           = i$Phone,
                                 Currency        = i$Currency,
                                 VatRate         = i$VatRate,
                                 ClientId        = i$ClientId,
                                 CountryId       = i$CountryId,
                                 AccountQuality  = ifelse( is.null(i$AccountQuality), NA, i$AccountQuality),
                                 Grants          = paste0(lapply(i$Grants, function(x) paste0(x[["Agency"]], ": ", x[["Privilege"]], " - ", x[["Value"]])), collapse = "; "),
                                 Representatives = paste0(lapply(i$Representatives, function( x ) paste0(x[["Login"]], ": ", x[["Role"]])), collapse = "; "),
                                 Restrictions    = paste0(lapply(i$Restrictions, function(x) paste0(x[["Element"]], ": ", x[["Value"]])), collapse = "; "),
                                 Setting         = paste0(lapply(i$Settings, function(x) paste0(x[["Option"]], ": ", x[["Value"]])), collapse = "; "))))
   }
   
   # binding to data frame
   dataTotal <- bind_rows(data)

   return(dataTotal)
 }
 

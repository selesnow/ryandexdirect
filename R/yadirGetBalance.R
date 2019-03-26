yadirGetBalance <- function(Logins        = NULL, 
                            Token         = NULL,     
                            AgencyAccount = NULL,
                            TokenPath     = getwd()){

  # result frame
  result <- data.table()
  
  # auth
  if (length(Logins) > 1 || is.null(Logins)) {
  Token <- tech_auth(login = AgencyAccount, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  } else {
  Token <- tech_auth(login = Logins, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)  
  }
 
  # start element
  start_element <- 1
  
  # limit
  lim <- 50
  
  # last iteraction
  ended <- FALSE
  
  while(ended == FALSE) {
  
   # get logins part
   logins_temp <- head(Logins[start_element:length(Logins)], lim)
   
   # for right json check number of logins
   # if number of login == 1 then convert him to list
   if(length(logins_temp)==1){
     logins_temp <- list(logins_temp)
    }
  
  # compose query body
	body_list <-  list(method = "AccountManagement",
					   param  = list(Action = "Get"),
					   locale = "ru",
					   token = Token)
    
  # if is agency account add selection 
	if ( ! is.null(AgencyAccount) ) {
	  body_list$param <- append(body_list$param, list(SelectionCriteria = list(Logins = logins_temp)))
	}

  # body to json format
  body_json <- toJSON(body_list, auto_unbox = T, pretty = TRUE)
  
  # send query
  answer <- POST("https://api.direct.yandex.ru/live/v4/json/", body = body_json)
  
  # check for error
  stop_for_status(answer)
  
  # parsing
  dataRaw <- content(answer, "parsed", "application/json")
  
  # check result for error
  if(!is.null(dataRaw$error_code)){
    stop(paste0("Error: code - ",dataRaw$error_code, ", message - ",dataRaw$error_str, ", detail - ",dataRaw$error_detail))
  }
  
  # Result to data frame
  result_temp <- fromJSON(content(answer, "text", "application/json", encoding = "UTF-8"),flatten = TRUE)$data$Accounts
  
  # check for all logins is loaded
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
  
  # bind to result data frame
  result <- rbind(result, result_temp, fill = TRUE)
  
  # to next iteraction
  start_element <- start_element + lim
  # check next part of logins
  if (start_element > length(Logins)) {
    ended <- TRUE
  }
 }    
  return(as.data.frame(result))}

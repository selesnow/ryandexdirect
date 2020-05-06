yadirStopKeyWords <-  function(Login = getOption("ryandexdirect.user"), 
                               Ids   = NULL,
                               Token = NULL,
                               AgencyAccount = getOption("ryandexdirect.agency_account"),
                               TokenPath     = yadirTokenPath()){
  # auth
  Token <- tech_auth(login = Login, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  
  if(length(Ids) > 10000){
    stop(paste0("In Ids set ",length(Ids), " keywords, limit 10000."))
  }
  
  if(is.null(Ids)){
    stop("Ids is require.")
  }
  
  # error counter
  CounErr <- 0
  
  # Error vector
  errors_id <-  vector()
  
  # Set start time
  start_time  <- Sys.time()
  
  # Set offset
  lim <- 0
  
  # Start message
  packageStartupMessage("Processing", appendLF = T)
  
  IdsPast <- paste0(Ids, collapse = ",")
  # Request body
  queryBody <- paste0("{
                      \"method\": \"suspend\",
                      \"params\": { 
                      \"SelectionCriteria\": {
                      \"Ids\": [",IdsPast,"]}
}
}")
  
  # Send request
  answer <- POST("https://api.direct.yandex.com/json/v5/keywords", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru","Client-Login" = Login))
  # Parsing
  ans_pars <- content(answer)
  # Check error
  if(!is.null(ans_pars$error)){
    stop(paste0("Error: ", ans_pars$error$error_string,". Message: ",ans_pars$error$error_detail, ". Request ID: ",ans_pars$error$request_id))
  }
  
  # Check of not processing keywords
  for(error_search in 1:length(ans_pars$result$SuspendResults)){
    if(!is.null(ans_pars$result$SuspendResults[[error_search]]$Errors)){
      CounErr <- CounErr + 1
      errors_id <- c(errors_id, Ids[error_search])
      packageStartupMessage(paste0("    KeyWordId: ",Ids[error_search]," - ", ans_pars$result$SuspendResults[[error_search]]$Errors[[1]]$Details))
    }
  }
  
  # Message about stoped keywords
  out_message <- ""
  
  TotalCampStoped <- length(Ids) - CounErr
  
  if(TotalCampStoped %in% c(2,3,4) & !(TotalCampStoped %% 100 %in% c(12,13,14))){
    out_message <- "keywords stoped"
  } else if(TotalCampStoped %% 10 == 1 & TotalCampStoped %% 100 != 11){
    out_message <- "keywords stoped"
  } else {
    out_message <- "keywords stoped"
  }
  
  # Out message
  packageStartupMessage(paste0(TotalCampStoped, " ", out_message))
  packageStartupMessage(paste0("Total durations: ", as.integer(round(difftime(Sys.time(), start_time , units ="secs"),0)), " sec."))
  return(errors_id)}

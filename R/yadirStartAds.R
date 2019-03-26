yadirStartAds <-  function(Login = NULL, 
                           Ids   = NULL,
                           Token = NULL,
                           AgencyAccount = NULL,
                           TokenPath     = getwd()){
  
  # auth
  Token <- tech_auth(login = Login, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  
  if(length(Ids) > 10000){
    stop(paste0("In the parameter Ids transferred numbers ",length(Ids), " of ads, the maximum number of ads per request is 10000."))
  }
  
  if(is.null(Ids)){
    stop("In the Ids argument, you must pass the vector containing the Id ads for which you want to resume the show. You have not passed any Id.")
  }
  
  # errors counter
  CounErr <- 0
  
  # Error vector
  errors_id <-  vector()
  
  # start time
  start_time  <- Sys.time()
  
  # start message
  packageStartupMessage("Processing", appendLF = T)
  
  IdsPast <- paste0(Ids, collapse = ",")
  
  # request body
  queryBody <- paste0("{
                      \"method\": \"resume\",
                      \"params\": { 
                      \"SelectionCriteria\": {
                      \"Ids\": [",IdsPast,"]}
}
}")
  
  # send request
  answer <- POST("https://api.direct.yandex.com/json/v5/ads", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru","Client-Login" = Login))
  # parse answer
  ans_pars <- content(answer)
  # check answer for errors
  if(!is.null(ans_pars$error)){
    stop(paste0("Error: ", ans_pars$error$error_string,". Message: ",ans_pars$error$error_detail, ". RequestID: ",ans_pars$error$request_id))
  }
  
  # check not starting ads
  for(error_search in 1:length(ans_pars$result$ResumeResults)){
    if(!is.null(ans_pars$result$ResumeResults[[error_search]]$Errors)){
      CounErr <- CounErr + 1
      errors_id <- c(errors_id, Ids[error_search])
      packageStartupMessage(paste0("    AdId: ",Ids[error_search]," - ", ans_pars$result$ResumeResults[[error_search]]$Errors[[1]]$Details))
    }
  }
  
  # message about starting ads number
  out_message <- ""
  
  TotalCampStoped <- length(Ids) - CounErr
  
  if(TotalCampStoped %in% c(2,3,4) & !(TotalCampStoped %% 100 %in% c(12,13,14))){
    out_message <- "start ads"
  } else if(TotalCampStoped %% 10 == 1 & TotalCampStoped %% 100 != 11){
    out_message <- "start ads"
  } else {
    out_message <- "start ads"
  }
  
  # message
  packageStartupMessage(paste0(TotalCampStoped, " ", out_message))
  packageStartupMessage(paste0("Total time: ", as.integer(round(difftime(Sys.time(), start_time , units ="secs"),0)), " sec."))
  return(errors_id)}

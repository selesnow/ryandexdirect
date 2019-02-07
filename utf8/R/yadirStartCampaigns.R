yadirStartCampaigns <-  function(Login = NULL, 
                                 Ids   = NULL,
                                 Token = NULL,
                                 AgencyAccount = NULL,
                                 TokenPath     = getwd()){
  
  # auth
  Token <- tech_auth(login = Login, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  
  if(length(Ids) > 1000){
    stop(paste0("In the parameter Ids transferred numbers of ",length(Ids), " campaigns, maximum number of campaigns in one request is 1000."))
  }
  
  if(is.null(Ids)){
    stop("In the Ids argument, you must pass the vector containing the Id campaigns for which you want to resume displaying ads. You have not transferred any Id.")
  }
  
  # err counter
  CounErr <- 0
  
  #Error vector
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
  answer <- POST("https://api.direct.yandex.com/json/v5/campaigns", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru","Client-Login" = Login))
  # parsing answer
  ans_pars <- content(answer)
  # xheck for error
  if(!is.null(ans_pars$error)){
    stop(paste0("Error: ", ans_pars$error$error_string,". Message: ",ans_pars$error$error_detail, ". Request ID: ",ans_pars$error$request_id))
  }
  
  # check resume campaing
  for(error_search in 1:length(ans_pars$result$ResumeResults)){
    if(!is.null(ans_pars$result$ResumeResults[[error_search]]$Errors)){
      CounErr <- CounErr + 1
      errors_id <- c(errors_id, Ids[error_search])
      packageStartupMessage(paste0("    CampId: ",Ids[error_search]," - ", ans_pars$result$ResumeResults[[error_search]]$Errors[[1]]$Details))
    }
  }
  
  # Prepare message for number of start campaings
  out_message <- ""
  
  TotalCampStoped <- length(Ids) - CounErr
  
  if(TotalCampStoped %in% c(2,3,4) & !(TotalCampStoped %% 100 %in% c(12,13,14))){
    out_message <- "campaings start"
  } else if(TotalCampStoped %% 10 == 1 & TotalCampStoped %% 100 != 11){
    out_message <- "campaings start"
  } else {
    out_message <- "campaings start"
  }
  
  # tech info
  packageStartupMessage(paste0(TotalCampStoped, " ", out_message))
  packageStartupMessage(paste0("Total time: ", as.integer(round(difftime(Sys.time(), start_time , units ="secs"),0)), " sec."))
  return(errors_id)}

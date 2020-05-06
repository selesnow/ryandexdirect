yadirGetReportFun <- 
     function(ReportType        = "CUSTOM_REPORT", 
              DateRangeType     = "LAST_30_DAYS", 
              DateFrom          = NULL, 
              DateTo            = NULL, 
              FieldNames        = c("CampaignName","Impressions","Clicks","Cost"), 
              FilterList        = NULL,
              Goals             = NULL,
              AttributionModels = NULL,
              IncludeVAT        = "YES",
              IncludeDiscount   = "NO",
              Login             = getOption("ryandexdirect.user"),
              AgencyAccount     = getOption("ryandexdirect.agency_account"),
              Token             = NULL,
              TokenPath         = yadirTokenPath(),
			  SkipErrors        = TRUE){
  
  # start time
  proc_start <- Sys.time()
  
  # field names
  Fields <- paste0("<FieldNames>",FieldNames, "</FieldNames>", collapse = "")
  
  # for limited accounts
  limit_reached <- c()
  
  # filters
  if(!is.null(FilterList)){
    fil_list <- NA
    filt <- FilterList
    for(fil in filt){
      val <- strsplit(paste0(strsplit(fil ," ")[[1]][3:length(strsplit(fil ," ")[[1]])], collapse = ""), split = ",| |;")[[1]]
      fil_list <- paste0(fil_list[!is.na(fil_list)],
                         paste0("<Filter>",
                                paste0("<Field>",strsplit(fil ," ")[[1]][1], "</Field>"),
                                paste0("<Operator>",strsplit(fil ," ")[[1]][2], "</Operator>"),
                                paste0(paste0("<Values>",val, "</Values>"), collapse = ""),"</Filter>"))
    }}
  
  # Goals and attributtion
  Goals             <- ifelse(is.null(Goals), "", paste0("<Goals>",Goals, "</Goals>", collapse = ""))
  AttributionModels <- ifelse(is.null(AttributionModels), "", paste0("<AttributionModels>",AttributionModels, "</AttributionModels>", collapse = ""))
 
   # compose request body
  queryBody <- paste0('
                      <ReportDefinition xmlns="http://api.direct.yandex.com/v5/reports">
                      <SelectionCriteria>',
                      ifelse(DateRangeType == "CUSTOM_DATE",paste0("<DateFrom>",DateFrom,"</DateFrom>","<DateTo>",DateTo,"</DateTo>") ,"" ),
                      ifelse(is.null(FilterList),"",fil_list),
                      '
                      </SelectionCriteria>',
                      Goals,AttributionModels,Fields,'
                      <ReportName>',paste0("MyReport ", Sys.time()),'</ReportName>
                      <ReportType>',ReportType,'</ReportType>
                      <DateRangeType>',DateRangeType ,'</DateRangeType>
                      <Format>TSV</Format>
                      <IncludeVAT>',IncludeVAT,'</IncludeVAT>
                      <IncludeDiscount>',IncludeDiscount,'</IncludeDiscount>
                      </ReportDefinition>')
  
  # result frame
  result <- data.frame()
  
  for(current_login in Login){
    # auth
    curToken <- tech_auth(login = current_login, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
   
    # time counter
    parsing_time <- 0
    server_time <- 0
    # start message
    packageStartupMessage("-----------------------------------------------------------")
    packageStartupMessage(paste0("Loading data by ",current_login))
    
	# send request to API
    serv_start_time <- Sys.time()
    
    answer <- POST("https://api.direct.yandex.com/v5/reports", 
	               body = queryBody, 
	               add_headers( Authorization       = paste0("Bearer ",curToken), 
				               'Accept-Language'    = "ru", 
							    skipReportHeader    = "true" ,
								skipReportSummary   = "true" , 
								'Client-Login'      = current_login, 
								returnMoneyInMicros = "false", 
								processingMode      = "auto"))
    
    if(substr(answer$status_code,1,1) == 4){
      packageStartupMessage("Error in request parameters or limit on the number of requests or reports in the queue is exceeded. In this case, analyze the error message, correct the request and send it again.")
      
      # parse error
      content(answer, "parsed","text/xml",encoding = "UTF-8") %>%
          xml_find_all(xpath = ".//reports:ApiError//reports:requestId") %>%
          xml_text() %>%
          message(" > Request Id")
      
      content(answer, "parsed","text/xml",encoding = "UTF-8") %>%
          xml_find_all(xpath = ".//reports:ApiError//reports:errorCode") %>%
          xml_text() %>%
          message(" > Error Code")
      
      content(answer, "parsed","text/xml",encoding = "UTF-8") %>%
          xml_find_all(xpath = ".//reports:ApiError//reports:errorMessage") %>%
          xml_text() %>%
          message(" > Error Message")
      
      content(answer, "parsed","text/xml",encoding = "UTF-8") %>%
          xml_find_all(xpath = ".//reports:ApiError//reports:errorDetail") %>%
          xml_text() %>%
          message(" > Error Detail")
		  
	  if ( SkipErrors == FALSE ) stop(content(answer, "parsed","text/xml",encoding = "UTF-8") %>%
									  xml_find_all(xpath = ".//reports:ApiError//reports:errorDetail") %>%
									  xml_text() %>%
									  message(" > Error Detail"))
      
      next
    }
    
    if(answer$status_code == 500){
      packageStartupMessage(paste0(current_login," - ",xml_text(content(answer, "parsed","text/xml",encoding = "UTF-8"))))
      packageStartupMessage("While generating the report an error occurred on the server. If for this report the error on the server occurred for the first time, try to generate a report again. If the error persists, contact support.")
	  
	  if ( SkipErrors == FALSE ) stop(content(answer, "parsed","text/xml",encoding = "UTF-8") %>%
		      						  xml_find_all(xpath = ".//reports:ApiError//reports:errorDetail") %>%
									  xml_text() %>%
									  message(" > Error Detail"))
	  
      next
    }
    
    if(answer$status_code == 201){
      packageStartupMessage("The report has been successfully queued for offline generation.", appendLF = T)
      packageStartupMessage("Proccesing", appendLF = F)
      packageStartupMessage("|", appendLF = F)
    }
    
    if(answer$status_code == 202){
      packageStartupMessage("Report generation is not completed yet.", appendLF = F)
    }
    
    
    while(answer$status_code != 200){
      answer <- POST("https://api.direct.yandex.com/v5/reports", 
	                 body = queryBody, 
					 add_headers( Authorization       = paste0("Bearer ",curToken), 
					             'Accept-Language'    = "ru", 
								  skipReportHeader    = "true" ,
								  skipReportSummary   = "true" , 
								 'Client-Login'       = current_login, 
								  returnMoneyInMicros = "false", 
								  processingMode      = "auto"))
								  
      packageStartupMessage("=", appendLF = F)
      if(answer$status_code == 500){
        stop("While generating the report an error occurred on the server. If for this report the error on the server occurred for the first time, try to generate a report again. If the error persists, contact support.")
      }
      if(answer$status_code == 502){
        stop("Request processing time exceeded server limit.")
      }
      Sys.sleep(5)
    }
    packageStartupMessage("|", appendLF = T)
    # succes message
    server_time <- round(difftime(Sys.time(), serv_start_time , units ="secs"),0)
    packageStartupMessage("Report successfully generated and transmitted in response body.", appendLF = T)
    packageStartupMessage(paste0("Server time: ",server_time , " sec."), appendLF = T)
    
    # pars start time
    pasr_start_time <- Sys.time()
    
    if(answer$status_code == 200){
      df_new <- suppressMessages(content(answer,  "parsed", "text/tab-separated-values", encoding = "UTF-8"))

      # check data
      if(nrow(df_new) == 0){
        packageStartupMessage("Your request did not return any data, carefully check the specified filter and report period, and then try again.")
        next
      }
	  
	  # check if there are APi limits
      if (nrow(df_new) >= 1000000) { 
        warning(current_login,': You have reached the limits of Yandex.Direct API. Try to use "FetchBy" parameter with DateRangeType = "CUSTOM_DATE", "DateFrom" and "DateTo". If you are already using it, try to choose a smaller value.')
		limit_reached <- append(limit_reached, current_login)
      }
	  
      # timing message
      parsing_time <- round(difftime(Sys.time(), pasr_start_time , units ="secs"),0)
      packageStartupMessage(paste0("Parsing time: ", parsing_time, " sec."), appendLF = T)

      # request id
      packageStartupMessage(paste0("RequestID: ",answer$headers$requestid), appendLF = T)
      
      # add login
      if(length(Login) > 1){
        df_new$Login <- current_login}
      
      # add to result
      result <- rbind(result, df_new)
      # end of cycle
    }
  }
  
  # check limits
  if ( length(limit_reached) > 0 ) {
   attr(result, "limit_reached") <- limit_reached
   packageStartupMessage("Limit of 1 000 000 rows reached by next accounts: ", paste(limit_reached, collapse = ", "))
  }  
  
  # tech messages
  total_work_time <- round(difftime(Sys.time(), proc_start , units ="secs"),0)
  packageStartupMessage(paste0("Total time: ",total_work_time, " sec."))
  packageStartupMessage(paste0(round(as.integer(server_time) / as.integer(total_work_time) * 100, 0), "% server time rate."))
  packageStartupMessage(paste0(round(as.integer(parsing_time) / as.integer(total_work_time) * 100, 0), "% parsing time rate."))
  packageStartupMessage("Number of rows is ", nrow(df_new))
  packageStartupMessage(paste0("RequestID: ",answer$headers$requestid))
  packageStartupMessage("-----------------------------------------------------------")
  # return result
  return(result)
}
yadirGetDictionary <- function(DictionaryName = "GeoRegions", 
                               Language       = "ru", 
                               Login          = getOption("ryandexdirect.user"),
                               Token          = NULL,
                               AgencyAccount  = getOption("ryandexdirect.agency_account"),
                               TokenPath      = yadirTokenPath()){
  
  # start

  # auth
  Token <- tech_auth(login = Login, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  
  # Check dict name
  if(!DictionaryName %in% c("Currencies",
                            "MetroStations",
                            "GeoRegions",
                            "TimeZones",
                            "Constants",
                            "AdCategories",
                            "OperationSystemVersions",
                            "ProductivityAssertions",
                            "SupplySidePlatforms",
                            "Interests")){
    stop("Error in DictionaryName, select one of Currencies, MetroStations, GeoRegions, TimeZones, Constants, AdCategories, OperationSystemVersions, ProductivityAssertions, SupplySidePlatforms, Interests")
  }

	#check stringAsFactor
	factor_change <- FALSE

	#change string is factor if TRUE
	if(getOption("stringsAsFactors")){
	  options(stringsAsFactors = F)
	  factor_change <- TRUE
	}
	  
	  queryBody <- paste0("{
						  \"method\": \"get\",
						  \"params\": {
						  \"DictionaryNames\": [ \"",DictionaryName,"\" ]
	}
	}")
  
  # send query
  answer <- POST("https://api.direct.yandex.com/json/v5/dictionaries", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = Language, "Client-Login" = Login[1]))
  # check status
  stop_for_status(answer)
  # parse
  dataRaw <- content(answer, "parsed", "application/json")
  
  if(length(dataRaw$error) > 0){
    stop(paste0(dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
  }
  
  # convert to data.frame
  
  # georegions
  if(DictionaryName == "GeoRegions"){
  dictionary_df <- data.frame()

  for(dr in 1:length(dataRaw$result[[1]])){
    dictionary_df_temp <- data.frame(GeoRegionId = dataRaw$result[[1]][[dr]]$GeoRegionId,
                                     ParentId = ifelse(is.null(dataRaw$result[[1]][[dr]]$ParentId),NA , dataRaw$result[[1]][[dr]]$ParentId),
                                     GeoRegionType = dataRaw$result[[1]][[dr]]$GeoRegionType,
                                     GeoRegionName = dataRaw$result[[1]][[dr]]$GeoRegionName)
    dictionary_df <- rbind(dictionary_df, dictionary_df_temp)
    
  }}

  # cur
  if(DictionaryName == "Currencies"){
    dictionary_df <- data.frame()
    for(dr in dataRaw$result$Currencies){
      dictionary_df_temp <- data.frame(Currency                = dr$Currency,
                                       BidIncrement            = as.numeric(dr$Properties[[1]]$Value) / 1000000,
                                       FullName                = dr$Properties[[2]]$Value,
                                       MaximumBid              = as.numeric(dr$Properties[[3]]$Value) / 1000000,
                                       MinimumAverageCPA       = as.numeric(dr$Properties[[4]]$Value) / 1000000,
                                       MinimumAverageCPC       = as.numeric(dr$Properties[[5]]$Value) / 1000000,
                                       MinimumCPM              = as.numeric(dr$Properties[[6]]$Value) / 1000000,
                                       MaximumCPM              = as.numeric(dr$Properties[[7]]$Value) / 1000000,
                                       MinimumBid              = as.numeric(dr$Properties[[8]]$Value) / 1000000,
                                       MinimumDailyBudget      = as.numeric(dr$Properties[[9]]$Value) / 1000000,
                                       MinimumPayment          = as.numeric(dr$Properties[[10]]$Value) / 1000000,
                                       MinimumTransferAmount   = as.numeric(dr$Properties[[11]]$Value) / 1000000,
                                       MinimumWeeklySpendLimit = as.numeric(dr$Properties[[12]]$Value) / 1000000)
      
      dictionary_df <- rbind(dictionary_df, dictionary_df_temp)
    }
    
  }
  
  # Interests
  if(DictionaryName == "Interests"){
    dictionary_df <- data.frame()
    for(dr in 1:length(dataRaw$result[[1]])){
      dictionary_df_temp <- data.frame(Name = dataRaw$result[[1]][[dr]]$Name,
                                       ParentId = ifelse(is.null(dataRaw$result[[1]][[dr]]$ParentId),NA , dataRaw$result[[1]][[dr]]$ParentId),
                                       InterestId = dataRaw$result[[1]][[dr]]$InterestId,
                                       IsTargetable = dataRaw$result[[1]][[dr]]$IsTargetable)
      dictionary_df <- rbind(dictionary_df, dictionary_df_temp)
    }
  }
  
  # pars dict with standart structure
  if(! DictionaryName %in% c("Currencies","GeoRegions","Interests")){
    dictionary_df <- do.call(rbind.data.frame, dataRaw$result[[1]])
    }
  
  # back string as factor value
  if(factor_change){
  options(stringsAsFactors = T)
  }
  
  # technical info message
   packageStartupMessage("Directory successfully loaded!", appendLF = T)
   packageStartupMessage(paste0("Points are deducted from: " ,answer$headers$`units-used-login`), appendLF = T)
   packageStartupMessage(paste0("Number of API points spent when executing the request: " ,strsplit(answer$headers$units, "/")[[1]][1]), appendLF = T)
   packageStartupMessage(paste0("Available balance of daily limit API points: " ,strsplit(answer$headers$units, "/")[[1]][2]), appendLF = T)
   packageStartupMessage(paste0("Daily limit of API points:" ,strsplit(answer$headers$units, "/")[[1]][3]), appendLF = T)
   packageStartupMessage(paste0("Reqiest ID that must be specified when contacting support:: ",answer$headers$requestid), appendLF = T)
  
  # result
  return(dictionary_df)
}


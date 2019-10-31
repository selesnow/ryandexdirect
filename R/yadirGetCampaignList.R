yadirGetCampaignList <-
  function (Logins          = NULL, 
            States          = c("OFF","ON","SUSPENDED","ENDED","CONVERTED","ARCHIVED"),
            Types           = c("TEXT_CAMPAIGN","MOBILE_APP_CAMPAIGN","DYNAMIC_TEXT_CAMPAIGN","CPM_BANNER_CAMPAIGN"),
            Statuses        = c("ACCEPTED","DRAFT","MODERATION","REJECTED"),
            StatusesPayment = c("DISALLOWED","ALLOWED"),
            Token           = NULL,
            AgencyAccount = NULL,
            TokenPath     = getwd()) {
    
	# depricating
    .Deprecated(new = "yadirGetCampaign()", 
                package = "ryandexdirect", 
                old = "yadirGetCampaignList()")
				
    # start time
    start_time  <- Sys.time()
    
    # result frame
    result       <- data.frame(Id = character(0),
                               Name = character(0),
                               Type = character(0),
                               Status = character(0),
                               State = character(0),
                               DailyBudgetAmount = double(0),
                               DailyBudgetMode = character(0),
                               Currency = character(0),
                               StartDate = as.Date(character(0)),
                               Impressions = integer(0),
                               Clicks = integer(0),
                               ClientInfo = character(0),
                               TextCampBidStrategySearchType   = character(0),
                               TextCampBidStrategyNetworkType  = character(0),
                               DynCampBidStrategySearchType    = character(0),
                               DynCampBidStrategyNetworkType   = character(0),
                               MobCampBidStrategySearchType    = character(0),
                               MobCampBidStrategyNetworkType   = character(0),
                               CpmBannerBidStrategySearchType  = character(0),
                               CpmBannerBidStrategyNetworkType = character(0),
                               Login = character(0),
                               stringsAsFactors=FALSE)
    
    # filters
    States          <- paste("\"",States,"\"",collapse=", ",sep="")
    Types           <- paste("\"",Types,"\"",collapse=", ",sep="")
    Statuses        <- paste("\"",Statuses,"\"",collapse=", ",sep="")
    StatusesPayment <- paste("\"",StatusesPayment,"\"",collapse=", ",sep="")
    
    # offset
    lim <- 0
    
    # start message
    packageStartupMessage("Processing", appendLF = F)
    
    while(lim != "stoped") {  
      # compose query body
      queryBody <- paste0("{
                          \"method\": \"get\",
                          \"params\": { 
                          \"SelectionCriteria\": {
                          \"States\": [",States,"],        
                          \"Types\": [",Types,"],
                          \"StatusesPayment\": [",StatusesPayment,"],
                          \"Statuses\": [",Statuses,"]},
                          \"FieldNames\": [
                                      \"Id\",
                                      \"Name\",
                                      \"Type\",
                                      \"StartDate\",
                                      \"Status\",
                                      \"State\",
                                      \"Statistics\",
                                      \"Currency\",
                                      \"DailyBudget\",
                                      \"ClientInfo\"],
                          \"TextCampaignFieldNames\": [\"BiddingStrategy\"],
                          \"MobileAppCampaignFieldNames\": [\"BiddingStrategy\"],
                          \"DynamicTextCampaignFieldNames\": [\"BiddingStrategy\"],
                          \"CpmBannerCampaignFieldNames\": [\"BiddingStrategy\"],
                          \"Page\": {  
                          \"Limit\": 10000,
                          \"Offset\": ",lim,"
    }
    }
    }")

      
      
      for(l in 1:length(Logins)){
        # auth
        Token <- tech_auth(login = Logins[l], token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
        
        answer <- POST("https://api.direct.yandex.com/json/v5/campaigns", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru","Client-Login" = Logins[l]))
        # check answer status
        stop_for_status(answer)
        dataRaw <- content(answer, "parsed", "application/json")
        
        if(length(dataRaw$error) > 0){
          stop(paste0(dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
        }
        
        # parsing
        for (i in 1:length(dataRaw$result$Campaigns)){
          
          try(result <- rbind(result,
                              data.frame(Id                              = dataRaw$result$Campaigns[[i]]$Id,
                                         Name                            = dataRaw$result$Campaigns[[i]]$Name,
                                         Type                            = dataRaw$result$Campaigns[[i]]$Type,
                                         Status                          = dataRaw$result$Campaigns[[i]]$Status,
                                         State                           = dataRaw$result$Campaigns[[i]]$State,
                                         DailyBudgetAmount               = ifelse(is.null(dataRaw$result$Campaigns[[i]]$DailyBudget$Amount), NA, dataRaw$result$Campaigns[[i]]$DailyBudget$Amount / 1000000),
                                         DailyBudgetMode                 = ifelse(is.null(dataRaw$result$Campaigns[[i]]$DailyBudget$Mode), NA, dataRaw$result$Campaigns[[i]]$DailyBudget$Mode),
                                         Currency                        = dataRaw$result$Campaigns[[i]]$Currency,
                                         StartDate                       = dataRaw$result$Campaigns[[i]]$StartDate,
                                         Impressions                     = ifelse(is.null(dataRaw$result$Campaigns[[i]]$Statistics$Impressions), NA,dataRaw$result$Campaigns[[i]]$Statistics$Impressions),
                                         Clicks                          = ifelse(is.null(dataRaw$result$Campaigns[[i]]$Statistics$Clicks), NA,dataRaw$result$Campaigns[[i]]$Statistics$Clicks),
                                         ClientInfo                      = dataRaw$result$Campaigns[[i]]$ClientInfo,
                                         TextCampBidStrategySearchType   = ifelse(is.null(dataRaw$result$Campaigns[[i]]$TextCampaign$BiddingStrategy$Search$BiddingStrategyType), "", dataRaw$result$Campaigns[[i]]$TextCampaign$BiddingStrategy$Search$BiddingStrategyType),
                                         TextCampBidStrategyNetworkType  = ifelse(is.null(dataRaw$result$Campaigns[[i]]$TextCampaign$BiddingStrategy$Network$BiddingStrategyType), "", dataRaw$result$Campaigns[[i]]$TextCampaign$BiddingStrategy$Network$BiddingStrategyType),
                                         DynCampBidStrategySearchType    = ifelse(is.null(dataRaw$result$Campaigns[[i]]$DynamicTextCampaign$BiddingStrategy$Search$BiddingStrategyType), "", dataRaw$result$Campaigns[[i]]$DynamicTextCampaign$BiddingStrategy$Search$BiddingStrategyType),
                                         DynCampBidStrategyNetworkType   = ifelse(is.null(dataRaw$result$Campaigns[[i]]$DynamicTextCampaign$BiddingStrategy$Network$BiddingStrategyType), "", dataRaw$result$Campaigns[[i]]$DynamicTextCampaign$BiddingStrategy$Network$BiddingStrategyType),
                                         MobCampBidStrategySearchType    = ifelse(is.null(dataRaw$result$Campaigns[[i]]$MobileAppCampaign$BiddingStrategy$Search$BiddingStrategyType), "", dataRaw$result$Campaigns[[i]]$MobileAppCampaign$BiddingStrategy$Search$BiddingStrategyType),
                                         MobCampBidStrategyNetworkType   = ifelse(is.null(dataRaw$result$Campaigns[[i]]$MobileAppCampaign$BiddingStrategy$Network$BiddingStrategyType), "", dataRaw$result$Campaigns[[i]]$MobileAppCampaign$BiddingStrategy$Network$BiddingStrategyType),
                                         CpmBannerBidStrategySearchType  = ifelse(is.null(dataRaw$result$Campaigns[[i]]$CpmBannerCampaign$BiddingStrategy$Search$BiddingStrategyType), "", dataRaw$result$Campaigns[[i]]$CpmBannerCampaign$BiddingStrategy$Search$BiddingStrategyType),
                                         CpmBannerBidStrategyNetworkType = ifelse(is.null(dataRaw$result$Campaigns[[i]]$CpmBannerCampaign$BiddingStrategy$Network$BiddingStrategyType), "", dataRaw$result$Campaigns[[i]]$CpmBannerCampaign$BiddingStrategy$Network$BiddingStrategyType),
                                         Login                           = Logins[l])), silent = T)
          
        }
      }
      
      # add progres
      packageStartupMessage(".", appendLF = F)
      # check for next iteraction
      lim <- ifelse(is.null(dataRaw$result$LimitedBy), "stoped",dataRaw$result$LimitedBy + 1)
    }
    
    # convert to factor
    result$Type     <- as.factor(result$Type)
    result$Status   <- as.factor(result$Status)
    result$State    <- as.factor(result$State)
    result$Currency <- as.factor(result$Currency)
    result$SearchBidStrategyType  <- paste0(result$TextCampBidStrategySearchType, result$DynCampBidStrategySearchType, result$MobCampBidStrategySearchType, result$CpmBannerBidStrategySearchType)
    result$NetworkBidStrategyType <- paste0(result$TextCampBidStrategyNetworkType, result$DynCampBidStrategyNetworkType, result$MobCampBidStrategyNetworkType, result$CpmBannerBidStrategyNetworkType)
    
    # removing
    result$TextCampBidStrategySearchType   <- NULL
    result$TextCampBidStrategyNetworkType  <- NULL
    result$DynCampBidStrategySearchType    <- NULL
    result$DynCampBidStrategyNetworkType   <- NULL
    result$MobCampBidStrategySearchType    <- NULL
    result$MobCampBidStrategyNetworkType   <- NULL
    result$CpmBannerBidStrategySearchType  <- NULL
    result$CpmBannerBidStrategyNetworkType <- NULL
    
    # end timr
    stop_time <- Sys.time()
    
    # out message
    packageStartupMessage("Done", appendLF = T)
    packageStartupMessage(paste0("Number of load campaings: ", nrow(result)), appendLF = T)
    packageStartupMessage(paste0("Processing durations: ", round(difftime(stop_time, start_time , units ="secs"),0), " sec."), appendLF = T)
    
    # result
    return(result)
  }

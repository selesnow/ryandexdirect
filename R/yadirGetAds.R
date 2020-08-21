yadirGetAds <- function(CampaignIds   = NULL,
                        AdGroupIds    = NA,
                        Ids           = NA,
                        Types         = c("TEXT_AD", "MOBILE_APP_AD", "DYNAMIC_TEXT_AD", "IMAGE_AD",
                                          "CPC_VIDEO_AD", "CPM_BANNER_AD", "CPM_VIDEO_AD", "SMART_AD"),
                        States        = c("OFF","ON","SUSPENDED","OFF_BY_MONITORING","ARCHIVED"),
                        Login         = getOption("ryandexdirect.user"),
                        Token         = NULL,
                        AgencyAccount = getOption("ryandexdirect.agency_account"),
                        TokenPath     = yadirTokenPath()){

  # auth
  Token <- tech_auth(login = Login, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)

  # check campaign filter
  if ( is.null(CampaignIds) ) {
    message("You dont choised any ids of campaign, adgroup or ad. Loading full campaign list.")
    CampaignIds <-  yadirGetCampaign(Logins        = Login,
                                     AgencyAccount = AgencyAccount,
                                     Token         = Token,
                                     TokenPath     = TokenPath)$Id
  }

  # set start time
  start_time  <- Sys.time()

  # result frame
  result      <- data.frame(Id                            = integer(0),
                            AdGroupId                     = integer(0),
                            CampaignId                    = integer(0),
                            Type                          = character(0),
                            Subtype                       = character(0),
                            Status                        = character(0),
                            AgeLabel                      = character(0),
                            State                         = character(0),
                            TextAdTitle                   = character(0),
                            TextAdTitle2                  = character(0),
                            TextAdText                    = character(0),
                            TextAdHref                    = character(0),
                            TextAdDisplayDomain           = character(0),
                            TextAdMobile                  = character(0),
                            TextImageAdHref               = character(0),
                            TextImageAdTurboPageId         = character(0),
                            TextMediaAdHref               = character(0),
                            TextAdSitelinkSetId           = integer(0),
                            DynamicTextAdText             = character(0),
                            DynamicTextAdSitelinkSetId    = integer(0),
                            SmartAdBuilderAdCreative      = character(0),
                            SmartAdBuilderThumbnailUrl    = character(0),
                            SmartAdBuilderPreviewUrl      = character(0),
                            CpmBannerAdBuilderHref        = character(0),
                            CpmBannerAdBuilderTurboPageId = character(0),
                            CpcVideoAdBuilderHref         = character(0),
                            CpcVideoAdBuilderTurboPageId  = character(0),
                            CpmVideoAdBuilderHref         = character(0),
                            CpmVideoAdBuilderTurboPageId  = character(0))

  # states to json for query
  States          <- paste("\"",States,"\"",collapse=", ",sep="")
  Types           <- paste("\"",Types,"\"",collapse=", ",sep="")

  # camp queue
  camp_num     <- as.integer(length(CampaignIds))
  camp_start   <- 1
  camp_step    <- 10

  packageStartupMessage("Processing", appendLF = F)

  # campaign cicle
  while(camp_start <= camp_num){

    # how ,ani campaing need processing
    camp_step   <-  if(camp_num - camp_start >= 10) camp_step else camp_num - camp_start + 1

    # prepare camp list for iteration
    Ids             <- ifelse(any(is.na(Ids)), NA,paste0(Ids, collapse = ","))
    AdGroupIds      <- ifelse(any(is.na(AdGroupIds)),NA,paste0(AdGroupIds, collapse = ","))
    CampaignIdsTmp  <- paste("\"",CampaignIds[camp_start:(camp_start + camp_step - 1)],"\"",collapse=", ",sep="")

    # lim offset
    lim <- 0

    while(lim != "stoped"){

      queryBody <- paste0("{
                          \"method\": \"get\",
                          \"params\": {
                          \"SelectionCriteria\": {
                          \"CampaignIds\": [", CampaignIdsTmp, "],
                          ", ifelse(is.na(Ids), "", paste0("\"Ids\": [",Ids, "],")), "
                          ",ifelse(is.na(AdGroupIds), "", paste0("\"AdGroupIds\": [", AdGroupIds, "],")),"
                          \"States\": [",States, "],
                          \"Types\": [",Types,"]
    },
                          \"FieldNames\": [
                              \"Id\",
                              \"CampaignId\",
                              \"AdGroupId\",
                              \"Status\",
                              \"State\",
                              \"AgeLabel\",
                              \"Type\",
                              \"Subtype\"],
                          \"TextAdFieldNames\": [
                              \"Title\",
                              \"Title2\",
                              \"Text\",
                              \"Href\",
                              \"Mobile\",
                              \"SitelinkSetId\",
                              \"DisplayDomain\"],
                          \"TextImageAdFieldNames\": [
                              \"Href\"],
                          \"DynamicTextAdFieldNames\": [
                              \"Text\",
                              \"SitelinkSetId\"],
                          \"CpcVideoAdBuilderAdFieldNames\": [
                              \"Creative\",
                              \"Href\",
                              \"TurboPageId\"],
                          \"CpmBannerAdBuilderAdFieldNames\": [
                              \"Creative\",
                              \"Href\",
                              \"TurboPageId\"],
                          \"CpmVideoAdBuilderAdFieldNames\": [
                              \"Creative\",
                              \"Href\",
                              \"TurboPageId\"],
                          \"SmartAdBuilderAdFieldNames\": [
                              \"Creative\"],
                          \"Page\": {
                          \"Limit\": 10000,
                          \"Offset\": ",
                          lim, "}
    }
    }")

      answer <- POST("https://api.direct.yandex.com/json/v5/ads", 
                     body = queryBody, 
                     add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru",'Client-Login' = Login))
      
      stop_for_status(answer)
      
      dataRaw <- content(answer, "parsed", "application/json")

      # check erroe
      if(length(dataRaw$error) > 0){
        stop(paste0(dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
      }

      # parse list and add to result frame
      if (length(dataRaw$result$Ads) > 0){
        for(ads_i in seq_along(1:length(dataRaw$result$Ads))){
          result      <- rbind(result,
                               data.frame(Id                            = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$Id), NA,dataRaw$result$Ads[[ads_i]]$Id),
                                          AdGroupId                     = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$AdGroupId), NA,dataRaw$result$Ads[[ads_i]]$AdGroupId),
                                          CampaignId                    = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$CampaignId), NA,dataRaw$result$Ads[[ads_i]]$CampaignId),
                                          Type                          = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$Type), NA,dataRaw$result$Ads[[ads_i]]$Type),
                                          Subtype                       = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$Subtype), NA,dataRaw$result$Ads[[ads_i]]$Subtype),
                                          Status                        = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$Status), NA,dataRaw$result$Ads[[ads_i]]$Status),
                                          AgeLabel                      = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$AgeLabel), NA,dataRaw$result$Ads[[ads_i]]$AgeLabel),
                                          State                         = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$State), NA,dataRaw$result$Ads[[ads_i]]$State),
                                          TextAdTitle                   = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$TextAd$Title), NA,dataRaw$result$Ads[[ads_i]]$TextAd$Title),
                                          TextAdTitle2                  = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$TextAd$Title2), NA,dataRaw$result$Ads[[ads_i]]$TextAd$Title2),
                                          TextAdText                    = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$TextAd$Text), NA,dataRaw$result$Ads[[ads_i]]$TextAd$Text),
                                          TextAdHref                    = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$TextAd$Href), NA,dataRaw$result$Ads[[ads_i]]$TextAd$Href),
                                          TextAdDisplayDomain           = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$TextAd$DisplayDomain), NA,dataRaw$result$Ads[[ads_i]]$TextAd$DisplayDomain),
                                          TextAdMobile                  = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$TextAd$Mobile), NA,dataRaw$result$Ads[[ads_i]]$TextAd$Mobile),
                                          TextImageAdHref               = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$TextImageAd$Href), NA,dataRaw$result$Ads[[ads_i]]$TextImageAd$Href),
                                          TextImageAdTurboPageId        = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$TextImageAd$TurboPageId), NA,dataRaw$result$Ads[[ads_i]]$TextImageAd$TurboPageId),
                                          TextMediaAdHref               = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$CpmBannerAdBuilderAd$Href), NA, dataRaw$result$Ads[[ads_i]]$CpmBannerAdBuilderAd$Href),
                                          TextAdSitelinkSetId           = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$TextAd$SitelinkSetId), NA, dataRaw$result$Ads[[ads_i]]$TextAd$SitelinkSetId),
                                          DynamicTextAdText             = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$DynamicTextAd$Text), NA, dataRaw$result$Ads[[ads_i]]$DynamicTextAd$Text),
                                          DynamicTextAdSitelinkSetId    = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$DynamicTextAd$SitelinkSetId), NA, dataRaw$result$Ads[[ads_i]]$DynamicTextAd$SitelinkSetId),
                                          SmartAdBuilderAdCreativeId    = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$SmartAdBuilderAd$Creative$CreativeId), NA, dataRaw$result$Ads[[ads_i]]$SmartAdBuilderAd$Creative$CreativeId),
                                          SmartAdBuilderThumbnailUrl    = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$SmartAdBuilderAd$Creative$ThumbnailUrl), NA, dataRaw$result$Ads[[ads_i]]$SmartAdBuilderAd$Creative$ThumbnailUrl),
                                          SmartAdBuilderPreviewUrl      = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$SmartAdBuilderAd$Creative$PreviewUrl), NA, dataRaw$result$Ads[[ads_i]]$SmartAdBuilderAd$Creative$PreviewUrl),
                                          CpmBannerAdBuilderHref        = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$CpmBannerAdBuilderAd$Href), NA, dataRaw$result$Ads[[ads_i]]$CpmBannerAdBuilderAd$Href),
                                          CpmBannerAdBuilderTurboPageId = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$CpmBannerAdBuilderAd$TurboPageId), NA, dataRaw$result$Ads[[ads_i]]$CpmBannerAdBuilderAd$TurboPageId),
                                          CpcVideoAdBuilderHref         = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$CpcVideoAdBuilderAd$Href), NA, dataRaw$result$Ads[[ads_i]]$CpcVideoAdBuilderAd$Href),
                                          CpcVideoAdBuilderTurboPageId  = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$CpcVideoAdBuilderAd$TurboPageId), NA, dataRaw$result$Ads[[ads_i]]$CpcVideoAdBuilderAd$TurboPageId),
                                          CpmVideoAdBuilderHref         = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$CpmVideoAdBuilderAd$Href), NA, dataRaw$result$Ads[[ads_i]]$CpmVideoAdBuilderAd$Href),
                                          CpmVideoAdBuilderTurboPageId  = ifelse(is.null(dataRaw$result$Ads[[ads_i]]$CpmVideoAdBuilderAd$TurboPageId), NA, dataRaw$result$Ads[[ads_i]]$CpmVideoAdBuilderAd$TurboPageId))
                                          )
        }
        # add point to progress bar
        packageStartupMessage(".", appendLF = F)
      }
      # if last iteration change lim
      lim <- ifelse(is.null(dataRaw$result$LimitedBy), "stoped",dataRaw$result$LimitedBy + 1)
    }

    # set offset to next iteration
    camp_start <- camp_start + camp_step
  }

  # set finish time
  stop_time <- Sys.time()

  # tech messages
  packageStartupMessage("Done", appendLF = T)
  packageStartupMessage(paste0("Number of load ads: ", nrow(result)), appendLF = T)
  packageStartupMessage(paste0("Duration: ", round(difftime(stop_time, start_time , units ="secs"),0), " sec."), appendLF = T)
  # return of result
  return(result)}

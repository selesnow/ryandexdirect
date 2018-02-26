yadirGetKeyWords <- function(CampaignIds = "14163546", 
                             AdGroupIds = NA, 
                             Ids = NA, 
                             States = c("OFF","ON","SUSPENDED"), 
                             WithStats = T,
                             Login,
                             Token){
  
  if(is.null(Login)|is.null(Token)) {
    stop("You must enter login and API token!")
  }
  
  #Г”ГЁГЄГ±ГЁГ°ГіГҐГ¬ ГўГ°ГҐГ¬Гї Г­Г Г·Г Г«Г  Г°Г ГЎГ®ГІГ»
  start_time  <- Sys.time()
  
  #ГђГҐГ§ГіГ«ГјГІГЁГ°ГіГѕГ№ГЁГ© Г¤Г ГІГ  ГґГ°ГҐГ©Г¬
  result      <- data.frame(Id                            = integer(0), 
                            Keyword                       = character(0),
                            AdGroupId                     = integer(0),
                            CampaignId                    = integer(0),
                            ServingStatus                 = character(0),
                            State                         = character(0),
                            Status                        = character(0),
                            StrategyPriority              = character(0), 
                            StatisticsSearchImpressions   = integer(0),
                            StatisticsSearchClicks        = integer(0),
                            StatisticsNetworkImpressions  = integer(0),
                            StatisticsNetworkClicks       = integer(0),
                            UserParam1                    = character(0),
                            UserParam2                    = character(0),
                            ProductivityValue             = numeric(0),
                            ProductivityReferences        = character(0),
                            Bid                           = integer(0),
                            ContextBid                    = integer(0))
  
  #ГЏГҐГ°ГҐГўГ®Г¤ГЁГ¬ ГґГЁГ«ГјГІГ° ГЇГ® Г±ГІГ ГІГіГ±Гі Гў json
  States          <- paste("\"",States,"\"",collapse=", ",sep="")
  
  #ГЋГЇГ°ГҐГ¤ГҐГ«ГїГҐГ¬ ГЄГ®Г«ГЁГ·ГҐГ±ГІГўГ® ГЄГ Г¬ГЇГ Г­ГЁГ© ГЄГ®ГІГ®Г°Г®ГҐ ГІГ°ГҐГЎГіГҐГІГ±Гї Г®ГЎГ°Г ГЎГ®ГІГ ГІГј
  camp_num     <- as.integer(length(CampaignIds))
  camp_start   <- 1
  camp_step    <- 10
  
  packageStartupMessage("Processing", appendLF = F)
  #Г‡Г ГЇГіГ±ГЄГ ГҐГ¬ Г¶ГЁГЄГ« Г®ГЎГ°Г ГЎГ®ГІГЄГЁ ГЄГ Г¬ГЇГ Г­ГЁГ©
  while(camp_start <= camp_num){
    
    #Г®ГЇГ°ГҐГ¤ГҐГ«ГїГҐГ¬ ГЄГ ГЄГ®ГҐ ГЄ-ГўГ® ГђГЉ Г­Г Г¤Г® Г®ГЎГ°Г ГЎГ®ГІГ ГІГј
    camp_step   <-  if(camp_num - camp_start > 10) camp_step else camp_num - camp_start + 1
    
    #ГЏГ°ГҐГ®ГЎГ°Г Г§ГіГҐГ¬ Г±ГЇГЁГ±Г®ГЄ Г°ГҐГЄГ«Г Г¬Г­Г»Гµ ГЄГ Г¬ГЇГ Г­ГЁГ©
    Ids             <- ifelse(is.na(Ids), NA,paste0(Ids, collapse = ","))
    AdGroupIds      <- ifelse(is.na(AdGroupIds),NA,paste0(AdGroupIds, collapse = ","))
    CampaignIdsTmp  <- paste("\"",CampaignIds[camp_start:(camp_start + camp_step - 1)],"\"",collapse=", ",sep="")
    
    #Г‡Г Г¤Г ВёГ¬ Г­Г Г·Г Г«ГјГ­Г»Г© offset
    lim <- 0
    
    while(lim != "stoped"){
      
      queryBody <- paste0("{
                          \"method\": \"get\",
                          \"params\": {
                          \"SelectionCriteria\": {
                          \"CampaignIds\": [",CampaignIdsTmp,"],
                          ",ifelse(is.na(Ids),"",paste0("\"Ids\": [",Ids,"],")),"        
                          ",ifelse(is.na(AdGroupIds),"",paste0("\"AdGroupIds\": [",AdGroupIds,"],")),"
                          \"States\": [",States,"]
    },
                          
                          \"FieldNames\": [
                              \"Id\",
                              \"CampaignId\",
                              \"AdGroupId\",
                              \"Keyword\",
                              \"UserParam1\",
                              \"UserParam2\",
                              \"Bid\",
                              \"ContextBid\",
                              \"StrategyPriority\",
                              \"Status\",
                              \"ServingStatus\",
                              \"State\",
                              \"Productivity\"
                              ",ifelse(WithStats == F, "",",\"StatisticsSearch\""),
                                ifelse(WithStats == F, "",",\"StatisticsNetwork\""),"],
                          \"Page\": {  
                              \"Limit\": 10000,
                              \"Offset\": ",lim,"}
    }
    }")

      answer <- POST("https://api.direct.yandex.com/json/v5/keywords", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru",'Client-Login' = Login))
      stop_for_status(answer)
      dataRaw <- content(answer, "parsed", "application/json")
      
      #ГЏГ°Г®ГўГҐГ°ГЄГ  Г­ГҐ ГўГҐГ°Г­ГіГ« Г«ГЁ Г§Г ГЇГ°Г®Г± Г®ГёГЁГЎГЄГі
      if(length(dataRaw$error) > 0){
        stop(paste0(dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
      }
      
      
      #ГЏГ Г°Г±ГҐГ° Г®ГІГўГҐГІГ 
      for(Keywords_i in 1:length(dataRaw$result$Keywords)){
        result      <- rbind(result,
                             data.frame(Id                            = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$Id), NA,dataRaw$result$Keywords[[Keywords_i]]$Id),
                                        Keyword                       = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$Keyword), NA,dataRaw$result$Keyword[[Keywords_i]]$Keyword),
                                        AdGroupId                     = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$AdGroupId), NA,dataRaw$result$Keywords[[Keywords_i]]$AdGroupId),
                                        CampaignId                    = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$CampaignId), NA,dataRaw$result$Keywords[[Keywords_i]]$CampaignId),
                                        ServingStatus                 = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$ServingStatus), NA,dataRaw$result$Keywords[[Keywords_i]]$ServingStatus),
                                        State                         = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$State), NA,dataRaw$result$Keywords[[Keywords_i]]$State),
                                        Status                        = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$Status), NA,dataRaw$result$Keywords[[Keywords_i]]$Status),
                                        StrategyPriority              = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$StrategyPriority), NA,dataRaw$result$Keywords[[Keywords_i]]$StrategyPriority), 
                                        StatisticsSearchImpressions   = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$StatisticsSearch$Impressions)|WithStats == F, NA,dataRaw$result$Keywords[[Keywords_i]]$StatisticsSearch$Impressions),
                                        StatisticsSearchClicks        = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$StatisticsSearch$Clicks)|WithStats == F, NA,dataRaw$result$Keywords[[Keywords_i]]$StatisticsSearch$Clicks),
                                        StatisticsNetworkImpressions  = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$StatisticsNetwork$Impressions)|WithStats == F, NA,dataRaw$result$Keywords[[Keywords_i]]$StatisticsNetwork$Impressions),
                                        StatisticsNetworkClicks       = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$StatisticsNetwork$Clicks|WithStats) == F, NA,dataRaw$result$Keywords[[Keywords_i]]$StatisticsNetwork$Clicks),
                                        UserParam1                    = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$UserParam1), NA,dataRaw$result$Keywords[[Keywords_i]]$UserParam1),
                                        UserParam2                    = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$UserParam2), NA,dataRaw$result$Keywords[[Keywords_i]]$UserParam2),
                                        ProductivityValue             = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$Productivity$Value), NA,dataRaw$result$Keywords[[Keywords_i]]$Productivity$Value),
                                        ProductivityReferences        = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$Productivity$References), NA,paste(dataRaw$result$Keywords[[Keywords_i]]$Productivity$References,collapse = "," )),
                                        Bid                           = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$Bid), NA,dataRaw$result$Keywords[[Keywords_i]]$Bid / 1000000),
                                        ContextBid                    = ifelse(is.null(dataRaw$result$Keywords[[Keywords_i]]$ContextBid), NA,dataRaw$result$Keywords[[Keywords_i]]$ContextBid / 1000000)))
      }
      #Г„Г®ГЎГ ГўГ«ГїГҐГ¬ ГІГ®Г·ГЄГі, Г·ГІГ® ГЇГ°Г®Г¶ГҐГ±Г± Г§Г ГЈГ°ГіГ§ГЄГЁ ГЁГ¤ВёГІ
      packageStartupMessage(".", appendLF = F)
      #ГЏГ°Г®ГўГҐГ°ГїГҐГ¬ Г®Г±ГІГ Г«ГЁГ±Гј Г«ГЁ ГҐГ№Вё Г±ГІГ°Г®ГЄГЁ ГЄГ®ГІГ®Г°Г»ГҐ Г­Г Г¤Г® Г§Г ГЎГ°Г ГІГј
      lim <- ifelse(is.null(dataRaw$result$LimitedBy), "stoped",dataRaw$result$LimitedBy + 1)
    }
    
    #ГЋГЇГ°ГҐГ¤ГҐГ«ГїГҐГ¬ Г±Г«ГҐГ¤ГіГѕГ№ГЁГ© ГЇГіГ« ГЄГ Г¬ГЇГ Г­ГЁГ©
    camp_start <- camp_start + camp_step
  }
  
  #Г”ГЁГЄГ±ГЁГ°ГіГҐГ¬ ГўГ°ГҐГ¬Гї Г§Г ГўГҐГ°ГёГҐГ­ГЁГї Г®ГЎГ°Г ГЎГ®ГІГЄГЁ
  stop_time <- Sys.time()
  
  #Г‘Г®Г®ГЎГ№ГҐГ­ГЁГҐ Г® ГІГ®Г¬, Г·ГІГ® Г§Г ГЈГ°ГіГ§ГЄГ  Г¤Г Г­Г­Г»Гµ ГЇГ°Г®ГёГ«Г  ГіГ±ГЇГҐГёГ­Г®
  #Сообщение о том, что загрузка данных прошла успешно
  packageStartupMessage("Done", appendLF = T)
  packageStartupMessage(paste0("Количество полученных ключевых слов: ", nrow(result)), appendLF = T)
  packageStartupMessage(paste0("Длительность работы: ", round(difftime(stop_time, start_time , units ="secs"),0), " сек."), appendLF = T)
  #Г‚Г®Г§ГўГ°Г Г№Г ГҐГ¬ Г°ГҐГ§ГіГ«ГјГІГ ГІ
  return(result)}

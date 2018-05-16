yadirGetAdGroups <- function(CampaignIds   = NULL, 
                             AdGroupIds    = NA, 
                             Ids           = NA, 
                             Types         = c("TEXT_AD_GROUP" ,"MOBILE_APP_AD_GROUP" ,"DYNAMIC_TEXT_AD_GROUP"),
                             Statuses      = c( "ACCEPTED", "DRAFT", "MODERATION", "PREACCEPTED", "REJECTED"), 
                             Login         = NULL,
                             AgencyAccount = NULL,
                             Token         = NULL,
                             TokenPath     = getwd()){
  
  #Фиксируем время начала работы
  start_time  <- Sys.time()
  
  #Авторизация
  Token <- tech_auth(login = Login, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  
  #Результирующий дата фрейм
  result      <- data.frame(Id                                                   = integer(0), 
                            Name                                                 = character(0),
                            CampaignId                                           = integer(0),
                            Type                                                 = character(0),
                            Subtype                                              = character(0),
                            Status                                               = character(0),
                            ServingStatus                                        = character(0),
                            NegativeKeywords                                     = character(0),
                            TrackingParams                                       = character(0),
                            RegionIds                                            = character(0),
                            RestrictedRegionIds                                  = character(0),
                            MobileAppAdGroupStoreUrl                             = character(0),
                            MobileAppAdGroupTargetDeviceType                     = character(0),
                            MobileAppAdGroupTargetCarrier                        = character(0),
                            MobileAppAdGroupTargetOperatingSystemVersion         = character(0),
                            MobileAppAdGroupAppIconModerationStatus              = character(0),
                            MobileAppAdGroupAppIconModerationStatusClarification = character(0),
                            MobileAppAdGroupAppOperatingSystemType               = character(0),
                            MobileAppAdGroupAppAvailabilityStatus                = character(0),
                            DynamicTextAdGroupDomainUrl                          = character(0),
                            DynamicTextAdGroupDomainUrlProcessingStatus          = character(0),
                            DynamicTextFeedAdGroupSource                         = character(0),
                            DynamicTextFeedAdGroupSourceType                     = character(0),
                            DynamicTextFeedAdGroupSourceProcessingStatus         = character(0))
  
  #Проверяем если не задан список рекламных кампаний загружаем его и получаем все группы
  if (is.null(CampaignIds)) {
    CampaignIds <-  yadirGetCampaignList(Login         = Login,
                                         AgencyAccount = AgencyAccount,
                                         Token         = Token,
                                         TokenPath     = TokenPath)$Id
  }
  
  #Переводим фильтр по статусу в json
  Statuses          <- paste("\"",Statuses,"\"",collapse=", ",sep="")
  Types             <- paste("\"",Types,"\"",collapse=", ",sep="")
  
  #Определяем количество кампаний которое требуется обработать
  camp_num     <- as.integer(length(CampaignIds))
  camp_start   <- 1
  camp_step    <- 10
  
  packageStartupMessage("Processing", appendLF = F)
  #Запускаем цикл обработки кампаний
  while(camp_start <= camp_num){
    
    #определяем какое к-во РК надо обработать
    camp_step   <-  if(camp_num - camp_start >= 10) camp_step else camp_num - camp_start + 1
    
    #Преобразуем список рекламных кампаний
    Ids             <- ifelse(is.na(Ids), NA,paste0(Ids, collapse = ","))
    AdGroupIds      <- ifelse(is.na(AdGroupIds),NA,paste0(AdGroupIds, collapse = ","))
    CampaignIdsTmp  <- paste("\"",CampaignIds[camp_start:(camp_start + camp_step - 1)],"\"",collapse=", ",sep="")
    
    #Задаём начальный offset
    lim <- 0
    
    while(lim != "stoped"){
      
      queryBody <- paste0("{
                          \"method\": \"get\",
                          \"params\": {
                          \"SelectionCriteria\": {
                              \"CampaignIds\": [",CampaignIdsTmp,"],
                              ",ifelse(is.na(Ids),"",paste0("\"Ids\": [",Ids,"],")),"      
                              \"Types\": [",Types,"],
                              \"Statuses\": [",Statuses,"]},
                          \"FieldNames\": [
                              \"Id\",
                              \"Name\",
                              \"CampaignId\",
                              \"RegionIds\",
                              \"RestrictedRegionIds\",
                              \"NegativeKeywords\",
                              \"TrackingParams\",
                              \"Status\",
                              \"ServingStatus\",
                              \"Type\",
                              \"Subtype\"],
                         \"MobileAppAdGroupFieldNames\":[
                              \"StoreUrl\",
                              \"TargetDeviceType\",
                              \"TargetCarrier\",
                              \"TargetOperatingSystemVersion\",
                              \"AppIconModeration\",
                              \"AppOperatingSystemType\",
                              \"AppAvailabilityStatus\"],
                         \"DynamicTextAdGroupFieldNames\":[
                              \"DomainUrl\",
                              \"DomainUrlProcessingStatus\"],
                         \"DynamicTextFeedAdGroupFieldNames\":[
                              \"Source\",
                              \"SourceType\",
                              \"SourceProcessingStatus\"],
                          \"Page\": {  
                          \"Limit\": 10000,
                          \"Offset\": ",lim,"}
    }
    }")
      
      answer <- POST("https://api.direct.yandex.com/json/v5/adgroups", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru",'Client-Login' = Login))
      stop_for_status(answer)
      dataRaw <- content(answer, "parsed", "application/json")
      
      #Проверка не вернул ли запрос ошибку
      if(length(dataRaw$error) > 0){
        stop(paste0(dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
      }
      
      #Парсер ответа
      for(adgroups_i in 1:length(dataRaw$result$AdGroups)){
        result      <- rbind(result,
                             data.frame(Id                                                   = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$Id), NA,dataRaw$result$AdGroups[[adgroups_i]]$Id), 
                                        Name                                                 = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$Name), NA,dataRaw$result$AdGroups[[adgroups_i]]$Name),
                                        CampaignId                                           = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$CampaignId), NA,dataRaw$result$AdGroups[[adgroups_i]]$CampaignId),
                                        Type                                                 = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$Type), NA,dataRaw$result$AdGroups[[adgroups_i]]$Type),
                                        Subtype                                              = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$Subtype), NA,dataRaw$result$AdGroups[[adgroups_i]]$Subtype),
                                        Status                                               = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$Status), NA,dataRaw$result$AdGroups[[adgroups_i]]$Status),
                                        ServingStatus                                        = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$ServingStatus), NA,dataRaw$result$AdGroups[[adgroups_i]]$ServingStatus),
                                        NegativeKeywords                                     = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$NegativeKeywords$Items), NA,paste0(dataRaw$result$AdGroups[[adgroups_i]]$NegativeKeywords$Items, collapse = ",")),
                                        TrackingParams                                       = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$TrackingParams), NA,dataRaw$result$AdGroups[[adgroups_i]]$TrackingParams),
                                        RegionIds                                            = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$RegionIds), NA,paste0(dataRaw$result$AdGroups[[adgroups_i]]$RegionIds, collapse = ",")),
                                        RestrictedRegionIds                                  = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$RestrictedRegionIds$Items), NA,paste0(dataRaw$result$AdGroups[[adgroups_i]]$RestrictedRegionIds$Items, collapse = ",")),
                                        MobileAppAdGroupStoreUrl                             = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$MobileAppAdGroup$StoreUrl), NA,dataRaw$result$AdGroups[[adgroups_i]]$MobileAppAdGroup$StoreUrl),
                                        MobileAppAdGroupTargetDeviceType                     = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$MobileAppAdGroup$TargetDeviceType), NA,dataRaw$result$AdGroups[[adgroups_i]]$MobileAppAdGroup$TargetDeviceType),
                                        MobileAppAdGroupTargetCarrier                        = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$MobileAppAdGroup$TargetCarrier), NA,dataRaw$result$AdGroups[[adgroups_i]]$MobileAppAdGroup$TargetCarrier),
                                        MobileAppAdGroupTargetOperatingSystemVersion         = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$MobileAppAdGroup$TargetOperatingSystemVersion), NA,dataRaw$result$AdGroups[[adgroups_i]]$TargetOperatingSystemVersion),
                                        MobileAppAdGroupAppIconModerationStatus              = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$MobileAppAdGroup$AppIconModeration$Status), NA,dataRaw$result$AdGroups[[adgroups_i]]$AppIconModeration$Status),
                                        MobileAppAdGroupAppIconModerationStatusClarification = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$MobileAppAdGroup$AppIconModeration$StatusClarification), NA,dataRaw$result$AdGroups[[adgroups_i]]$AppIconModeration$StatusClarification),
                                        MobileAppAdGroupAppOperatingSystemType               = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$MobileAppAdGroup$OperatingSystemType), NA,dataRaw$result$AdGroups[[adgroups_i]]$OperatingSystemType),
                                        MobileAppAdGroupAppAvailabilityStatus                = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$MobileAppAdGroup$AppAvailabilityStatus), NA,dataRaw$result$AdGroups[[adgroups_i]]$AppAvailabilityStatus),
                                        DynamicTextAdGroupDomainUrl                          = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$DynamicTextAdGroup$DomainUrl), NA,dataRaw$result$AdGroups[[adgroups_i]]$DynamicTextAdGroup$DomainUrl),
                                        DynamicTextAdGroupDomainUrlProcessingStatus          = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$DynamicTextAdGroup$DomainUrlProcessingStatus), NA,dataRaw$result$AdGroups[[adgroups_i]]$DynamicTextAdGroup$DomainUrlProcessingStatus),
                                        DynamicTextFeedAdGroupSource                         = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$DynamicTextFeedAdGroup$Source), NA,dataRaw$result$AdGroups[[adgroups_i]]$DynamicTextFeedAdGroup$Source),
                                        DynamicTextFeedAdGroupSourceType                     = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$DynamicTextFeedAdGroup$SourceType), NA,dataRaw$result$AdGroups[[adgroups_i]]$DynamicTextFeedAdGroup$SourceType),
                                        DynamicTextFeedAdGroupSourceProcessingStatus         = ifelse(is.null(dataRaw$result$AdGroups[[adgroups_i]]$DynamicTextFeedAdGroup$SourceProcessingStatus), NA,dataRaw$result$AdGroups[[adgroups_i]]$DynamicTextFeedAdGroup$SourceProcessingStatus)))
      }
      #Добавляем точку, что процесс загрузки идёт
      packageStartupMessage(".", appendLF = F)
      #Проверяем остались ли ещё строки которые надо забрать
      lim <- ifelse(is.null(dataRaw$result$LimitedBy), "stoped",dataRaw$result$LimitedBy + 1)
    }
    
    #Определяем следующий пул кампаний
    camp_start <- camp_start + camp_step
  }
  
  #Фиксируем время завершения обработки
  stop_time <- Sys.time()
  
  #Сообщение о том, что загрузка данных прошла успешно
  packageStartupMessage("Done", appendLF = T)
  packageStartupMessage(paste0("Количество полученных групп объявлений: ", nrow(result)), appendLF = T)
  packageStartupMessage(paste0("Длительность работы: ", round(difftime(stop_time, start_time , units ="secs"),0), " сек."), appendLF = T)
  #Возвращаем результат
  return(result)}

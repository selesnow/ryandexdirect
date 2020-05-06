yadirGetSiteLinks <- function(Login = getOption("ryandexdirect.user"),
                              Token = NULL,
                              Ids   = NULL,
                              AgencyAccount = getOption("ryandexdirect.agency_account"),
                              TokenPath     = yadirTokenPath()) {
  
  # result frame
  result <- data.frame()
  
  # auth
  Token <- tech_auth(login = Login, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  
  # set offset and limit
  offset <- 0
  limit  <- 10000
  
  dataRaw <- list()
  
  # start the cycle
  while (! is.null(dataRaw$result$LimitedBy) || offset == 0 ) {
    # body query
    queryBody <- paste0("{
                        \"method\": \"get\",
                        \"params\": {",
                          ifelse( is.null(Ids), "", paste0("\"SelectionCriteria\": { \"Ids\": [",paste0(Ids, collapse = ","),"]}," )),"
                          \"FieldNames\": [\"Id\", \"Sitelinks\"],
                          \"Page\": {  
                          \"Limit\": ",limit,",
                          \"Offset\": ",offset,"}
  }
  }")
    
    # send request API
    answer <- POST("https://api.direct.yandex.com/json/v5/sitelinks", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru",'Client-Login' = Login))
    stop_for_status(answer)
    
    # parsing
    dataRaw <- content(answer, "parsed", "application/json")
    
    # check error
    if(length(dataRaw$error) > 0){
      stop(paste0(dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
    }
    
    # parse json and to result frame
    for (i in seq_along(1:length(dataRaw$result$SitelinksSets))) {
      for (y in seq_along(1:length(dataRaw$result$SitelinksSets[[i]]$Sitelinks)))
        result <- rbind(result, 
                        data.frame(Id          = dataRaw$result$SitelinksSets[[i]]$Id,
                                   Title       = ifelse(is.null(dataRaw$result$SitelinksSets[[i]]$Sitelinks[[y]]$Title), NA, dataRaw$result$SitelinksSets[[i]]$Sitelinks[[y]]$Title),
                                   Href        = ifelse(is.null(dataRaw$result$SitelinksSets[[i]]$Sitelinks[[y]]$Href), NA, dataRaw$result$SitelinksSets[[i]]$Sitelinks[[y]]$Href),
                                   Description = ifelse(is.null(dataRaw$result$SitelinksSets[[i]]$Sitelinks[[y]]$Description), NA, dataRaw$result$SitelinksSets[[i]]$Sitelinks[[y]]$Description))
        )
    }
    
    # check of needly next iteration
    if (! is.null(dataRaw$result$LimitedBy)) {
      offset <- offset + limit
    } else {
      break
    }
  }
  
  # result
  return(result)
}

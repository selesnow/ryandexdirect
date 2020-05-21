yadirGetReport <- function(ReportType        = "CUSTOM_REPORT", 
                           DateRangeType     = "CUSTOM_DATE", 
                           DateFrom          = Sys.Date() - 31, 
                           DateTo            = Sys.Date() - 1, 
                           FieldNames        = c("CampaignName","Impressions","Clicks","Cost"), 
                           FilterList        = NULL,
                           Goals             = NULL,
                           AttributionModels = NULL,
                           IncludeVAT        = "YES",
                           IncludeDiscount   = "NO",
                           Login             = getOption("ryandexdirect.user"),
                           AgencyAccount     = getOption("ryandexdirect.agency_account"),
                           FetchBy           = NULL,
                           Token             = NULL,
                           TokenPath         = yadirTokenPath(),
						               SkipErrors        = TRUE) {
  st <- Sys.time()
  
  # for limited accounts
  limit_reached <- c()
  
  # FetchBy
  if (!is.null(FetchBy)) {
    if ((DateRangeType != "CUSTOM_DATE") && (is.null(DateFrom)) && (is.null(DateTo)))
        stop('You should use "FetchBy" parameter only with DateRangeType "CUSTOM_DATE" and existing DateFrom and DateTo.')
    #dates df
    dates <- date_ranges(DateFrom, DateTo, FetchBy)
    n <- nrow(dates)
    packageStartupMessage("Batch processing mode is enabled.")
    packageStartupMessage(paste0("Fetching data by ", tolower(FetchBy), ": from ", as.Date(DateFrom), " to ", as.Date(DateTo), "."))
    packageStartupMessage()
  } else {
    #dates df
    dates <- as.data.frame(list(DateFrom, DateTo), col.names = c("start","end"), stringsAsFactors = F)
    n <- 1
  }

  # result
  result <- data.frame()
  for (i in 1:n) {
    df <- yadirGetReportFun(ReportType, 
                            DateRangeType, 
                            dates[i, "start"], 
                            dates[i, "end"], 
                            FieldNames, 
                            FilterList,
                            Goals,
                            AttributionModels,
                            IncludeVAT,
                            IncludeDiscount,
                            Login,
                            AgencyAccount,
                            Token,
                            TokenPath,
						    SkipErrors
    )
	
	limit_reached <- attr(df, "limit_reached")
	
    result <- rbind(result, df)
  }
  
  # logs
  if (!is.null(FetchBy) && length(limit_reached) == 0) {
    packageStartupMessage('Function with batch processing mode has executed successfully.')
    packageStartupMessage("Total number of rows is: ", nrow(result))
    packageStartupMessage("Total executing time is: ", round(difftime(Sys.time(), st , units = "secs"), 0), " sec.")
  }
  
    # check limits
  if ( length(limit_reached) > 0 ) {
   attr(result, "limit_reached") <- unique(limit_reached)
  }  
  return(result)
}

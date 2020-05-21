# for check
Date <- NULL

yadirGetCostData <- function(DateFrom        = Sys.Date() - 31,
                             DateTo          = Sys.Date() - 1,
                             Source          = 'yandex',
                             Medium          = 'cpc',
                             IncludeVAT      = "YES",
                             IncludeDiscount = "NO",
                             Login           = getOption("ryandexdirect.user"),
                             AgencyAccount   = getOption("ryandexdirect.agency_account"),
                             FetchBy         = NULL,
                             Token           = NULL,
                             TokenPath       = yadirTokenPath()) {
  
  
  # run report loader
  cost_data <- yadirGetReport(ReportType = "CUSTOM_REPORT",
                              DateRangeType = "CUSTOM_DATE",
                              DateFrom = DateFrom,
                              DateTo = DateTo,
                              FieldNames = c("Date",
                                             "CampaignName", 
                                             "Criteria",
                                             "AdId",
                                             "Impressions",
                                             "Clicks", 
                                             "Cost"),
                              IncludeVAT = IncludeVAT,
                              IncludeDiscount = IncludeDiscount,
                              FetchBy = FetchBy,
                              Login = Login,
                              AgencyAccount = AgencyAccount,
                              Token = Token,
                              TokenPath = TokenPath,
                              SkipErrors = FALSE) %>%
    mutate(Date = format(as.Date(Date), "%Y%m%d")) %>%
    rename("ga:date"        = 'Date',
           "ga:campaign"    = 'CampaignName',
           "ga:keyword"     = 'Criteria',
           "ga:adContent"   = 'AdId',
           "ga:adCost"      = 'Cost',
           "ga:impressions" = 'Impressions',
           "ga:adClicks"    = 'Clicks') %>%
    mutate("ga:medium" = Medium,
           "ga:source" = Source) %>%
    select("ga:date",
           "ga:medium",
           "ga:source",
           "ga:adClicks",
           "ga:adCost",
           "ga:impressions",
           "ga:campaign",
           "ga:keyword",
           "ga:adContent") %>%
    mutate_if( is.character, iconv, to = "UTF-8" )%>%
    mutate_if( is.numeric, replace_na, 0)
  
  return(cost_data)
  
  
}
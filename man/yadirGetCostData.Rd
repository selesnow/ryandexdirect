\name{yadirGetCostData}
\alias{yadirGetCostData}
\title{Loading Cost Data for Upload to Google Analytics}
\description{Get data on expenses, impressions and clicks on advertising campaigns, keywords and ads for further loading into 'Google Analytics' source.}
\usage{
yadirGetCostData(
    DateFrom = Sys.Date() - 31,
    DateTo = Sys.Date() - 1,
    Source = 'yandex',
    Medium = 'cpc',
    IncludeVAT        = "YES",
    IncludeDiscount   = "NO",
    Login             = getOption("ryandexdirect.user"),
    AgencyAccount     = getOption("ryandexdirect.agency_account"),
    FetchBy           = NULL,
    Token             = NULL,
    TokenPath         = yadirTokenPath())
}

\arguments{
  \item{DateFrom}{If your select CUSTOM_DATE in DateRangeType you must enter start date in this argument in YYYY-MM-DD format else you can not used this argument}
  \item{DateTo}{If your select CUSTOM_DATE in DateRangeType you must enter end date in this argument in YYYY-MM-DD format else you can not used this argument}
  \item{Source}{Character, UTM source}
  \item{Medium}{Character, UTM medium}
  \item{IncludeVAT}{Include or exclude VAT, one of "NO" or "YES"}
  \item{IncludeDiscount}{Include or exclude Discount, one of "NO" or "YES"}
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{FetchBy}{Split the query by date range. Allowed values: "DAY", "WEEK", "MONTH", "QUARTER", "YEAR".}
  \item{TokenPath}{Path to directory where you save credential data}
  \item{Token}{character or list object, your Yandex API Token, you can get this by function yadirGetToken or yadirAuth}
}

\value{Data frame with cost data}

\author{Alexey Seleznev}

\examples{
\dontrun{
### 
# Use googleAnalyticsR for upload data into Google Analytics
library(googleAnalyticsR)

# load cost data
cost_data <- yadirGetCostData(DateFrom = "2020-05-10", 
                              DateTo = '2020-05-14')
                              
# upload into GA source
ga_custom_upload_file(accountId          = xxxx, 
                      webPropertyId      = "UA-xxxx-1", 
                      customDataSourceId = 'abcdefg', 
                      cost_data)

}
}

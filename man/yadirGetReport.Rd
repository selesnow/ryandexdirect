\name{yadirGetReport}
\alias{yadirGetReport}
\title{Get report from yandex direct Report service}
\description{yadirGetReport get data frame with Report data from Report Yandex Direct Service}
\usage{
yadirGetReport(ReportType    = "CAMPAIGN_PERFORMANCE_REPORT", 
               DateRangeType     = "LAST_MONTH", 
               DateFrom          = NULL, 
               DateTo            = NULL, 
               FieldNames        = c("CampaignName","Impressions","Clicks","Cost"), 
               FilterList        = NULL,
               Goals             = NULL,
               AttributionModels = NULL,
               IncludeVAT        = "YES",
               IncludeDiscount   = "NO",
               Login             = NULL,
               AgencyAccount     = NULL,
               Token             = NULL,
               TokenPath         = getwd())
}

\arguments{
  \item{ReportType}{Report level, one from ACCOUNT_PERFORMANCE_REPORT, CAMPAIGN_PERFORMANCE_REPORT, ADGROUP_PERFORMANCE_REPORT, AD_PERFORMANCE_REPORT, CRITERIA_PERFORMANCE_REPORT, CUSTOM_REPORT, SEARCH_QUERY_PERFORMANCE_REPORT. For detail go https://tech.yandex.ru/direct/doc/reports/type-docpage/}
  \item{DateRangeType}{Reporting period, one from  TODAY, YESTERDAY, LAST_3_DAYS, LAST_5_DAYS, LAST_7_DAYS, LAST_14_DAYS, LAST_30_DAYS, LAST_90_DAYS, LAST_365_DAYS, THIS_WEEK_MON_TODAY ,THIS_WEEK_SUN_TODAY, LAST_WEEK, LAST_BUSINESS_WEEK, LAST_WEEK_SUN_SAT, THIS_MONTH, LAST_MONTH, ALL_TIME, CUSTOM_DATE, AUTO. For detail go https://tech.yandex.ru/direct/doc/reports/period-docpage/}
  \item{DateFrom}{If your select CUSTOM_DATE in DateRangeType you must enter start date in this argument in YYYY-MM-DD format else you can not used this argument}
  \item{DateTo}{If your select CUSTOM_DATE in DateRangeType you must enter end date in this argument in YYYY-MM-DD format else you can not used this argument}
  \item{FieldNames}{Character vector with field names list, for example c("Date","CampaignName","Impressions","Clicks"), for more ditails go https://tech.yandex.ru/direct/doc/reports/fields-list-docpage/}
  \item{FilterList}{Character vector with rows filters, for example c("Clicks GREATER_THAN 99","Impressions LESS_THAN 1000"), for more details go https://tech.yandex.ru/direct/doc/reports/filters-docpage/}
  \item{Goals}{integer vector, id of the Yandex.Metric goals for which you want to get statistics. No more than 10 elements in the array. For example c(182453, 182452, 23458860).}
  \item{AttributionModels}{Attribution models used in the calculation of data on Yandex.Metrica goals. For example c("LSC", "LC", "FC"), see detail for more information.}
  \item{IncludeVAT}{Include or exclude VAT, one of "NO" or "YES"}
  \item{IncludeDiscount}{Include or exclude Discount, one of "NO" or "YES"}
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
  \item{Token}{character or list object, your Yandex API Token, you can get this by function yadirGetToken or yadirAuth}
}
\details{
Attribution model is the rule, what transition to consider the source of the visit.

Possible values:

\item{FC}{the first transition}
\item{LC}{the last transition}
\item{LSC}{is the last significant transition}
 
The AttributionModels parameter can be specified only if the Goals parameter is specified. If the Goals parameter is specified, and the AttributionModels parameter is not, the default value is LSC.

If several attribution models are specified, the data will be displayed for each model separately.

}
\references{
\href{https://tech.yandex.ru/direct/doc/reports/reports-docpage/}{Official docs of 'Service Reports'}

\href{https://yandex.ru/support/metrika/general/goals.html}{What are goals?}

\href{https://yandex.ru/support/direct/statistics/attribution-model.html}{What are attribution models?}

\href{https://selesnow.github.io/ryandexdirect/}{Docs on ryandexdirect website}
}
\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
#Load package
library(ryandexdirect)

#For get Report from client account
statAgency <- yadirGetReport(ReportType       = "ACCOUNT_PERFORMANCE_REPORT", 
                             DateRangeType    = "CUSTOM_DATE", 
                             DateFrom         = "2018-01-01", 
                             DateTo           = "2018-05-10", 
                             FieldNames       = c("AdNetworkType",
                                                  "Impressions",
                                                  "Clicks",
                                                  "Cost"), 
							 Goals             = c(182453, 182452, 23458860),
							 AttributionModels = c("LSC", "LC"),
                             IncludeVAT        = "YES", 
                             IncludeDiscount   = "NO", 
                             Login             = "client_login", 
                             TokenPath         = "C:/token_yandex")
							 
#For get data from agency client account
statAgency <- yadirGetReport(ReportType = "ACCOUNT_PERFORMANCE_REPORT", 
                             DateRangeType = "CUSTOM_DATE", 
                             DateFrom = "2018-01-01", 
                             DateTo = "2018-05-10", 
                             FieldNames = c("AdNetworkType",
                                            "Impressions",
                                            "Clicks",
                                            "Cost"), 
                             IncludeVAT = "YES", 
                             IncludeDiscount = "NO", 
                             Login = "client_login", 
                             AgencyAccount = "aguncy_login",
                             TokenPath = "C:/token_yandex")

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
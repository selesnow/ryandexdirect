\name{yadirGetReport}
\alias{yadirGetReport}
\title{Get report from yandex direct Report service}
\description{yadirGetReport get data frame with Report data from Report Yandex Direct Service}
\usage{
yadirGetReport(ReportType = "CAMPAIGN_PERFORMANCE_REPORT", 
               DateRangeType = "LAST_MONTH", 
               DateFrom = NULL, 
               DateTo = NULL, 
               FieldNames = c("CampaignName","Impressions","Clicks","Cost"), 
               FilterList = NULL,
               IncludeVAT = "NO",
               IncludeDiscount = "NO",
               Login = NULL,
               Token = NULL)
}

\arguments{
  \item{ReportType}{Report level, one from ACCOUNT_PERFORMANCE_REPORT, CAMPAIGN_PERFORMANCE_REPORT, ADGROUP_PERFORMANCE_REPORT, AD_PERFORMANCE_REPORT, CRITERIA_PERFORMANCE_REPORT, CUSTOM_REPORT, SEARCH_QUERY_PERFORMANCE_REPORT. For detail go https://tech.yandex.ru/direct/doc/reports/type-docpage/}
  \item{DateRangeType}{Reporting period, one from  TODAY, YESTERDAY, LAST_3_DAYS, LAST_5_DAYS, LAST_7_DAYS, LAST_14_DAYS, LAST_30_DAYS, LAST_90_DAYS, LAST_365_DAYS, THIS_WEEK_MON_TODAY ,THIS_WEEK_SUN_TODAY, LAST_WEEK, LAST_BUSINESS_WEEK, LAST_WEEK_SUN_SAT, THIS_MONTH, LAST_MONTH, ALL_TIME, CUSTOM_DATE, AUTO. For detail go https://tech.yandex.ru/direct/doc/reports/period-docpage/}
  \item{DateFrom}{If your select CUSTOM_DATE in DateRangeType you must enter start date in this argument in YYYY-MM-DD format else you can not used this argument}
  \item{DateTo}{If your select CUSTOM_DATE in DateRangeType you must enter end date in this argument in YYYY-MM-DD format else you can not used this argument}
  \item{FieldNames}{Character vector with field names list, for example c("Date","CampaignName","Impressions","Clicks"), for more ditails go https://tech.yandex.ru/direct/doc/reports/fields-list-docpage/}
  \item{FilterList}{Character vector with rows filters, for example c("Clicks GREATER_THAN 99","Impressions LESS_THAN 1000"), for more details go https://tech.yandex.ru/direct/doc/reports/filters-docpage/}
  \item{IncludeVAT}{Include or exclude VAT, one of "NO" or "YES"}
  \item{IncludeDiscount}{Include or exclude Discount, one of "NO" or "YES"}
  \item{Login}{Your Yandex Login}
  \item{Token}{Your Yandex API Token}
}
\details{
For more details about Report service go https://tech.yandex.ru/direct/doc/reports/reports-docpage/
}
\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
#For get Report
My_report <- yadirGetReport(ReportType = "CAMPAIGN_PERFORMANCE_REPORT", DateRangeType = "LAST_MONTH", DateFrom = NULL, DateTo = NULL, FieldNames = c("CampaignName","Impressions","Clicks"), FilterList = c("Clicks GREATER_THAN 99","Impressions LESS_THAN 1000"), Login = <YourLogin>, Token = <YourToken>)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
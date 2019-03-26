\name{yadirGetKeyWords}
\alias{yadirGetKeyWords}
\title{Get keywords list from yandex direct account}
\description{yadirGetKeyWords get Р»СѓРЅС†С‰РєРІС‹ id and parameters from Yandex Direct account}
\usage{
yadirGetKeyWords(CampaignIds = NULL, AdGroupIds = NA, Ids = NA, States
                 = c("OFF", "ON", "SUSPENDED"), WithStats = T, Login =
                 NULL, Token = NULL, AgencyAccount = NULL, TokenPath =
                 getwd())
}

\arguments{
  \item{CampaignIds}{character vector with yandex direct campaign ID, require}
  \item{AdGroupIds}{character vector with yandex direct adgroup ID}
  \item{Ids}{character vector with yandex direct ad ID}
  \item{States}{character vector with ad states}
  \item{WithStats}{logical, if TRUE then load stat by impressions and click but load process will be long durations}
  \item{Login}{character, your login at Yandex, require}
  \item{Token}{character, your Yandex Direct API Token, require}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
}

\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
\dontrun{
#For get keywords data frame
library(ryandexdirect)
# get data from agency account
my_keywords <- yadirGetKeyWords(Login = "client_login",
                                AgencyAccount = "agency_login",
                                TokenPath     = "token_yandex")
}
}

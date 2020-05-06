\name{yadirGetKeyWords}
\alias{yadirGetKeyWords}
\title{Get Keywords}
\description{Returns the parameters of key phrases or autotargets that match the specified criteria: the values of the placeholder variables, status and status, statistics of impressions and clicks, rates and priorities.}
\usage{
yadirGetKeyWords(CampaignIds = NULL, AdGroupIds = NA, Ids = NA, States
                 = c("OFF", "ON", "SUSPENDED"), WithStats = TRUE, 
                 Login = getOption("ryandexdirect.user"), Token = NULL, 
                 AgencyAccount = getOption("ryandexdirect.agency_account"), 
                 TokenPath = yadirTokenPath())
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

# get data from agency account
### Please choose another TokenPath to save the Login permanently.
my_keywords <- yadirGetKeyWords(Login = "client_login",
                                AgencyAccount = "agency_login",
                                TokenPath     = tempdir())
}
}

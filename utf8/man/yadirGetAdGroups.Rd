\name{yadirGetAdGroups}
\alias{yadirGetAdGroups}
\title{Get adgroups list from yandex direct account}
\description{yadirGetCampaignList get adgroups id and parameters from Yandex Direct account}
\usage{
yadirGetAdGroups(CampaignIds   = NULL, 
                             AdGroupIds    = NA, 
                             Ids           = NA, 
                             Types         = c("TEXT_AD_GROUP" ,"MOBILE_APP_AD_GROUP" ,"DYNAMIC_TEXT_AD_GROUP"),
                             Statuses      = c( "ACCEPTED", "DRAFT", "MODERATION", "PREACCEPTED", "REJECTED"), 
                             Login         = NULL,
                             AgencyAccount = NULL,
                             Token         = NULL,
                             TokenPath     = getwd())
}

\arguments{
  \item{CampaignIds}{character vector with yandex direct campaign ID, require}
  \item{Ids}{character vector with yandex direct adgroup ID}
  \item{Types}{character vector with adgroup types states}
  \item{Statuses}{character vector with adgroup types statuses}
  \item{Login}{character, your login at Yandex, require}
  \item{Token}{character, your Yandex Direct API Token, require}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
#For get adgroups data frame
# Get data from clients account
library(ryandexdirect)
my_ad_group <- yadirGetAdGroups(Login = "login")

# Get data from agency account
library(ryandexdirect)
my_ad_group <- yadirGetAdGroups(Login         = "client_login",
                                AgencyAccount = "agency_login",
								TokenPath     = "token_yandex")

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

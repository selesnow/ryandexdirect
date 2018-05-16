\name{yadirGetAds}
\alias{yadirGetAds}
\title{Get ads list from yandex direct account}
\description{yadirGetCampaignList get ads id and parameters from Yandex Direct account}
\usage{
yadirGetAds(CampaignIds   = NULL, 
            AdGroupIds    = NA, 
            Ids           = NA, 
            States        = c("OFF","ON","SUSPENDED","OFF_BY_MONITORING","ARCHIVED"), 
            Login         = NULL,
            Token         = NULL,
            AgencyAccount = NULL,
            TokenPath     = getwd())
}

\arguments{
  \item{CampaignIds}{character vector with yandex direct campaign ID, require}
  \item{AdGroupIds}{character vector with yandex direct adgroup ID}
  \item{Ids}{character vector with yandex direct ad ID}
  \item{States}{character vector with ad states}
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
#For get ads data frame
# Get ads from client account
library(ryandexdirect)
aut <- yadirAuth(Login = "login", NewUser = TRUE)
my_ads  <- yadirGetAds(Login = "login",
                       Token = aut)
					   
# Get data from agency account
library(ryandexdirect)

aut <- yadirAuth(Login = "agency_login", NewUser = TRUE)

my_ads  <- yadirGetAds(Login = "client_login",
					   AgencyAccount = "agency_login",
                       Token = aut)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

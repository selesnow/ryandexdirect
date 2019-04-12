\name{yadirGetAds}
\alias{yadirGetAds}
\title{Get Ads List From 'Yandex Direct' account}
\description{Returns the parameters of ads that match the specified criteria.}
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

\value{Data Frame}
\author{Alexey Seleznev}

\examples{
\dontrun{
### Please choose another TokenPath to save the Login permanently.
#For get ads data frame
# Get ads from client account
aut <- yadirAuth(Login = "login", NewUser = TRUE,
                 TokenPath = tempdir())
my_ads  <- yadirGetAds(Login = "login",
                       Token = aut)
					   
# Get data from agency account
aut <- yadirAuth(Login = "agency_login", NewUser = TRUE,
                 TokenPath = tempdir())

my_ads  <- yadirGetAds(Login = "client_login",
					   AgencyAccount = "agency_login",
                       Token = aut)
}
}

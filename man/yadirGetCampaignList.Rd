\name{yadirGetCampaignList}
\alias{yadirGetCampaignList}
\title{Get campaign list from yandex direct account}
\description{yadirGetCampaignList get campaings names and parameters}
\usage{
yadirGetCampaignList(Logins          = NULL, 
                     States          = c("OFF","ON","SUSPENDED","ENDED","CONVERTED","ARCHIVED"),
                     Types           = c("TEXT_CAMPAIGN","MOBILE_APP_CAMPAIGN","DYNAMIC_TEXT_CAMPAIGN"),
                     Statuses        = c("ACCEPTED","DRAFT","MODERATION","REJECTED"),
                     StatusesPayment = c("DISALLOWED","ALLOWED"),
                     Token           = NULL,
                     AgencyAccount = NULL,
                     TokenPath     = getwd())
}

\arguments{
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
  \item{Token}{character or list object, your Yandex API Token, you can get this by function yadirGetToken or yadirAuth}
  \item{States}{character vector, filter by campaign states, for example c("OFF", "ON", "SUSPENDED", "ENDED", "CONVERTED", "ARCHIVED")}
  \item{Types}{character vector with campaign types, example c("TEXT_CAMPAIGN", "MOBILE_APP_CAMPAIGN", "DYNAMIC_TEXT_CAMPAIGN")}
  \item{Statuses}{character vector, filter campaign list by status, for example c("ACCEPTED", "DRAFT", "MODERATION", "REJECTED")}
  \item{StatusesPayment}{character vector, filter campaign list by payment status, for example c("DISALLOWED", "ALLOWED")}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
#Get data from client accounts
library(ryandexdirect)
my_ad_group <- yadirGetCampaignList(Login = "login")

#Get data from agency account
library(ryandexdirect)
# Auth
aut <- yadirAuth(Login = "agency_login", NewUser = TRUE, TokenPath = "token_yandex")

# Load Ad Group List
my_ad_group <- yadirGetCampaignList(Login = "client_login",
                                    Token = aut)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ campaigns }
\keyword{ yandex direct }% __ONLY ONE__ keyword per line

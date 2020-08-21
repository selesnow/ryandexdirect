\name{yadirGetAdGroups}
\alias{yadirGetAdGroups}
\title{Get AdGroups List}
\description{Returns parameters of adgroups that meet specified criteria.}
\usage{
yadirGetAdGroups(CampaignIds   = NULL, 
                 Ids           = NA, 
                 Types         = c("TEXT_AD_GROUP", 
                                   "MOBILE_APP_AD_GROUP", 
                                   "DYNAMIC_TEXT_AD_GROUP",
                                   "CPM_BANNER_AD_GROUP", 
                                   "CPM_VIDEO_AD_GROUP",
                                   "SMART_AD_GROUP"),
                 Statuses      = c("ACCEPTED", 
				                   "DRAFT", 
			                       "MODERATION", 
								   "PREACCEPTED", 
								   "REJECTED"), 
                 Login         = getOption("ryandexdirect.user"),
                 AgencyAccount = getOption("ryandexdirect.agency_account"),
                 Token         = NULL,
                 TokenPath     = yadirTokenPath())
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

\value{data frame with adgroups names and parameters}
\author{Alexey Seleznev}

\examples{
\dontrun{
#For get adgroups data frame
# Get data from clients account
my_ad_group <- yadirGetAdGroups(Login = "login")

# Get data from agency account
### !!!Please choose another TokenPath to save the Login permanently.
my_ad_group <- yadirGetAdGroups(Login         = "client_login",
                                AgencyAccount = "agency_login",
								TokenPath     =  tempdir())

}
}

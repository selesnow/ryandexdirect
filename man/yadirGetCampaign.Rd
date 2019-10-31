\name{yadirGetCampaign}
\alias{yadirGetCampaignList}
\alias{yadirGetCampaign}
\title{Get Campaigns List}
\description{Returns the parameters of campaigns that meet the specified criteria.}
\usage{
yadirGetCampaignList(Logins = NULL, States = c("OFF", "ON", "SUSPENDED",
                   "ENDED", "CONVERTED", "ARCHIVED"), Types =
                   c("TEXT_CAMPAIGN", "MOBILE_APP_CAMPAIGN",
                   "DYNAMIC_TEXT_CAMPAIGN", "CPM_BANNER_CAMPAIGN"),
                   Statuses = c("ACCEPTED", "DRAFT", "MODERATION",
                   "REJECTED"), StatusesPayment = c("DISALLOWED",
                   "ALLOWED"), Token = NULL, AgencyAccount = NULL,
                   TokenPath = getwd())
				   
yadirGetCampaign(Logins = NULL, States = c("OFF", "ON", "SUSPENDED",
                   "ENDED", "CONVERTED", "ARCHIVED"), Types =
                   c("TEXT_CAMPAIGN", "MOBILE_APP_CAMPAIGN",
                   "DYNAMIC_TEXT_CAMPAIGN", "CPM_BANNER_CAMPAIGN"),
                   Statuses = c("ACCEPTED", "DRAFT", "MODERATION",
                   "REJECTED"), StatusesPayment = c("DISALLOWED",
                   "ALLOWED"), Token = NULL, AgencyAccount = NULL,
                   TokenPath = getwd())
}

\arguments{
  \item{Logins}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
  \item{Token}{character or list object, your Yandex API Token, you can get this by function yadirGetToken or yadirAuth}
  \item{States}{character vector, filter by campaign states, for example c("OFF", "ON", "SUSPENDED", "ENDED", "CONVERTED", "ARCHIVED")}
  \item{Types}{character vector with campaign types, example c("TEXT_CAMPAIGN", "MOBILE_APP_CAMPAIGN", "DYNAMIC_TEXT_CAMPAIGN")}
  \item{Statuses}{character vector, filter campaign list by status, for example c("ACCEPTED", "DRAFT", "MODERATION", "REJECTED")}
  \item{StatusesPayment}{character vector, filter campaign list by payment status, for example c("DISALLOWED", "ALLOWED")}
}

\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
\dontrun{
### Please choose another TokenPath to save the Login permanently.
#Get data from client accounts
my_ad_group <- yadirGetCampaign(Login = "login",
                                TokenPath = tempdir())

#Get data from agency account
# Auth
aut <- yadirAuth(Login = "agency_login", 
                 NewUser = TRUE, 
				 TokenPath = tempdir())

# Load Ad Group List
my_ad_group <- yadirGetCampaign(Login = "client_login",
                                Token = aut,
								TokenPath     = tempdir())
}
}

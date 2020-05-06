\name{yadirStopAds}
\alias{yadirStopAds}
\title{Suspend impressions by Ads}
\description{Stops Ad Impressions in 'Yandex Direct' accounts.}
\usage{
yadirStopAds(Login = getOption("ryandexdirect.user"), Ids = NULL,
      Token = NULL, AgencyAccount = getOption("ryandexdirect.agency_account"), 
      TokenPath = yadirTokenPath())
}

\arguments{
  \item{Ids}{Integer or Character vector with Ads Ids, who will suspend impressions}
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{Token}{Your Yandex API Token}
  \item{TokenPath}{Path to directory where you save credential data}
}
\details{
Function resume impressions and return vector with Ads Ids with error.
}
\value{Vector with ads ids which failed to suspend impressions}
\author{Alexey Seleznev}

\examples{
\dontrun{
### Please choose another TokenPath to save the Login permanently.
# Get API token
tok <- yadirGetToken(Login = "LOGIN",
                     TokenPath = tempdir())

# Get Campaigns
my_camp <- yadirGetCampaignList(Login = "LOGIN", 
                                Token = tok)

# Get ads dictionary
my_ads <- yadirGetAds(Login = "LOGIN", 
                      Token = tok, 
					  States = "ON", 
					  CampaignIds = my_camp$Id[1:10])

# Resume impressions
err <- yadirStopAds(Login = "LOGIN", Token =  tok, Ids = my_ads$Id) 
}
}

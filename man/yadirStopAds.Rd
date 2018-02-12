\name{yadirStopAds}
\alias{yadirStopAds}
\title{Suspend impressions by Ads}
\description{yadirStopAds suspend impressions by ads}
\usage{
yadirStopAds(Login = NULL, 
             Ids   = NULL,
             Token = NULL)
}

\arguments{
  \item{Ids}{Integer or Character vector with Ads Ids, who will suspend impressions}
  \item{Login}{Your Yandex Login}
  \item{Token}{Your Yandex API Token}
}
\details{
Function resume impressions and return vector with Ads Ids with error.
}
\value{Vector with ads ids which failed to suspend impressions}
\author{Alexey Seleznev}

\examples{
#Get API token
tok <- yadirGetToken()

#Get Campaigns
my_camp <- yadirGetCampaignList(Login = "LOGIN", Token = tok)

#Get ads dictionary
my_ads <- yadirGetAds(Login = "LOGIN", Token = tok, States = "ON", CampaignIds = my_camp$Id[1:10])

#Resume impressions
err <- yadirStopAds(Login = "LOGIN", Token =  tok, Ids = my_ads$Id) 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
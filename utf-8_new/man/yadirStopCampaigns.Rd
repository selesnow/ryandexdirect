\name{yadirStopCampaigns}
\alias{yadirStopCampaigns}
\title{Suspend impressions by Campaigns}
\description{yadirStopCampaigns suspend impressions by campaings in Yandex Direct account}
\usage{
yadirStartCampaigns(Login = NULL, 
					Ids   = NULL,
					Token = NULL)
}

\arguments{
  \item{Ids}{Integer or Character vector with Campaigns Ids, who will suspend impressions}
  \item{Login}{Your Yandex Login}
  \item{Token}{Your Yandex API Token}
}
\details{
Function suspend impressions and return vector with Campaigns Ids with error.
}
\value{Vector with campaigns ids which failed to suspend impressions}
\author{Alexey Seleznev}

\examples{
#Get API token
tok <- yadirGetToken()

#Get camp dictionary
my_camp <- yadirGetCampaignList(Login = "Login", Token = tok)

#Resume impressions
err <- yadirStopCampaigns(Login = "LOGIN", Token =  tok, Ids = my_camp$Id) 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
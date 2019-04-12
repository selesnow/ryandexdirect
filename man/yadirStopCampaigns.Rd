\name{yadirStopCampaigns}
\alias{yadirStopCampaigns}
\title{Suspend impressions by Campaigns}
\description{Suspend impressions by campaings in 'Yandex Direct' account}
\usage{
yadirStopCampaigns(Login = NULL, Ids = NULL, Token = NULL, AgencyAccount
                 = NULL, TokenPath = getwd())
}

\arguments{
  \item{Ids}{Integer or Character vector with Campaigns Ids, who will suspend impressions}
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{Token}{Your Yandex API Token}
  \item{TokenPath}{Path to directory where you save credential data}
}
\details{
Function suspend impressions and return vector with Campaigns Ids with error.
}
\value{Vector with campaigns ids which failed to suspend impressions}
\author{Alexey Seleznev}

\examples{
\dontrun{
### Please choose another TokenPath to save the Login permanently.
# Get API token
tok <- yadirGetToken(TokenPath = tempdir())

# Get camp dictionary
my_camp <- yadirGetCampaignList(Login = "Login", Token = tok)

# Resume impressions
err <- yadirStopCampaigns(Login = "LOGIN", Token =  tok, Ids = my_camp$Id) 
}
}

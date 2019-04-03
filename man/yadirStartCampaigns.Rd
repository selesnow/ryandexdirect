\name{yadirStartCampaigns}
\alias{yadirStartCampaigns}
\title{Start Campaigns}
\description{Resumes impressions at the campaign level.}
\usage{
yadirStartCampaigns(Login = NULL, Ids = NULL, Token = NULL, AgencyAccount
                 = NULL, TokenPath = getwd())
}

\arguments{
  \item{Ids}{Integer or Character vector with Campaigns Ids, who will resume impressions}
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{Token}{Your Yandex API Token}
  \item{TokenPath}{Path to directory where you save credential data}
}
\details{
Function resume impressions and return vector with Campaigns Ids with error.
}
\value{Vector with campaigns ids which failed to resume impressions}
\author{Alexey Seleznev}

\examples{
\dontrun{
# Get API token
tok <- yadirGetToken()

# Get camp dictionary
my_camp <- yadirGetCampaignList(Login = "Login", Token = tok)

# Resume impressions
err <- yadirStartCampaigns(Login = "LOGIN", Token =  tok, Ids = my_camp$Id) 
}
}

\name{yadirStartAds}
\alias{yadirStartAds}
\title{Start Ads}
\description{Resumes ad impressions previously stopped by the owner.}
\usage{
yadirStartAds(Login = NULL, Ids = NULL, Token = NULL, AgencyAccount
                 = NULL, TokenPath = getwd())
}

\arguments{
  \item{Ids}{Integer or Character vector with Ads Ids, who will resume impressions}
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{Token}{Your Yandex API Token}
  \item{TokenPath}{Path to directory where you save credential data}
}
\details{
Function resume impressions and return vector with Ads Ids with error.
}
\value{Vector with ads ids which failed to resume impressions}
\author{Alexey Seleznev}

\examples{
\dontrun{
### Please choose another TokenPath to save the Login permanently.
# Get API token
tok <- yadirGetToken(TokenPath = tempdir())

# Get ads dictionary
my_ads <- yadirGetAds(Login = "LOGIN", 
                      Token = tok,
                      States = c("SUSPENDED","OFF"))

# Resume impressions
err <- yadirStartAds(Login = "LOGIN", 
                     Token =  tok, 
					 Ids = my_ads$Id) 
}
}

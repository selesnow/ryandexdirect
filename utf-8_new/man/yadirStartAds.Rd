\name{yadirStartAds}
\alias{yadirStartAds}
\title{Resume impressions by Ads}
\description{yadirStartAds resume impressions by ads}
\usage{
yadirStartAds(Login = NULL, 
              Ids   = NULL,
              Token = NULL)
}

\arguments{
  \item{Ids}{Integer or Character vector with Ads Ids, who will resume impressions}
  \item{Login}{Your Yandex Login}
  \item{Token}{Your Yandex API Token}
}
\details{
Function resume impressions and return vector with Ads Ids with error.
}
\value{Vector with ads ids which failed to resume impressions}
\author{Alexey Seleznev}

\examples{
#Get API token
tok <- yadirGetToken()

#Get ads dictionary
my_ads <- yadirGetAds(Login = "LOGIN", Token = tok,States = c("SUSPENDED","OFF"))

#Resume impressions
err <- yadirStartAds(Login = "LOGIN", Token =  tok, Ids = my_ads$Id) 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
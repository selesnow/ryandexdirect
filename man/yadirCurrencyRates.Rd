\name{yadirCurrencyRates}
\alias{yadirCurrencyRates}
\title{Get campaign list from yandex direct account}
\description{yadirCurrencyRates get currency rates from Yandex Direct}
\usage{
yadirCurrencyRates(logins = NULL, token = NULL)
}

\arguments{
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
  \item{Token}{character or list object, your Yandex API Token, you can get this by function yadirGetToken or yadirAuth}
}
\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
# from storage tokrn
library(ryandexdirect)
cur <- yadirCurrencyRates(Login         = "login" ,
                          TokenPath     = "token_yandex")

# from auth object
library(ryandexdirect)
aut <- yadirAuth(Login = "login", NewUser = TRUE, TokenPath = "token_yandex")
cur2 <- yadirCurrencyRates(Login =  "login" ,
                           Token = aut)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

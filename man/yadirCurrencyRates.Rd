\name{yadirCurrencyRates}
\alias{yadirCurrencyRates}
\title{Get currencies}
\description{Exchange rates, currency parameters and restrictions.}
\usage{
yadirCurrencyRates(Login = NULL, AgencyAccount = NULL, Token = NULL,
                 TokenPath = getwd())
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
\dontrun{
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
}

\name{yadirCurrencyRates}
\alias{yadirCurrencyRates}
\title{Get currencies}
\description{Exchange rates, currency parameters and restrictions.}
\usage{
yadirCurrencyRates(
     Login = getOption("ryandexdirect.user"), 
     AgencyAccount = getOption("ryandexdirect.agency_account"), 
     Token = NULL,
     TokenPath = yadirTokenPath())
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
### Please choose another TokenPath to save the Login permanently.
# from storage tokrn
library(ryandexdirect)
cur <- yadirCurrencyRates(Login = "login" ,
                          TokenPath = tempdir())

# from auth object

aut <- yadirAuth(Login = "login", NewUser = TRUE, 
        TokenPath = tempdir())
cur2 <- yadirCurrencyRates(Login =  "login" ,
                           Token = aut)
}
}

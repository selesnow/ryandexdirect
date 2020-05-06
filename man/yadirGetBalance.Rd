\name{yadirGetBalance}
\alias{yadirGetBalance}
\title{Get 'Yandex Direct' account balance}
\description{Returns settings for shared accounts.}
\usage{
yadirGetBalance(Logins        = getOption("ryandexdirect.user"), 
                Token         = NULL,     
                AgencyAccount = getOption("ryandexdirect.agency_account"),
                TokenPath     = yadirTokenPath())
}

\arguments{
  \item{Logins}{character vector, your logins at Yandex Direct, require}
  \item{Token}{character, your Yandex Direct API Token, require}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
}

\value{Data frame}
\author{Alexey Seleznev}

\examples{
\dontrun{
### Please choose another TokenPath to save the Login permanently.
aut <- yadirAuth(Login = "login", NewUser = TRUE, 
        TokenPath = tempdir())
#For get accounts from client account use
my_balance <- yadirGetBalance(Logins = "login",
                              Token = aut)

#For get accounts from agancy account use
library(ryandexdirect)
aut <- yadirAuth(Login = "agency_login", NewUser = TRUE, 
                 TokenPath = tempdir())
client <- yadirGetClientList(Token = aut)
client_balance <- yadirGetBalance(Logins = client$Login,
                                  AgencyAccount = "agency_login",
                                  Token = aut)
}
}

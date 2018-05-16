\name{yadirGetBalance}
\alias{yadirGetBalance}
\title{Get yandex direct balance}
\description{yadirGetBalance get data frame with information about you account.}
\usage{
yadirGetBalance(Logins        = NULL, 
                Token         = NULL,     
                AgencyAccount = NULL,
                TokenPath     = getwd())
}

\arguments{
  \item{Logins}{character vector, your logins at Yandex Direct, require}
  \item{Token}{character, your Yandex Direct API Token, require}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
#For get accounts from client account use
my_balance <- yadirGetBalance(Logins = "vasya",  Token = "abcdef123456")

#For get accounts from agancy account use
library(ryandexdirect)
aut <- yadirAuth(Login = "agency_login", NewUser = TRUE, TokenPath = "token_yandex")
client <- yadirGetClientList(Token = aut)
client_balance <- yadirGetBalance(Logins = client$Login,
                                  AgencyAccount = "agency_login",
                                  Token = aut)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

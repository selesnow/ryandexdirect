\name{yadirGetBalance}
\alias{yadirGetBalance}
\title{Get yandex direct balance}
\description{yadirGetBalance get data frame with information about you account.}
\usage{
yadirGetBalance(Logins = NULL, Token = NULL)
}

\arguments{
  \item{Logins}{character vector, your logins at Yandex Direct, require}
  \item{Token}{character, your Yandex Direct API Token, require}
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
my_clients_balance <- yadirGetBalance(Logins = c("vasya", "petya", "kolya"),  Token = "abcdef123456")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

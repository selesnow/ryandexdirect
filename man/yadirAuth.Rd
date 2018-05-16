\name{yadirAuth}
\alias{yadirAuth}
\title{Authentication in Yandex Direct API}
\description{Get API Token for Yandex Direct account}
\usage{
yadirAuth(Login = NULL, NewUser = FALSE, TokenPath = getwd())
}
\arguments{
  \item{Login}{character, your login at Yandex, require}
  \item{NewUser}{logical, use TRUE if you want login into new account}
  \item{TokenPath}{Path to directory where you save credential data}
}
\value{R object with api token}
\author{Alexey Seleznev}

\examples{
library(ryandexdirect)
yadirAuth(Login = "login", NewUser = TRUE)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

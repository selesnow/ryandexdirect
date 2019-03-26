\name{yadirGetToken}
\alias{yadirGetToken}
\title{get api yandex developer token}
\description{this function open web browser for get api yandex direct token}
\usage{
yadirGetToken(Login = NULL, TokenPath = getwd())
}
\arguments{
  \item{Login}{character, your login at Yandex, require}
  \item{TokenPath}{Path to directory where you save credential data}
}
\value{R object with api token}
\author{Alexey Seleznev}

\examples{
myToken <- yadirGetToken()
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

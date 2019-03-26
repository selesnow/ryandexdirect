\name{yadirGetToken}
\alias{yadirGetToken}
\title{get api yandex developer token}
\description{This function open web browser for get api yandex direct token}
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
\dontrun{
myToken <- yadirGetToken()
}
}

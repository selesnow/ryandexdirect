\name{yadirGetToken}
\alias{yadirGetToken}
\title{Auth in 'Yandex Direct' API}
\description{Simplified, one-step API authorization.}
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
### Please choose another TokenPath to save the Login permanently.
myToken <- yadirGetToken(TokenPath = tempdir())
}
}

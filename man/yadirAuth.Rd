\name{yadirAuth}
\alias{yadirAuth}
\title{Authentication in 'Yandex Direct' API}
\description{Get API Token for 'Yandex Direct' account}
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
\dontrun{
### Please choose another TokenPath to save the Login permanently.
library(ryandexdirect)
yadirAuth(Login = "login", NewUser = TRUE,
          TokenPath = tempdir())
}
}

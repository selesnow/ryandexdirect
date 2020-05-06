\name{yadirGetLogins}
\alias{yadirGetLogins}
\title{Get Login List or Set Login}
\description{Get and set List of accessed yandex direct login from token path.}
\usage{
yadirGetLogins(TokenPath = yadirTokenPath(), SetLogin = TRUE)
}

\arguments{
  \item{TokenPath}{Path to directory where you save credential data}
  \item{SetLogin}{Boolean, if TRUE you will choose default login}
}
\value{vector with logins}
\author{Alexey Seleznev}

\examples{
\dontrun{
logins <- yadirGetLogins()
}
}

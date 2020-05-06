\name{yadirSetLogin}
\alias{yadirSetLogin}
\title{Set Login}
\description{Set yandex direct login in current R session.}
\usage{
yadirSetLogin(Login, TokenPath = yadirTokenPath())
}

\arguments{
  \item{TokenPath}{Path to directory where you save credential data}
  \item{Login}{Character, your username in Yandex}
}
\value{TRUE}
\author{Alexey Seleznev}

\examples{
\dontrun{
yadirSetLogin('my_name')
}
}

\name{yadirSetAgencyAccount}
\alias{yadirSetAgencyAccount}
\title{Set Agency Account}
\description{Set yandex direct Agency Account in current R session.}
\usage{
yadirSetAgencyAccount(AgencyAccount, TokenPath = yadirTokenPath())
}

\arguments{
  \item{TokenPath}{Path to directory where you save credential data}
  \item{AgencyAccount}{Character, username of agency account in Yandex}
}
\value{TRUE}
\author{Alexey Seleznev}

\examples{
\dontrun{
yadirSetAgencyAccount('my_agency')
}
}

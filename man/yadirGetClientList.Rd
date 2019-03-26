\name{yadirGetClientList}
\alias{yadirGetClientList}
\title{Get client list with parameters and information}
\description{yadirGetClientList function for agency account for get his clients list with all information}
\usage{
yadirGetClientList(AgencyAccount = NULL,
         Token         = NULL,
         TokenPath     = getwd())
}

\arguments{
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
  \item{Token}{character or list object, your Yandex API Token, you can get this by function yadirGetToken or yadirAuth}
}

\value{data frame with client list}
\author{Alexey Seleznev}

\examples{
\dontrun{
library(ryandexdirect)
my_client <- yadirGetClientList(AgencyAccount = "agency_login", TokenPath = "token_yandex")
}
}

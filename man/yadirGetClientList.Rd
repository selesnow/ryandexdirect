\name{yadirGetClientList}
\alias{yadirGetClientList}
\title{Get Client List From Agency Account}
\description{Returns a list of advertisers - agency clients, their parameters and settings of the main representatives of the advertiser.}
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
### Please choose another TokenPath to save the Login permanently.
my_client <- yadirGetClientList(AgencyAccount = "agency_login", 
                                TokenPath = tempdir())
}
}

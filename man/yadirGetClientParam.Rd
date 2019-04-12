\name{yadirGetClientParam}
\alias{yadirGetClientParam}
\title{Get params list from 'Yandex Direct' agency clients}
\description{Returns the parameters of the advertiser and the settings of the user - the representative of the advertiser or the parameters of the agency and the settings of the user - the representative of the agency.}
\usage{
yadirGetClientParam(Language = "ru", 
                    Logins = NULL, 
                    Token = NULL,
                    AgencyAccount = NULL,
                    TokenPath     = getwd())
}

\arguments{
  \item{Logins}{Character vector of yandex logins}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
  \item{Token}{character or list object, your Yandex API Token, you can get this by function yadirGetToken or yadirAuth}
  \item{Language}{Answer language one of en, ru, tr, uk}
}

\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
\dontrun{
### Please choose another TokenPath to save the Login permanently.
#Get client param from agency account
client_param <- yadirGetClientParam(AgencyAccount = "agency_login", 
                                    TokenPath     = tempdir())
}
}


\name{yadirGetClientParam}
\alias{yadirGetClientParam}
\title{Get params list from yandex direct account}
\description{yadirGetClientParam get clients parameters names and parameters}
\usage{
yadirGetClientParam(Language = "ru", 
                    Logins = NULL, 
                    Token = NULL,
                    AgencyAccount = NULL,
                    TokenPath     = getwd())
}

\arguments{
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
  \item{Token}{character or list object, your Yandex API Token, you can get this by function yadirGetToken or yadirAuth}
  \item{Language}{Answer language one of en, ru, tr, uk}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
#Get client param from agency account
library(ryandexdirect)
client_param <- yadirGetClientParam(AgencyAccount = "agency_login", 
                                    TokenPath     = "token_yandex")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

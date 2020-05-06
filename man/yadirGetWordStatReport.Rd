\name{yadirGetWordStatReport}
\alias{yadirGetWordStatReport}
\title{Get WordStat Report}
\description{Returns a search query statistics report from 'Wordstat'.}
\usage{
yadirGetWordStatReport( 
                 Phrases,
                 GeoID         = 0,
                 Login         = getOption("ryandexdirect.user"),
                 Token         = NULL,
                 AgencyAccount = getOption("ryandexdirect.agency_account"),
                 TokenPath     = yadirTokenPath())
}

\arguments{
  \item{Phrases}{character vector with yandex direct campaign ID, require}
  \item{GeoID}{character vectora, an array of key phrases for which you want to obtain statistics on search queries}
  \item{Login}{integer, An array of region identifiers. Allows you to get statistics on search queries made only in the specified regions, see yadirGetDictionary}
  \item{Token}{character, your Yandex Direct API Token, require}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
}

\value{Data Frame}
\author{Alexey Seleznev}

\examples{
\dontrun{
### Please choose another TokenPath to save the Login permanently.
# get wordstat report
wsrep <- yadirGetWordStatReport(
            Phrases = 'samsung smartphone',
            Login = "abekker.ru.2017")

wsrep[['SearchedAlso']]
wsrep[['SearchedWith']]
}
}

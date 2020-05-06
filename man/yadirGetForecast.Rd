\name{yadirGetForecast}
\alias{yadirGetForecast}
\title{Get Forecast}
\description{Returns a forecast for cost, click and impression}
\usage{
yadirGetForecast(Phrases,
                 GeoID         = 0,
                 Currency      = "RUB",
                 AuctionBids   = "No",
                 Login         = getOption("ryandexdirect.user"),
                 Token         = NULL,
                 AgencyAccount = getOption("ryandexdirect.agency_account"),
                 TokenPath     = yadirTokenPath())
                        }

\arguments{
  \item{Phrases}{character vector of key phrases for which you want to get a forecast, require}
  \item{GeoID}{character vectora, an array of key phrases for which you want to obtain statistics on search queries}
  \item{Currency}{The currency in which click prices and total costs in the report should be expressed. Possible values: RUB, CHF, EUR, KZT, TRY, UAH, USD, BYN.}
  \item{AuctionBids}{Whether to display trading results in the report (Yes / No)}
  \item{Login}{integer, An array of region identifiers. Allows you to get statistics on search queries made only in the specified regions, see yadirGetDictionary}
  \item{Token}{character, your Yandex Direct API Token, require}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
}

\value{Data Frame}
\author{Alexey Seleznev}

\examples{
\dontrun{
# get forecast
forecast <- yadirGetForecast(c('buy smartphone -xiaomi', 
                               'buy samsung'),
                             Login = "selesnow")
}
}

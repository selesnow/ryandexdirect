\name{yadirGetDictionary}
\alias{yadirGetDictionary}
\title{Get Dictionary from 'Yandex Direct'}
\description{Returns reference data: regions, time zones, exchange rates, list of metro stations, restrictions on parameter values, external networks (SSP), Crypt segments for targeting by user profile, etc.}
\usage{
yadirGetDictionary(DictionaryName = "GeoRegions", 
                   Language      = "ru", 
                   Login         = getOption("ryandexdirect.user"),
                   Token         = NULL,
                   AgencyAccount = getOption("ryandexdirect.agency_account"),
                   TokenPath     = yadirTokenPath())
}

\arguments{
  \item{DictionaryName}{character string with Dictionary name, one of Currencies, MetroStations, GeoRegions, TimeZones, Constants, AdCategories, OperationSystemVersions, ProductivityAssertions, SupplySidePlatforms, Interests}
  \item{Language}{Answer message lenguage, by default "ru", support one of en, ru, tr, uk}
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
  \item{Token}{character or list object, your Yandex API Token, you can get this by function yadirGetToken or yadirAuth}
}
\references{
For more details go \href{https://yandex.ru/dev/direct/doc/ref-v5/dictionaries/get-docpage}{link}
}
\value{Data Frame}
\author{Alexey Seleznev}

\examples{
\dontrun{
### Please choose another TokenPath to save the Login permanently.
geo <- yadirGetDictionary(Login = "login", 
                          DictionaryName = "GeoRegions",
                          TokenPath = tempdir())
}
}

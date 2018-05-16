\name{yadirGetDictionary}
\alias{yadirGetDictionary}
\title{Get Dictionary from Yandex}
\description{yadirGetDictionary get Dictionaties from Yandex Direct API v.5.}
\usage{
yadirGetDictionary(DictionaryName = "GeoRegions", 
                               Language      = "ru", 
                               Login         = NULL,
                               Token         = NULL,
                               AgencyAccount = NULL,
                               TokenPath     = getwd())
}

\arguments{
  \item{DictionaryName}{character string with Dictionary name, one of Currencies, MetroStations, GeoRegions, TimeZones, Constants, AdCategories, OperationSystemVersions, ProductivityAssertions, SupplySidePlatforms, Interests}
  \item{Language}{Answer message lenguage, by default "ru", support one of en, ru, tr, uk}
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
  \item{Token}{character or list object, your Yandex API Token, you can get this by function yadirGetToken or yadirAuth}
}
\details{
For more details go https://tech.yandex.ru/direct/doc/ref-v5/dictionaries/get-docpage/
}
\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
library(ryandexdirect)
geo <- yadirGetDictionary(Login     = "login", 
                          TokenPath = "token_yandex")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
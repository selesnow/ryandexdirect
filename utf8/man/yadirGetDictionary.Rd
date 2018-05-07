\name{yadirGetDictionary}
\alias{yadirGetDictionary}
\title{Get Dictionary from Yandex}
\description{yadirGetDictionary get Dictionaties from Yandex Direct API v.5.}
\usage{
yadirGetDictionary <- function(DictionaryName = "GeoRegions", Language = "ru", login = NULL, token = NULL)
}

\arguments{
  \item{DictionaryName}{character string with Dictionary name, one of Currencies, MetroStations, GeoRegions, TimeZones, Constants, AdCategories, OperationSystemVersions, ProductivityAssertions, SupplySidePlatforms, Interests}
  \item{Language}{Answer message lenguage, by default "ru", support one of en, ru, tr, uk}
  \item{login}{Your login in Yandex}
  \item{token}{Your api yandex direct token}
}
\details{
For more details go https://tech.yandex.ru/direct/doc/ref-v5/dictionaries/get-docpage/
}
\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
GeoData <- (DictionaryName = "GeoRegions", Language = "ru", login = <LOGIN>, token = <TOKEN>)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

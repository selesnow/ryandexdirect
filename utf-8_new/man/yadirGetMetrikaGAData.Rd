\name{yadirGetMetrikaGAData}
\alias{yadirGetMetrikaGAData}
\title{Get data from Yandex Metrika API is compatible with the Google Analytics Core Reporting API (v3)}
\description{Get data from Yandex Metrika API is compatible with the Google Analytics Core Reporting API (v3), more ditails go link https://tech.yandex.ru/metrika/doc/api2/ga/intro-docpage/}
\usage{
yadirGetMetrikaGAData(start_date = "10daysAgo", end_date = "today", counter_ids = NULL, dimensions = NULL, metrics = NULL, filters = NULL, sort = NULL, samplingLevel = "HIGHER_PRECISION", token = NULL)
}

\arguments{
  \item{start_date}{Start date in YYYY-MM-DD or relative value for example "today", "yesterday", "5daysAgo"}
  \item{end_date}{End date in YYYY-MM-DD or relative value for example "today", "yesterday", "5daysAgo"}
  \item{counter_ids}{Number of yandex metrika counter, require}
  \item{dimensions}{List of yandex metrika dimensions, for example "ga:date,ga:sourceMedium", for vore details go link https://tech.yandex.ru/metrika/doc/api2/ga/ga/implemented/metrika_dim-docpage/}
  \item{metrics}{List of yandex metrika metrics, for example "ga:sessions,ga:bounces,ga:users", for vore details go link https://tech.yandex.ru/metrika/doc/api2/ga/ga/implemented/metrika_dim-docpage, require}
  \item{filters}{List of filter dimensions and metrics of yandex metrika. For example "ga:country==Russia;ga:language!~^ru.*", for more detail go https://tech.yandex.ru/metrika/doc/api2/ga/segmentation-ga-docpage/}
  \item{sort}{Sort result by metric or dimension, for example "-ga:sessions"}
  \item{samplingLevel}{Level of sempling, one of "HIGHER_PRECISION", "FASTER", "DEFAULT"}
  \item{Token}{character, your Yandex Direct API Token, require}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
#For get data from Yandex Metrika Data
metrikData <- yadirGetMetrikaGAData(start_date = "2017-08-01",
                                    end_date = "yesterday",
                                    counter_ids = "ga:111111",
                                    metrics = "ga:sessions,ga:bounces,ga:users",
                                    dimensions = "ga:date,ga:sourceMedium",
                                    token = "abcdef123456")

metrikDataGoals <- yadirGetMetrikaGAData(start_date = "2017-08-01",
                                     end_date = "yesterday",
                                     counter_ids = "ga:111111",
                                     metrics = "ga:goal18731440Completions",
                                     dimensions = "ga:date,ga:sourceMedium",
                                     token = "abcdef123456")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

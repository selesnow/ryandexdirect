\name{yadirGetLogsData}
\alias{yadirGetLogsData}
\title{yadirGetLogsData get raw data from Yandex Metrika LogsApi}
\description{yadirGetLogsData get raw data from Yandex Metrika LogsApi}
\usage{
yadirGetLogsData(counter = NULL, date_from = Sys.Date() - 10, date_to = Sys.Date(), fields = NULL, source = "visits", token = NULL)
}

\arguments{
  \item{counter}{ID of your metrika counter}
  \item{date_from}{Start date}
  \item{date_to}{End date date}
  \item{fields}{Report fields}
  \item{source}{Character string, "hits" or "visits"}
  \item{token}{Your API token}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{data frame with row data}
\author{Alexey Seleznev}
\seealso{
All parameters for visits - https://tech.yandex.ru/metrika/doc/api2/logs/fields/visits-docpage/
All parameters for hits - https://tech.yandex.ru/metrika/doc/api2/logs/fields/hits-docpage/
}

\examples{
my_token <- yadirGetToken()
rawmetrikdata <- yadirGetLogsData(counter = "00000000",
                                  date_from = "2016-12-01",
                                  date_to = "2016-12-20",
                                  fields = "ym:s:visitID,ym:s:date,ym:s:bounce,ym:s:clientID,ym:s:networkType",
                                  source = "visits",
                                  token = my_token)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
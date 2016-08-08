\name{yadirCurrencyRates}
\alias{yadirCurrencyRates}
\title{Get campaign list from yandex direct account}
\description{yadirCurrencyRates get currency rates from Yandex Direct}
\usage{
yadirCurrencyRates(logins = NULL, token = NULL)
}

\arguments{
  \item{logins}{character vector with yandex direct logins}
  \item{token}{your api yandex direct token}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
#For get campaings data frame
campaigns <- yadirCurrencyRates(logins = clientList$Login, token = myToken)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

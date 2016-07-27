\name{yadirGetSummaryStat}
\alias{yadirGetSummaryStat}
\title{Get campaign statistic}
\description{Get campaign statistic by day}
\usage{
yadirGetSummaryStat(campaignIDS = NULL, dateStart = Sys.Date() - 10, dateEnd = Sys.Date(), currency = "USD", token = NULL)
}

\arguments{
  \item{campaignIDS}{vector with campaign id list}
  \item{dateStart}{start date in YYYY-MM-DD format}
  \item{dateEnd}{end date in YYYY-MM-DD format}
  \item{currency}{currency code, support RUB, CHF, EUR, KZT, TRY, UAH, USD}
  \item{token}{your api yandex direct token}
}

\value{data frame with campaign statistic}

\author{Alexey Seleznev}

\examples{
stat <- yadirGetSummaryStat(campaignIDS = campaigns$CampaignID[campaigns$Login == clientList$Login[208]],
                            dateStart = "2016-01-01",
                            dateEnd = "2016-06-30",
                            currency = "USD",
                            token = myToken)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

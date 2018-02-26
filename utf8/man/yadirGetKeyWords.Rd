\name{yadirGetKeyWords}
\alias{yadirGetKeyWords}
\title{Get keywords list from yandex direct account}
\description{yadirGetKeyWords get Р»СѓРЅС†С‰РєРІС‹ id and parameters from Yandex Direct account}
\usage{
yadirGetAds(CampaignIds = NULL, AdGroupIds = NA, Ids = NA, States = c("OFF","ON","SUSPENDED"), WithStats = T, Login = NULL, Token = NULL)
}

\arguments{
  \item{CampaignIds}{character vector with yandex direct campaign ID, require}
  \item{AdGroupIds}{character vector with yandex direct adgroup ID}
  \item{Ids}{character vector with yandex direct ad ID}
  \item{States}{character vector with ad states}
  \item{WithStats}{logical, if TRUE then load stat by impressions and click but load process will be long durations}
  \item{Login}{character, your login at Yandex, require}
  \item{Token}{character, your Yandex Direct API Token, require}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
#For get keywords data frame
my_kw <- yadirGetKeyWords(CampaignIds = c(1,2,3,4,5), Login = "vasya", Token = "abcdef123456")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

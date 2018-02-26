\name{yadirGetAdGroups}
\alias{yadirGetAdGroups}
\title{Get adgroups list from yandex direct account}
\description{yadirGetCampaignList get adgroups id and parameters from Yandex Direct account}
\usage{
yadirGetAds(CampaignIds = NULL, Ids = NA, Types = c("TEXT_AD_GROUP" ,"MOBILE_APP_AD_GROUP" ,"DYNAMIC_TEXT_AD_GROUP"), Statuses = c( "ACCEPTED", "DRAFT", "MODERATION", "PREACCEPTED", "REJECTED") , Login = NULL, Token = NULL)
}

\arguments{
  \item{CampaignIds}{character vector with yandex direct campaign ID, require}
  \item{Ids}{character vector with yandex direct adgroup ID}
  \item{Types}{character vector with adgroup types states}
  \item{Statuses}{character vector with adgroup types statuses}
  \item{Login}{character, your login at Yandex, require}
  \item{Token}{character, your Yandex Direct API Token, require}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
#For get adgroups data frame
my_ad_group <- yadirGetAdGroups(CampaignIds = c(1,2,3,4,5), Login = "vasya", Token = "abcdef123456")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

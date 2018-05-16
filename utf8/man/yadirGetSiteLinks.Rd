\name{yadirGetSiteLinks}
\alias{yadirGetSiteLinks}
\title{Get fast links from yandex direct}
\description{yadirGetSiteLinks returns sets of quick links that meet the specified criteria..}
\usage{
yadirGetBalance(Login = NULL, Token = NULL)
}

\arguments{
  \item{Login}{character, your logins at Yandex Direct, require}
  \item{Token}{character, your Yandex Direct API Token, require}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{data frame with SiteLinks parameters, id, title, href and description }
\author{Alexey Seleznev}

\examples{
#For get accounts from client account use
library(ryandexdirect)
my_fast_links <- yadirGetSiteLinks(Login = "login")

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

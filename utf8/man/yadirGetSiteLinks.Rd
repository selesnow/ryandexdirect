\name{yadirGetSiteLinks}
\alias{yadirGetSiteLinks}
\title{Get fast links from yandex direct}
\description{yadirGetSiteLinks returns sets of quick links that meet the specified criteria..}
\usage{
yadirGetSiteLinks(Login = NULL,
                  Token = NULL,
                  Ids   = NULL,
                  AgencyAccount = NULL,
                  TokenPath     = getwd())
}

\arguments{
  \item{Login}{character, your logins at Yandex Direct, require}
  \item{Token}{character, your Yandex Direct API Token, require}
  \item{Ids}{integer vector, ids of sitelinks sets}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{TokenPath}{Path to directory where you save credential data}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{data frame with SiteLinks parameters, id, title, href and description }
\author{Alexey Seleznev}

\examples{
\dontrun{
# Get sitelinks
sl <- yadirGetSiteLinks2(AgencyAccount = "my.agency", 
                         Login         = "my.client.login",
						 Ids           = c(5276537, 8927897239, 252627, 33123)
                         TokenPath     = "C:\\tokens")
 }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

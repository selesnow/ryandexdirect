\name{yadirGetSiteLinks}
\alias{yadirGetSiteLinks}
\title{Get Fast Links}
\description{Returns sets of quick links that meet the specified criteria.}
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

\value{data frame with SiteLinks parameters, id, title, href and description }
\author{Alexey Seleznev}

\examples{
\dontrun{
#  Recomendation, please choose another TokenPath to save the Login permanently.
sl <- yadirGetSiteLinks(Login         = "your.yandex.login",
						Ids           = c(5276537, 
						                  8927897239, 
						         	      252627, 
								          33123),
                        TokenPath     = tempdir())
 }
}


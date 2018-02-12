\name{yadirStopKeyWordss}
\alias{yadirStopKeyWordss}
\title{Suspend impressions by KeyWords}
\description{yadirStopKeyWordss suspend impressions by keywords in Yandex Direct account}
\usage{
yadirStopKeyWordss(Login = NULL, 
				   Ids   = NULL,
				   Token = NULL)
}

\arguments{
  \item{Ids}{Integer or Character vector with KeyWords Ids, who will suspend impressions}
  \item{Login}{Your Yandex Login}
  \item{Token}{Your Yandex API Token}
}
\details{
Function suspend impressions and return vector with KeyWords Ids with error.
}
\value{Vector with keywords ids which failed to suspend impressions}
\author{Alexey Seleznev}

\examples{
#Get API token
tok <- yadirGetToken()

#Get camp dictionary
my_camp <- yadirGetCampaignList(Login = "Login", Token = tok)

#Get keywords dictionary
my_kw <- yadirGetKeyWords(Login = "Login", Token = tok, CampaignIds = my_camp$Id[1:10])

#Resume impressions
err <- yadirStopKeyWordss(Login = "LOGIN", Token =  tok, Ids = my_kw$Id) 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
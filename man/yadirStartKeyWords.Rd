\name{yadirStartKeyWords}
\alias{yadirStartKeyWords}
\title{Resume impressions by KeyWords}
\description{yadirStartKeyWords resume impressions by keywords in Yandex Direct account}
\usage{
yadirStartKeyWords(Login = NULL, 
				   Ids   = NULL,
				   Token = NULL)
}

\arguments{
  \item{Ids}{Integer or Character vector with KeyWords Ids, who will resume impressions}
  \item{Login}{Your Yandex Login}
  \item{Token}{Your Yandex API Token}
}
\details{
Function resume impressions and return vector with KeyWords Ids with error.
}
\value{Vector with keywords ids which failed to resume impressions}
\author{Alexey Seleznev}

\examples{
#Get API token
tok <- yadirGetToken()

#Get camp dictionary
my_camp <- yadirGetCampaignList(Login = "Login", Token = tok)

#Get keywords dictionary
my_kw <- yadirGetKeyWords(Login = "Login", Token = tok, CampaignIds = my_camp$Id[1:10])

#Resume impressions
err <- yadirStartKeyWords(Login = "LOGIN", Token =  tok, Ids = my_kw$Id) 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
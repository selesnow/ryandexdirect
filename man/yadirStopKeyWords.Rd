\name{yadirStopKeyWords}
\alias{yadirStopKeyWords}
\title{Suspend impressions by KeyWords}
\description{yadirStopKeyWords suspend impressions by keywords in Yandex Direct account}
\usage{
yadirStopKeyWords(Login = NULL, Ids = NULL, Token = NULL, AgencyAccount
                 = NULL, TokenPath = getwd())
}

\arguments{
  \item{Ids}{Integer or Character vector with KeyWords Ids, who will suspend impressions}
  \item{Login}{Your Yandex Login}
  \item{Token}{Your Yandex API Token}
  \item{TokenPath}{Path to directory where you save credential data}
}
\details{
Function suspend impressions and return vector with KeyWords Ids with error.
}
\value{Vector with keywords ids which failed to suspend impressions}
\author{Alexey Seleznev}

\examples{
\dontrun{
#Get API token
tok <- yadirGetToken()

#Get camp dictionary
my_camp <- yadirGetCampaignList(Login = "Login", Token = tok)

#Get keywords dictionary
my_kw <- yadirGetKeyWords(Login = "Login", Token = tok, CampaignIds = my_camp$Id[1:10])

#Resume impressions
err <- yadirStopKeyWordss(Login = "LOGIN", Token =  tok, Ids = my_kw$Id) 
}
}


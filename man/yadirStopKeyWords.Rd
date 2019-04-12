\name{yadirStopKeyWords}
\alias{yadirStopKeyWords}
\title{Suspend impressions by KeyWords}
\description{Stops impressions by keyword phrases and autotargeting.}
\usage{
yadirStopKeyWords(Login = NULL, Ids = NULL, Token = NULL, AgencyAccount
                 = NULL, TokenPath = getwd())
}

\arguments{
  \item{Ids}{Integer or Character vector with KeyWords Ids, who will suspend impressions}
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
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
### Please choose another TokenPath to save the Login permanently.
# Get API token
tok <- yadirGetToken(TokenPath = tempdir())

# Get camp dictionary
my_camp <- yadirGetCampaignList(Login = "Login", Token = tok)

# Get keywords dictionary
my_kw <- yadirGetKeyWords(Login = "Login", Token = tok, CampaignIds = my_camp$Id[1:10])

# Resume impressions
err <- yadirStopKeyWords(Login = "LOGIN", Token =  tok, Ids = my_kw$Id) 
}
}


\name{yadirStartKeyWords}
\alias{yadirStartKeyWords}
\title{Resume KeyWords}
\description{Resumes impressions on previously stopped keyword phrases and auto-targeting.}
\usage{
yadirStartKeyWords(Login = getOption("ryandexdirect.user"), Ids = NULL, 
        Token = NULL, 
        AgencyAccount = getOption("ryandexdirect.agency_account"), 
        TokenPath = yadirTokenPath())
}

\arguments{
  \item{Ids}{Integer or Character vector with KeyWords Ids, who will resume impressions}
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{Token}{Your Yandex API Token}
  \item{TokenPath}{Path to directory where you save credential data}
}
\details{
Function resume impressions and return vector with KeyWords Ids with error.
}
\value{Vector with keywords ids which failed to resume impressions}
\author{Alexey Seleznev}

\examples{
\dontrun{
### Please choose another TokenPath to save the Login permanently.
# Get API token
tok <- yadirGetToken(TokenPath = tempdir())

# Get camp dictionary
my_camp <- yadirGetCampaignList(Login = "Login", 
                                Token = tok,
								TokenPath = tempdir())

# Get keywords dictionary
my_kw <- yadirGetKeyWords(Login = "Login", Token = tok, 
                          CampaignIds = my_camp$Id[1:10],
						  TokenPath = tempdir())

# Resume impressions
err <- yadirStartKeyWords(Login = "LOGIN", Token =  tok, 
                          Ids = my_kw$Id,
						  TokenPath = tempdir()) 
}
}

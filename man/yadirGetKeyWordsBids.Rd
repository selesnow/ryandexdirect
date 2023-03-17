\name{yadirGetKeyWordsBids}
\alias{yadirGetKeyWordsBids}
\title{Get KeyWords Bids}
\description{Returns bids and priorities for key phrases and auto-targeting that meet specified criteria, as well as bidding data: bids and write-off prices for different traffic volumes on a search and bids to reach different audience shares in networks.}
\usage{
yadirGetKeyWordsBids(
    KeywordIds    = NULL,
    AdGroupIds    = NULL,
    CampaignIds   = NULL,
    AuctionBids   = c(NA, 
		                  "search", 
		          			  "network"),
    Login         = getOption("ryandexdirect.user"),
    Token         = NULL,
    AgencyAccount = getOption("ryandexdirect.agency_account"),
    TokenPath     = yadirTokenPath())
}

\arguments{
  \item{KeywordIds}{Phrase ID. Specified if you want to update the bid for an individual phrase.}
  \item{AdGroupIds}{Ad Group ID. Specified if you need to update bids for all group phrases.}
  \item{CampaignIds}{Campaign ID. Specified if you need to update bids for all campaign phrases.}
  \item{AuctionBids}{Data on auctions, specify information about which auctions you are requesting. The values are: NA, "search", "network"}
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{Token}{Your Yandex API Token}
  \item{TokenPath}{Path to directory where you save credential data}
}
\details{
Use AuctionBids = "search" when you need traffic volume, bid on the search corresponding to the specified amount of traffi and charged price corresponding to the specified amount of traffic.
Use AuctionBids = "search" when you need get frequency of the show (audience share) in networks (specified in percent from 0 to 100) and network bid that matches the frequency shown.
}
\value{Data Frame with keyword bids and auction data}
\author{Alexey Seleznev}
\references{
\href{https://yandex.ru/dev/direct/doc/ref-v5/keywordbids/keywordbids-docpage}{KeyWord Bids API documentation}
\href{https://yandex.ru/dev/direct/doc/ref-v5/keywordbids/get-docpage}{KeyWord Bids get method API documentation}
}
\examples{
\dontrun{
### Please choose another TokenPath to save the Login permanently.
## Only bids for keywords with ids 123, 234, 345
bids <- yadirGetKeyWordsBids(KeywordIds = c(123, 234, 345))

### Get bids with search auction data
search_bids <- 
    yadirGetKeyWordsBids(KeywordIds = c(123, 234, 345)
	                     AuctionBids = "search")
						 
### Get bids with network auction data
network_bids <- 
    yadirGetKeyWordsBids(KeywordIds = c(123, 234, 345)
	                     AuctionBids = "network")
}
}


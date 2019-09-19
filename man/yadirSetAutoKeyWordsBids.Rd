\name{yadirSetAutoKeyWordsBids}
\alias{yadirSetAutoKeyWordsBids}
\title{Auto Set KeyWords Bids}
\description{Assigns search phrases for phrases depending on the desired volume of traffic or rates in networks depending on the desired frequency of display (audience share).}
\usage{
yadirSetAutoKeyWordsBids(
    KeywordIds             = NULL,
    AdGroupIds             = NULL,
    CampaignIds            = NULL,
    TargetTrafficVolume    = NULL,
    SearchIncreasePercent  = NULL,
    SearchBidCeiling       = NULL,
    TargetCoverage         = NULL,
    NetworkIncreasePercent = NULL,
    NetworkBidCeiling      = NULL,
    Login                  = NULL,
    Token                  = NULL,
    AgencyAccount          = NULL,
    TokenPath              = getwd())
}

\arguments{
  \item{KeywordIds}{Phrase ID. Specified if you want to update the bid for an individual phrase.}
  \item{AdGroupIds}{Ad Group ID. Specified if you need to update bids for all group phrases.}
  \item{CampaignIds}{Campaign ID. Specified if you need to update bids for all campaign phrases.}
  \item{TargetTrafficVolume}{The desired amount of traffic on the search. It is specified in percents from 5 to 100. The surcharge is added to the rate corresponding to the selected traffic volume (see the SearchIncreasePercent parameter).}
  \item{SearchIncreasePercent}{Percentage of markup on search from 0 to 1000. If not specified, the markup is not calculated.}
  \item{SearchBidCeiling}{Limit on bid on search. Integer. Indicated in the currency of the advertiser.}
  \item{TargetCoverage}{The desired frequency of display (audience share) in the networks. It is specified in percents from 1 to 100. The surcharge is added to the rate corresponding to the selected display frequency (see the NetworkIncreasePercent parameter).}
  \item{NetworkIncreasePercent}{Percentage of markup on network from 0 to 1000. If not specified, the markup is not calculated.}
  \item{NetworkBidCeiling}{Limit on network bid. Integer. Indicated in the currency of the advertiser.}
  \item{Login}{Your Yandex Login}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account}
  \item{Token}{Your Yandex API Token}
  \item{TokenPath}{Path to directory where you save credential data}
}
\details{
Search.

The rate corresponding to the traffic volume \code{TargetTrafficVolume × (1 + SearchIncreasePercent / 100)}, but no more \code{SearchBidCeiling}.

Over time, the activity of competitors can raise the rate for the desired amount of traffic, and it will exceed the advertiser's rate. The higher the surcharge, the greater the volume of traffic, but the higher the possible costs.

Network.

The rate corresponding to the display frequency \code{TargetCoverage × (1 + NetworkIncreasePercent / 100)}, but no more \code{NetworkBidCeiling}.

Over time, the activity of competitors can raise the bid for the desired frequency of display, and it will exceed the advertiser's bid. The higher the surcharge, the higher the frequency of display, but the higher the possible costs.
}
\value{List with result data, object ids, warnings and errors.}
\author{Alexey Seleznev}
\references{
\href{https://tech.yandex.ru/direct/doc/ref-v5/keywordbids/keywordbids-docpage/}{KeyWord Bids API documentation}
\href{https://tech.yandex.ru/direct/doc/ref-v5/keywordbids/setAuto-docpage/}{KeyWord Bids setAuto method API documentation}
}
\examples{
\dontrun{
# loading keywords list
kw <- yadirGetKeyWords()
# set bid on search
autosetbids_search <- 
   yadirSetAutoKeyWordsBids(TargetTrafficVolume = 5, 
                            KeywordIds = kw$Id)
# set bid on network
autosetbids_network <- 
   yadirSetAutoKeyWordsBids(TargetCoverage = 15,
                            KeywordIds = KeywordIds)
}
}


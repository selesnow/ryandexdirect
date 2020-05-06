\name{yadirSetKeyWordsBids}
\alias{yadirSetKeyWordsBids}
\title{Set KeyWords Bids}
\description{Assigns fixed bids and priorities for keyword phrases and auto-targeting.}
\usage{
yadirSetKeyWordsBids(
    KeywordIds       = NULL,
    AdGroupIds       = NULL,
    CampaignIds      = NULL,
    StrategyPriority = c(NA,
                        "LOW",
                        "NORMAL",
                        "HIGH"),
    SearchBid        = NULL,
    NetworkBid       = NULL,
    Login            = getOption("ryandexdirect.user"),
    Token            = NULL,
    AgencyAccount    = getOption("ryandexdirect.agency_account"),
    TokenPath        = yadirTokenPath())
}

\arguments{
  \item{KeywordIds}{Phrase ID. Specified if you want to update the bid for an individual phrase.}
  \item{AdGroupIds}{Ad Group ID. Specified if you need to update bids for all group phrases.}
  \item{CampaignIds}{Campaign ID. Specified if you need to update bids for all campaign phrases.}
  \item{StrategyPriority}{The priority of the phrase: LOW, NORMAL or HIGH. Only for automatic strategy.}
  \item{SearchBid}{Bid on search.}
  \item{NetworkBid}{Bid on network.}
  \item{Login}{Your Yandex Login.}
  \item{AgencyAccount}{Your agency account login, if you get statistic from client account.}
  \item{Token}{Your Yandex API Token.}
  \item{TokenPath}{Path to directory where you save credential data.}
}

\details{

You can set a bet or priority:

\itemize{
  \item for a separate keyword phrase or autotarget.
  \item for all keyword phrases and autotargeting in an ad group.
  \item for all keyword phrases and autotargets in the campaign.
} 

You can set a bid or priority depending on which display strategy is selected in the campaign:

\itemize{
  \item if the display strategy is selected on the \code{HIGHEST_POSITION} search, you can specify the SearchBid parameter.
  \item if you selected a display strategy on \code{MAXIMUM_COVERAGE} or \code{MANUAL_CPM} networks, you can specify the NetworkBid parameter.
  \item if the automatic strategy is selected, you can specify the StrategyPriority parameter: phrases with a higher priority receive as much traffic as possible, and in case of a budget deficit, they are turned off last.
}

If the element of the input array contains parameters that do not correspond to the strategy, the values of these parameters will not be changed:

\itemize{
  \item If the input array element contains both parameters corresponding to the strategy and parameters that do not correspond to the strategy (for example, both the bid and priority), then as a result of the operation, the values of only the parameters corresponding to the strategy will be changed and a warning will be issued.
  \item If the input array element contains only parameters that do not correspond to the strategy (for example, only the priority for a manual strategy), the operation will fail and an error will be returned.
}

}

\seealso{
See for get and autoset keyword bids \code{\link[ryandexdirect:yadirGetKeyWordsBids]{yadirGetKeyWordsBids()}} and \code{\link[ryandexdirect:yadirSetAutoKeyWordsBids]{yadirSetAutoKeyWordsBids()}}
}

\value{List with result data, object ids, warnings and errors.}
\author{Alexey Seleznev}
\references{
\itemize{
  \item \href{https://tech.yandex.ru/direct/doc/ref-v5/keywordbids/keywordbids-docpage/}{KeyWord Bids API documentation}
  \item \href{https://tech.yandex.ru/direct/doc/ref-v5/keywordbids/set-docpage/}{KeyWord Bids set method API documentation}
}
}
\examples{
\dontrun{
# loading keywords list
kw <- yadirGetKeyWords()
# set bid on search
setbid <- yadirSetKeyWordsBids(KeywordIds = kw$Id,
                               SearchBid  = 9)
}
}


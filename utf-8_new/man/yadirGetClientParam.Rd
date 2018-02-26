\name{yadirGetClientParam}
\alias{yadirGetClientParam}
\title{Get params list from yandex direct account}
\description{yadirGetClientParam get clients parameters names and parameters}
\usage{
yadirGetClientParam(Language = "ru", login = NULL, token = NULL)
}

\arguments{
  \item{login}{character with yandex direct login}
  \item{token}{your api yandex direct token}
  \item{Language}{Answer language one of en, ru, tr, uk}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{data frame with campaings names and parameters}
\author{Alexey Seleznev}

\examples{
#For get campaings data frame
cl <- yadirGetClientsTest(Language = "ru",
                          login = <YourLogin>, 
                          token = <YourToken>)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

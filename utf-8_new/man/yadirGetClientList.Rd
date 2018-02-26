\name{yadirGetClientList}
\alias{yadirGetClientList}
\title{Get client list with parameters and information}
\description{yadirGetClientList function for agency account for get his clients list with all information}
\usage{
yadirGetClientList(token = NULL)
}

\arguments{
  \item{token}{your api yandex direct token}
}

\value{data frame with client list}
\author{Alexey Seleznev}

\examples{clientList <- yadirGetClientList(myToken)}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

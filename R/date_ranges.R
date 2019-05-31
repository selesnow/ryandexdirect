# FetchBy
date_ranges <- function(start, end, by) {
  start <- as.Date(start)
  end <- as.Date(end)
  by <- tolower(by)
  by <- match.arg(by, c("day", "week", "month", "quarter", "year"))
  dates <- seq.Date(start, end, by = by)
  res <- cbind(start = as.character(dates),
               end = as.character(c(dates[-1] - 1, end)))
  as.data.frame(res, stringsAsFactors = F)
}

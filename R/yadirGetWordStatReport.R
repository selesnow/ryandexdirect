ReportID <- NULL
StatusReport <- NULL
ws_data <- NULL
SearchedAlso <- NULL 
SearchedWith <- NULL
. <- NULL

yadirGetWordStatReport <- function(
                             Phrases,
                             GeoID         = 0,
                             Login         = NULL,
                             Token         = NULL,
                             AgencyAccount = NULL,
                             TokenPath     = getwd()) {
  
  
  #start time
  start_time  <- Sys.time()
  
  Token <- tech_auth(login = Login, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  
  # send query
  send_query <- list(method = "CreateNewWordstatReport",
                     param = list(Phrases = list(Phrases),
                                  GeoID   = list(GeoID)),
                     locale = "ru",
                     token = Token) %>%
                toJSON(auto_unbox = TRUE)
  
  ans <- POST("https://api.direct.yandex.ru/v4/json/", body = send_query )
  
  rep_id = content(ans, 'parsed')
  
  
  # get query status
  rep_status <- 'New'
  
  while ( rep_status != 'Done' ) {
    
    get_status <- list(method = "GetWordstatReportList",
                  locale = "ru",
                  token = Token) %>%
             toJSON(auto_unbox = TRUE)
    
    ans <- POST("https://api.direct.yandex.ru/v4/json/", body = get_status )
    
    rep_status <- content(ans, 'parsed') %>% 
                    tibble( report = .$data ) %>% 
                    unnest_wider(report) %>%
                    filter(ReportID == rep_id) %>%
                    select(StatusReport) %>%
                    unlist()
    
    Sys.sleep(1)
    message("Report status: ", rep_status)
  }
  
  # get query
  get_query <- list(method = "GetWordstatReport",
                    param  = unlist(rep_id),
                    locale = "ru",
                    token = Token) %>%
               toJSON(auto_unbox = TRUE)
  
  raw_data <- POST("https://api.direct.yandex.ru/v4/json/", body = get_query )
  
  # unnesting_report
  report <- content(raw_data, 'parsed') %>% 
              tibble(ws_data = .$data) %>%
              unnest_wider(ws_data) %>%
              unnest_longer(GeoID) %>%
              unnest_longer(SearchedAlso) %>%
              hoist(SearchedAlso,
                    SearchedAlsoPhrase = c("Phrase"),
                    SearchedAlsoShows  = c("Shows")) %>%
              unnest_longer(SearchedWith) %>%
              hoist(SearchedWith,
                    SearchedWithPhrase = c("Phrase"),
                    SearchedWithShows  = c("Shows")) %>% 
              select(-".")
  
  
  message("Success!")
  stop_time <- Sys.time()
  message(paste0("Duration: ", round(difftime(stop_time, start_time , units ="secs"),0), " sec."))
  message("Request ID: ", ans$headers$requestid)
  message("WordStat Report ID: ", rep_id)
  return(report) 
}
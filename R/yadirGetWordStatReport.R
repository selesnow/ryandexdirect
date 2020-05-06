ReportID <- NULL
StatusReport <- NULL
ws_data <- NULL
SearchedAlso <- NULL 
SearchedWith <- NULL
. <- NULL

yadirGetWordStatReport <- function(
                             Phrases,
                             GeoID         = 0,
                             Login         = getOption("ryandexdirect.user"),
                             Token         = NULL,
                             AgencyAccount = getOption("ryandexdirect.agency_account"),
                             TokenPath     = yadirTokenPath()) {
  
  
  #start time
  start_time  <- Sys.time()
  
  Token <- tech_auth(login = Login, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  
  # check length
  Phrases <- yadirToList(Phrases)
  GeoID   <- yadirToList(GeoID)
  
  # отправляем отчёт
  message('.Send report')
  send_query <- list(method = "CreateNewWordstatReport",
                     param = list(Phrases = Phrases,
                                  GeoID   = GeoID),
                     locale = "ru",
                     token = Token) %>%
                toJSON(auto_unbox = TRUE)
  
  ans <- POST("https://api.direct.yandex.ru/v4/json/", body = send_query )
  
  rep_id = content(ans, 'parsed')
  
  # check for error
  if ( ! is.null( rep_id$error_str ) ) {
    
    message(rep_id$error_detail)
    stop(rep_id$error_str)
  }
  
  # проверка статуса отчёта
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
    message(".Report status: ", rep_status)
  }
  
  # get query
  message('.Get report')
  get_query <- list(method = "GetWordstatReport",
                    param  = unlist(rep_id),
                    locale = "ru",
                    token = Token) %>%
               toJSON(auto_unbox = TRUE)
  
  raw_data <- POST("https://api.direct.yandex.ru/v4/json/", body = get_query )
  
  # unnesting_report
  message('.Parse report')
  SearchedAlso <- content(raw_data, 'parsed') %>% 
                    tibble(ws_data = .$data) %>%
                    unnest_wider(ws_data) %>%
                    unnest_longer(GeoID) %>%
                    select(-SearchedWith, -".") %>%
                    unnest_longer(SearchedAlso) %>%
                    hoist(SearchedAlso,
                          Phrase     = c("Phrase"),
                          Shows      = c("Shows"))
  
  SearchedWith <- content(raw_data, 'parsed') %>% 
                    tibble(ws_data = .$data) %>%
                    unnest_wider(ws_data) %>%
                    unnest_longer(GeoID) %>%
                    select(-SearchedAlso, -".") %>%
                    unnest_longer(SearchedWith) %>%
                    hoist(SearchedWith,
                          Phrase     = c("Phrase"),
                          Shows      = c("Shows"))
  
  # create object
  report <- list(SearchedWith = SearchedWith,
                 SearchedAlso = SearchedAlso)
  
  # delete report
  message('.Delete report')
  get_query <- list(method = "GetWordstatReport",
                    param  = unlist(rep_id),
                    locale = "ru",
                    token = Token) %>%
    toJSON(auto_unbox = TRUE)
  
  raw_data <- POST("https://api.direct.yandex.ru/v4/json/", body = get_query )
  
  message("Success!")
  stop_time <- Sys.time()
  message(paste0("Duration: ", round(difftime(stop_time, start_time , units ="secs"),0), " sec."))
  message("Request ID: ", ans$headers$requestid)
  message("WordStat Report ID: ", rep_id)
  message("Report SearchedAlso has ", nrow(SearchedAlso), " rows")
  message("Report SearchedWith has ", nrow(SearchedWith), " rows")
  message("For get report data x[['ReportName']]")
  return(report) 
}

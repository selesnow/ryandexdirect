# var
ForecastID <- NULL 
StatusForecast <- NULL
Phrases <- NULL
Common <- NULL

# length check function
yadirToList <- function(x) {
  
  if ( length(x) == 1 ) {
    
    x <- as.list(x)
    
  }
  
  return(x)
  
}

# forecast function
yadirGetForecast <- function(
  Phrases,
  GeoID         = 0,
  Currency      = "RUB",
  AuctionBids   = "No",
  Login         = getOption("ryandexdirect.user"),
  Token         = NULL,
  AgencyAccount = getOption("ryandexdirect.agency_account"),
  TokenPath     = yadirTokenPath()) {
  
  
  #start time
  start_time  <- Sys.time()
  
  # auth
  Token <- tech_auth(login = Login, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  
  # AuctionBids
  if ( is.logical(AuctionBids) ) {
    
    if ( isTRUE(AuctionBids) ) {
      
      AuctionBids <- "Yes"
    
    } else {
      
      AuctionBids <- "No"
      
    }
  }
  
  # check length
  Phrases <- yadirToList(Phrases)
  GeoID   <- yadirToList(GeoID)
  
  # отправляем отчёт
  message('.Send Query')
  send_query <- list(method = "CreateNewForecast",
                     param = list(Phrases     = Phrases,
                                  GeoID       = GeoID,
                                  Currency    = Currency,
                                  AuctionBids = AuctionBids),
                     locale = "ru",
                     token = Token) %>%
    toJSON(auto_unbox = T, pretty = T)
  
  #return(send_query)
  ans <- POST("https://api.direct.yandex.ru/live/v4/json/", body = send_query )
  
  rep_id <- content(ans, 'parsed')

  # check for error
  if ( ! is.null( rep_id$error_str ) ) {
    
    message(rep_id$error_detail)
    stop(rep_id$error_str)
  }
  
  
  # проверка статуса отчёта
  rep_status <- 'New'

  while ( rep_status != 'Done' ) {
    
    get_status <- list(method = "GetForecastList",
                       locale = "ru",
                       token = Token) %>%
      toJSON(auto_unbox = TRUE)
    
    ans <- POST("https://api.direct.yandex.ru/live/v4/json/", body = get_status )
    
    rep_status <- content(ans, 'parsed') %>% 
      tibble( report = .$data ) %>% 
      unnest_wider(report) %>% 
      filter(ForecastID == rep_id) %>%
      select(StatusForecast) %>%
      unlist()
    
    Sys.sleep(15)
    message(".Forecast status: ", rep_status)
  }
  
  # get query
  message('.Get Forecast')
  get_query <- list(method = "GetForecast",
                    param  = unlist(rep_id),
                    locale = "ru",
                    token = Token) %>%
    toJSON(auto_unbox = TRUE)
  
  raw_data <- POST("https://api.direct.yandex.ru/live/v4/json/", body = get_query )
  
  # unnesting_report
  message('.Parse Forecast')

  PhrasesForecast <- content(raw_data, 'parsed') %>% 
                        tibble(ws_data = list(.$data)) %>% 
                        select(ws_data) %>%
                        unnest_wider(ws_data) %>%
                        select(-Common) %>%
                        unnest_longer(Phrases) %>% 
                        unnest_wider(Phrases)
  
  # if report with AuctionBids unnesting
  if ( tolower(AuctionBids) == 'yes' ) {
    
    PhrasesForecast <-
      PhrasesForecast %>%
        unnest_longer(AuctionBids) %>%
        unnest_wider(AuctionBids)
    
  }
  
  CommonForecast <- content(raw_data, 'parsed') %>% 
                        tibble(ws_data = list(.$data)) %>% 
                        select(ws_data) %>%
                        unnest_wider(ws_data) %>%
                        select(-Phrases) %>%
                        unnest_wider(Common) 
  
  # create object
  report <- list(PhrasesForecast = PhrasesForecast,
                 CommonForecast  = CommonForecast)
  
  # delete report
  message('.Delete Forecast')
  get_query <- list(method = "DeleteForecastReport",
                    param  = unlist(rep_id),
                    locale = "ru",
                    token = Token) %>%
    toJSON(auto_unbox = TRUE)
  
  raw_data <- POST("https://api.direct.yandex.ru/live/v4/json/", body = get_query )
  
  message("Success!")
  stop_time <- Sys.time()
  message(paste0("Duration: ", round(difftime(stop_time, start_time , units ="secs"),0), " sec."))
  message("Request ID: ", ans$headers$requestid)
  message("Forecast ID: ", rep_id)
  message("PhrasesForecast has ", nrow(PhrasesForecast), " rows")
  message("CommonForecast has ", nrow(CommonForecast), " rows")
  message("For get report data x[['ReportName']]")
  return(report) 
}

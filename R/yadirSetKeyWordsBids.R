yadirSetKeyWordsBids <- function(KeywordIds       = NULL,
                                 AdGroupIds       = NULL,
                                 CampaignIds      = NULL,
                                 StrategyPriority = c(NA, "LOW", "NORMAL", "HIGH" ),
                                 SearchBid        = NULL,
                                 NetworkBid       = NULL,
                                 Login            = NULL,
                                 Token            = NULL,
                                 AgencyAccount    = NULL,
                                 TokenPath        = getwd()) {
  # start time
  start_time  <- Sys.time()
  
  # check str priority
  StrategyPriority <- match.arg(StrategyPriority)
  
  # auth
  Token <- tech_auth(login         = Login, 
                     token         = Token, 
                     AgencyAccount = AgencyAccount, 
                     TokenPath     = TokenPath)
  
  # requests id log
  req_ids <- c()
  
  # out
  out <- list()
  
  # create body shell
  query_list <- list(method = "set",
                     params = 
                       list(KeywordBids = list())
  )
  
  
  # define variables
  if (! is.null(KeywordIds) ) {
    
    if ( "data.frame" %in% class( KeywordIds ) ) {
      KeywordIds <- KeywordIds$Id
    }
    object          <- "keywords"
    ids_parts_limit <- 10000
    ids             <- KeywordIds
    
    
  } else if (! is.null(AdGroupIds) ) {
    
    if ( "data.frame" %in% class( AdGroupIds ) ) {
      AdGroupIds <- AdGroupIds$Id
    }
    
    object          <- "adgroups"
    ids_parts_limit <- 1000
    ids             <- AdGroupIds
    
  } else {
    
    object          <- "campaings"
    ids_parts_limit <- 10
    
    
    if ( "data.frame" %in% class( CampaignIds ) ) {
      CampaignIds <- CampaignIds$Id
    }
    
    # if CampaignIds not set
    if ( is.null(CampaignIds) ) {
      message("You dont choised any ids of campaign, adgroup or ad. Loading full campaign list.")
      if ( interactive() ) {
        load_camp <- readline("Do you want load all campaings and set keywordbids to all account keywords? (y / n)")
        if ( tolower(load_camp) %in% c("y", "yes")) {
          ids <-  yadirGetCampaignList(Logins        = Login,
                                       AgencyAccount = AgencyAccount,
                                       Token         = Token,
                                       TokenPath     = TokenPath)$Id
        } else {
          
          stop("You don`t set any objects ids, please set KeywordIds or AdGroupIds or CampaignIds")
          
        }
        
      } else {
        
        stop("You don`t set any objects ids, please set KeywordIds or AdGroupIds or CampaignIds")
        
      }
      
    } else {
      ids             <- CampaignIds
    }
    
  }
  
  # object for collect answers
  res <- list()
  
  # spliting for obj limit
  id_parts <- split(ids, 
                    ceiling(seq_along(ids) / ids_parts_limit))
  
  # start of coleccting
  for (part_of_id in id_parts) {
    
    # detect ids and object
    if ( object == "keywords" ) {
      query_list_param <- lapply( part_of_id, function(x) list(KeywordId        = x,
                                                               StrategyPriority = StrategyPriority,
                                                               SearchBid        = ifelse( is.null(SearchBid), NA, SearchBid * 1000000 ),
                                                               NetworkBid       = ifelse( is.null(NetworkBid), NA, NetworkBid * 1000000 )))
    } else if ( object == "adgroups" ) {
      query_list_param <- lapply( part_of_id, function(x) list(AdGroupId        = x,
                                                               StrategyPriority = StrategyPriority,
                                                               SearchBid        = ifelse( is.null(SearchBid), NA, SearchBid * 1000000 ),
                                                               NetworkBid       = ifelse( is.null(NetworkBid), NA, NetworkBid * 1000000 )))
    } else if ( object == "campaings" ) {
      query_list_param <- lapply( part_of_id, function(x) list(CampaignId      = x,
                                                               StrategyPriority = StrategyPriority,
                                                               SearchBid        = ifelse( is.null(SearchBid), NA, SearchBid * 1000000 ),
                                                               NetworkBid       = ifelse( is.null(NetworkBid), NA, NetworkBid * 1000000 )))
    }
    
    # param to body
    query_list$params$KeywordBids <- query_list_param
    
    # create body
    queryBody <- toJSON(query_list, 
                        auto_unbox = T, 
                        pretty = T, 
                        null = "null")  
    
    # send request
    answer <- POST("https://api.direct.yandex.com/json/v5/keywordbids", 
                   body = queryBody, 
                   add_headers(Authorization = paste0("Bearer ", Token), 
                               `Accept-Language` = "ru", 
                               `Client-Login` = Login))
    
    # add request id
    req_ids <- append(req_ids, headers(answer)$requestid)
    
    # answer
    dataRaw <- content(answer, "parsed", "application/json")
    
    # check answer for error
    if ( ! is.null(dataRaw$error) ) {
      message("Error:  ", dataRaw$error$error_string)
      message("Code:   ", dataRaw$error$error_code)
      message("Detail: ", dataRaw$error$error_detail)
      stop(dataRaw$error$error_detail)
    }
    
    out     <- append(out, list(list(request_id = headers(answer)$requestid,
                                     data       = list(dataRaw)))) 
    
    # set names
    names(out)  <- c(names(out), headers(answer)$requestid)
  }
  
  # copy for 
  out_ew <- out
  
  # get out data
  out <-
    lapply(out,
           function(x) {
             lapply(x$data,
                    function(y) 
                      sapply(y$result$SetResults,
                             function(z) 
                               z$KeywordId)
             )
     })
  
  # check errors
  Errors <- lapply(out_ew,
                      function(x) {
                        sapply( x$data,
                                function(y) {
                                  sapply(y$result$SetResults,
                                         function(z) {
                                           sapply(z$Errors,
                                                  function(errors) {
                                                    message("!..Error: ", unlist(errors$Details))
                                                    errors$Details
                                                  })})
                                } )
                      }
  )

  # check warnings
  Warnings <- lapply(out_ew,
                     function(x) {
                       sapply( x$data,
                               function(y) {
                                 sapply(y$result$SetResults,
                                        function(z) {
                                          sapply(z$Warnings,
                                                 function(warnings) {
                                                   message("...Warning: ", unlist(warnings$Details))
                                                   warnings$Details
                                                 })})
                               } )
                     }
  )
  
  end_time <- Sys.time()
  
  message("Duration: ", round(difftime(end_time, start_time, units = "secs"), 0), " secs")
  message("Total requests send: ", length(req_ids))
  message("RequestIDs: ", paste(req_ids, collapse = ", "))
  
  message("Ditails ----------------->")
  for ( om in req_ids ) {
    message("RequestID: ", om)
    message("ResultIds: ", paste(unlist(out[[om]]), collapse = ", "))
  }
  
  return(out)
}

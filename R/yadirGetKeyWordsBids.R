yadirGetKeyWordsBids <- function(KeywordIds    = NULL,
                                 AdGroupIds    = NULL,
                                 CampaignIds   = NULL,
                                 AuctionBids   = c(NA, "search", "network"),
                                 Login         = NULL,
                                 Token         = NULL,
                                 AgencyAccount = NULL,
                                 TokenPath     = getwd()) {
  # start time
  start_time  <- Sys.time()
  
  # auth
  Token <- tech_auth(login = Login, 
                     token = Token, 
                     AgencyAccount = AgencyAccount, 
                     TokenPath = TokenPath)
  
  # auction
  AuctionBids <- match.arg(AuctionBids)
  
  # requests id log
  req_ids <- c()
  
  # create body
  query_list <- list(method = "get",
                     params = 
                        list(SelectionCriteria = list(ServingStatuses = list("ELIGIBLE", "RARELY_SERVED")),
                             FieldNames = list( "KeywordId", "AdGroupId", "CampaignId", "ServingStatus", "StrategyPriority"),
                             SearchFieldNames = list("Bid", "AuctionBids"),
                             NetworkFieldNames  = list("Bid", "Coverage"))
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
      ids <-  yadirGetCampaignList(Logins        = Login,
                                           AgencyAccount = AgencyAccount,
                                           Token         = Token,
                                           TokenPath     = TokenPath)$Id
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
    
    if ( length(part_of_id) == 1 ) {
    
	part_of_id <- list(part_of_id)
	 
    }	
	
    # detect ids and object
    if ( object == "keywords" ) {
      query_list$params$SelectionCriteria$KeywordIds  <- part_of_id
    } else if ( object == "adgroups" ) {
      query_list$params$SelectionCriteria$AdGroupIds  <- part_of_id
    } else {
      query_list$params$SelectionCriteria$CampaignIds <- part_of_id
    }
    
    # create body
    queryBody <- jsonlite::toJSON(query_list, 
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
    
    # check answer
    stop_for_status(answer)
    # pars answer
    dataRaw <- content(answer, "parsed", "application/json")
    
    # check answer for error
    if ( ! is.null(dataRaw$error) ) {
      message("Error:  ", dataRaw$error$error_string)
      message("Code:   ", dataRaw$error$error_code)
      message("Detail: ", dataRaw$error$error_detail)
      stop(dataRaw$error$error_detail)
    }
    
    # add to results list
    res <- append(res, list(dataRaw))
    
    
  }
  
  # answer level parsing result
  res_flatting <- list()
  
  # answer level
  for ( part_of_res in res ) {
    
    # keywordbid level
    for( kw_bid in part_of_res$result$KeywordBids ) {
      
      ## check AuctionBids for Search auctions
      if ( tolower(AuctionBids) == "search" && !is.na(AuctionBids) ) {
        # auction level
        for( auction_ser in kw_bid$Search$AuctionBids$AuctionBidItems ) {
          
             res_flatting <- append(res_flatting,
                               list(      
                               list(KeywordId            = kw_bid$KeywordId,
                                    AdGroupId            = kw_bid$AdGroupId,
                                    CampaignId           = kw_bid$CampaignId,
                                    ServingStatus        = kw_bid$ServingStatus,
                                    StrategyPriority     = kw_bid$StrategyPriority,
                                    SearchBid            = kw_bid$Search$Bid / 1000000,
                                    NetworkBid           = kw_bid$Network$Bid / 1000000,
                                    AuctionTrafficVolume = auction_ser$TrafficVolume,
                                    AuctionBid           = auction_ser$Bid / 1000000,
                                    AuctionPrice         = auction_ser$Price / 1000000)
                                )
                              )
        }
        
      ## check AuctionBids for Network auctions
      } else if (  tolower(AuctionBids) == "network"  && !is.na(AuctionBids) ) {
        # auction level
        for( auction_ser in kw_bid$Network$Coverage$CoverageItems ) {
          
          res_flatting <- append(res_flatting,
                                 list(      
                                   list(KeywordId        = kw_bid$KeywordId,
                                        AdGroupId        = kw_bid$AdGroupId,
                                        CampaignId       = kw_bid$CampaignId,
                                        ServingStatus    = kw_bid$ServingStatus,
                                        StrategyPriority = kw_bid$StrategyPriority,
                                        SearchBid        = kw_bid$Search$Bid / 1000000,
                                        NetworkBid       = kw_bid$Network$Bid / 1000000,
                                        Probability      = auction_ser$Probability,
                                        AuctionBid       = auction_ser$Bid / 1000000)
                                 )
          )
          
        }
        
      ## check AuctionBids without auctions
      } else {
        
        res_flatting <- append(res_flatting,
                               list(      
                                 list(KeywordId        = kw_bid$KeywordId,
                                      AdGroupId        = kw_bid$AdGroupId,
                                      CampaignId       = kw_bid$CampaignId,
                                      ServingStatus    = kw_bid$ServingStatus,
                                      StrategyPriority = kw_bid$StrategyPriority,
                                      SearchBid        = kw_bid$Search$Bid  / 1000000,
                                      NetworkBid       = kw_bid$Network$Bid / 1000000)
                               )
        )
        
    }
      
      
  }
}
  
  out <- dplyr::bind_rows(res_flatting) 
  end_time <- Sys.time()
  
  message("Duration: ", round(difftime(end_time, start_time, units = "secs"), 0), " secs")
  message("Total requests send: ", length(req_ids))
  message("RequestIDs: ", paste(req_ids, collapse = ", "))
  
  return(out)

}


yadirGetSummaryStat <-
function(campaignIDS = NULL, dateStart = Sys.Date()-10, dateEnd = Sys.Date(), currency = "USD", token = NULL){
  if(is.null(token)|is.null(campaignIDS)){
    warning("You must add argument campaignIDS and token! ");
    return()
  }
  
  if(as.integer(as.Date(dateEnd) - as.Date(dateStart)) > 1000) {
    warning("You can send query less 1000 days period!");
    return()
    }
  
  #Check currency value, and replace him if is nit in provide currency refference
  #Ïðîâåðÿåì çíà÷åíèå âàëþòû è åñëè îíî íå âõîäèò â ñïðàâî÷íèê äîñòóïíûõ âàëþò óñòàíàâëèâàåì USD
  ifelse((!(currency %in% c("RUB", "CHF", "EUR", "KZT", "TRY", "UAH", "USD"))), currency <- "USD", currency <- currency)
  
  #Create result data frame
  #Ñîçäà¸ì ðåçóëüòèðóþùèé äàòà ôðåéì
  data <- data.frame()
  
  #bypassing limitation and run api request by one campaign
  #Îáõîäèì îãðàíè÷åíèå â êîëè÷åñòâî ñòðîê â 1000 ïóò¸ì ïîî÷åð¸äíîãî çàïðîñà ïî êàìïàíèÿì
  for (iids in 1:length(campaignIDS)){
    #Create POST request
    #Ñîçäà¸ì POST çàïðîñ
    answer <- POST("https://api.direct.yandex.ru/v4/json/", body = paste0("{\"method\": \"GetSummaryStat\", \"param\":{\"CampaignIDS\": [\"",campaignIDS[iids],"\"], \"StartDate\" : \"",dateStart,"\", \"EndDate\": \"",dateEnd,"\", \"Currency\": \"",currency,"\"}, \"locale\": \"ru\", \"token\": \"",token,"\"}"))
    #Send POST request
    #Îòïðàâêà POST çàïðîñà ê API Äèðåêòà
    stop_for_status(answer)
    dataRaw <- content(answer, "parsed", "application/json")
    
    #Run cicle which parse result by current campaign and add this data to result data frame
    #Çàïóñêàåì öèêë êîòîðûé ïàðñèò òåêóùóþ êàìïàíèþ è äîáàâëÿåò ïîëó÷åííûå äàííûå â èòîãîâûé äàòà ôðåéì
    for (i in 1:length(dataRaw$data)){
      #Replace NULL to NA
      #Çàìåíÿåì ïðîïóùåííûå çíà÷åíèå íà NA
      try(dataRaw$data[[i]][sapply(dataRaw$data[[i]], is.null)] <- NA, silent = TRUE)
      try(dataTemp <- data.frame(t(as.data.frame(unlist(dataRaw$data[[i]],recursive = T))),row.names = NULL), silent = TRUE)
      try(data <- rbind(data, dataTemp), silent = TRUE)
      if(exists("dataTemp")) {rm(dataTemp)} 
    }
  }
  try(dataTotal <- data.frame(
        Date =  as.POSIXlt(data$StatDate),
        CampaignID = as.factor(data$CampaignID),
        SumSearch = as.numeric(as.character(data$SumSearch)),
        GoalConversionSearch = as.numeric(as.character(data$GoalConversionSearch)),
        GoalCostSearch = as.numeric(as.character(data$GoalCostSearch)),
        ClickSearch = as.integer(data$ClicksSearch),
        ShowsSearch = as.integer(data$ShowsSearch),
        SessionDepthSearch = as.numeric(as.character(data$SessionDepthSearch)),
        SumContext = as.numeric(as.character(data$SumContext)),
        GoalConversionContext = as.numeric(as.character(data$GoalConversionContext)),
        GoalCostContext = as.numeric(as.character(data$GoalCostContext)),
        ClicksContext = as.integer(data$ClicksContext),
        ShowsContext = as.integer(data$ShowsContext),
        SessionDepthContext = as.numeric(as.character(data$SessionDepthSearch))
  ), silent = T)
  if(exists("dataTotal")){return(dataTotal)} else {return(data.frame())}
}

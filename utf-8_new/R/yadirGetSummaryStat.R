yadirGetSummaryStat <-
function(campaignIDS = NULL, dateStart = Sys.Date()-10, dateEnd = Sys.Date(), currency = "USD", token = NULL){
  if(is.null(token)|is.null(campaignIDS)){
    warning("You must add argument campaignIDS and token! ");
    break
  }
  #Check currency value, and replace him if is nit in provide currency refference
  #РџСЂРѕРІРµСЂСЏРµРј Р·РЅР°С‡РµРЅРёРµ РІР°Р»СЋС‚С‹ Рё РµСЃР»Рё РѕРЅРѕ РЅРµ РІС…РѕРґРёС‚ РІ СЃРїСЂР°РІРѕС‡РЅРёРє РґРѕСЃС‚СѓРїРЅС‹С… РІР°Р»СЋС‚ СѓСЃС‚Р°РЅР°РІР»РёРІР°РµРј USD
  ifelse((!(currency %in% c("RUB", "CHF", "EUR", "KZT", "TRY", "UAH", "USD"))), currency <- "USD", currency <- currency)
  
  #Create result data frame
  #РЎРѕР·РґР°С‘Рј СЂРµР·СѓР»СЊС‚РёСЂСѓСЋС‰РёР№ РґР°С‚Р° С„СЂРµР№Рј
  data <- data.frame()
  
  #bypassing limitation and run api request by one campaign
  #РћР±С…РѕРґРёРј РѕРіСЂР°РЅРёС‡РµРЅРёРµ РІ РєРѕР»РёС‡РµСЃС‚РІРѕ СЃС‚СЂРѕРє РІ 1000 РїСѓС‚С‘Рј РїРѕРѕС‡РµСЂС‘РґРЅРѕРіРѕ Р·Р°РїСЂРѕСЃР° РїРѕ РєР°РјРїР°РЅРёСЏРј
  for (iids in 1:length(campaignIDS)){
    #Create POST request
    #РЎРѕР·РґР°С‘Рј POST Р·Р°РїСЂРѕСЃ
    answer <- POST("https://api.direct.yandex.ru/v4/json/", body = paste0("{\"method\": \"GetSummaryStat\", \"param\":{\"CampaignIDS\": [\"",campaignIDS[iids],"\"], \"StartDate\" : \"",dateStart,"\", \"EndDate\": \"",dateEnd,"\", \"Currency\": \"",currency,"\"}, \"locale\": \"ru\", \"token\": \"",token,"\"}"))
    #Send POST request
    #РћС‚РїСЂР°РІРєР° POST Р·Р°РїСЂРѕСЃР° Рє API Р”РёСЂРµРєС‚Р°
    stop_for_status(answer)
    dataRaw <- content(answer, "parsed", "application/json")
    
    #Run cicle which parse result by current campaign and add this data to result data frame
    #Р—Р°РїСѓСЃРєР°РµРј С†РёРєР» РєРѕС‚РѕСЂС‹Р№ РїР°СЂСЃРёС‚ С‚РµРєСѓС‰СѓСЋ РєР°РјРїР°РЅРёСЋ Рё РґРѕР±Р°РІР»СЏРµС‚ РїРѕР»СѓС‡РµРЅРЅС‹Рµ РґР°РЅРЅС‹Рµ РІ РёС‚РѕРіРѕРІС‹Р№ РґР°С‚Р° С„СЂРµР№Рј
    for (i in 1:length(dataRaw$data)){
      #Replace NULL to NA
      #Р—Р°РјРµРЅСЏРµРј РїСЂРѕРїСѓС‰РµРЅРЅС‹Рµ Р·РЅР°С‡РµРЅРёРµ РЅР° NA
      try(dataRaw$data[[i]][sapply(dataRaw$data[[i]], is.null)] <- NA, silent = TRUE)
      try(dataTemp <- data.frame(StatDate           = dataRaw$data[[i]]$StatDate,
                             CampaignID             = dataRaw$data[[i]]$CampaignID,
                             SumSearch              = dataRaw$data[[i]]$SumSearch,
                             GoalConversionSearch   = dataRaw$data[[i]]$GoalConversionSearch,
                             GoalCostSearch         = dataRaw$data[[i]]$GoalCostSearch,
                             ClickSearch            = dataRaw$data[[i]]$ClicksSearch,
                             ShowsSearch            = dataRaw$data[[i]]$ShowsSearch,
                             SessionDepthSearch     = dataRaw$data[[i]]$SessionDepthSearch,
                             SumContext             = dataRaw$data[[i]]$SumContext,
                             GoalConversionContext  = dataRaw$data[[i]]$GoalConversionContext,
                             GoalCostContext        = dataRaw$data[[i]]$GoalCostContext,
                             ClicksContext          = dataRaw$data[[i]]$ClicksContext,
                             ShowsContext           = dataRaw$data[[i]]$ShowsContext,
                             SessionDepthContext    = dataRaw$data[[i]]$SessionDepthContext), silent = T)
      try(data <- rbind(data, dataTemp), silent = TRUE)
      if(exists("dataTemp")) {rm(dataTemp)} 
    }
  }
  try(dataTotal <- data.frame(
    Date                  =  as.POSIXlt(data$StatDate),
    CampaignID            = as.factor(data$CampaignID),
    SumSearch             = as.numeric(as.character(data$SumSearch)),
    GoalConversionSearch  = as.numeric(as.character(data$GoalConversionSearch)),
    GoalCostSearch        = as.numeric(as.character(data$GoalCostSearch)),
    ClickSearch           = as.integer(data$ClickSearch),
    ShowsSearch           = as.integer(data$ShowsSearch),
    SessionDepthSearch    = as.numeric(as.character(data$SessionDepthSearch)),
    SumContext            = as.numeric(as.character(data$SumContext)),
    GoalConversionContext = as.numeric(as.character(data$GoalConversionContext)),
    GoalCostContext       = as.numeric(as.character(data$GoalCostContext)),
    ClicksContext         = as.integer(data$ClicksContext),
    ShowsContext          = as.integer(data$ShowsContext),
    SessionDepthContext   = as.numeric(as.character(data$SessionDepthSearch))
  ), silent = T)
  if(exists("dataTotal")){return(dataTotal)} else {return(data.frame())}
}

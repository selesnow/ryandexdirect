yadirGetDictionary <- function(DictionaryName = "GeoRegions", Language = "ru", login = NULL, token = NULL){
  #Ïðîâåðêà íàëè÷èÿ ëîãèíà è òîêåíà
  if(is.null(login)|is.null(token)) {
    stop("You must enter login and API token!")
  }
  
  #Ïðîâåðêà âåðíî ëè óêàçàíî íàçâàíèå ñïðàâî÷íèêà
  if(!DictionaryName %in% c("Currencies",
                            "MetroStations",
                            "GeoRegions",
                            "TimeZones",
                            "Constants",
                            "AdCategories",
                            "OperationSystemVersions",
                            "ProductivityAssertions",
                            "SupplySidePlatforms",
                            "Interests")){
    stop("Error in DictionaryName, select one of Currencies, MetroStations, GeoRegions, TimeZones, Constants, AdCategories, OperationSystemVersions, ProductivityAssertions, SupplySidePlatforms, Interests")
  }
  
  queryBody <- paste0("{
                      \"method\": \"get\",
                      \"params\": {
                      \"DictionaryNames\": [ \"",DictionaryName,"\" ]
}
}")
  
  #Îòïðàâêà çàïðîñà íà ñåðâåð
  answer <- POST("https://api.direct.yandex.com/json/v5/dictionaries", body = queryBody, add_headers(Authorization = paste0("Bearer ",token), 'Accept-Language' = Language, "Client-Login" = login[1]))
  #Ïðîâåðêà ðåçóëüòàòà íà îøèáêè
  stop_for_status(answer)
  
  dataRaw <- content(answer, "parsed", "application/json")
  
  if(length(dataRaw$error) > 0){
    stop(paste0(dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
  }
  
  #Ïðåîáðàçóåì îòâåò â data frame
  
  #Ïàðñèíã ñïðàâî÷íèêà ðåãèîíîâ
  if(DictionaryName == "GeoRegions"){
    dictionary_df <- data.frame()
    
    for(dr in 1:length(dataRaw$result[[1]])){
      dictionary_df_temp <- data.frame(GeoRegionId = dataRaw$result[[1]][[dr]]$GeoRegionId,
                                       ParentId = ifelse(is.null(dataRaw$result[[1]][[dr]]$ParentId),NA , dataRaw$result[[1]][[dr]]$ParentId),
                                       GeoRegionType = dataRaw$result[[1]][[dr]]$GeoRegionType,
                                       GeoRegionName = dataRaw$result[[1]][[dr]]$GeoRegionName)
      dictionary_df <- rbind(dictionary_df, dictionary_df_temp)
      
    }}
  
  #Ïàðñèíã ñïðàâî÷íèêà âàëþò
  if(DictionaryName == "Currencies"){
    dictionary_df <- data.frame()
    for(dr in 1:length(dataRaw$result[[1]])){
      dictionary_df_temp <- data.frame(Cur = dataRaw$result[[1]][[dr]]$Currency, as.data.frame(do.call(rbind.data.frame, dataRaw$result[[1]][[dr]]$Properties), row.names = NULL, stringsAsFactors = F))
      dictionary_df <- rbind(dictionary_df, dictionary_df_temp)
    }
    dictionary_df_cur <- data.frame()
    #Ïðåîáðàçóåì ñïðàâî÷íèê âàëþò
    for(curlist in unique(dictionary_df$Cur)){
      dictionary_df_temp <- data.frame(Cur = curlist,
                                       FullName = dictionary_df[dictionary_df$Cur == curlist & dictionary_df$Name == "FullName",3],
                                       Rate = dictionary_df[dictionary_df$Cur == curlist & dictionary_df$Name == "Rate",3],
                                       RateWithVAT = dictionary_df[dictionary_df$Cur == curlist & dictionary_df$Name == "RateWithVAT",3])
      dictionary_df_cur <- rbind(dictionary_df_cur,dictionary_df_temp)
    }
    dictionary_df <- dictionary_df_cur
  }
  
  #Ïàðñèíã ñïðàâî÷íèêà Interests
  if(DictionaryName == "Interests"){
    dictionary_df <- data.frame()
    for(dr in 1:length(dataRaw$result[[1]])){
      dictionary_df_temp <- data.frame(Name = dataRaw$result[[1]][[dr]]$Name,
                                       ParentId = ifelse(is.null(dataRaw$result[[1]][[dr]]$ParentId),NA , dataRaw$result[[1]][[dr]]$ParentId),
                                       InterestId = dataRaw$result[[1]][[dr]]$InterestId,
                                       IsTargetable = dataRaw$result[[1]][[dr]]$IsTargetable)
      dictionary_df <- rbind(dictionary_df, dictionary_df_temp)
    }
  }
  
  #Ïàðñèíã îñòàëüíûõ ñïðàâî÷íèêîâ ñî ñòàíäàðòíîé ñòðóêòóðîé
  if(! DictionaryName %in% c("Currencies","GeoRegions","Interests")){
    dictionary_df <- do.call(rbind.data.frame, dataRaw$result[[1]])
  }
  
  #Âûâîäèì èíôîðìàöèþ î ðàáîòå çàïðîñà è î êîëè÷åñòâå áàëëîâ
  packageStartupMessage("Ñïðàâî÷íèê óñïåøíî çàãðóæåí!", appendLF = T)
  packageStartupMessage(paste0("Áûëëû ñïèñàíû ñ : " ,answer$headers$`units-used-login`), appendLF = T)
  packageStartupMessage(paste0("Ê-âî áàëëîâ èçðàñõîäîâàíûõ ïðè âûïîëíåíèè çàïðîñà: " ,strsplit(answer$headers$units, "/")[[1]][1]), appendLF = T)
  packageStartupMessage(paste0("Äîñòóïíûé îñòàòîê ñóòî÷íîãî ëèìèòà áàëëîâ: " ,strsplit(answer$headers$units, "/")[[1]][2]), appendLF = T)
  packageStartupMessage(paste0("Ñóòî÷íûé ëèìèò áàëëîâ: " ,strsplit(answer$headers$units, "/")[[1]][3]), appendLF = T)
  packageStartupMessage(paste0("Óíèêàëüíûé èäåíòèôèêàòîð çàïðîñà êîòîðûé íåîáõîäèìî óêàçûâàòü ïðè îáðàùåíèè â ñëóæáó ïîääåðæêè: ",answer$headers$requestid), appendLF = T)
  
  #Âîçâðàùàåì ðåçóëüòàò â âèäå Data Frame
  return(dictionary_df)
}


yadirGetClientParam <- function(Language = "ru", login = NULL, token = NULL){
  #Ïðîâåðêà íàëè÷èÿ ëîãèíà è òîêåíà
  if(is.null(login)|is.null(token)) {
    stop("You must enter login and API token!")
  }
  
  
  queryBody <- paste0("{
  \"method\": \"get\",
                      \"params\": { 
                      \"FieldNames\": [
                      \"AccountQuality\",
                      \"Archived\",
                      \"ClientId\",
                      \"ClientInfo\",
                      \"CountryId\",
                      \"CreatedAt\",
                      \"Currency\",
                      \"Grants\",
                      \"Login\",
                      \"Notification\",
                      \"OverdraftSumAvailable\",
                      \"Phone\",
                      \"Representatives\",
                      \"Restrictions\",
                      \"Settings\",
                      \"VatRate\"]
}
}")
  
  #Îòïðàâêà çàïðîñà íà ñåðâåð
  answer <- POST("https://api.direct.yandex.com/json/v5/clients", body = queryBody, add_headers(Authorization = paste0("Bearer ",token), 'Accept-Language' = Language, "Client-Login" = login[1]))
  #Ïðîâåðêà ðåçóëüòàòà íà îøèáêè
  stop_for_status(answer)
  
  dataRaw <- content(answer, "parsed", "application/json")
  
  if(length(dataRaw$error) > 0){
    stop(paste0(dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
  }
  
  #Ïðåîáðàçóåì îòâåò â data frame
  
  #Ïàðñèíã ñïðàâî÷íèêà ðåãèîíîâ
    dictionary_df <- data.frame()
    
    for(dr in 1:length(dataRaw$result[[1]])){
      dictionary_df_temp <- data.frame(Login = dataRaw$result[[1]][[dr]]$Login,
                                       ClientId = dataRaw$result[[1]][[dr]]$ClientId,
                                       CountryId = dataRaw$result[[1]][[dr]]$CountryId,
                                       Currency = dataRaw$result[[1]][[dr]]$Currency,
                                       CreatedAt = dataRaw$result[[1]][[dr]]$CreatedAt,
                                       ClientInfo = dataRaw$result[[1]][[dr]]$ClientInfo,
                                       AccountQuality = dataRaw$result[[1]][[dr]]$AccountQuality,
                                       CampaignsTotalPerClient = dataRaw$result[[1]][[dr]]$Restrictions[[1]]$Value,
                                       CampaignsUnarchivePerClient = dataRaw$result[[1]][[dr]]$Restrictions[[2]]$Value,
                                       APIPoints = dataRaw$result[[1]][[dr]]$Restrictions[[10]]$Value)
      
      dictionary_df <- rbind(dictionary_df, dictionary_df_temp)
      
    }

    #Âûâîäèì èíôîðìàöèþ î ðàáîòå çàïðîñà è î êîëè÷åñòâå áàëëîâ
     #packageStartupMessage("Ñïðàâî÷íèê óñïåøíî çàãðóæåí!", appendLF = T)
     #packageStartupMessage(paste0("Áûëëû ñïèñàíû ñ : " ,answer$headers$`units-used-login`), appendLF = T)
     #packageStartupMessage(paste0("Ê-âî áàëëîâ èçðàñõîäîâàíûõ ïðè âûïîëíåíèè çàïðîñà: " ,strsplit(answer$headers$units, "/")[[1]][1]), appendLF = T)
     #packageStartupMessage(paste0("Äîñòóïíûé îñòàòîê ñóòî÷íîãî ëèìèòà áàëëîâ: " ,strsplit(answer$headers$units, "/")[[1]][2]), appendLF = T)
     #packageStartupMessage(paste0("Ñóòî÷íûé ëèìèò áàëëîâ: " ,strsplit(answer$headers$units, "/")[[1]][3]), appendLF = T)
     #packageStartupMessage(paste0("Óíèêàëüíûé èäåíòèôèêàòîð çàïðîñà êîòîðûé íåîáõîäèìî óêàçûâàòü ïðè îáðàùåíèè â ñëóæáó ïîääåðæêè: ",answer$headers$requestid), appendLF = T)
    #Âîçâðàùàåì ðåçóëüòàò â âèäå Data Frame
  return(dictionary_df)
}

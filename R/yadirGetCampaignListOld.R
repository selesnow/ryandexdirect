yadirGetCampaignListOld <-
function (logins = NULL, token = NULL) {
  #Create result data frame
  #Ñîçäà¸ì äàòà ôðåéì
  data <- data.frame()
  
  #Check login number, if less 100 send simply query
  #Ïðîâåðÿåì êîëè÷åñòâî ëîãèíîâ, åñëè ìåíåå 100 òî çàïóñêàåì óïðîù¸ííóþ ïðîöåäóðó
  if(length(logins) < 101){
    #Create login list in string
    #Ñîçäà¸ì ñïèñîê ëîãèíîâ â âèäå ñòðîêè
    loginsList <- paste0(paste0("\"",logins,"\""), collapse = ",")
    answer <- POST("https://api.direct.yandex.ru/v4/json/", body = paste0("{\"method\": \"GetCampaignsList\"",ifelse(is.null(logins),"",paste0(",\"param\": [",loginsList,"]")),", \"locale\": \"ru\", \"token\": \"",token,"\"}"))
    #Send POST request
    #Îòïðàâêà POST çàïðîñà
    stop_for_status(answer)
    dataRaw <- content(answer, "parsed", "application/json")
    #Create result data frame
    #Íàïîëíÿåì ðåçóëüòèðóþùèé äàòà ôðåéì
    data <- data.frame()
    for (i in 1:length(dataRaw$data)){
      dataRaw$data[[i]][sapply(dataRaw$data[[i]], is.null)] <- NA
      dataTemp <- data.frame(t(as.data.frame(unlist(dataRaw$data[[i]],recursive = T))),row.names = NULL)
      data <- rbind(data, dataTemp)
    }
    
    return(data)
    
  } else {
    
    #If logins more than 100 run cicle by 100 logins
    #Â ñëó÷àå åñëè ââåäåíî áîëåå 100 ëîãèíîâ íåîõîäèìî îáîéòè îãðàíè÷åíèå API è îòïðàâëÿòü çàïðîñû îòäåëüíî ïî 100 ëîãèíîâ
    loginsList <- NULL
    start <- 1
    step <- 99
    finish <- length(logins)
    while (start < (finish - 100)){
      
      startLim <- start+step
      loginstxt <- logins[start:startLim]
      loginsList <- paste0(paste0("\"",loginstxt,"\""), collapse = ",")
      answer <- POST("https://api.direct.yandex.ru/v4/json/", body = paste0("{\"method\": \"GetCampaignsList\"",ifelse(is.null(logins),"",paste0(",\"param\": [",loginsList,"]")),", \"locale\": \"ru\", \"token\": \"",token,"\"}"))
      #Send POST request
      #Îòïðàâëÿåì POST çàïðîñ
      stop_for_status(answer)
      
      dataRaw <- content(answer, "parsed", "application/json")
      for (i in 1:length(dataRaw$data)){
        dataRaw$data[[i]][sapply(dataRaw$data[[i]], is.null)] <- NA
        dataTemp <- data.frame(t(as.data.frame(unlist(dataRaw$data[[i]],recursive = T))),row.names = NULL)
        data <- rbind(data, dataTemp)
      }
      #Step on next 100 logins
      #Ïåðåõîäèì íà ñëåäóþùèå 100 ëîãèíîâ
      start <- start + step + 1
      #If this last part of logins do this
      #Åñëè ýòî ïîñëåäíÿÿ ïàðòèÿ ëîãèíîâ òî ïåðåõîäèì ê ñëåäóþùåé ïðîöåäóðå
      if(start > (finish - 100)) {
        loginstxt <- logins[start:finish]
        loginsList <- paste0(paste0("\"",loginstxt,"\""), collapse = ",")
        answer <- POST("https://api.direct.yandex.ru/v4/json/", body = paste0("{\"method\": \"GetCampaignsList\"",ifelse(is.null(logins),"",paste0(",\"param\": [",loginsList,"]")),", \"locale\": \"ru\", \"token\": \"",token,"\"}"))
        #Send POST request
        #Îòïðàâêà POST çàïðîñà
        stop_for_status(answer)
        dataRaw <- content(answer, "parsed", "application/json")
        for (i in 1:length(dataRaw$data)){
          dataRaw$data[[i]][sapply(dataRaw$data[[i]], is.null)] <- NA
          dataTemp <- data.frame(t(as.data.frame(unlist(dataRaw$data[[i]],recursive = T))),row.names = NULL)
          data <- rbind(data, dataTemp)
        }
      }
    }
    return(data)
  }
}

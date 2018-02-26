yadirGetCampaignListOld <-
function (logins = NULL, token = NULL) {
  #Create result data frame
  #Г‘Г®Г§Г¤Г ВёГ¬ Г¤Г ГІГ  ГґГ°ГҐГ©Г¬
  data <- data.frame()
  
  #Check login number, if less 100 send simply query
  #ГЏГ°Г®ГўГҐГ°ГїГҐГ¬ ГЄГ®Г«ГЁГ·ГҐГ±ГІГўГ® Г«Г®ГЈГЁГ­Г®Гў, ГҐГ±Г«ГЁ Г¬ГҐГ­ГҐГҐ 100 ГІГ® Г§Г ГЇГіГ±ГЄГ ГҐГ¬ ГіГЇГ°Г®Г№ВёГ­Г­ГіГѕ ГЇГ°Г®Г¶ГҐГ¤ГіГ°Гі
  if(length(logins) < 101){
    #Create login list in string
    #Г‘Г®Г§Г¤Г ВёГ¬ Г±ГЇГЁГ±Г®ГЄ Г«Г®ГЈГЁГ­Г®Гў Гў ГўГЁГ¤ГҐ Г±ГІГ°Г®ГЄГЁ
    loginsList <- paste0(paste0("\"",logins,"\""), collapse = ",")
    answer <- POST("https://api.direct.yandex.ru/v4/json/", body = paste0("{\"method\": \"GetCampaignsList\"",ifelse(is.null(logins),"",paste0(",\"param\": [",loginsList,"]")),", \"locale\": \"ru\", \"token\": \"",token,"\"}"))
    #Send POST request
    #ГЋГІГЇГ°Г ГўГЄГ  POST Г§Г ГЇГ°Г®Г±Г 
    stop_for_status(answer)
    dataRaw <- content(answer, "parsed", "application/json")
    #Create result data frame
    #ГЌГ ГЇГ®Г«Г­ГїГҐГ¬ Г°ГҐГ§ГіГ«ГјГІГЁГ°ГіГѕГ№ГЁГ© Г¤Г ГІГ  ГґГ°ГҐГ©Г¬
    data <- data.frame()
    for (i in 1:length(dataRaw$data)){
      dataRaw$data[[i]][sapply(dataRaw$data[[i]], is.null)] <- NA
      dataTemp <- data.frame(t(as.data.frame(unlist(dataRaw$data[[i]],recursive = T))),row.names = NULL)
      data <- rbind(data, dataTemp)
    }
    
    return(data)
    
  } else {
    
    #If logins more than 100 run cicle by 100 logins
    #Г‚ Г±Г«ГіГ·Г ГҐ ГҐГ±Г«ГЁ ГўГўГҐГ¤ГҐГ­Г® ГЎГ®Г«ГҐГҐ 100 Г«Г®ГЈГЁГ­Г®Гў Г­ГҐГ®ГµГ®Г¤ГЁГ¬Г® Г®ГЎГ®Г©ГІГЁ Г®ГЈГ°Г Г­ГЁГ·ГҐГ­ГЁГҐ API ГЁ Г®ГІГЇГ°Г ГўГ«ГїГІГј Г§Г ГЇГ°Г®Г±Г» Г®ГІГ¤ГҐГ«ГјГ­Г® ГЇГ® 100 Г«Г®ГЈГЁГ­Г®Гў
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
      #ГЋГІГЇГ°Г ГўГ«ГїГҐГ¬ POST Г§Г ГЇГ°Г®Г±
      stop_for_status(answer)
      
      dataRaw <- content(answer, "parsed", "application/json")
      for (i in 1:length(dataRaw$data)){
        dataRaw$data[[i]][sapply(dataRaw$data[[i]], is.null)] <- NA
        dataTemp <- data.frame(t(as.data.frame(unlist(dataRaw$data[[i]],recursive = T))),row.names = NULL)
        data <- rbind(data, dataTemp)
      }
      #Step on next 100 logins
      #ГЏГҐГ°ГҐГµГ®Г¤ГЁГ¬ Г­Г  Г±Г«ГҐГ¤ГіГѕГ№ГЁГҐ 100 Г«Г®ГЈГЁГ­Г®Гў
      start <- start + step + 1
      #If this last part of logins do this
      #Г…Г±Г«ГЁ ГЅГІГ® ГЇГ®Г±Г«ГҐГ¤Г­ГїГї ГЇГ Г°ГІГЁГї Г«Г®ГЈГЁГ­Г®Гў ГІГ® ГЇГҐГ°ГҐГµГ®Г¤ГЁГ¬ ГЄ Г±Г«ГҐГ¤ГіГѕГ№ГҐГ© ГЇГ°Г®Г¶ГҐГ¤ГіГ°ГҐ
      if(start > (finish - 100)) {
        loginstxt <- logins[start:finish]
        loginsList <- paste0(paste0("\"",loginstxt,"\""), collapse = ",")
        answer <- POST("https://api.direct.yandex.ru/v4/json/", body = paste0("{\"method\": \"GetCampaignsList\"",ifelse(is.null(logins),"",paste0(",\"param\": [",loginsList,"]")),", \"locale\": \"ru\", \"token\": \"",token,"\"}"))
        #Send POST request
        #ГЋГІГЇГ°Г ГўГЄГ  POST Г§Г ГЇГ°Г®Г±Г 
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

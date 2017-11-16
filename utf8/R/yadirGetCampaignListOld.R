yadirGetCampaignListOld <-
function (logins = NULL, token = NULL) {
  #Create result data frame
  #Создаём дата фрейм
  data <- data.frame()
  
  #Check login number, if less 100 send simply query
  #Проверяем количество логинов, если менее 100 то запускаем упрощённу процедуру
  if(length(logins) < 101){
    #Create login list in string
    #Создаём список логинов в виде строки
    loginsList <- paste0(paste0("\"",logins,"\""), collapse = ",")
    answer <- POST("https://api.direct.yandex.ru/v4/json/", body = paste0("{\"method\": \"GetCampaignsList\"",ifelse(is.null(logins),"",paste0(",\"param\": [",loginsList,"]")),", \"locale\": \"ru\", \"token\": \"",token,"\"}"))
    #Send POST request
    #Отправка POST запроса
    stop_for_status(answer)
    dataRaw <- content(answer, "parsed", "application/json")
    #Create result data frame
    #Наполняем результирующий дата фрейм
    data <- data.frame()
    for (i in 1:length(dataRaw$data)){
      dataRaw$data[[i]][sapply(dataRaw$data[[i]], is.null)] <- NA
      dataTemp <- data.frame(t(as.data.frame(unlist(dataRaw$data[[i]],recursive = T))),row.names = NULL)
      data <- rbind(data, dataTemp)
    }
    
    return(data)
    
  } else {
    
    #If logins more than 100 run cicle by 100 logins
    #В случае если введено более 100 логинов неоходимо обойти ограничение API и отправлять запросы отдельно по 100 логинов
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
      #Отправляем POST запрос
      stop_for_status(answer)
      
      dataRaw <- content(answer, "parsed", "application/json")
      for (i in 1:length(dataRaw$data)){
        dataRaw$data[[i]][sapply(dataRaw$data[[i]], is.null)] <- NA
        dataTemp <- data.frame(t(as.data.frame(unlist(dataRaw$data[[i]],recursive = T))),row.names = NULL)
        data <- rbind(data, dataTemp)
      }
      #Step on next 100 logins
      #Переходим на следующие 100 логинов
      start <- start + step + 1
      #If this last part of logins do this
      #Если это последняя партия логинов то переходим к следующей процедуре
      if(start > (finish - 100)) {
        loginstxt <- logins[start:finish]
        loginsList <- paste0(paste0("\"",loginstxt,"\""), collapse = ",")
        answer <- POST("https://api.direct.yandex.ru/v4/json/", body = paste0("{\"method\": \"GetCampaignsList\"",ifelse(is.null(logins),"",paste0(",\"param\": [",loginsList,"]")),", \"locale\": \"ru\", \"token\": \"",token,"\"}"))
        #Send POST request
        #Отправка POST запроса
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

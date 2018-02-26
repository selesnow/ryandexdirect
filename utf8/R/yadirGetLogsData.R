yadirGetLogsData <- 
function(counter = NULL, date_from = Sys.Date() - 10, date_to = Sys.Date(), fields = NULL, source = "visits", token = NULL){
  fun_start <- Sys.time()
  #РћС‚РїСЂР°РІРёС‚СЊ Р·Р°РїСЂРѕСЃ
  fields <- gsub("[\\s\\n\\t]","",fields,perl = TRUE) 
  logapi <- POST(paste0("https://api-metrika.yandex.ru/management/v1/counter/",counter,"/logrequests?date1=",date_from,"&date2=",date_to,"&fields=",fields,"&source=",source,"&oauth_token=",token))
  queryparam <- content(logapi, "parsed", "application/json")
  
  #РџСЂРѕРІРµСЂРєР° РЅР° РѕС€РёР±РєРё, РµСЃР»Рё Р·Р°РїСЂРѕСЃ РІРµСЂРЅСѓР» РѕС€РёР±РєСѓ РѕСЃС‚Р°РЅР°РІР»РёРІР°РµРј СЂР°Р±РѕС‚Сѓ С„СѓРЅРєС†РёРё Рё РІС‹РІРѕРґРёРј СЃРѕРѕР±С‰РµРЅРёРµ
  if(!is.null(queryparam$errors)){
    stop(paste0(queryparam$errors[[1]][[1]]," - ",queryparam$errors[[1]][[2]], ", error code - ", queryparam$code))
  }
  
  #РЎРѕС…СЂР°РЅСЏРµРј id Р·Р°РїСЂРѕСЃР° Рё РµРіРѕ СЃС‚Р°С‚СѓСЃ РІ РїРµСЂРµРјРµРЅРЅСѓСЋ
  request_id <- queryparam$log_request$request_id
  request_status <- queryparam$log_request$status
  
  #Р—Р°РїСѓСЃРєР°РµРј СЃС‡С‘С‚С‡РёРє РІСЂРµРјРµРЅРё
  start_time <- Sys.time()
  
  #РћСЃС‚Р°РЅРѕРІРєР° СЃРёСЃС‚РµРјС‹ РЅР° 7 СЃРµРєСѓРЅРґ РґР»СЏ РѕР¶РёРґР°РЅРёСЏ РѕР±СЂР°Р±РѕС‚РєРё Р·Р°РїСЂРѕСЃР°
  Sys.sleep(7)
  
  #Р’С‹РІРѕРґРёРј СЃРѕРѕР±С‰РµРЅРёРµ Рѕ С‚РѕРј С‡С‚Рѕ РЅР°С‡Р°С‚ РїСЂРѕС†РµСЃСЃРёРЅРі
  packageStartupMessage("Processing ", appendLF = FALSE)
  
  #РџСЂРѕРІРµСЂРєР° СЃС‚Р°С‚СѓСЃР° Р·Р°РїСЂРѕСЃР°
  while(request_status != "processed"){
    logapistatus <- GET(paste0("https://api-metrika.yandex.ru/management/v1/counter/",counter,"/logrequest/",request_id,"?oauth_token=",token))
    request_status <- content(logapistatus, "parsed", "application/json")$log_request$status
    
    #Р’С‹РІРѕРґРёРј СЃРѕРѕР±С‰РµРЅРёРµ СЃ РёРЅС„РѕСЂРјР°С†РёРµР№ Рѕ СЃС‚Р°С‚СѓСЃРµ Р·Р°РїСЂРѕСЃР° Рё РІСЂРµРјРµРЅРё РІС‹РїРѕР»РЅРµРЅРёСЏ Р·Р°РїСЂРѕСЃР°
    #message(paste0("Query status: ", request_status," Query time: ", Sys.time() - start_time))
    packageStartupMessage(".", appendLF = FALSE)
    
    #РџРѕР»СѓС‡Р°РµРј Рє-РІРѕ С‡Р°СЃС‚РµР№ Р·Р°РїСЂРѕСЃР°
    partsnun <- length(content(logapistatus, "parsed", "application/json")$log_request$parts)
    
    #Р•СЃР»Рё Р»РѕРі РіРѕС‚РѕРІ Р·Р°Р±РёСЂР°РµРј РµРіРѕ РѕС‚РґРµР»СЊРЅРѕ РїРѕ С‡Р°СЃС‚СЏРј
    if(request_status == "processed"){
      #Р’С‹РІРѕРґРёРј СЃРѕРѕР±С‰РµРЅРёРµ Рѕ С‚РѕРј С‡С‚Рѕ РїСЂРѕС†РµСЃСЃРёРЅРі Р·Р°РІРµСЂС€РµРЅ
      packageStartupMessage(paste0(" processing time ",round(Sys.time() - start_time,2)," sec"), appendLF = TRUE)
      
      #РЎРѕР·РґР°С‘Рј РґР°С‚Р° С„СЂРµР№Рј РґР»СЏ Р·Р°РіСЂСѓР·РєРё РґР°РЅРЅС‹С…
      result <- data.frame()
      
      #Р’С‹РІРѕРґРёРј СЃРѕРѕР±С‰РµРЅРёРµ Рѕ С‚РѕРј С‡С‚Рѕ РЅР°С‡Р°С‚Р° Р·Р°РіСЂСѓР·РєР° РґР°РЅРЅС‹С…
      packageStartupMessage("Loading ", appendLF = FALSE)
      start_load_time <- Sys.time()
      for(parts in 0:partsnun-1){
        packageStartupMessage(".", appendLF = FALSE)
        #РџРѕР»СѓС‡РёС‚СЊ РґР°РЅРЅС‹Рµ
        logapidata <- GET(paste0("https://api-metrika.yandex.ru/management/v1/counter/",counter,"/logrequest/",request_id,"/part/",parts,"/download?oauth_token=",token))
        rawdata <- try(content(logapidata,"text","application/json",encoding = "UTF-8"), silent = T)
        df_temp <- try(read.delim(text=rawdata), silent = T)
        result <- rbind(result, df_temp)
      }
      #Р’РѕР·РІСЂР°С‰Р°РµРј РёС‚РѕРіРѕРІС‹Р№ СЂРµР·СѓР»СЊС‚Р°С‚
      packageStartupMessage(paste0(" done! ", "loading time ",round(Sys.time() - start_load_time,2)," sec"))
      
      #РЈРґР°Р»СЏРµРј Р·Р°РїСЂРѕСЃ СЃ СЃРµСЂРІРµСЂР°
      req_delite <- POST(paste0("https://api-metrika.yandex.ru/management/v1/counter/",counter,"/logrequest/",request_id,"/clean?oauth_token=",token))
      req_delite <- content(req_delite, "parsed", "application/json")
      #Р’С‹РІРѕРґРёРј РѕР±С‰СѓСЋ РёРЅС„РѕСЂРјР°С†РёСЋ Рѕ СЂР°Р±РѕС‚Рµ С„СѓРЅРєС†РёРё
      packageStartupMessage("Information: ")
      packageStartupMessage(paste0("Request id: ", request_id))
      packageStartupMessage(paste0("Request status: ", req_delite$log_request$status))
      packageStartupMessage(paste0("Total time: ", round(Sys.time() - fun_start,2)," sec"))
      packageStartupMessage(paste0("Data size: ",round(req_delite$log_request$size * 1e-6,2), " Mb"))
      packageStartupMessage(paste0("Return rows: ",nrow(result)))                   
      if(exists("result")){
      packageStartupMessage("Data load successful!")
      }
      return(result)
    }
    
    #Р•СЃР»Рё РїРѕСЏРІРёР»Р°СЃСЊ РѕС€РёР±РєР° РїСЂРё РѕР±СЂР°Р±РѕС‚РєРµ РѕСЃС‚Р°РЅР°РІР»РёРІР°РµРј С„СѓРЅРєС†РёСЋ
    if(request_status == "processing_failed"){
      stop("РћС€РёР±РєР° РїСЂРё РѕР±СЂР°Р±РѕС‚РєРµ Р·Р°РїСЂРѕСЃР°")
    }
    
    #Р•СЃР»Рё РѕС‚РјРµРЅС‘РЅ
    if(request_status == "canceled"){
      stop("Р—Р°РїСЂРѕСЃ Р±С‹Р» РѕС‚РјРµРЅС‘РЅ")
    }
    
    #Р•СЃР»Рё РѕС‚РјРµРЅС‘РЅ
    if(request_status == "cleaned_by_user"|request_status == "cleaned_automatically_as_too_old"){
      stop("Р—Р°РїСЂРѕСЃ Р±С‹Р» СѓРґР°Р»С‘РЅ СЃ СЃРµСЂРІРµСЂР°")
    }
    
    #5 СЃРµРєСѓРЅРґ РѕР¶РёРґР°РЅРёСЏ РїРµСЂРµРґ РїРѕРІС‚РѕСЂРЅРѕР№ РѕС‚РїСЂР°РІРєРѕР№
    Sys.sleep(5)
  }
}

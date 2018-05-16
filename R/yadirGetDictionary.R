yadirGetDictionary <- function(DictionaryName = "GeoRegions", 
                               Language = "ru", 
                               Login         = NULL,
                               Token         = NULL,
                               AgencyAccount = NULL,
                               TokenPath     = getwd()){
  #ГЏГ°Г®ГўГҐГ°ГЄГ  Г­Г Г«ГЁГ·ГЁГї Г«Г®ГЈГЁГ­Г  ГЁ ГІГ®ГЄГҐГ­Г 

  #Авторизация
  Token <- tech_auth(login = Login, token = Token, AgencyAccount = AgencyAccount, TokenPath = TokenPath)
  
  #ГЏГ°Г®ГўГҐГ°ГЄГ  ГўГҐГ°Г­Г® Г«ГЁ ГіГЄГ Г§Г Г­Г® Г­Г Г§ГўГ Г­ГЁГҐ Г±ГЇГ°Г ГўГ®Г·Г­ГЁГЄГ 
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

#check stringAsFactor
factor_change <- FALSE

#change string is factor if TRUE
if(getOption("stringsAsFactors")){
  options(stringsAsFactors = F)
  factor_change <- TRUE
}
  
  queryBody <- paste0("{
                      \"method\": \"get\",
                      \"params\": {
                      \"DictionaryNames\": [ \"",DictionaryName,"\" ]
}
}")
  
  #ГЋГІГЇГ°Г ГўГЄГ  Г§Г ГЇГ°Г®Г±Г  Г­Г  Г±ГҐГ°ГўГҐГ°
  answer <- POST("https://api.direct.yandex.com/json/v5/dictionaries", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = Language, "Client-Login" = Login[1]))
  #ГЏГ°Г®ГўГҐГ°ГЄГ  Г°ГҐГ§ГіГ«ГјГІГ ГІГ  Г­Г  Г®ГёГЁГЎГЄГЁ
  stop_for_status(answer)
  
  dataRaw <- content(answer, "parsed", "application/json")
  
  if(length(dataRaw$error) > 0){
    stop(paste0(dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
  }
  
  #ГЏГ°ГҐГ®ГЎГ°Г Г§ГіГҐГ¬ Г®ГІГўГҐГІ Гў data frame
  
  #ГЏГ Г°Г±ГЁГ­ГЈ Г±ГЇГ°Г ГўГ®Г·Г­ГЁГЄГ  Г°ГҐГЈГЁГ®Г­Г®Гў
  if(DictionaryName == "GeoRegions"){
  dictionary_df <- data.frame()

  for(dr in 1:length(dataRaw$result[[1]])){
    dictionary_df_temp <- data.frame(GeoRegionId = dataRaw$result[[1]][[dr]]$GeoRegionId,
                                     ParentId = ifelse(is.null(dataRaw$result[[1]][[dr]]$ParentId),NA , dataRaw$result[[1]][[dr]]$ParentId),
                                     GeoRegionType = dataRaw$result[[1]][[dr]]$GeoRegionType,
                                     GeoRegionName = dataRaw$result[[1]][[dr]]$GeoRegionName)
    dictionary_df <- rbind(dictionary_df, dictionary_df_temp)
    
  }}

  #ГЏГ Г°Г±ГЁГ­ГЈ Г±ГЇГ°Г ГўГ®Г·Г­ГЁГЄГ  ГўГ Г«ГѕГІ
  if(DictionaryName == "Currencies"){
    dictionary_df <- data.frame()
  for(dr in 1:length(dataRaw$result[[1]])){
    dictionary_df_temp <- data.frame(Cur = dataRaw$result[[1]][[dr]]$Currency, as.data.frame(do.call(rbind.data.frame, dataRaw$result[[1]][[dr]]$Properties), row.names = NULL, stringsAsFactors = F))
    dictionary_df <- rbind(dictionary_df, dictionary_df_temp)
  }
    dictionary_df_cur <- data.frame()
    #ГЏГ°ГҐГ®ГЎГ°Г Г§ГіГҐГ¬ Г±ГЇГ°Г ГўГ®Г·Г­ГЁГЄ ГўГ Г«ГѕГІ
    for(curlist in unique(dictionary_df$Cur)){
      dictionary_df_temp <- data.frame(Cur = curlist,
                                       FullName = dictionary_df[dictionary_df$Cur == curlist & dictionary_df$Name == "FullName",3],
                                       Rate = dictionary_df[dictionary_df$Cur == curlist & dictionary_df$Name == "Rate",3],
                                       RateWithVAT = dictionary_df[dictionary_df$Cur == curlist & dictionary_df$Name == "RateWithVAT",3])
      dictionary_df_cur <- rbind(dictionary_df_cur,dictionary_df_temp)
    }
    dictionary_df <- dictionary_df_cur
  }
  
  #ГЏГ Г°Г±ГЁГ­ГЈ Г±ГЇГ°Г ГўГ®Г·Г­ГЁГЄГ  Interests
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
  
  #ГЏГ Г°Г±ГЁГ­ГЈ Г®Г±ГІГ Г«ГјГ­Г»Гµ Г±ГЇГ°Г ГўГ®Г·Г­ГЁГЄГ®Гў Г±Г® Г±ГІГ Г­Г¤Г Г°ГІГ­Г®Г© Г±ГІГ°ГіГЄГІГіГ°Г®Г©
  if(! DictionaryName %in% c("Currencies","GeoRegions","Interests")){
    dictionary_df <- do.call(rbind.data.frame, dataRaw$result[[1]])
    }
  
  #back string as factor value
  if(factor_change){
  options(stringsAsFactors = T)
  }
  #Г‚Г»ГўГ®Г¤ГЁГ¬ ГЁГ­ГґГ®Г°Г¬Г Г¶ГЁГѕ Г® Г°Г ГЎГ®ГІГҐ Г§Г ГЇГ°Г®Г±Г  ГЁ Г® ГЄГ®Г«ГЁГ·ГҐГ±ГІГўГҐ ГЎГ Г«Г«Г®Гў
   packageStartupMessage("Справочник успешно загружен!", appendLF = T)
   packageStartupMessage(paste0("Баллы списаны с : " ,answer$headers$`units-used-login`), appendLF = T)
   packageStartupMessage(paste0("К-во баллов израсходованых при выполнении запроса: " ,strsplit(answer$headers$units, "/")[[1]][1]), appendLF = T)
   packageStartupMessage(paste0("Доступный остаток суточного лимита баллов: " ,strsplit(answer$headers$units, "/")[[1]][2]), appendLF = T)
   packageStartupMessage(paste0("Суточный лимит баллов: " ,strsplit(answer$headers$units, "/")[[1]][3]), appendLF = T)
   packageStartupMessage(paste0("Уникальный идентификатор запроса который необходимо указывать при обращении в службу поддержки: ",answer$headers$requestid), appendLF = T)
  
  #Г‚Г®Г§ГўГ°Г Г№Г ГҐГ¬ Г°ГҐГ§ГіГ«ГјГІГ ГІ Гў ГўГЁГ¤ГҐ Data Frame
  return(dictionary_df)
}


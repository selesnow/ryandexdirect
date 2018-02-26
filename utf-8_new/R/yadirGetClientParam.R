yadirGetClientParam <- function(Language = "ru", login = NULL, token = NULL){
  #ГЏГ°Г®ГўГҐГ°ГЄГ  Г­Г Г«ГЁГ·ГЁГї Г«Г®ГЈГЁГ­Г  ГЁ ГІГ®ГЄГҐГ­Г 
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
  
  #ГЋГІГЇГ°Г ГўГЄГ  Г§Г ГЇГ°Г®Г±Г  Г­Г  Г±ГҐГ°ГўГҐГ°
  answer <- POST("https://api.direct.yandex.com/json/v5/clients", body = queryBody, add_headers(Authorization = paste0("Bearer ",token), 'Accept-Language' = Language, "Client-Login" = login[1]))
  #ГЏГ°Г®ГўГҐГ°ГЄГ  Г°ГҐГ§ГіГ«ГјГІГ ГІГ  Г­Г  Г®ГёГЁГЎГЄГЁ
  stop_for_status(answer)
  
  dataRaw <- content(answer, "parsed", "application/json")
  
  if(length(dataRaw$error) > 0){
    stop(paste0(dataRaw$error$error_string, " - ", dataRaw$error$error_detail))
  }
  
  #ГЏГ°ГҐГ®ГЎГ°Г Г§ГіГҐГ¬ Г®ГІГўГҐГІ Гў data frame
  
  #ГЏГ Г°Г±ГЁГ­ГЈ Г±ГЇГ°Г ГўГ®Г·Г­ГЁГЄГ  Г°ГҐГЈГЁГ®Г­Г®Гў
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

    #Г‚Г»ГўГ®Г¤ГЁГ¬ ГЁГ­ГґГ®Г°Г¬Г Г¶ГЁГѕ Г® Г°Г ГЎГ®ГІГҐ Г§Г ГЇГ°Г®Г±Г  ГЁ Г® ГЄГ®Г«ГЁГ·ГҐГ±ГІГўГҐ ГЎГ Г«Г«Г®Гў
     #packageStartupMessage("Г‘ГЇГ°Г ГўГ®Г·Г­ГЁГЄ ГіГ±ГЇГҐГёГ­Г® Г§Г ГЈГ°ГіГ¦ГҐГ­!", appendLF = T)
     #packageStartupMessage(paste0("ГЃГ»Г«Г«Г» Г±ГЇГЁГ±Г Г­Г» Г± : " ,answer$headers$`units-used-login`), appendLF = T)
     #packageStartupMessage(paste0("ГЉ-ГўГ® ГЎГ Г«Г«Г®Гў ГЁГ§Г°Г Г±ГµГ®Г¤Г®ГўГ Г­Г»Гµ ГЇГ°ГЁ ГўГ»ГЇГ®Г«Г­ГҐГ­ГЁГЁ Г§Г ГЇГ°Г®Г±Г : " ,strsplit(answer$headers$units, "/")[[1]][1]), appendLF = T)
     #packageStartupMessage(paste0("Г„Г®Г±ГІГіГЇГ­Г»Г© Г®Г±ГІГ ГІГ®ГЄ Г±ГіГІГ®Г·Г­Г®ГЈГ® Г«ГЁГ¬ГЁГІГ  ГЎГ Г«Г«Г®Гў: " ,strsplit(answer$headers$units, "/")[[1]][2]), appendLF = T)
     #packageStartupMessage(paste0("Г‘ГіГІГ®Г·Г­Г»Г© Г«ГЁГ¬ГЁГІ ГЎГ Г«Г«Г®Гў: " ,strsplit(answer$headers$units, "/")[[1]][3]), appendLF = T)
     #packageStartupMessage(paste0("Г“Г­ГЁГЄГ Г«ГјГ­Г»Г© ГЁГ¤ГҐГ­ГІГЁГґГЁГЄГ ГІГ®Г° Г§Г ГЇГ°Г®Г±Г  ГЄГ®ГІГ®Г°Г»Г© Г­ГҐГ®ГЎГµГ®Г¤ГЁГ¬Г® ГіГЄГ Г§Г»ГўГ ГІГј ГЇГ°ГЁ Г®ГЎГ°Г Г№ГҐГ­ГЁГЁ Гў Г±Г«ГіГ¦ГЎГі ГЇГ®Г¤Г¤ГҐГ°Г¦ГЄГЁ: ",answer$headers$requestid), appendLF = T)
    #Г‚Г®Г§ГўГ°Г Г№Г ГҐГ¬ Г°ГҐГ§ГіГ«ГјГІГ ГІ Гў ГўГЁГ¤ГҐ Data Frame
  return(dictionary_df)
}

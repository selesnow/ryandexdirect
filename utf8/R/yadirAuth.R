yadirAuth <- function(Login = NULL, NewUser = FALSE, TokenPath = getwd()) {
  
  # РїСЂРѕРІРµСЂСЏРµРј С…СЂР°РЅРёР»РёС‰Рµ
  
  if (!dir.exists(TokenPath)) {
    dir.create(TokenPath)
  }
    
  # РґР»СЏ СЃРѕС…СЂР°РЅРµРЅРёСЏ С‚РѕРєРЅР°
  
  if (NewUser == FALSE && file.exists(paste0(paste0(TokenPath, "/", Login, ".yadirAuth.RData")))) {
    message("Load token from ", paste0(paste0(TokenPath, "/", Login, ".yadirAuth.RData")))
    load(paste0(TokenPath, "/", Login, ".yadirAuth.RData"))
    # РїСЂРѕРІРµСЂСЏРµРј РєРѕРіРґР° РёСЃС‚РµРєР°РµС‚ С‚РѕРєРµРЅ  
    if (as.numeric(token$expire_at - Sys.time(), units = "days") < 30) {
      message("Auto refresh token")
      token_raw  <- httr::POST("https://oauth.yandex.ru/token", body = list(grant_type="refresh_token", 
                                                                            refresh_token = token$refresh_token,
                                                                            client_id = "365a2d0a675c462d90ac145d4f5948cc",
                                                                            client_secret = "f2074f4c312449fab9681942edaa5360"), encode = "form")
      # РїСЂРѕРІРµСЂСЏРµ РЅР° РѕС€РёР±РєРё
      if (!is.null(token$error_description)) {
        stop(paste0(token$error, ": ", token$error_description))
      }
      # РїР°СЂСЃРёРј С‚РѕРєРµРЅ
      new_token <- content(token_raw)
      # РґРѕР±Р°РІР»СЏРµРј РёРЅС„РѕСЂРјР°С†РёСЋ Рѕ С‚РѕРј РєРѕРіРґР° РѕРЅ РёСЃС‚РµРєР°РµС‚
      new_token$expire_at <- Sys.time() + as.numeric(token$expires_in, units = "secs")
      
      # СЃРѕС…СЂР°РЅСЏРµРј С‚РѕРєРµРЅ РІ С„Р°Р№Р»
      save(new_token, file = paste0(TokenPath, "/", Login, ".yadirAuth.RData"))
      message("Token saved in file ", paste0(TokenPath, "/", Login, ".yadirAuth.RData"))
      
      return(new_token)
    } else {
      message("Token expire in ", round(as.numeric(token$expire_at - Sys.time(), units = "days"), 0), " days")
      
      return(token)
  }
}
  # РµСЃР»Рё С‚РѕРєРµРЅ РЅРµ РЅР°Р№РґРµРЅ РІ С„Р°Р№Р»Рµ С‚Рѕ РїРѕР»СѓС‡Р°РµРј РєРѕРґ Рё РїСЂРѕС…РѕРґРёРј РІСЃСЋ РїСЂРѕС†РµРґСѓСЂСѓ
  browseURL(paste0("https://oauth.yandex.ru/authorize?response_type=code&client_id=365a2d0a675c462d90ac145d4f5948cc&redirect_uri=https://selesnow.github.io/ryandexdirect/getToken/get_code.html&force_confirm=", as.integer(NewUser), ifelse(is.null(Login), "", paste0("&login_hint=", Login))))
  # Р·Р°РїСЂР°С€РёРІР°РµРј РєРѕРґ
  temp_code <- readline(prompt = "Enter authorize code:")
  
  # РїСЂРѕРІРµСЂРєР° РІРІРµРґС‘РЅРЅРѕРіРѕ РєРѕРґР°
  while(nchar(temp_code) != 7) {
    message("РџСЂРѕРІРµСЂРѕС‡РЅС‹Р№ РєРѕРґ РІРІРµРґС‘РЅРЅС‹Р№ РІР°РјРё РЅРµ СЏРІР»СЏРµС‚СЃСЏ 7-Р·РЅР°С‡РЅС‹Рј, РїРѕСЃС‚РѕСЂРёС‚Рµ РїРѕРїС‹С‚РєСѓ РІРІРѕРґР° РєРѕРґР°.")
    temp_code <- readline(prompt = "Enter authorize code:")
  }
  
  token_raw <- httr::POST("https://oauth.yandex.ru/token", body = list(grant_type="authorization_code", 
                                                                       code = temp_code, 
                                                                       client_id = "365a2d0a675c462d90ac145d4f5948cc", 
                                                                       client_secret = "f2074f4c312449fab9681942edaa5360"), encode = "form")
  # РїР°СЂСЃРёРј С‚РѕРєРµРЅ
  token <- content(token_raw)
  token$expire_at <- Sys.time() + as.numeric(token$expires_in, units = "secs")
  # РїСЂРѕРІРµСЂСЏРµ РЅР° РѕС€РёР±РєРё
  if (!is.null(token$error_description)) {
    stop(paste0(token$error, ": ", token$error_description))
  }
  # СЃРѕС…СЂР°РЅСЏРµРј С‚РѕРєРµРЅ РІ С„Р°Р№Р»
  save(token, file = paste0(TokenPath, "/", Login, ".yadirAuth.RData"))
  message("Token saved in file ", paste0(TokenPath, "/", Login, ".yadirAuth.RData"))
  
  return(token)
}

# С‚РµС… С„СѓРЅРєС†РёСЏ РґР»СЏ Р°РІС‚РѕСЂРёР·Р°С†РёРё РІ РґСЂСѓРіРёС… С„СѓРЅРєС†РёСЏС…
tech_auth <-  function(login = NULL, token = NULL, AgencyAccount = NULL, TokenPath = NULL) {

  # Р•СЃРё Р·Р°РґР°РЅ С‚РѕРєРµРЅ С‚Рѕ РїСЂРѕРїСѓСЃРєР°РµРј РїСЂРѕРІРµСЂРєСѓ
  if (! is.null(token) ) {
    # РћРїСЂРµРґРµР»СЏРµРј РєР»Р°СЃСЃ РѕР±СЉРµРєС‚Р° СЃРѕРґРµСЂР¶Р°С‰РµРіРѕ С‚РѕРєРµРЅ
    if(class(token) == "list") {
      Token <- token$access_token 
    } else {
      Token <- token
    }
  # Р•СЃР»Рё С‚РѕРєРµРЅ РЅРµ Р·Р°РґР°РЅ С‚Рѕ РЅРµРѕР±С…РѕРґРёРјРѕ РµРіРѕ РїРѕР»СѓС‡РёС‚СЊ
  } else {
    # РѕРїСЂРµРґРµР»СЏРµРј С‚РёРї Р°РєРєР°СѓРЅС‚Р°, Р°РіРµРЅС‚СЃРєРёР№ РёР»Рё РєР»РёРµРЅС‚СЃРєРёР№
    load_login <- ifelse(is.null(AgencyAccount) | is.na(AgencyAccount), login, AgencyAccount)
    # Р·Р°РіСЂСѓР¶Р°РµРј С‚РѕРєРµРЅ
    Token <- yadirAuth(Login = load_login, TokenPath = TokenPath, NewUser = FALSE)$access_token
  }
  
  # РІРѕР·РІСЂР°Р·Р°РµРј С‚РѕРєРµРЅ
  return(Token)
}

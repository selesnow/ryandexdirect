yadirAuth <- function(Login = NULL, NewUser = FALSE, TokenPath = getwd()) {
  
  # check dir
  
  if (!dir.exists(TokenPath)) {
    dir.create(TokenPath)
  }
  
  # find file with auth data
  
  if (NewUser == FALSE && file.exists(paste0(paste0(TokenPath, "/", Login, ".yadirAuth.RData")))) {
    message("Load token from ", paste0(paste0(TokenPath, "/", Login, ".yadirAuth.RData")))
    load(paste0(TokenPath, "/", Login, ".yadirAuth.RData"))
    # check token expire  
    if (as.numeric(token$expire_at - Sys.time(), units = "days") < 30) {
      message("Auto refresh token")
      token_raw  <- httr::POST("https://oauth.yandex.ru/token", body = list(grant_type="refresh_token", 
                                                                            refresh_token = token$refresh_token,
                                                                            client_id = "365a2d0a675c462d90ac145d4f5948cc",
                                                                            client_secret = "f2074f4c312449fab9681942edaa5360"), encode = "form")
      # check for error
      if (!is.null(token$error_description)) {
        stop(paste0(token$error, ": ", token$error_description))
      }
      # get token
      token <- content(token_raw)
      # add expire time
      token$expire_at <- Sys.time() + as.numeric(token$expires_in, units = "secs")
      
      # update auth file
      save(token, file = paste0(TokenPath, "/", Login, ".yadirAuth.RData"))
      message("Token saved in file ", paste0(TokenPath, "/", Login, ".yadirAuth.RData"))
      
      return(token)
    } else {
      message("Token expire in ", round(as.numeric(token$expire_at - Sys.time(), units = "days"), 0), " days")
      
      return(token)
    }
  }
  
  # check session mode
  if ( ! interactive() ) {
    stop(paste0("Function yadirAuth does not find the ", Login, ".yadirAuth.RData file in ",TokenPath,". You must run this script in interactive mode in RStudio or RGui and go through the authorization process for create ", Login,".yadirAuth.RData file, and using him between R session in batch mode. For more details see realise https://github.com/selesnow/ryandexdirect/releases/tag/3.0.0. For more details about R modes see https://www.r-bloggers.com/batch-processing-vs-interactive-sessions/") )
  } else {
    # if file not find
    browseURL(paste0("https://oauth.yandex.ru/authorize?response_type=code&client_id=365a2d0a675c462d90ac145d4f5948cc&redirect_uri=https://selesnow.github.io/ryandexdirect/getToken/get_code.html&force_confirm=", as.integer(NewUser), ifelse(is.null(Login), "", paste0("&login_hint=", Login))))
    # enter code
    temp_code <- readline(prompt = "Enter authorize code:")
    
    # check code simbol number
    while(nchar(temp_code) != 7) {
      message("The verification code entered by you is not 7-digit, try to enter the code again.")
      temp_code <- readline(prompt = "Enter authorize code:")
    }
  }
  
  token_raw <- httr::POST("https://oauth.yandex.ru/token", body = list(grant_type="authorization_code", 
                                                                       code = temp_code, 
                                                                       client_id = "365a2d0a675c462d90ac145d4f5948cc", 
                                                                       client_secret = "f2074f4c312449fab9681942edaa5360"), encode = "form")
  # parse token
  token <- content(token_raw)
  token$expire_at <- Sys.time() + as.numeric(token$expires_in, units = "secs")
  # check for error
  if (!is.null(token$error_description)) {
    stop(paste0(token$error, ": ", token$error_description))
  }
  
  # save token in file
  message("Do you want save API credential in local file (",paste0(TokenPath, "/", Login, ".rymAuth.RData"),"), for use it between R sessions?")
  ans <- readline("y / n (recomedation - y): ")
  
  if ( tolower(ans) %in% c("y", "yes", "ok", "save") ) {
    # save into local file
    save(token, file = paste0(TokenPath, "/", Login, ".yadirAuth.RData"))
    message("Token saved in file ", paste0(TokenPath, "/", Login, ".yadirAuth.RData"))
  }
  return(token)
}

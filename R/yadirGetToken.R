yadirGetToken <-
function(Login = NULL, TokenPath = getwd()){
  # open browser
  browseURL("https://oauth.yandex.ru/authorize?response_type=token&client_id=365a2d0a675c462d90ac145d4f5948cc")
  
  # create list
  token <- list(token_type    = "bearer",
                access_token  = readline(prompt = "Enter your token: "),
                expires_in    = 26715505,
                refresh_token = NA,
                expire_at     = Sys.time() + as.numeric(26715505, units = "secs"))
  # set class
  class(token) <- "yadir_token"
  
  # ask for save credential
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

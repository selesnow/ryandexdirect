yadirGetLogins <- function(TokenPath = yadirTokenPath(), SetLogin = TRUE) {
  
  if ( is.null(TokenPath) ) {
    TokenPath <- getwd()
  }
  
  if ( ! interactive() ) {
    
    SetLogin <- FALSE
    
  }
  
  files  <- dir(TokenPath, pattern = "\\.yadirAuth\\.RData$")
  logins <- gsub("\\.yadirAuth\\.RData$", replacement = "", files)
  
  if ( length(files) == 0 ) {
    
    message("You does't have any authorize login.")
    auth <- readline("Do you want start authorize process? ( y / n ): ")
    
    if (auth == "y") {
      
      if ( is.null(getOption("ryandexdirect.user")) ) {
        
        login <- readline("Enter your Yandex login:")
        
      } else {
        
        login <- getOption("ryandexdirect.user")
        
      }
      
      yadirAuth(Login = login, NewUser = T, TokenPath = TokenPath)
      
      return(login)
      
    } else {
      
      return(NULL)
      
    }
  }
  
  for ( i in 1:length(logins) ) {
    
    cat(i, ":\t", logins[i], "\n")
    
  }
  
  if (SetLogin) {
    
    len          <- length(logins)
    login_number <- readline(str_glue("Choose login (enter number from 1 to {len}): "))
    login        <- logins[as.integer(login_number)]
    options(ryandexdirect.user = login)
    message(str_glue("Set {login} as default session login"))
    return(login)
    
  }
  
  return(logins)
  
}

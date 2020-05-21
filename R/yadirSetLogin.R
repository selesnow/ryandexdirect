yadirSetLogin <- function(Login, TokenPath = yadirTokenPath()) {
  
  file_name   <- file.path(TokenPath, str_glue("{Login}.yadirAuth.RData"))
     
  if ( file.exists(file_name) ) {

    options(ryandexdirect.user = Login)
    
  } else if ( ! is.null(getOption('ryandexdirect.agency_account')) ) {
    
    clients <- yadirGetClientList()
    client_logins <- clients$Login
    
    # search in agency account
    if ( tolower(Login) %in% tolower(client_logins) ) {
      
      options(ryandexdirect.user = Login)
      message("AgencyAccount: ", getOption('ryandexdirect.agency_account'), "\n",
              "Login: ", Login)
      
    }
  

  } else if ( interactive() ) {
    
    yadirAuth(Login, NewUser = TRUE, TokenPath)
    
    options(ryandexdirect.user = Login)
  
  } else {
    
    stop(str_glue("Your login not found in {TokenPath}, and you using batch mode. Run R in interactive mode and repeat this action."))
    
  }

  return(TRUE)
  
}
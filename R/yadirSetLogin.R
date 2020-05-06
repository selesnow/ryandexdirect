yadirSetLogin <- function(Login, TokenPath = yadirTokenPath()) {
  
  file_name   <- file.path(TokenPath, str_glue("{Login}.yadirAuth.RData"))
     
  if ( file.exists(file_name) ) {

    options(ryandexdirect.user = Login)

  } else if ( interactive() ) {
    
    yadirAuth(Login, NewUser = TRUE, TokenPath)
    
    options(ryandexdirect.user = Login)
  
  } else {
    
    stop(str_glue("Your login not found in {TokenPath}, and you using batch mode. Run R in interactive mode and repeat this action."))
    
  }

  return(TRUE)
  
}
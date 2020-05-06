yadirSetAgencyAccount <- function(AgencyAccount, TokenPath = yadirTokenPath()) {
  
  file_name   <- file.path(TokenPath, str_glue("{AgencyAccount}.yadirAuth.RData")) 

if ( file.exists(file_name) ) {
  
  options(ryandexdirect.agency_account = AgencyAccount)
  
} else if ( interactive() ) {
  
  yadirAuth(Login = AgencyAccount, NewUser = TRUE, TokenPath)
  
  options(ryandexdirect.user = AgencyAccount)
  
} else {
  
  stop(str_glue("Your login not found in {TokenPath}, and you using batch mode. Run R in interactive mode and repeat this action."))
  
}

return(TRUE)

}
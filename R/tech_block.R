# tech block auth
tech_auth <-  function(login = NULL, token = NULL, AgencyAccount = NULL, TokenPath = NULL) {
  
  # check options
  if ( is.null(token) ) {
    ## login
    if ( is.null(login) && ! is.null(getOption("ryandexdirect.user") ) ) {
      
      login <- getOption("ryandexdirect.user")
      
    }
    
    ## agency
    if ( is.null(AgencyAccount) && ! is.null(getOption("ryandexdirect.agency_account") ) ) {
      
      AgencyAccount <- getOption("ryandexdirect.agency_account")
      
    }
    
  }

  # if token not null skip auth
  if (! is.null(token) ) {
    # detect class of token object
    if(inherits(token, "list")) {
      Token <- token$access_token 
    } else {
      Token <- token
    }
  # if token is null go auth
  } else {
    # detect of account type, agency or client
    load_login <- ifelse(is.null(AgencyAccount) || is.na(AgencyAccount), login, AgencyAccount)
    # auth
    Token <- yadirAuth(Login = load_login, TokenPath = TokenPath, NewUser = FALSE)$access_token
  }
  
  # return token obj
  return(Token)
}

yadirTokenPath <- function() {
  
  if ( ! is.null(getOption("ryandexdirect.token_path")) ) {
    
    return(getOption("ryandexdirect.token_path"))
    
  } else {
    
    return(getwd())
    
  }
  
}

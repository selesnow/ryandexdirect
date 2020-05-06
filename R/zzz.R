.onAttach <- function(lib, pkg,...){
  packageStartupMessage(ryandexdirectWelcomeMessage())
  
  if ( any( ! is.null(getOption("ryandexdirect.token_path") ),
            ! is.null(getOption("ryandexdirect.user") ),
			! is.null(getOption("ryandexdirect.agency_account") ) 
			) 
	 ) {
	 
	 packageStartupMessage("\n ..ryandexdirect Auth Presets:")
	 
	}
  
  ## token path
  if ( ! is.null(getOption("ryandexdirect.token_path") ) ) {
    packageStartupMessage("...Set ryandexdirect TokenPath: ", appendLF = F)
    packageStartupMessage(getOption("ryandexdirect.token_path"))
  } 
  
  ## username
  if ( ! is.null(getOption("ryandexdirect.user") ) ) {
    packageStartupMessage("...Set ryandexdirect Login: ", appendLF = F)
    packageStartupMessage(getOption("ryandexdirect.user"))
  } 
  
  ## agency
  if ( ! is.null(getOption("ryandexdirect.agency_account") ) ) {
    packageStartupMessage("...Set ryandexdirect AgencyAccount: ", appendLF = F)
    packageStartupMessage(getOption("ryandexdirect.agency_account"))
  } 
}

#
#

ryandexdirectWelcomeMessage <- function(){
  # library(utils)
  
  paste0("\n",
         "---------------------\n",
         "Welcome to ryandexdirect version ", utils::packageDescription("ryandexdirect")$Version, "\n",
         "\n",
         "Author:           Alexey Seleznev (Head of analytics dept at Netpeak).\n",
		 "Telegram channel: https://t.me/R4marketing \n",
         "Email:            selesnow@gmail.com\n",
         "Blog:             https://alexeyseleznev.wordpress.com \n",
         "Facebook:         https://facebook.com/selesnown \n",
         "Linkedin:         https://www.linkedin.com/in/selesnow \n",
         "\n",
         "Type ?ryandexdirect for the main documentation.\n",
         "The github page is: https://github.com/selesnow/ryandexdirect/\n",
         "\n",
         "Suggestions and bug-reports can be submitted at: https://github.com/selesnow/ryandexdirect/issues\n",
         "Or contact: <selesnow@gmail.com>\n",
         "\n",
         "\tTo suppress this message use:  ", "suppressPackageStartupMessages(library(ryandexdirect))\n",
         "---------------------\n"
  )
}

.onLoad <- function(libname, pkgname) {
  
  op <- options()
  
  op.ryandexdirect <- list(ryandexdirect.user           = Sys.getenv("RYD_USER"),
                           ryandexdirect.token_path     = Sys.getenv("RYD_TOKEN_PATH"),
						               ryandexdirect.agency_account = Sys.getenv("RYD_AGENCY"))
  
  op.ryandexdirect <- lapply(op.ryandexdirect, function(x) if ( x == "" ) return(NULL) else return(x))
  
  toset <- !(names(op.ryandexdirect) %in% names(op))
  if (any(toset)) options(op.ryandexdirect[toset])
  
  invisible()
}
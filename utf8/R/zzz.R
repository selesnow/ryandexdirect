.onAttach <- function(lib, pkg,...){
  packageStartupMessage(ryandexdirectWelcomeMessage())
}

#
#

ryandexdirectWelcomeMessage <- function(){
  # library(utils)
  
  paste0("\n",
         "---------------------\n",
         "Welcome to ryandexdirect version ", utils::packageDescription("ryandexdirect")$Version, "\n",
         "\n",
         "Author:   Alexey Seleznev (Head of analytics dept at Netpeak).\n",
         "Email:    selesnow@gmail.com\n",
         "Blog:     https://alexeyseleznev.wordpress.com \n",
         "Facebook: https://facebook.com/selesnown \n",
         "Linkedin: https://www.linkedin.com/in/selesnow \n",
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

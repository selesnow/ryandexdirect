yadirAuth <- function(Login = getOption("ryandexdirect.user"), NewUser = FALSE, TokenPath = yadirTokenPath()) {
  
  # check dir
  # Create token directory if it does not exist
  if (!dir.exists(TokenPath)) dir.create(TokenPath)
  
  # Set login if not provided
  Login <- if (exists("Login") && !is.null(Login)) Login else getOption("ryandexdirect.user")

  # Normalize path
  TokenPath <- gsub("\\\\", "/", TokenPath)
  token_file <- file.path(TokenPath, paste0(Login, ".yadirAuth.RData"))
  
  gr_type <- "authorization_code"
  id_cl <- "365a2d0a675c462d90ac145d4f5948cc"
  secret_cl <- "f2074f4c312449fab9681942edaa5360"
  
  # Load token if it exists
  if (!NewUser && file.exists(token_file)) {
    message("Load token from ", token_file)
    load(token_file)

    # Check token expiration
    if (as.numeric(difftime(token$expire_at, Sys.time(), units = "days")) < 30) {
      message("Auto refresh token")
      token_raw <- httr::POST(
        "https://oauth.yandex.ru/token",
        body = list(
          grant_type = gr_type,
          refresh_token = token$refresh_token,
          client_id = id_cl,
          client_secret = secret_cl
        ),
        encode = "form"
      )
      
      # Check for errors
      token <- content(token_raw)
      if (!is.null(token$error_description)) stop(paste0(token$error, ": ", token$error_description))
      
      # Update token data
      token$expire_at <- Sys.time() + as.numeric(token$expires_in, units = "secs")
      class(token) <- "yadir_token"
      save(token, file = token_file)
      
      message("Token saved in file ", token_file)
      return(token)
    } else {
      message("Token expires in ", round(difftime(token$expire_at, Sys.time(), units = "days")), " days")
      return(token)
    }
  }
  
  # Check execution mode
  if (!interactive()) {
    stop(sprintf(
      "Function yadirAuth does not find the %s.yadirAuth.RData file in %s. 
    You must run this script in interactive mode (RStudio or RGui) to complete the authorization process. 
    Once authorized, the token file will be saved and can be used in batch mode. 

    More details:
    - Release notes: https://github.com/selesnow/ryandexdirect/releases/tag/3.0.0
    - R modes: https://www.r-bloggers.com/batch-processing-vs-interactive-sessions/",
      Login, TokenPath
    ))
  }
  
  # Start user authorization
  auth_url <- sprintf(
    "https://oauth.yandex.ru/authorize?response_type=code&client_id=365a2d0a675c462d90ac145d4f5948cc&redirect_uri=https://selesnow.github.io/ryandexdirect/getToken/get_code.html&force_confirm=%d%s",
    as.integer(NewUser),
    if (!is.null(Login)) paste0("&login_hint=", Login) else ""
  )
  browseURL(auth_url)
  
  # Enter authorization code
  repeat {
    temp_code <- readline("Enter authorize code:")
    if (nchar(temp_code) == 16) break
    message("The verification code is not 16 characters long, try again.")
  }

  body_data <- list(
    grant_type = gr_type,
    code = temp_code,
    client_id = id_cl,
    client_secret = secret_cl)
  
  response <- request("https://oauth.yandex.ru/token") %>%
    req_body_form(!!!body_data) %>%
    req_perform()
 
  token <- resp_body_json(response)
  token$expire_at <- Sys.time() + token$expires_in
  class(token) <- "yadir_token"

  # check error
  if (!is.null(token$error_description)) {
    stop(paste0(token$error, ": ", token$error_description))
  }

  # print save token file
  save_path <- paste0(TokenPath, "/", Login, ".yadirAuth.RData")
  message("Do you want to save the API credential in a local file (", save_path, ") for use between R sessions?")
  ans <- tolower(readline("y / n (recommendation - y): "))
  
  # save token
  if (ans %in% c("y", "yes", "ok", "save")) {
    save(token, file = save_path)
    message("Token saved in file ", save_path)
  }
  # return token
  return(token)

}

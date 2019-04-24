yadirGetLogsData <- 
function(counter = NULL, date_from = Sys.Date() - 10, date_to = Sys.Date(), fields = NULL, source = "visits", token = NULL){
  fun_start <- Sys.time()

  fields <- gsub("[\\s\\n\\t]","",fields,perl = TRUE) 
  logapi <- POST(paste0("https://api-metrika.yandex.ru/management/v1/counter/",counter,"/logrequests?date1=",date_from,"&date2=",date_to,"&fields=",fields,"&source=",source,"&oauth_token=",token))
  queryparam <- content(logapi, "parsed", "application/json")
  

  if(!is.null(queryparam$errors)){
    stop(paste0(queryparam$errors[[1]][[1]]," - ",queryparam$errors[[1]][[2]], ", error code - ", queryparam$code))
  }
  

  request_id <- queryparam$log_request$request_id
  request_status <- queryparam$log_request$status
  

  start_time <- Sys.time()
  

  Sys.sleep(7)
  

  packageStartupMessage("Processing ", appendLF = FALSE)
  

  while(request_status != "processed"){
    logapistatus <- GET(paste0("https://api-metrika.yandex.ru/management/v1/counter/",counter,"/logrequest/",request_id,"?oauth_token=",token))
    request_status <- content(logapistatus, "parsed", "application/json")$log_request$status
    

    #message(paste0("Query status: ", request_status," Query time: ", Sys.time() - start_time))
    packageStartupMessage(".", appendLF = FALSE)
    

    partsnun <- length(content(logapistatus, "parsed", "application/json")$log_request$parts)
    

    if(request_status == "processed"){

      packageStartupMessage(paste0(" processing time ",round(Sys.time() - start_time,2)," sec"), appendLF = TRUE)
      

      result <- data.frame()
      

      packageStartupMessage("Loading ", appendLF = FALSE)
      start_load_time <- Sys.time()
      for(parts in 0:partsnun-1){
        packageStartupMessage(".", appendLF = FALSE)

        logapidata <- GET(paste0("https://api-metrika.yandex.ru/management/v1/counter/",counter,"/logrequest/",request_id,"/part/",parts,"/download?oauth_token=",token))
        rawdata <- try(content(logapidata,"text","application/json",encoding = "UTF-8"), silent = T)
        df_temp <- try(read.delim(text=rawdata), silent = T)
        result <- rbind(result, df_temp)
      }

      packageStartupMessage(paste0(" done! ", "loading time ",round(Sys.time() - start_load_time,2)," sec"))
      

      req_delite <- POST(paste0("https://api-metrika.yandex.ru/management/v1/counter/",counter,"/logrequest/",request_id,"/clean?oauth_token=",token))
      req_delite <- content(req_delite, "parsed", "application/json")

      packageStartupMessage("Information: ")
      packageStartupMessage(paste0("Request id: ", request_id))
      packageStartupMessage(paste0("Request status: ", req_delite$log_request$status))
      packageStartupMessage(paste0("Total time: ", round(Sys.time() - fun_start,2)," sec"))
      packageStartupMessage(paste0("Data size: ",round(req_delite$log_request$size * 1e-6,2), " Mb"))
      packageStartupMessage(paste0("Return rows: ",nrow(result)))                   
      if(exists("result")){
      packageStartupMessage("Data load successful!")
      }
      return(result)
    }
    

    if(request_status == "processing_failed"){
      stop("failed")
    }
    
    if(request_status == "canceled"){
      stop("canceled")
    }
    
    if(request_status == "cleaned_by_user"|request_status == "cleaned_automatically_as_too_old"){
      stop("cleaned")
    }
    
    Sys.sleep(5)
  }
}

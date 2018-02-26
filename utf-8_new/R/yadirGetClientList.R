yadirGetClientList <-
function(token = NULL){
  if(is.null(token)){
    warning("Get your api token by function yadirGetToken() and argument token in function yadirGetClientList!");
    break
    }
  #Create POST request
  answer <- POST("https://api.direct.yandex.ru/v4/json/", body = paste0("{\"method\": \"GetClientsList\", \"locale\": \"ru\", \"token\": \"",token,"\"}"))
  #Send POST request
  stop_for_status(answer)
  dataRaw <- content(answer, "parsed", "application/json")
  #Create result data frame
  data <- data.frame()
  for (i in 1:length(dataRaw$data)){
    #Replace NULL to NA
    dataRaw$data[[i]][c('FIO','Login','DateCreate','Phone','Email','Role','StatusArch')][sapply(dataRaw$data[[i]][c('FIO','Login','DateCreate','Phone','Email','Role','StatusArch')], is.null)] <- NA
    dataTemp <- data.frame(t(as.data.frame(unlist(dataRaw$data[[i]][c('FIO','Login','DateCreate','Phone','Email','Role','StatusArch')],recursive = T))),row.names = NULL)
    data <- rbind(data, dataTemp)
  }
  dataTotal <- data.frame(
    Login = as.character(data$Login),
    FIO = as.character(data$FIO),
    StatusArch = as.factor(data$StatusArch),
    DateCreate = as.POSIXct(data$DateCreate),
    Role = as.factor(data$Role),
    Email = as.character(data$Email),
    Phone = as.character(data$Phone)
  );
  dataTotal$Login = as.character(dataTotal$Login)
  dataTotal$FIO = as.character(dataTotal$FIO)
  dataTotal$Email = as.character(dataTotal$Email)
  dataTotal$Phone = as.character(dataTotal$Phone)
  return(dataTotal)
}

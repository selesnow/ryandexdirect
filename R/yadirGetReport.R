yadirGetReport <- function(ReportType = "CAMPAIGN_PERFORMANCE_REPORT", 
                           DateRangeType = "LAST_MONTH", 
                           DateFrom = NULL, 
                           DateTo = NULL, 
                           FieldNames = c("CampaignName","Impressions","Clicks","Cost"), 
                           FilterList = NULL,
                           IncludeVAT = "NO",
                           IncludeDiscount = "NO",
                           Login = NULL,
                           Token = NULL){
  
  #Ôîðììèðóåì ñïèñîê ïîëåé
  Fields <- paste0("<FieldNames>",FieldNames, "</FieldNames>", collapse = "")
  
  #Ôîðìèðóåì ôèëüòð
  if(!is.null(FilterList)){
    fil_list <- NA
    filt <- FilterList
    for(fil in filt){
      fil_list <- paste0(fil_list[!is.na(fil_list)],
                         paste0("<Filter>",
                                paste0("<Field>",strsplit(fil ," ")[[1]][1], "</Field>"),
                                paste0("<Operator>",strsplit(fil ," ")[[1]][2], "</Operator>"),
                                paste0("<Values>",strsplit(fil ," ")[[1]][3], "</Values>"),"</Filter>"))
    }}
  
  #Ôîðìèðóåì òåëî çàïðîñà
  queryBody <- paste0('
                      <ReportDefinition xmlns="http://api.direct.yandex.com/v5/reports">
                      <SelectionCriteria>',
                      ifelse(DateRangeType == "CUSTOM_DATE",paste0("<DateFrom>",DateFrom,"</DateFrom>","<DateTo>",DateTo,"</DateTo>") ,"" ),
                      ifelse(is.null(FilterList),"",fil_list),
                      '
                      </SelectionCriteria>',
                      Fields,'
                      <ReportName>',paste0("MyReport ", Sys.time()),'</ReportName>
                      <ReportType>',ReportType,'</ReportType>
                      <DateRangeType>',DateRangeType ,'</DateRangeType>
                      <Format>TSV</Format>
                      <IncludeVAT>',IncludeVAT,'</IncludeVAT>
                      <IncludeDiscount>',IncludeDiscount,'</IncludeDiscount>
                      </ReportDefinition>')
  
  #Îòïðàâëÿåì çàïðîñ íà ñåðâåð ßíäåêñà
  answer <- POST("https://api.direct.yandex.com/v5/reports", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru", 'Client-Login' = Login, returnMoneyInMicros = "false", processingMode = "auto"))
  
  if(answer$status_code == 400){
    stop("Îøèáêà â ïàðàìåòðàõ çàïðîñà ëèáî ïðåâûøåíî îãðàíè÷åíèå íà êîëè÷åñòâî çàïðîñîâ èëè îò÷åòîâ â î÷åðåäè. Â ýòîì ñëó÷àå ïðîàíàëèçèðóéòå ñîîáùåíèå îá îøèáêå, ñêîððåêòèðóéòå çàïðîñ è îòïðàâüòå åãî ñíîâà.")
  }
  
  
  if(answer$status_code == 500){
    stop("Ïðè ôîðìèðîâàíèè îò÷åòà ïðîèçîøëà îøèáêà íà ñåðâåðå. Åñëè äëÿ ýòîãî îò÷åòà îøèáêà íà ñåðâåðå âîçíèêëà âïåðâûå, ïîïðîáóéòå ñôîðìèðîâàòü îò÷åò çàíîâî. Åñëè îøèáêà ïîâòîðÿåòñÿ, îáðàòèòåñü â ñëóæáó ïîääåðæêè.")
  }
  
  if(answer$status_code == 201){
    packageStartupMessage("Îò÷åò óñïåøíî ïîñòàâëåí â î÷åðåäü íà ôîðìèðîâàíèå â ðåæèìå îôëàéí.", appendLF = F)
  }
  
  if(answer$status_code == 202){
    packageStartupMessage("Ôîðìèðîâàíèå îò÷åòà åùå íå çàâåðøåíî.", appendLF = F)
  }
  
  
  while(answer$status_code != 200){
    answer <- POST("https://api.direct.yandex.com/v5/reports", body = queryBody, add_headers(Authorization = paste0("Bearer ",Token), 'Accept-Language' = "ru", 'Client-Login' = Login, returnMoneyInMicros = "false", processingMode = "auto"))
    packageStartupMessage(".", appendLF = F)
    if(answer$status_code == 500){
      stop("Ïðè ôîðìèðîâàíèè îò÷åòà ïðîèçîøëà îøèáêà íà ñåðâåðå. Åñëè äëÿ ýòîãî îò÷åòà îøèáêà íà ñåðâåðå âîçíèêëà âïåðâûå, ïîïðîáóéòå ñôîðìèðîâàòü îò÷åò çàíîâî. Åñëè îøèáêà ïîâòîðÿåòñÿ, îáðàòèòåñü â ñëóæáó ïîääåðæêè.")
    }
    
    Sys.sleep(5)
  }
  
  if(answer$status_code == 200){
    #Ïîëó÷àåì ñïèñîê íàçâàíèé ïîëåé
    names_col <- strsplit(read.csv(text = content(answer, "text"), sep = "\n", stringsAsFactors = F)[1,], "\t")[[1]]
    #ïîëó÷àåì äàííûå
    dataRaw <- read.csv(text = content(answer, "text"), sep = "\n", stringsAsFactors = F)[-1,]
    #Ôîðìèðóåì ðåçóëüòèðóþùóþ òàáëèöó
    #df_new <- data.frame(do.call('rbind', strsplit(as.character(dataRaw),'\t',fixed=TRUE)))
    df_new <- read.csv(text = dataRaw,header = F, sep = "\t", col.names = names_col)
    
    #Ïðîâåðêà âåðíóëèñü ëè êàêèå òî äàííûå
    if(is.null(nrow(df_new[-nrow(df_new),]))){
      stop("Âàø çàïðîñ íå âåðíóë íèêàêèõ äàííûõ, âíèìàòåëüíî ïðîâåðüòå çàäàííûé  ôèëüòð è ïåðèîä îò÷¸òà, ïîñëå ÷åãî ïîâòîðèòå ïîïûòêó.")
    }
    #Çàäà¸ì íàçâàíèÿ ïîëåé
    #names(df_new) <- names_col
    #Óáèðàåì ñòðîêó èòîãîâ
    #df_new <- df_new[-nrow(df_new),]
    packageStartupMessage("Îò÷åò óñïåøíî ñôîðìèðîâàí è ïåðåäàí â òåëå îòâåòà.", appendLF = T)
    
    #Èíôîðìàöèÿ î êîëè÷åñòâå áàëëîâ.
    packageStartupMessage(paste0("РЈРЅРёРєР°Р»СЊРЅС‹Р№ РёРґРµРЅС‚РёС„РёРєР°С‚РѕСЂ Р·Р°РїСЂРѕСЃР° РєРѕС‚РѕСЂС‹Р№ РЅРµРѕР±С…РѕРґРёРјРѕ СѓРєР°Р·С‹РІР°С‚СЊ РїСЂРё РѕР±СЂР°С‰РµРЅРёРё РІ СЃР»СѓР¶Р±Сѓ РїРѕРґРґРµСЂР¶РєРё: ",answer$headers$requestid), appendLF = T)
    #Âîçâðàùàåì ïîëó÷åííûé ìàññèâ
    return(df_new)
  }
}

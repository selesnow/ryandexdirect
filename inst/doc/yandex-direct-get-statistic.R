## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  eval = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
#  library(ryandexdirect)

## ---- eval = TRUE, results = "asis", echo=FALSE-------------------------------
library(magrittr)
table_report_types <- data.frame(reptype = c("ACCOUNT_PERFORMANCE_REPORT", 
                                             "CAMPAIGN_PERFORMANCE_REPORT", 
                                             "ADGROUP_PERFORMANCE_REPORT",
                                             "AD_PERFORMANCE_REPORT",
                                             "CRITERIA_PERFORMANCE_REPORT",
                                             "CUSTOM_REPORT",
                                             "REACH_AND_FREQUENCY_PERFORMANCE_REPORT",
                                             "SEARCH_QUERY_PERFORMANCE_REPORT"), 
                                 descr    = c("Статистика по аккаунту рекламодателя",
                                              "Статистика по кампаниям",
                                              "Статистика по группам объявлений",
                                              "Статистика по объявлениям",
                                              "Статистика по условиям показа",
                                              "Статистика с произвольными группировками",
                                              "Статистика по медийным кампаниям. Отчет содержит только данные по кампаниям с типом «Медийная кампания», кампании остальных типов игнорируются",
                                              "Статистика по поисковым запросам"),
                                 grouping = c("–", 
                                              "CampaignId", 
                                              "AdGroupId",
                                              "AdId",
                                              "AdGroupId, CriteriaId, CriteriaType",
                                              "–",
                                              "В запросе на формирование отчета необходимо указать в поле FieldNames значение CampaignId", 
                                              "AdGroupId, Query"))

names(table_report_types) <- c("Тип отчёта", "Описание", "Добавляется группировка")
table_report_types <- kableExtra::kable(table_report_types)
kableExtra::kable_styling(table_report_types, bootstrap_options = c("striped", "hover"))

## ---- eval = TRUE, results = "asis", echo=FALSE-------------------------------
library(magrittr)
table_report_types <- data.frame(field = c("AdNetworkType, CampaignId, CampaignType", 
                                             "AdFormat, AdGroupId, AdId, Age, AudienceTargetId, CarrierType, ClickType, CriteriaType, CriterionType, Device, DynamicTextAdTargetId, ExternalNetworkName, Gender, LocationOfPresenceId, MatchType, MobilePlatform, Placement, RlAdjustmentId, Slot, SmartBannerFilterId, TargetingLocationId", 
                                             "Clicks, Conversions, ImpressionReach, Impressions",
                                             "AvgClickPosition, AvgCpc, AvgCpm, AvgImpressionFrequency, AvgImpressionPosition, AvgPageviews, AvgTrafficVolume, BounceRate, ConversionRate, Cost, CostPerConversion, Ctr, GoalsRoi, ImpressionShare, Profit, Revenue, WeightedCtr, WeightedImpressions, ",
                                             "Keyword, MatchedKeyword, Query"), 
                                 operators    = c("EQUALS, IN",
                                              "EQUALS, IN, NOT_EQUALS, NOT_IN",
                                              "EQUALS, IN, GREATER_THAN, LESS_THAN",
                                              "GREATER_THAN, LESS_THAN",
                                              "EQUALS, IN, NOT_EQUALS, NOT_IN, STARTS_WITH_IGNORE_CASE, STARTS_WITH_ANY_IGNORE_CASE, DOES_NOT_START_WITH_IGNORE_CASE, DOES_NOT_START_WITH_ALL_IGNORE_CASE"))

names(table_report_types) <- c("Имя поля", "Доступные операторы")
table_report_types <- kableExtra::kable(table_report_types)
kableExtra::kable_styling(table_report_types, bootstrap_options = c("striped", "hover"))

## -----------------------------------------------------------------------------
#  library(ryandexdirect)
#  
#  # создаём результирующий фрейм
#  res   <- data.frame()
#  
#  # список логинов
#  log_list <- c("login1", "login2","login3", "login4")
#  
#  # проверка лиситов
#  # отмечаем что это первый запуск
#  check <- "first"
#  
#  # создаём последовательность уровней временной разбивки запросов
#  fetching_seq <- c("OFF", "MONTH", "WEEK", "DAY")
#  
#  # счётчик последовательностей разбивки
#  fetch_id <- 1
#  
#  # запускаем цикл загрузки данных с проверкой лимитов
#  while ( ! is.null( log_list ) ) {
#  
#    # определяем уровень разбивки запроса
#    if ( fetching_seq[fetch_id] == "OFF" ) fetching <- NULL else fetching <- fetching_seq[fetch_id]
#  
#    # запускаем сбор данных
#    data <- yadirGetReport(DateRangeType = "CUSTOM_DATE",
#                           DateFrom      = "2018-06-01",
#                           DateTo        = "2019-05-31",
#                           FieldNames    = c("Date","CampaignName","Impressions","Clicks"),
#                           Login         = log_list,
#                           FetchBy       = fetching)
#  
#    # если загрузка была по одному аккаунту добавляем его логин
#    if ( length(log_list) == 1 ) {
#      data$Login <- log_list
#    }
#  
#    # проверяем список аккаунтов достигших лимита
#    log_list <- attr(data, "limit_reached")
#  
#    # выводим список аккаунтов достигших лимита
#    print(log_list)
#  
#    # если есть аккаунты достигшие лимита
#    if ( length(log_list) > 0 ) {
#      # очищаем от них общую таблицу
#      data <- data[ ! data$Login %in% log_list, ]
#      # переключаем уровень разбивки на более мелкий
#      fetch_id <- fetch_id + 1
#    }
#  
#    # дописываем в результирующий фрейм данные
#    # по тем аккаунтам которые не упёрлись в лимит
#    if ( nrow(data) > 0 ) {
#      res <- dplyr::bind_rows(res, data)
#    }
#  
#    # проверяем модно ли разбить запрос на более мелкие части
#    if ( fetch_id > length(fetching_seq) && length(log_list) > 0 ) {
#      message("Запрос невозможно разбить на меньшие части")
#      message("Аккаунты которые достигли лимита при загрузке данных по дням: ", paste(log_list, collapse = ", "))
#      limits_login <- log_list
#      break
#    }
#  }


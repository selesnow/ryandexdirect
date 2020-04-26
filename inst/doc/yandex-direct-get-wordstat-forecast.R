## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  eval = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
#  library(ryandexdirect)

## -----------------------------------------------------------------------------
#  s_ws_rep <- yadirGetWordStatReport(c('купить смартфон',
#                                       'купить сотовый телефон',
#                                       'купить мобильный',
#                                       'samsung -(серого цвета)'),
#                                     Login = "selesnow")

## -----------------------------------------------------------------------------
#  # Что искали с заданными ключевыми словами
#  s_ws_rep$SearchedWith
#  s_ws_rep[['SearchedWith']]
#  
#  # Запросы, похожие на заданные ключевые слова
#  s_ws_rep$SearchedAlso
#  s_ws_rep[['SearchedAlso']]
#  

## -----------------------------------------------------------------------------
#  library(dplyr)
#  
#  # запрашиваем справочник регионов
#  regions <- yadirGetDictionary(Login = "selesnow")
#  
#  # оставляем толлько нужные регионы
#  rep_regions <- regions %>%
#                    filter(GeoRegionName %in% c("Москва",
#                                                "Санкт-Петербург",
#                                                "Екатеринбург",
#                                                "Владивосток"))
#  
#  # запрашиваем отчёт
#  reg_ws <- yadirGetWordStatReport(Phrases = c('купить смартфон -xiaomi',
#                                               'купить xiaomi'),
#                                   GeoID   = rep_regions$GeoRegionId,
#                                   Login   = "selesnow")

## -----------------------------------------------------------------------------
#  library(dplyr)
#  
#  # запрашиваем справочник регионов
#  regions <- yadirGetDictionary(Login = "selesnow")
#  
#  # получаем идентификатор России
#  regions <- regions %>%
#    filter(GeoRegionName %in% c("Россия"))
#  
#  # получаем идентификатор минус регионов и помечаем их минусом
#  minus_regions <- regions %>%
#    filter(GeoRegionName %in% c("Москва",
#                                "Санкт-Петербург",
#                                "Екатеринбург",
#                                "Владивосток")) %>%
#    mutate(GeoRegionId = paste0("-", GeoRegionId))
#  
#  # запрашиваем прогноз с результататми торгов
#  forecast <- yadirGetForecast2(Phrases = c('купить смартфон -xiaomi',
#                                           'купить xiaomi',
#                                           'самсунг -(серого цвета)'),
#                               GeoID   = c(regions$GeoRegionId, minus_regions$GeoRegionId),
#                               AuctionBids = 'Yes',
#                               Login   = "selesnow")


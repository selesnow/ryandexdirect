#### Структура возвращаемого функцией `yadirGetBalance` дата фрейма:


#### Пример кода для получения списка ключевых слов:
```
#Подключаем пакет
library(ryandexdirect)
#Получаем API token
my_token <- yadirGetToken()

#Получаем остаток средств общего счёта для аккаунта рекламодателя
my_balance <- yadirGetBalance(Logins = "vasya",  Token = "abcdef123456")

#Получаем список клиентских аккаунтов
my_client <- yadirGetClientList(Token = "abcdef123456")
#Получаем остатки средств на общих счетах всех клиентов агентского аккаунта
my_clients_balance <- yadirGetBalance(Logins = my_client$Login,  Token = "abcdef123456")
```

### `yadirGetReport(ReportType = "CAMPAIGN_PERFORMANCE_REPORT", DateRangeType = "LAST_MONTH", DateFrom = NULL, DateTo = NULL,    FieldNames = c("CampaignName","Impressions","Clicks","Cost"), FilterList = NULL, IncludeVAT = "NO", IncludeDiscount = "NO",          Login = NULL, Token = NULL)`

Основная функция пакета с помощь которой вы можете выгружать данные из [сервиса Reports](https://tech.yandex.ru/direct/doc/reports/reports-docpage/) Яндекс Директ, ниже приведено подробное описание функции.

#### Аргументы:

# ryandexdirect - пакет для работы с API Яндекс.Директ версии 4, Live 4 и 5, а так же с Logs API Яндекс метрики на языке R.

##Содержание
+ [Краткое описание](https://github.com/selesnow/ryandexdirect/blob/master/README.md#Краткое-описание)
+ [Установка пакета ryandexdirect](https://github.com/selesnow/ryandexdirect/blob/master/README.md#Установка-пакета-ryandexdirect)
+ [Функции входящие в пакет ryandexdirect](https://github.com/selesnow/ryandexdirect/blob/master/README.md#Функции-входящие-в-пакет-ryandexdirect)
+ [yadirGetToken](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadirgettoken)
+ [yadirGetClientList](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadirgetclientlisttoken--null)
+ [yadirGetCampaignList](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadirgetcampaignlistlogins--null-token--null)
+ [yadirGetCampaignListOld](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadirgetcampaignlistoldlogins--null-token--null)
+ [yadirGetSummaryStat](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadirgetsummarystatcampaignids--null-datestart--sysdate---10-dateend--sysdate-currency--usd-token--null)
+ [yadirCurrencyRates](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadircurrencyrateslogin--null-token--null)
+ [yadirGetLogsData](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadirgetlogsdatacounter--null-date_from--sysdate---10-date_to--sysdate-fields--null-source--visits-token--null)
+ [Пример работы с пакетом ryandexdirect](https://github.com/selesnow/ryandexdirect/blob/master/README.md#Пример-работы-с-пакетом-ryandexdirect)
+ [Пример работы с Logs API Яндекс Метрики](https://github.com/selesnow/ryandexdirect/blob/master/README.md#Пример-работы-с-logs-api-Яндекс-Метрики)

## Краткое описание.

Пакет ryandexdirect помонает получить дата фрейм со списком клиентов агентств из аккаунта Яндекс.Директ, получить список и обшие параметры рекламных кампаний по каждому из проектов, а так же получить детальную статистику по кампаниям за каждый день.


## Установка пакета ryandexdirect.

Установка пакета осуществляется из репозитория GitHub, для этого сначала требуется установить и подключить пакет devtools.

`install.packages("devtools")`

`library(devtools)`

После чего можно устанавливать пакет ryandexdirect.

`install_github('selesnow/ryandexdirect')`


## Функции входящие в пакет ryandexdirect.

На данный момент в версию пакета 1.3 входит 7 функции:

###`yadirGetToken()`
Функция для получения токена для доступа к API Яндекс.Директ, полученый токен используется во всех остальных функциях.

###`yadirGetClientList(token = NULL)`
Данная функция возвращает дата фрейм со списком всех клиентов доступных в агентском аккаунте которому был выдан токен для доступа к API, используется только при работе с агентскими аккаунтами.

####Структура возвращаемого функцией `yadirGetClientList` дата фрейма:
<table>
    <tr>
        <td><center>Поле</center></td><td><center>Тип данных</center></td><td><center>Описание</center></td>
    </tr>
    <tr>
        <td>Login</td><td>chr</td><td>Логин пользователя на Яндексе</td>
    </tr>
    <tr>
        <td>FIO</td><td>chr</td><td>Фамилия Имя Отчество указанные в аккаунте клиентом</td>
    </tr>
    <tr>
        <td>StatusArch</td><td>Factor</td><td>Учетная запись пользователя помещена в архив — Yes/No</td>
    </tr>
    <tr>
        <td>DateCreate</td><td>POSIXct</td><td>Дата регистрации пользователя, YYYY-MM-DD.</td>
    </tr>
    <tr>
        <td>Role</td><td>Factor</td><td>Роль в Яндекс.Директе:
        Client — клиент рекламного агентства, или прямой рекламодатель, или представитель прямого рекламодателя;
        Agency — рекламное агентство или представитель агентства.</td>
    </tr>
    <tr>
        <td>Email</td><td>chr</td><td>Адрес электронной почты клиента</td>
    </tr>
    <tr>
        <td>Phone</td><td>chr</td><td>Контактный телефон в произвольном формате.</td>
    </tr>
</table>


###`yadirGetCampaignList(logins = NULL, token = NULL)`
Функция возвращает дата фрейм со списком рекламных кампаний и некоторых их параметров по логину.

####Структура возвращаемого функцией `yadirGetCampaignList` дата фрейма:
<table>
    <tr>
        <td><center>Поле</center></td><td><center>Тип данных</center></td><td><center>Описание</center></td>
    </tr>
    <tr>
        <td>Id</td><td>chr</td><td>Идентификатор кампании.</td>
    </tr>
    <tr>
        <td>Name</td><td>chr</td><td>Название кампании.</td>
    </tr>
    <tr>
        <td>Type</td><td>Factor</td><td>Тип кампании ("TEXT_CAMPAIGN" | "MOBILE_APP_CAMPAIGN" |  "DYNAMIC_TEXT_CAMPAIGN" | "UNKNOWN").</td>
    </tr>
    <tr>
        <td>Status</td><td>Factor</td><td>Статус кампании ( "ACCEPTED" | "DRAFT" | "MODERATION" | "REJECTED" | "UNKNOWN" ).</td>
    </tr>
    <tr>
        <td>State</td><td>Factor</td><td>Состояние кампании ( "ARCHIVED" | "CONVERTED" | "ENDED" | "OFF" | "ON" | "SUSPENDED" | "UNKNOWN" ).</td>
    </tr>
    <tr>
        <td>DailyBudgetAmount</td><td>num</td><td>Дневной бюджет кампании в валюте рекламодателя.</td>
    </tr>
    <tr>
        <td>DailyBudgetMode</td><td>chr</td><td>DISTRIBUTED — распределять дневной бюджет равномерно на весь день.
STANDARD — дневной бюджет может исчерпаться, а показы завершиться ранее окончания дня.</td>
    </tr>
    <tr>
        <td>Currency</td><td>Factor</td><td>Валюта кампании. Совпадает с валютой рекламодателя для всех кампаний.</td>
    </tr>
    <tr>
        <td>StartDate</td><td>Date</td><td>Дата начала показов объявлений.</td>
    </tr>
    <tr>
        <tdImpressions</td><td>int</td><td>Количество показов за время существования кампании..</td>
    </tr>
    <tr>
        <td>Clicks</td><td>int</td><td>Количество кликов за время существования кампании.</td>
    </tr>
    <tr>
        <td>ClientInfo</td><td>chr</td><td>Название клиента. Значение по умолчанию — наименование из настроек рекламодателя.</td>
    </tr>
    <tr>
        <td>login</td><td>chr</td><td>Логин пользователя на Яндексе.</td>
    </tr>
</table>

###`yadirGetCampaignListOld(logins = NULL, token = NULL)`
Устаревшая функцая для получения списка рекламных кампаний, список функций запрашивался с помощью метода GetCampaignList из версии API 4, с августе 2016 года этот метод стал недоступен, для того что бы получить список кампаний используйте новую  функцию`yadirGetCampaignList(logins = NULL, token = NULL)`.

###`yadirGetSummaryStat(campaignIDS = NULL, dateStart = Sys.Date() - 10, dateEnd = Sys.Date(), currency = "USD", token = NULL)`
Основная функция пакета, возвращает дата фрейм со статистикой в разрезе кампаний и дат.

####Структура возвращаемого функцией `yadirGetSummaryStat` дата фрейма:
<table>
    <tr>
        <td><center>Поле</center></td><td><center>Тип данных</center></td><td><center>Описание</center></td>
    </tr>
    <tr>
        <td>Date</td><td>POSIXct</td><td>Дата, за которую приведена статистика.</td>
    </tr>
    <tr>
        <td>CampaignID</td><td>Factor</td><td>Идентификатор кампании.</td>
    </tr>
    <tr>
        <td>SumSearch</td><td>num</td><td>Стоимость кликов на поиске.</td>
    </tr>
    <tr>
        <td>GoalConversionSearch</td><td>num</td><td>Доля целевых визитов в общем числе визитов при переходе с поиска, в процентах.</td>
    </tr>
    <tr>
        <td>GoalCostSearch</td><td>num</td><td>Цена достижения цели Яндекс.Метрики при переходе с поиска.</td>
    </tr>
    <tr>
        <td>ClickSearch</td><td>int</td><td>Количество кликов на поиске.</td>
    </tr>
    <tr>
        <td>ShowsSearch</td><td>int</td><td>Количество показов на поиске.</td>
    </tr>
    <tr>
        <td>SessionDepthSearch</td><td>num</td><td>Глубина просмотра сайта при переходе с поиска.</td>
    </tr>
    <tr>
        <td>SumContext</td><td>num</td><td>Стоимость кликов в Рекламной сети Яндекса.</td>
    </tr>
    <tr>
        <td>GoalConversionContext</td><td>num</td><td>Доля целевых визитов в общем числе визитов при переходе из Рекламной сети Яндекса, в процентах.</td>
    </tr>
    <tr>
        <td>GoalCostContext</td><td>num</td><td>Цена достижения цели Яндекс.Метрики при переходе из Рекламной сети Яндекса.</td>
    </tr>
    <tr>
        <td>ClicksContext</td><td>int</td><td>Количество кликов в Рекламной сети Яндекса.</td>
    </tr>
    <tr>
        <td>ShowsContext</td><td>int</td><td>Количество показов в Рекламной сети Яндекса.</td>
    </tr>
    <tr>
        <td>SessionDepthContext</td><td>num</td><td>Глубина просмотра сайта при переходе из Рекламной сети Яндекса.</td>
    </tr>
</table>

###`yadirCurrencyRates(login = NULL, token = NULL)`
Функция возвращает дата фрейм с актуальными курсами валют в Яндекс.Директ.

####Структура возвращаемого функцией `yadirGetSummaryStat` дата фрейма:
<table>
    <tr>
        <td><center>Поле</center></td><td><center>Тип данных</center></td><td><center>Описание</center></td>
    </tr>
    <tr>
        <td><center>curName</center></td><td><center>chr</center></td><td><center>Код валюты</center></td>
    </tr>
    <tr>
        <td><center>fullName</center></td><td><center>chr</center></td><td><center>Полное название валюты</center></td>
    </tr>
    <tr>
        <td><center>RateWithVAT</center></td><td><center>num</center></td><td><center>стоимость 1 у. е. с учетом НДС.</center></td>
    </tr>
    <tr>
        <td><center>Rate</center></td><td><center>num</center></td><td><center>стоимость 1 у. е. без учета НДС.</center></td>
    </tr>
</table>

###`yadirGetLogsData(counter = NULL, date_from = Sys.Date() - 10, date_to = Sys.Date(), fields = NULL, source = "visits", token = NULL)`
Функция для работы с Logs API Яндекс Метрики, которое позволяет выгрузить сырые данные.

Иногда возникают проблемы с тем, что функция останавливается если в возвращаемых данных встречается строчная русская буква 'я', решение этой проблемы описано [тут](http://ru.stackoverflow.com/questions/432007/%D0%9F%D0%BE%D0%B4%D0%B4%D0%B5%D1%80%D0%B6%D0%BA%D0%B0-%D1%8E%D0%BD%D0%B8%D0%BA%D0%BE%D0%B4%D0%B0-%D0%B2-shiny).

По сути просто необходимо установить одну хитрую локаль.

`Sys.setlocale("LC_ALL","Russian_Russia.20866")`

Далее функция будет работать корректно.

####Аргументы:
counter - номер счётчика Яндекс Метрики
date_from - начальная дата отчёта
date_to - конечная дата отчёта
fields - список полей которые вы отите получить, для visits актуальный список доступных полей можно получить [тут](https://tech.yandex.ru/metrika/doc/api2/logs/fields/visits-docpage/), для hits актуальный список полей можно получить [тут](https://tech.yandex.ru/metrika/doc/api2/logs/fields/hits-docpage/).
source - Источник логов, возможные значения hits — просмотры или visits — визиты

Подробное описание аргументов можно посмотреть [тут](https://tech.yandex.ru/metrika/doc/api2/logs/queries/class_logrequest-docpage/).

## Пример работы с пакетом ryandexdirect.

###Подключаем пакет ryandexdirect
`library(ryandexdirect)`

###Получаем токен для доступа к API
`myToken <- yadirGetToken()`

После запуска функции автоматически будет открыт браузер, на странице с выданным вам токеном, скопируйте его и вставьте в консоль R.
<p align="center">
<img src="http://picsee.net/upload/2016-07-29/5d6a84ad44f8.png" data-canonical-src="http://picsee.net/upload/2016-07-29/5d6a84ad44f8.png" style="max-width:100%;">
</p>
<p align="center">
<img src="http://picsee.net/upload/2016-07-29/acfa15376aa6.png" data-canonical-src="http://picsee.net/upload/2016-07-29/acfa15376aa6.png" style="max-width:100%;">
</p>
После чего в рабочей области появится объект myToken, который вы будете использовать в остальных функциях.

Далее в случае если у вас агетский аккаунт получаем список всех клиентов:

`clientList <- yadirGetClientList(myToken)`


Следующий шаг получить список рекламных кампаний клиентов, для этого в функции `yadirGetCampaignList`, для агентских аккаунтов необходимо задать вектор со списком логинов тех аккаунтов по которым вы хотите получить статистику, для обычных аккаунтов достаточно просто указать ваш токен.

`campaignList <- yadirGetCampaignList(logins = clientList$Login, token = myToken)`

Для того, что бы получить дата фрейм со статиской по кампаниям в разрезе дней осталось воспользоваться функцией `yadirGetSummaryStat`

`stat <- yadirGetSummaryStat(campaignIDS = campaigns$Id],
                            dateStart = "2016-01-01",
                            dateEnd = "2016-06-30",
                            currency = "USD",
                            token = myToken)`


##Образец кода для работы с пакетом ryandexdirect для агентских аккаунтов
```
library(ryandexdirect)
myToken <- yadirGetToken()
clientList <- yadirGetClientList(myToken)
campaignList <- yadirGetCampaignList(logins = clientList$Login, token = myToken)
stat <- yadirGetSummaryStat(campaignIDS = campaignList$Id,
                            dateStart = "2016-01-01",
                            dateEnd = "2016-06-30",
                            currency = "USD",
                            token = myToken)
```

#Пример работы с Logs API Яндекс Метрики.
```
library(ryandexdirect)
myToken <- yadirGetToken()
rawmetrikdata <- yadirGetLogsData(counter = "00000000",
                                  date_from = "2016-12-01",
                                  date_to = "2016-12-20",
                                  fields = "ym:s:visitID,ym:s:date,ym:s:bounce,ym:s:clientID,ym:s:networkType",
                                  source = "visits",
                                  token = myToken)
```

 *Автор пакета: Алексей Селезнёв, Head of Analytics Dept. at Netpeak*
 
 [GitHub](https://github.com/selesnow/)
 [VK](https://vk.com/selesnow)
 [Facebook](https://www.facebook.com/selesnow)
 [Linkedin](https://ua.linkedin.com/in/selesnow)
 [Stepik](https://stepik.org/users/792428)
  
<p align="center">
<img src="http://s017.radikal.ru/i444/1608/b7/989edcf88741.png" data-canonical-src="http://s017.radikal.ru/i444/1608/b7/989edcf88741.png" style="max-width:100%;">
</p>

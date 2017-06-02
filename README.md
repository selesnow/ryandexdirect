# ryandexdirect - пакет для работы с API Яндекс.Директ версии 4, Live 4 и 5, а так же с Logs API Яндекс метрики на языке R.

## Содержание
+ [Краткое описание](https://github.com/selesnow/ryandexdirect/blob/master/README.md#Краткое-описание)
+ [Установка пакета ryandexdirect](https://github.com/selesnow/ryandexdirect/blob/master/README.md#Установка-пакета-ryandexdirect)
+ [Функции входящие в пакет ryandexdirect](https://github.com/selesnow/ryandexdirect/blob/master/README.md#Функции-входящие-в-пакет-ryandexdirect)
+ [yadirGetToken](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadirgettoken) - Получение токена доступа
+ [yadirGetClientList](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadirgetclientlisttoken--null) - Получение списка клиентов для агентского аккаунта
+ [yadirGetClientParam](https://github.com/selesnow/ryandexdirect#yadirgetclientparamlanguage--ru-login--null-token--null) - Получение параметров аккаунта Яндекс Директ
+ [yadirGetCampaignList](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadirgetcampaignlistlogins--null-token--null) - Получения списка рекламных кампаний
+ [yadirGetReport](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadirgetreportreporttype--campaign_performance_report-daterangetype--last_month-datefrom--null-dateto--null-fieldnames--ccampaignnameimpressionsclickscost-filterlist--null-includevat--no-includediscount--no-login--null-token--null) - Получение статистики из Report сервиса API v.5.
+ [yadirGetDictionary](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadirgetdictionarydictionaryname--georegions-language--ru-login--null-token--null) - Получение справочной информации из API v.5.
+ [yadirGetCampaignListOld](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadirgetcampaignlistoldlogins--null-token--null) - Получения списка рекламных кампаний (Устаревшая функция из API v.4.)
+ [yadirGetSummaryStat](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadirgetsummarystatcampaignids--null-datestart--sysdate---10-dateend--sysdate-currency--usd-token--null) - Получение общей статистики по рекламным кампаниям
+ [yadirCurrencyRates](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadircurrencyrateslogin--null-token--null) - Получения текущих курсов валют (С 28.03.2017 справочник валют так же можно получить с помощью функции yadirGetDictionary)
+ [yadirGetLogsData](https://github.com/selesnow/ryandexdirect/blob/master/README.md#yadirgetlogsdatacounter--null-date_from--sysdate---10-date_to--sysdate-fields--null-source--visits-token--null) - Получение данных из Logs API Яндекс Метрики
+ [Пример работы с пакетом ryandexdirect](https://github.com/selesnow/ryandexdirect/blob/master/README.md#Пример-работы-с-пакетом-ryandexdirect)
+ [Пример работы с функцией yadirGetReport](https://github.com/selesnow/ryandexdirect/blob/master/README.md#Пример-работы-с-функцией-yadirgetreport-и-загрузки-данных-из-сервиса-reports) - Загрузка данных из сервиса Reports
+ [Пример работы с функцией yadirGetDictionary](https://github.com/selesnow/ryandexdirect/blob/master/README.md#Пример-работы-с-функцией-yadirgetdictionary-для-загрузки-справочников-из-api-v5-Яндекс-Директ) - загрузки справочников из API v.5. Яндекс Директ
+ [Пример работы с Logs API Яндекс Метрики](https://github.com/selesnow/ryandexdirect/blob/master/README.md#Пример-работы-с-logs-api-Яндекс-Метрики) - Загрузка сырых данных из Яндекс Метрики
+ [Как обратится к API сервисов Яндекс.Директ и Яндекс.Метрика через прокси сервер](https://github.com/selesnow/ryandexdirect/blob/master/README.md#Как-обратиться-к-api-сервисов-ЯндексДирект-и-ЯндексМетрика-с-помощью-proxy-сервера-необходимо-в-случае-блокировки-доступа-к-сервисам).
+ [Подборка статей с примерами работы с пакетом ryandexdirect](https://github.com/selesnow/ryandexdirect/blob/master/README.md#Подборка-статей-с-примерами-работы-с-пакетом-ryandexdirect)

## Краткое описание.

Пакет ryandexdirect предназначен для загрузки данных из Яндекс Директ и Яндекс Метрики в R, с помощью функций данного пакета вы можете работать с перечисленными ниже сервисами и службами API Яндекса с помощью готовых функций, не углубляясь при этом в документацию по работе с этими API сервисами.

+ [Сервис Reports](https://tech.yandex.ru/direct/doc/reports/reports-docpage/) - Предназначен для получения статистики по аккаунту рекламодателя.
+ [Logs API Яндекс Метрики](https://tech.yandex.ru/metrika/doc/api2/logs/intro-docpage/) - Logs API позволяет получать неагрегированные данные, собираемые Яндекс.Метрикой. Данный API предназначен для пользователей сервиса, которые хотят самостоятельно обрабатывать статистические данные и использовать их для решения уникальных аналитических задач.
+ [API Директа версии 4 и Live 4](https://tech.yandex.ru/direct/doc/dg-v4/concepts/About-docpage/) - Через API внешние приложения добавляют и редактируют кампании, объявления, фразы, задают ставки, получают статистику показов.
+ [API Директа версии 5](https://tech.yandex.ru/direct/doc/dg/concepts/about-docpage/) - Через API внешние приложения добавляют и редактируют кампании, объявления, фразы, задают ставки, получают статистику показов.

## Установка пакета ryandexdirect.

Установка пакета осуществляется из репозитория GitHub, для этого сначала требуется установить и подключить пакет devtools.

`install.packages("devtools")`

`library(devtools)`

После чего можно устанавливать пакет ryandexdirect.

`install_github('selesnow/ryandexdirect')`


## Функции входящие в пакет ryandexdirect.

На данный момент в версию пакета 2 входит 9 функции:

### `yadirGetToken()`
Функция для получения токена для доступа к API Яндекс.Директ, полученый токен используется во всех остальных функциях.

### `yadirGetClientList(token = NULL)`
Данная функция возвращает дата фрейм со списком всех клиентов доступных в агентском аккаунте которому был выдан токен для доступа к API, используется только при работе с агентскими аккаунтами.

#### Структура возвращаемого функцией `yadirGetClientList` дата фрейма:
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

### `yadirGetClientParam(Language = "ru", login = NULL, token = NULL)`
Функция возврщает Data frame с основными параметрами аккаунта Яндекс Директ.

#### Аргументы:
<b>Language</b> - Язык ответа

<b>login</b> - Логин на Яндексе

<b>token</b> - Токен дотупа к API

#### Структура возвращаемого функцией `yadirGetClientParam` дата фрейма:
<table>
    <tr>
        <td><center>Поле</center></td><td><center>Тип данных</center></td><td><center>Описание</center></td>
    </tr>
    <tr>
        <td>Login</td><td>chr</td><td>Логин пользователя Директа.</td>
    </tr>
    <tr>
        <td>ClientId</td><td>int</td><td>Идентификатор рекламодателя.</td>
    </tr>
    <tr>
        <td>CountryId</td><td>int</td><td>Идентификатор страны рекламодателя из справочника регионов.
Справочник регионов можно получить с помощью функции yadirGetDictionary.</td>
    </tr>
    <tr>
        <td>Currency</td><td>chr</td><td>Валюта рекламодателя.
Справочник валют можно получить с помощью функции yadirGetDictionary.</td>
    </tr>
    <tr>
         <td>CreatedAt</td><td>chr</td><td>Дата регистрации пользователя в Директе, в формате YYYY-MM-DD.</td>
    </tr>
     <tr>
         <td>ClientInfo</td><td>chr</td><td>ФИО пользователя Директа.</td>
    </tr>
     <tr>
         <td>AccountQuality</td><td>num</td><td>Показатель качества аккаунта.</td>
         <tr>
         <td>CampaignsTotalPerClient</td><td>int</td><td>Максимальное количество кампаний у рекламодателя.</td>
    <tr>
         <td> CampaignsUnarchivePerClient</td><td>int</td><td>максимальное количество кампаний, не находящихся в архиве.</td>
    </tr>
    <tr>
         <td>APIPoints</td><td>int</td><td>Суточный лимит баллов API.</td>
</table>

### `yadirGetCampaignList(logins = NULL, token = NULL)`
Функция возвращает дата фрейм со списком рекламных кампаний и некоторых их параметров по логину.

#### Структура возвращаемого функцией `yadirGetCampaignList` дата фрейма:
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

### `yadirGetReport(ReportType = "CAMPAIGN_PERFORMANCE_REPORT", DateRangeType = "LAST_MONTH", DateFrom = NULL, DateTo = NULL,    FieldNames = c("CampaignName","Impressions","Clicks","Cost"), FilterList = NULL, IncludeVAT = "NO", IncludeDiscount = "NO",          Login = NULL, Token = NULL)`

Основная функция пакета с помощь которой вы можете выгружать данные из [сервиса Reports](https://tech.yandex.ru/direct/doc/reports/reports-docpage/) Яндекс Директ, ниже приведено подробное описание функции.

#### Аргументы:
<b>ReportType</b> - Тип отчёта, принимает на вход строку с одним из возможных значений:

<table>
 <tr>
    <td>Тип отчета</td><td>Описание</td><td>Добавляется группировка данных</td><td>Не допускаются поля</td>
 </tr>
  <tr>
    <td>ACCOUNT_PERFORMANCE_REPORT</td><td>Статистика по аккаунту рекламодателя</td><td>–</td><td>См. раздел Допустимые поля(https://tech.yandex.ru/direct/doc/reports/fields-list-docpage/)</td>
 </tr>
   <tr>
    <td>CAMPAIGN_PERFORMANCE_REPORT</td><td>Статистика по кампаниям</td><td>CampaignId</td><td>См. раздел Допустимые поля(https://tech.yandex.ru/direct/doc/reports/fields-list-docpage/)</td>
 </tr>
   <tr>
    <td>ADGROUP_PERFORMANCE_REPORT</td><td>Статистика по группам объявлений</td><td>AdGroupId</td><td>См. раздел Допустимые поля(https://tech.yandex.ru/direct/doc/reports/fields-list-docpage/)</td>
 </tr>
   <tr>
    <td>AD_PERFORMANCE_REPORT</td><td>Статистика по объявлениям</td><td>AdId</td><td>AudienceTargetId, Criteria, CriteriaId, DynamicTextAdTargetId, ImpressionShare, Keyword, Query, RlAdjustmentId, SmartBannerFilterId</td>
 </tr>
   <tr>
    <td>CRITERIA_PERFORMANCE_REPORT</td><td>Статистика по условиям показа</td><td>AdGroupId, CriteriaId, CriteriaType</td><td>AdFormat, AdId, Placement, Query</td>
 </tr>
   <tr>
    <td>CUSTOM_REPORT</td><td>Статистика с произвольными группировками</td><td>–</td><td>ImpressionShare, Query</td>
 </tr>
   <tr>
    <td>SEARCH_QUERY_PERFORMANCE_REPORT</td><td>Статистика по поисковым запросам</td><td>AdGroupId, Query</td><td>См. раздел Допустимые поля(https://tech.yandex.ru/direct/doc/reports/fields-list-docpage/)</td>
 </tr>
</table>

<b>DateRangeType</b> - Тип периода отчёта, принимает на вход строку с одним из следующих значений.
 
 + TODAY — текущий день;
 + YESTERDAY — вчера;
 + LAST_3_DAYS, LAST_5_DAYS, LAST_7_DAYS, LAST_14_DAYS, LAST_30_DAYS, LAST_90_DAYS, LAST_365_DAYS — указанное количество предыдущих дней, не включая текущий день;
 + THIS_WEEK_MON_TODAY — текущая неделя начиная с понедельника, включая текущий день;
 + THIS_WEEK_SUN_TODAY — текущая неделя начиная с воскресенья, включая текущий день;
 + LAST_WEEK — прошлая неделя с понедельника по воскресенье;
 + LAST_BUSINESS_WEEK — прошлая рабочая неделя с понедельника по пятницу;
На схеме:
<p align="center">
<img src="https://yastatic.net/doccenter/images/tech-ru/direct/freeze/LJkDkhq2zaeFuKLmxkjfCg5wEjc.png" data-canonical-src="https://yastatic.net/doccenter/images/tech-ru/direct/freeze/LJkDkhq2zaeFuKLmxkjfCg5wEjc.png" style="max-width:100%;">
</p>

 + LAST_WEEK_SUN_SAT — прошлая неделя с воскресенья по субботу;
 + THIS_MONTH — текущий месяц;
 + LAST_MONTH — предыдущий месяц;
 + ALL_TIME — вся доступная статистика, включая текущий день;
 + CUSTOM_DATE — произвольный период. При выборе этого значения необходимо указать даты начала и окончания периода в параметрах DateFrom и DateTo.
 + AUTO — период, за который статистика могла измениться. Период выбирается автоматически в зависимости от того, произошла ли в предыдущий день корректировка статистики. Подробнее см. в разделе Как получить актуальную статистику.

<b>DateFrom и DateTo</b> - Начальная и конечная дата отчётного периода, необходимо указывать только в случае если в аргументе DateRangeType вы указали CUSTOM_DATE.

<b>FieldNames</b> - Строковый вектор содержащий названия полей которые вы хотите в результате получить, список доступных всех полей находится [тут](https://tech.yandex.ru/direct/doc/reports/fields-list-docpage/), при этом не все поля и типы отчётов совместимы между собой, если в результате запроса вы получили ошибку 400 проверьте все ли поля в вашем запросе между собой совместимы с помощью [этой таблицы](https://tech.yandex.ru/direct/doc/reports/compatibility-docpage/)

Подробное описание всех полей можно посмотреть по [этой ссылке.](https://tech.yandex.ru/direct/doc/reports/report-format-docpage/)

<b>FilterList</b> - Строковый вектор с описанием всех фильтров которые вы хотите применить к своим данным, пример FilterList = c("Clicks GREATER_THAN 99","Impressions LESS_THAN 1000"), в данном случае вы получите таблицу агрегированные значения в которых имеют более 99 кликов и при этом менее 1000 показов, все перечисленные условия имеют между собой логическую связь "И".

<b>IncludeVAT</b> - Включать ли НДС в денежные суммы в отчете. Если рекламодатель работает в у. е. Директа, допускается только значение YES. Принимает значения "YES" и "NO".

<b>IncludeDiscount</b> - Учитывать ли скидку для денежных сумм в отчете. Если рекламодатель работает в у. е. Директа, допускается только значение NO. Принимает значения "YES" и "NO".

<b>Login</b> - Строковое значение, ваш логин на Яндексе.

<b>Token</b> - Строковое значение, ваш API token.

### `yadirGetDictionary(DictionaryName = "GeoRegions", Language = "ru", login = NULL, token = NULL)`
Функция для загрузки справочников из API v.5. Яндекс Директ.

#### Аргументы
<b>DictionaryName</b> - Название справочника, принимает одно из следующих значений в текстовом виде.
<table>
 <tr>
    <td>DictionaryName</td><td>Описание</td>
 </tr>
 <tr>
    <td>AdCategories</td><td>Особые категории рекламируемых товаров и услуг.</td>
 </tr>
 <tr>
    <td>Constants</td><td>Ограничения на значения параметров.</td>
 </tr>
 <tr>
    <td>Currencies</td><td>Курсы валют, валютные параметры и ограничения.</td>
 </tr>
 <tr>
    <td>GeoRegions</td><td>Регионы.</td>
</tr>
 <tr>
    <td>MetroStations</td><td>Станции метрополитена (только для Москвы, Санкт-Петербурга и Киева).</td>
</tr>
 <tr>
    <td>OperationSystemVersions</td><td>мобильных приложений.</td>
</tr>
<tr>
    <td>ProductivityAssertions</td><td>Рекомендации по повышению продуктивности.</td>
</tr>
<tr>
    <td>TimeZones</td><td>Часовые пояса.</td>
</tr>
<tr>
    <td>SupplySidePlatforms</td><td>Внешние сети (SSP).</td>
</tr>
<tr>
    <td>Interests</td><td>Интересы к категориям мобильных приложений.</td>
 </tr>
</table>

<b>Language</b> - Язык предупреждений и сообщеий (не обязательный аргумент)

<b>login</b> - Строковое значение, ваш логин на Яндексе.

<b>token</b> - Строковое значение, ваш API token.

### `yadirGetCampaignListOld(logins = NULL, token = NULL)`
Устаревшая функцая для получения списка рекламных кампаний, список функций запрашивался с помощью метода GetCampaignList из версии API 4, с августе 2016 года этот метод стал недоступен, для того что бы получить список кампаний используйте новую  функцию`yadirGetCampaignList(logins = NULL, token = NULL)`.

### `yadirGetSummaryStat(campaignIDS = NULL, dateStart = Sys.Date() - 10, dateEnd = Sys.Date(), currency = "USD", token = NULL)`
Функция возвращает дата фрейм с общей статистикой в разрезе рекламных кампаний и дат.

#### Структура возвращаемого функцией `yadirGetSummaryStat` дата фрейма:
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

### `yadirCurrencyRates(login = NULL, token = NULL)`
Функция возвращает дата фрейм с актуальными курсами валют в Яндекс.Директ.

#### Структура возвращаемого функцией `yadirGetSummaryStat` дата фрейма:
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

### `yadirGetLogsData(counter = NULL, date_from = Sys.Date() - 10, date_to = Sys.Date(), fields = NULL, source = "visits", token = NULL)`
Функция для работы с Logs API Яндекс Метрики, которое позволяет выгрузить сырые данные.

#### Аргументы:
<b>counter</b> - номер счётчика Яндекс Метрики
<b>date_from</b> - начальная дата отчёта
<b>date_to</b> - конечная дата отчёта
<b>fields</b> - список полей которые вы отите получить, для visits актуальный список доступных полей можно получить [тут](https://tech.yandex.ru/metrika/doc/api2/logs/fields/visits-docpage/), для hits актуальный список полей можно получить [тут](https://tech.yandex.ru/metrika/doc/api2/logs/fields/hits-docpage/).
<b>source</b> - Источник логов, возможные значения hits — просмотры или visits — визиты

Подробное описание аргументов можно посмотреть [тут](https://tech.yandex.ru/metrika/doc/api2/logs/queries/class_logrequest-docpage/).

## Пример работы с пакетом ryandexdirect.

### Подключаем пакет ryandexdirect
`library(ryandexdirect)`

### Получаем токен для доступа к API
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
# Пример работы с функцией yadirGetReport и загрузки данных из сервиса Reports.
```
library(ryandexdirect)
myToken <- yadirGetToken()
My_report <- yadirGetReport(ReportType = "CAMPAIGN_PERFORMANCE_REPORT", 
                            DateRangeType = "CUSTOM_DATE", 
                            DateFrom = '2017-01-01', 
                            DateTo = '2017-01-31', 
                            FieldNames = c("CampaignName","Impressions","Clicks"), 
                            FilterList = c("Clicks GREATER_THAN 49","Impressions LESS_THAN 1001"), 
                            Login = <YourLogin>, 
                            Token = myToken)
```
Вместо <b>YourLogin</b> подставьте в виде строки ваш логин на Яндексе, для примеры работы с фильтрами данный запрос вернёт рекламные кампании по которым за выбранный период было более 49 кликов и менее 1001 показа. 

Данные в отчете можно агрегировать по различным периодам. Для этого укажите в аргументе FieldNames одно из значений Date, Week, Month, Quarter или Year.

# Пример работы с функцией yadirGetDictionary для загрузки справочников из API v.5. Яндекс Директ.
```
library(ryandexdirect)
myToken <- yadirGetToken()
Regions <- yadirGetDictionary(DictionaryName = "GeoRegions", 
                              Language = "ru", 
                              login = <YourLogin>, 
                              token = myToken
```
Вместо <b>YourLogin</b> подставьте в виде строки ваш логин на Яндексе, данный запрос загрузит в R справочник регионов Яндекс Директ.

# Пример работы с Logs API Яндекс Метрики.
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
## Как обратиться к API сервисов Яндекс.Директ и Яндекс.Метрика с помощью proxy сервера, необходимо в случае блокировки доступа к сервисам.
Для обхода блокировки API сервиса Яндекс.Директ, и Яндекс.Метрика необходимо сделать следующие действия:
+ Найти любой сервис генерирующий списки доступных прокси например [этот](https://hidemy.name/ru/proxy-list/)
+ Выбрать в фильтре тип прокси поддерживающий HTTPS.
+ Сформировать список доступных прокси серверов.
<p align="center">
<img src="http://img.netpeak.ua/alsey/149573200371_kiss_26kb.png" data-canonical-src="http://img.netpeak.ua/alsey/149573200371_kiss_26kb.png" style="max-width:100%;">
</p>
+ Далее нам понадобятся только IP адрес и порт прокси сервера (я обычно использую сервера с портом  3128):
<p align="center">
<img src="http://img.netpeak.ua/alsey/149573210236_kiss_41kb.png" data-canonical-src="http://img.netpeak.ua/alsey/149573210236_kiss_41kb.png" style="max-width:100%;">
</p>
+ В данном случае в качестве примера возьмём американский сервер который находится в третей строке списка IP 104.37.212.5 порт 3128, далее в код R перед функцией обращения к API необходимо направить интернет соединение через прокси сервер добавив в код строку
`Sys.setenv(https_proxy="http://104.37.212.5:3128")`
+ После пишем обычный код обращения к API.
+ После чего добавляем строку для отклчения интернет соединения от прокси сервера с помощью строки.
`Sys.unsetenv("https_proxy")`
+ В случае если прокси сервер требует прохождения аутентификации вы можете указать имя пользователя и пароль:
`Sys.setenv(https_proxy="http://user:password@proxy_server:port")`
+ Проверить установилась ли необходимая настройка соединения можно с помощью команды:
`Sys.getenv("https_proxy")`
+ Пример кода для обращения к API Яндекс.Директ через прокси сервер. В данном случае подразумевается что ранее вы уже получили токен доступа.
```
library(ryandexdirect)
Sys.setenv(https_proxy="http://104.37.212.5:3128")
My_report <- yadirGetReport(ReportType = "CAMPAIGN_PERFORMANCE_REPORT", 
                            DateRangeType = "CUSTOM_DATE", 
                            DateFrom = '2017-01-01', 
                            DateTo = '2017-01-31', 
                            FieldNames = c("CampaignName","Impressions","Clicks"), 
                            FilterList = c("Clicks GREATER_THAN 49","Impressions LESS_THAN 1001"), 
                            Login = <YourLogin>, 
                            Token = "897rn4jfk3jhfyb9ufjhkjdhks3390uui")
Sys.unsetenv("https_proxy")           
```

## Подборка статей с примерами работы с пакетом ryandexdirect.
+ [Как получить и обработать сырые данные из Яндекс.Метрики](https://netpeak.net/ru/blog/kak-poluchit-i-obrabotat-syrye-dannye-iz-yandeks-metriki/)
+ [Как связать Яндекс.Директ с Microsoft Power BI](https://netpeak.net/ru/blog/kak-svyazat-yandeks-direkt-s-microsoft-power-bi/)
+ [Подключение Power BI к Yandex.Metrika](http://pm-partner.ru/articles/114/591/)


 *Автор пакета: Алексей Селезнёв, Head of Analytics Dept. at Netpeak*
 
 [Image of Yaktocat](https://lh3.googleusercontent.com/R-0jgJSxIIhpag2L6YCIhJVIcIWx6-Jt5UCTRJjWzJewo47u2QBnik5CRF2dNB79jmsN_BFRjVOAYfvCqFcn3UNS_thGbbxF-99c9lwBWWlFI7JCWE43K5Yk9HnIW8i8YpTDx3l28IuYswaI-qc9QosHT1lPCsVilTfXTyV2empF4S74daOJ6x5QHYRWumT_2MhUS0hPqUsKVtOoveqDnGf3cF_VsN-RfOAwG9uCeGOgNRgv_fhSr41rw4LBND4gf05nO8zMp4TZMrrcUjKvvx6qNgYDor5LFOHiRmfKISYRVkWYe4wLyGO1FgkgTDjg0300lcur2t3txVwZUgROLZdaxOLx4owa8Rc8B8VKwd3vHxjov_aVfNPT4xf9jSFBBEOI-mfYpa55ejKDw-rqTQ6miFRFWpp_hjrk9KbGyB-Z6iZvYL-2dZ6mzgpUfs2I0tEAGsV07yTzboJ0RNCByC2-U-ZVjWdp2_9Au3FFoUcdQUAmPYOVqOv4r3oLbkkJKLj2A5jp7vf4IAoExLIfJuqEf7XN7fFcv4geib029qJjBt28wnqSO6TKEwB2fesR3uPHvGB6_6NHD70UDH-aCRCK4UBeoajtU0Y8Ks8Vwxo0oZBwmoEu8gudTFBF6mDT7GjLoGLDeNxE-TG7OtWUdxsJk7yzXGW3hE-VxsMD9g=s351-no)
 
 [GitHub](https://github.com/selesnow/)
 [VK](https://vk.com/selesnow)
 [Facebook](https://www.facebook.com/selesnow)
 [Linkedin](https://ua.linkedin.com/in/selesnow)
 [Stepik](https://stepik.org/users/792428)
  
<p align="center">
<img src="https://alexeyseleznev.files.wordpress.com/2017/03/as.png?w=300" data-canonical-src="https://alexeyseleznev.files.wordpress.com/2017/03/as.png?w=300" style="max-width:100%;">
</p>

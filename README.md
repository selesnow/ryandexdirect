# ryandexdirect - пакет для работы с API Яндекс.Директ версии 4, Live 4 и 5, а так же с Logs API Яндекс метрики на языке R.

## Содержание
+ [Краткое описание](#краткое-описание)
+ [Установка пакета ryandexdirect](#установка-пакета-ryandexdirect)
+ [Функции входящие в пакет ryandexdirect](#функции-входящие-в-пакет-ryandexdirect)
    + [yadirGetToken](#yadirgettoken) - Получение токена доступа
    + [yadirGetClientList](#yadirgetclientlisttoken--null) - Получение списка клиентов для агентского аккаунта
    + [yadirGetClientParam](#yadirgetclientparamlanguage--ru-login--null-token--null) - Получение параметров аккаунта Яндекс Директ
    + [yadirGetCampaignList](#yadirgetcampaignlistlogins--null-token--null) - Получения списка рекламных кампаний
    + [yadirGetAdGroups](#yadirgetadgroupscampaignids--c123login--null-token--null) - Получения списка групп объявлений
    + [yadirGetKeyWords](#yadirgetkeywordscampaignids--c123-withstats--t-login--null-token--null) - Получения списка ключевых слов
    + [yadirGetAds](#yadirgetadscampaignids--c123-login--null-token--null) - Получения списка объявлений
    + [yadirGetBalance]() - Получить остаток средств общего счёта и его различные параметры.
    + [yadirGetReport](#yadirgetreportreporttype--campaign_performance_report-daterangetype--last_month-datefrom--null-dateto--null-fieldnames--ccampaignnameimpressionsclickscost-filterlist--null-includevat--no-includediscount--no-login--null-token--null) - Получение статистики из Report сервиса API v.5.
    + [yadirGetDictionary](#yadirgetdictionarydictionaryname--georegions-language--ru-login--null-token--null) - Получение справочной информации из API v.5.
    + [yadirStartAds](#yadirstartadslogin--null-ids--null-token--null) - Возобновить показы по объявлениям.
    + [yadirStopAds](#yadirstopadslogin--null-ids--null-token--null) - Остановить показы по объявлениям.
    + [yadirStartCampaigns](#yadirstartcampaignslogin--null-ids--null-token--null) - Возобновить показы по рекламным кампаниям
    + [yadirStopCampaigns](#yadirstopcampaignslogin--null-ids--null-token--null) - Остановить показы по рекламным кампаниям
    + [yadirStartKeyWords](#yadirstartkeywordslogin--null-ids--null-token--null) - Возобновить показы по ключевым словам
    + [yadirStopKeyWords](#yadirstopkeywordslogin--null-ids--null-token--null) - Остановить показы по ключевым словам
    + [yadirGetSummaryStat](#yadirgetsummarystatcampaignids--null-datestart--sysdate---10-dateend--sysdate-currency--usd-token--null) - Получение общей статистики по рекламным кампаниям
    + [yadirCurrencyRates](#yadircurrencyrateslogin--null-token--null) - Получения текущих курсов валют (С 28.03.2017 справочник валют так же можно получить с помощью функции yadirGetDictionary)
    + [yadirGetLogsData](#yadirgetlogsdatacounter--null-date_from--sysdate---10-date_to--sysdate-fields--null-source--visits-token--null) - Получение данных из Logs API Яндекс Метрики
    + [yadirGetMetrikaGAData](#yadirgetmetrikagadatastart_date--10daysago-end_date--today-counter_ids--null-dimensions--null-metrics--null-filters--null-sort--null-samplinglevel--higher_precision-token--null) - Получение данных из API Яндекс Метрики совместимым с Google Analytics Core Reporting API (v3)
+ [Пример работы с пакетом ryandexdirect](#пример-работы-с-пакетом-ryandexdirect)
+ [Пример работы с функцией yadirGetReport](#пример-работы-с-функцией-yadirgetreport-и-загрузки-данных-из-сервиса-reports) - Загрузка данных из сервиса Reports
+ [Пример работы с функцией yadirGetDictionary](#пример-работы-с-функцией-yadirgetdictionary-для-загрузки-справочников-из-api-v5-Яндекс-Директ) - загрузки справочников из API v.5. Яндекс Директ
+ [Пример работы с Logs API Яндекс Метрики](#пример-работы-с-logs-api-Яндекс-Метрики) - Загрузка сырых данных из Яндекс Метрики
+ [Пример работы с API Яндекс Метрики совместимым с Google Analytics Core Reporting API (v3)](#пример-работы-с-api-Яндекс-Метрики-совместимым-с-google-analytics-core-reporting-api-v3)
+ [Как обратится к API сервисов Яндекс.Директ и Яндекс.Метрика через прокси сервер](#как-обратиться-к-api-сервисов-ЯндексДирект-и-ЯндексМетрика-с-помощью-proxy-сервера-необходимо-в-случае-блокировки-доступа-к-сервисам).
+ [Подборка статей с примерами работы с пакетом ryandexdirect](#подборка-статей-с-примерами-работы-с-пакетом-ryandexdirect)

## краткое описание.

Пакет ryandexdirect предназначен для загрузки данных из Яндекс Директ и Яндекс Метрики в R, с помощью функций данного пакета вы можете работать с перечисленными ниже сервисами и службами API Яндекса с помощью готовых функций, не углубляясь при этом в документацию по работе с этими API сервисами.

+ [Сервис Reports](https://tech.yandex.ru/direct/doc/reports/reports-docpage/) - Предназначен для получения статистики по аккаунту рекламодателя.
+ [Logs API Яндекс Метрики](https://tech.yandex.ru/metrika/doc/api2/logs/intro-docpage/) - Logs API позволяет получать неагрегированные данные, собираемые Яндекс.Метрикой. Данный API предназначен для пользователей сервиса, которые хотят самостоятельно обрабатывать статистические данные и использовать их для решения уникальных аналитических задач.
+ [API Директа версии 4 и Live 4](https://tech.yandex.ru/direct/doc/dg-v4/concepts/About-docpage/) - Через API внешние приложения добавляют и редактируют кампании, объявления, фразы, задают ставки, получают статистику показов.
+ [API Директа версии 5](https://tech.yandex.ru/direct/doc/dg/concepts/about-docpage/) - Через API внешние приложения добавляют и редактируют кампании, объявления, фразы, задают ставки, получают статистику показов.

## установка пакета ryandexdirect.

Установка пакета осуществляется из репозитория GitHub, для этого сначала требуется установить и подключить пакет devtools.

`install.packages("devtools")`

`library(devtools)`

После чего можно устанавливать пакет ryandexdirect.
### установка на Windows осуществляется с помощью следующей команды
`install_github('selesnow/ryandexdirect')`

### установка на iOS, Linux, Ubuntu осуществляется с помощью следующей команды
`install_github('selesnow/ryandexdirect', subdir = "utf8")`

## функции входящие в пакет ryandexdirect.

На данный момент в версию пакета 2.4.4 входит 13 функции:

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

   </tr>
    <tr>
         <td>CampaignsTotalPerClient</td><td>int</td><td>Максимальное количество кампаний у рекламодателя.</td>

   </tr>
    <tr>
         <td> CampaignsUnarchivePerClient</td><td>int</td><td>максимальное количество кампаний, не находящихся в архиве.</td>
    </tr>
    <tr>
         <td>APIPoints</td><td>int</td><td>Суточный лимит баллов API.</td>
    </tr>
</table>

### `yadirGetCampaignList(Logins = NULL, States = c("OFF","ON","SUSPENDED","ENDED","CONVERTED","ARCHIVED"),Types = c("TEXT_CAMPAIGN","MOBILE_APP_CAMPAIGN","DYNAMIC_TEXT_CAMPAIGN"), Statuses = c("ACCEPTED","DRAFT","MODERATION","REJECTED"), StatusesPayment = c("DISALLOWED","ALLOWED"), Token = NULL)`
          
Функция возвращает дата фрейм со списком рекламных кампаний и некоторых их параметров по логину.

#### Аргументы:
<b>Login</b> - Вектор с логинами на Яндексе

<b>States</b> - На вход принимает текстовый вектор, используется для для фильтрации кампаний в указанных состояниях. Описание состояний см. в разделе [Статус и состояние кампании.](https://tech.yandex.ru/direct/doc/dg/objects/campaign-docpage/#status), допустимые значения ( "ARCHIVED" | "CONVERTED" | "ENDED" | "OFF" | "ON" | "SUSPENDED" ), пример использования (c("ON","SUSPENDED","CONVERTED"))
+ Допустимые значения: ARCHIVED, CONVERTED, ENDED, OFF, ONSUSPENDED
+ Пример использования: States = c("ON","SUSPENDED","CONVERTED")
        
<b>Types</b> - На вход принимает текстовый вектор, используется для фильтрации кампаний по типам, См.  [Тип кампании](https://tech.yandex.ru/direct/doc/dg/objects/campaign-docpage/#type).
+ Допустимые значения: TEXT_CAMPAIGN, MOBILE_APP_CAMPAIGN, DYNAMIC_TEXT_CAMPAIGN
+ Пример использования: Types = c("TEXT_CAMPAIGN", "DYNAMIC_TEXT_CAMPAIGN")
        
<b>Statuses</b> - На вход принимает текстовый вектор, используется для фильтрации кампаний по указанными статусами. Описание статусов см. в разделе [Статус и состояние кампании](https://tech.yandex.ru/direct/doc/dg/objects/campaign-docpage/#status).*
+ Допустимые значения: ACCEPTED, DRAFT, MODERATION, REJECTED
+ Пример использования: Statuses = c("DRAFT", "REJECTED")
        
<b>StatusesPayment</b> - На вход принимает текстовый вектор, используется для фильтрации кампаний по указанным статусам оплаты. Описание статусов см. в разделе [Статус и состояние кампании.](https://tech.yandex.ru/direct/doc/dg/objects/campaign-docpage/#status).*
+ Допустимые значения: DISALLOWED, ALLOWED
+ Пример использования: Statuses = c("DISALLOWED", "ALLOWED")
        
<b>Token</b> - Токен дотупа к API

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
        <td>Impressions</td><td>int</td><td>Количество показов за время существования кампании.</td>
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

### `yadirGetAdGroups(CampaignIds = c(1,2,3),Login = NULL, Token = NULL)`
Функция возвращает дата фрейм со списком групп объявлений и некоторых их параметров по логину.

#### Аргументы:
<b>CampaignIds</b> - Вектор с ID рекламных кампаний, по которым необходимо загрузить список групп объявлений

<b>Login</b> - Логин на Яндексе

<b>Token</b> - Токен дотупа к API

#### Структура возвращаемого функцией `yadirGetAdGroups` дата фрейма:
<table>
    <tr>
        <td><center>Поле</center></td><td><center>Тип данных</center></td><td><center>Описание</center></td>
    </tr>
    <tr>
        <td>Id</td><td>num</td><td>Идентификатор группы объявлений.</td>
    </tr>
    <tr>
        <td>Name</td><td>Factor</td><td>Название группы.</td>
    </tr>
    <tr>
        <td>CampaignId</td><td>int</td><td>Идентификатор кампании.</td>
    </tr>
    <tr>
        <td>Type</td><td>Factor</td><td>Тип группы объявлений. <a href="https://tech.yandex.ru/direct/doc/dg/objects/adgroup-docpage/#types">См. Тип группы.</a></td>
    </tr>
    <tr>
        <td>Subtype</td><td>Factor</td><td>Подтип группы объявлений. Для групп с типом, отличным от DYNAMIC_TEXT_AD_GROUP, возвращается значение NONE.</td>
    </tr>
    <tr>
        <td>Status</td><td>Factor</td><td>Статус группы. <a href="https://tech.yandex.ru/direct/doc/dg/objects/adgroup-docpage/#status">См. Статус группы.</a></td>
    </tr>
    <tr>
        <td>ServingStatus</td><td>Factor</td><td>Статус возможности показов группы. <a href="https://tech.yandex.ru/direct/doc/dg/objects/adgroup-docpage/#serving-status">См. Статус возможности показов группы.</a></td>
    </tr>
    <tr>
        <td>NegativeKeywords</td><td>chr</td><td>Минус-фразы, общие для всех ключевых фраз группы объявлений.</td>
    </tr>
    <tr>
        <td>TrackingParams</td><td>Factor</td><td>ET-параметры для отслеживания источников переходов на сайт, которые добавляются в ссылку всех объявлений группы (не более 1024 символов). Могут содержать <a href="https://yandex.ru/support/direct/statistics/url-tags.html">подстановочные переменные.</a>
Например: from=direct&ad={ad_id}
Параметр можно указать для группы любого типа, однако в настоящее время он используется только для групп динамических объявлений. Для других типов групп указанные GET-параметры в ссылку не добавляются.</td>
    </tr>
    <tr>
        <td>RegionIds</td><td>Factor</td><td>Идентификаторы регионов, для которых показы включены или выключены.
Идентификатор 0 — показывать во всех регионах.
Минус перед идентификатором региона — выключить показы в данном регионе. Например [1,-219] — показывать для Москвы и Московской области, кроме Черноголовки.</td>
    </tr>
    <tr>
        <td>RestrictedRegionIds</td><td>chr</td><td>Идентификаторы регионов, в которых объявления не будут показаны в связи с законодательными ограничениями.</td>
    </tr>
    <tr>
        <td>MobileAppAdGroupStoreUrl</td><td>chr</td><td>Ссылка на приложение в магазине приложений AppStore или Google Play (не более 1024 символов). Должна содержать протокол. Недоступна для изменения.</td>
    </tr>
    <tr>
        <td>MobileAppAdGroupTargetDeviceType</td><td>chr</td><td>	На каких устройствах показывать объявления:
 DEVICE_TYPE_MOBILE — смартфоны;
 DEVICE_TYPE_TABLET — планшеты.</td>
    </tr>
    <tr>
    <td>MobileAppAdGroupTargetCarrier</td><td>chr</td><td>По каким типам подключения к интернету показывать объявления:
WI_FI_ONLY — только по Wi-FI;
WI_FI_AND_CELLULAR — по мобильной связи и Wi-Fi.</td>
    </tr>
    <tr>
    <td>MobileAppAdGroupTargetOperatingSystemVersion</td><td>chr</td><td>Минимальная версия операционной системы, на которой может быть показано объявление. Например, 2.3.
Примечание. Если минимальная версия ОС в магазине приложений выше, чем заданная в параметре, то объявления будут показаны только для версий ОС как в магазине приложений или выше.</td>
    </tr>
    <tr>
    <td>MobileAppAdGroupAppIconModerationStatus</td><td>chr</td><td>Результат модерации иконки мобильного приложения:
 ACCEPTED — принята модерацией;
 MODERATION — находится на модерации;
 REJECTED — отклонена.</td>
    </tr>
    <tr>
    <td>MobileAppAdGroupAppIconModerationStatusClarification</td><td>chr</td><td>Текстовое пояснение к статусу и/или причины отклонения на модерации.</td>
    </tr>
    <tr>
    <td>MobileAppAdGroupAppOperatingSystemType</td><td>chr</td><td>Тип операционной системы (определяется автоматически на основании данных из магазина приложений):
IOS — iOS;
ANDROID — Android;
OS_TYPE_UNKNOWN — данные из магазина приложений еще не получены.</td>
    </tr>
    <tr>
    <td>MobileAppAdGroupAppAvailabilityStatus</td><td>chr</td><td>Доступно ли приложение в магазине приложений:
 AVAILABLE — доступно;
 NOT_AVAILABLE — недоступно;
 UNPROCESSED — данные из магазина приложений еще не получены.</td>
    </tr>
    <tr>
    <td>DynamicTextAdGroupDomainUrl</td><td>chr</td><td>Доменное имя сайта, для которого требуется сгенерировать динамические объявления (не более 100 символов). Протокол указывать не нужно.</td>
    </tr>
    <tr>
    <td>DynamicTextAdGroupDomainUrlProcessingStatus</td><td>chr</td><td>Статус генерации динамических объявлений:
 UNPROCESSED — генерация объявлений не завершена;
 PROCESSED — объявления созданы;
 EMPTY_RESULT — не удалось создать ни одного объявления.</td>
    </tr>
    <tr>
    <td>DynamicTextFeedAdGroupSource</td><td>chr</td><td>Идентификатор фида.</td>
    </tr>
    <tr>
    <td>DynamicTextFeedAdGroupSourceType</td><td>chr</td><td>Тип источника данных. В настоящее время доступно только значение RETAIL_FEED. фида.</td>
    </tr>
    <tr>
    <td>DynamicTextFeedAdGroupSourceProcessingStatus</td><td>chr</td><td>Статус генерации динамических объявлений:
 UNPROCESSED — генерация объявлений не завершена;
 PROCESSED — объявления созданы;
 EMPTY_RESULT — не удалось создать ни одного объявления.</td>
    </tr>
</table>

#### Пример кода для получения списка групп объявлений:
```
#Подключаем пакет
library(ryandexdirect)
#Получаем API token
my_token <- yadirGetToken()
#Получаем список рекламных кампаний
my_campaign <- yadirGetCampaignList(login = <ВАШ ЛОГИН>, 
                                    token = my_token)
#Получаем данные по группам объявлений
my_adgroups <- yadirGetAdGroups(CampaignIds = my_campaign$Id, 
                                Login = <ВАШ ЛОГИН>, 
                                Token = my_token)
```

### `yadirGetKeyWords(CampaignIds = c(1,2,3), WithStats = T, Login = NULL, Token = NULL)`
Функция возвращает дата фрейм со списком групп объявлений и некоторых их параметров по логину.

#### Аргументы:
<b>CampaignIds</b> - Вектор с ID рекламных кампаний, по которым необходимо загрузить список групп объявлений

<b>WithStats</b> - Логическое TRUE или FALSE, аргумент отвечает за загрузку статистики по показам и кликам, в случае если вы установите значение TRUE время работы функции будет значительно дольше.

<b>Login</b> - Логин на Яндексе

<b>Token</b> - Токен дотупа к API

#### Структура возвращаемого функцией `yadirGetKeyWords` дата фрейма:
<table>
    <tr>
        <td><center>Поле</center></td><td><center>Тип данных</center></td><td><center>Описание</center></td>
    </tr>
    <tr>
        <td>Id</td><td>num</td><td>Идентификатор ключевой фразы.</td>
    </tr>
    <tr>
        <td>Keyword</td><td>Factor</td><td>Ключевая фраза. Может содержать минус-слова.</td>
    </tr>
    <tr>
        <td>AdGroupId</td><td>num</td><td>Идентификатор группы объявлений, к которой относится ключевая фраза.</td>
    </tr>
    <tr>
        <td>CampaignId</td><td>int</td><td>Идентификатор кампании, к которой относится ключевая фраза.</td>
    </tr>
    <tr>
        <td>ServingStatus</td><td>Factor</td><td>Статус возможности показов группы объявлений. Описание статусов см. в разделе <a href="https://tech.yandex.ru/direct/doc/dg/objects/adgroup-docpage/#serving-status">Статус возможности показов группы.</a></td>
    </tr>
    <tr>
        <td>State</td><td>Factor</td><td>Состояние ключевой фразы. Описание состояний см. в разделе <a href="https://tech.yandex.ru/direct/doc/dg/objects/keyword-docpage/#status">Статус и состояние фразы.</a></td>
    </tr>
    <tr>
        <td>Status</td><td>Factor</td><td>Статус ключевой фразы. Описание статусов см. в разделе <a href="https://tech.yandex.ru/direct/doc/dg/objects/keyword-docpage/#status">Статус и состояние фразы.</a></td>
    </tr>
    <tr>
        <td>StrategyPriority</td><td>Factor</td><td>Приоритет фразы: LOW, NORMAL или HIGH.</td>
    </tr>
    <tr>
        <td>StatisticsSearchImpressions</td><td>int</td><td>Количество показов всех объявлений группы в поиске по данной фразе. Рассчитывается за 28 дней от текущей даты. Для расчета отбираются дни, в течение которых был хотя бы один показ объявления по данной фразе.</td>
    </tr>
    <tr>
        <td>StatisticsSearchClicks </td><td>int</td><td>Количество кликов по всем объявлениям группы в поиске, показанным по данной фразе. Рассчитывается за 28 дней от текущей даты. Для расчета отбираются дни, в течение которых был хотя бы один клик по объявлению.</td>
    </tr>
    <tr>
        <td>StatisticsNetworkImpressions</td><td>int</td><td>Количество показов всех объявлений группы по данной фразе в сетях. Рассчитывается за 28 дней от текущей даты. Для расчета отбираются дни, в течение которых был хотя бы один показ объявления по данной фразе.</td>
    </tr>
    <tr>
        <td>StatisticsNetworkClicks</td><td>int</td><td>Количество кликов по всем объявлениям группы, показанным по данной фразе в сетях. Рассчитывается за 28 дней от текущей даты. Для расчета отбираются дни, в течение которых был хотя бы один клик по объявлению.</td>
    </tr>
    <tr>
        <td>UserParam1</td><td>Factor</td><td>Значение <a href="https://tech.yandex.ru/direct/doc/dg/objects/keyword-docpage/#userparams">подстановочной переменной</a> {param1}. Не более 255 символов.</td>
    </tr>
    <tr>
        <td>UserParam2</td><td>Factor</td><td>Значение <a href="https://tech.yandex.ru/direct/doc/dg/objects/keyword-docpage/#userparams">подстановочной переменной</a> {param2}. Не более 255 символов.</td>
    </tr>
    <tr>
    <td>ProductivityValue</td><td>num</td><td>Значение продуктивности фразы (до 1 знака после запятой).</td>
    </tr>
    <tr>
    <td>ProductivityReferences</td><td>Factor</td><td>Массив номеров рекомендаций для данной фразы. Справочник рекомендаций можно получить с помощью функции yadirGetDictionary, указав в качестве параметра DictionaryName "ProductivityAssertions".</td>
    </tr>
    <tr>
    <td>Bid</td><td>num</td><td>Ставка на поиске.</td>
    </tr>
    <tr>
    <td>ContextBid</td><td>num</td><td>Ставка в сетях.</td>
    </tr>
</table>

#### Пример кода для получения списка ключевых слов:
```
#Подключаем пакет
library(ryandexdirect)
#Получаем API token
my_token <- yadirGetToken()
#Получаем список рекламных кампаний
my_campaign <- yadirGetCampaignList(login = <ВАШ ЛОГИН>, 
                                    token = my_token)
#Получаем данные по ключевым словам
my_keywords <- yadirGetKeyWords(CampaignIds = my_campaign$Id, 
                                WithStats = F,
                                Login = <ВАШ ЛОГИН>, 
                                Token = my_token)
```

### `yadirGetAds(CampaignIds = c(1,2,3), Login = NULL, Token = NULL)`
Функция возвращает дата фрейм со списком групп объявлений и некоторых их параметров по логину.

#### Аргументы:
<b>CampaignIds</b> - Вектор с ID рекламных кампаний, по которым необходимо загрузить список групп объявлений

<b>Login</b> - Логин на Яндексе

<b>Token</b> - Токен дотупа к API

#### Структура возвращаемого функцией `yadirGetAds` дата фрейма:
<table>
    <tr>
        <td><center>Поле</center></td><td><center>Тип данных</center></td><td><center>Описание</center></td>
    </tr>
    <tr>
        <td>Id</td><td>num</td><td>Идентификатор объявления.</td>
    </tr>
    <tr>
        <td>AdGroupId</td><td>num</td><td>Идентификатор группы объявлений, к которой относится объявление.</td>
    </tr>
    <tr>
        <td>CampaignId</td><td>int</td><td>Идентификатор кампании, к которой относится объявление.</td>
    </tr>
    <tr>
        <td>Type</td><td>Factor</td><td>Тип объявления. См. <a href="https://tech.yandex.ru/direct/doc/dg/objects/ad-docpage/#types">Тип объявления.</a></td>
    </tr>
    <tr>
        <td>Subtype</td><td>Factor</td><td>одтип объявления. Для объявлений с типом, отличным от IMAGE_AD, возвращается значение NONE.</td>
    </tr>
    <tr>
        <td>Status</td><td>Factor</td><td>Статус объявления. Описание статусов см. в разделе <a href="https://tech.yandex.ru/direct/doc/dg/objects/ad-docpage/#status">Статус и состояние объявления.</a></td>
    </tr>
    <tr>
        <td>AgeLabel</td><td>chr</td><td><a href="https://tech.yandex.ru/direct/doc/dg/objects/ad-docpage/#age">Возрастная метка.</a></td>
    </tr>
    <tr>
        <td>State</td><td>int</td><td>Состояние объявления. Описание состояний см. в разделе <a href="https://tech.yandex.ru/direct/doc/dg/objects/ad-docpage/#status">Статус и состояние объявления.</a></td>
    </tr>
    <tr>
        <td>TextAdTitle</td><td>Factor</td><td>Заголовок 1.
Не более 35 символов без учета «узких» плюс не более 15 «узких» символов. Каждое слово не более 22 символов. В случае использования <a href="https://yandex.ru/support/direct/features/ad-templates.html">шаблона</a> символы # не учитываются в длине).</td>
    </tr>
    <tr>
        <td>TextAdTitle2</td><td>chr</td><td>Заголовок 2.
Не более 30 символов без учета «узких» плюс не более 15 «узких» символов. Каждое слово не более 22 символов. В случае использования <a href="https://yandex.ru/support/direct/features/ad-templates.html">шаблона</a> символы # не учитываются в длине).</td>
    </tr>
    <tr>
        <td>TextAdText</td><td>Factor</td><td>Текст объявления.
Не более 81 символа без учета «узких» плюс не более 15 «узких» символов. Каждое слово не более 23 символов. В случае использования <a href="https://yandex.ru/support/direct/features/ad-templates.html">шаблона</a> символы # не учитываются в длине).</td>
    </tr>
    <tr>
        <td>TextAdHref</td><td>Factor</td><td>Ссылка на сайт рекламодателя.</td>
    </tr>
    <tr>
        <td>TextAdDisplayDomain</td><td>Factor</td><td>Рекламируемый домен. Определяется автоматически на основе ссылки объявления.</td>
    </tr>
    <tr>
    <td>TextAdMobile</td><td>Factor</td><td>Признак того, что объявление является мобильным: YES или NO.</td>
    </tr>
    <tr>
    <td>TextImageAdHref</td><td>chr</td><td>Хэш изображения.
Для текстово-графических объявлений подходят только изображения с типом REGULAR и WIDE.</td>
    </tr>
</table>

#### Пример кода для получения списка ключевых слов:
```
#Подключаем пакет
library(ryandexdirect)
#Получаем API token
my_token <- yadirGetToken()
#Получаем список рекламных кампаний
my_campaign <- yadirGetCampaignList(login = <ВАШ ЛОГИН>, 
                                    token = my_token)
#Получаем данные по ключевым словам
my_ads <- yadirGetAds(CampaignIds = my_campaign$Id, 
                      Login = <ВАШ ЛОГИН>, 
                      Token = my_token)
```

### `yadirGetBalance(Logins = NULL, Token = NULL)`
Функция предназначена для загрузки остатка средств из общего счёта аккаунта рекламодателя, либо аккаунта клиента агентства со всеми доступными параметрами общего счёта.

#### Аргументы:
<b>Logins</b> - Текстовый вектор содердащий Логин аккаунта рекламодателя на Яндексе, либо логин клиента агентсва.

<b>Token</b> - Токен дотупа к API

#### Структура возвращаемого функцией `yadirGetBalance` дата фрейма:
<table>
    <tr>
        <td><center>Поле</center></td><td><center>Тип данных</center></td><td><center>Описание</center></td>
    </tr>
    <tr>
        <td>Amount</td><td>chr</td><td>Текущий баланс общего счета (в валюте общего счета, указанной в параметре Currency).</td>
    </tr>
    <tr>
        <td>AccountID</td><td>int</td><td>Идентификатор общего счета.</td>
    </tr>
    <tr>
        <td>Discount</td><td>int</td><td>Текущая скидка рекламодателя (в процентах). В настоящее время не применяется.</td>
    </tr>
    <tr>
        <td>Login</td><td>chr</td><td>Логин рекламодателя — владельца общего счета.</td>
    </tr>
    <tr>
        <td>AmountAvailableForTransfer</td><td>chr</td><td>Сумма, доступная для перевода с помощью операции TransferMoney (в валюте, указанной в параметре Currency).</td>
    </tr>
    <tr>
        <td>Currency</td><td>chr</td><td>Валюта общего счета. Возможные значения: RUB, CHF, EUR, KZT, TRY, UAH, USD, BYN. Если параметр отсутствует или равен NULL, подразумеваются условные единицы (у. е.).</td>
    </tr>
    <tr>
        <td>AgencyName</td><td>chr</td><td>Название рекламного агентства, обслуживающего счет. Для счетов, обслуживаемых рекламодателем самостоятельно, параметр отсутствует или равен NULL</td>
    </tr>
    <tr>
        <td>SmsNotification.MoneyInSms</td><td>chr</td><td>Сообщать об зачислении средств на общий счет — Yes/No.</td>
    </tr>
    <tr>
        <td>SmsNotification.SmsTimeTo</td><td>chr</td><td>Время, до которого разрешено отправлять SMS о событиях, связанных с общим счетом. Указывается в формате HH:MM, минуты задают кратно 15 (0, 15, 30, 45).</td>
    </tr>
    <tr>
        <td>SmsNotification.SmsTimeFrom</td><td>chr</td><td>Время, начиная с которого разрешено отправлять SMS о событиях, связанных с общим счетом. Указывается в формате HH:MM, минуты задают кратно 15 (0, 15, 30, 45).</td>
    </tr>
    <tr>
        <td>SmsNotification.MoneyOutSms</td><td>chr</td><td>Сообщать об исчерпании средств на общем счете — Yes/No.</td>
    </tr>
    <tr>
        <td>EmailNotification.MoneyWarningValue</td><td>int</td><td>Минимальный баланс, при уменьшении до которого отправляется уведомление. Задается в процентах от суммы последнего платежа. Предустановленное значение — 20.</td>
    </tr>
    <tr>
        <td>EmailNotification.SendWarn</td><td>logi</td><td>Отправлять оповещение на почту о том что закончились средства на основном счёте.</td>
    </tr>
    <tr>
        <td>EmailNotification.Email</td><td>chr</td><td>Адрес электронной почты для отправки уведомлений, связанных с общим счетом.</td>
 </tr>
</table>

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

<b>Login</b> - Строковое вектор содержащий логины на Яндексе по которым необходимо получить данные.

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

### `yadirStartAds(Login = NULL, Ids   = NULL, Token = NULL)`
Функция возобновляет показ по объявлениям и возвращает вектор с Id объявлений, по котором не удалось возобновить показы.

#### Аргументы
<b>Ids</b> - Числовой или текстовый вектор, содержащий Id объявлений по которым необходимо возобновить показ объявлений.

<b>Login</b> - Строковое значение, ваш логин на Яндексе.

<b>Token</b> - Строковое значение, ваш API token.

#### Пример кода для возобновления показа объявлений
```
#Получаем токен
tok <- yadirGetToken()

#Получаем список рекламных кампаний
my_camp <- yadirGetCampaignList(Login = "Логин", Token = tok)

#Получаем список остановленных и выключенных объявлений
my_ads <- yadirGetAds(Login = "Логин", Token = tok, States = c("SUSPENDED","OFF"))

#Возобнолвям показы объявлений
err <- yadirStartAds(Login = "Логин", Token =  tok, Ids = my_ads$Id) 
```

### `yadirStopAds(Login = NULL, Ids   = NULL, Token = NULL)`
Функция останавливает показ по объявлениям и возвращает вектор с Id объявлений, по котором не удалось возобновить показы.

#### Аргументы
<b>Ids</b> - Числовой или текстовый вектор, содержащий Id объявлений по которым необходимо остановить показ.

<b>Login</b> - Строковое значение, ваш логин на Яндексе.

<b>Token</b> - Строковое значение, ваш API token.

#### Пример кода для остановки показа объявлений
```
#Получаем токен
tok <- yadirGetToken()

#Получаем список рекламных кампаний
my_camp <- yadirGetCampaignList(Login = "Логин", Token = tok)

#Получаем список остановленных и выключенных объявлений
my_ads <- yadirGetAds(Login = "Логин", Token = tok, States = "ON")

#Останавливаем показы объявлений
err <- yadirStopAds(Login = "Логин", Token =  tok, Ids = my_ads$Id) 
```

### `yadirStartCampaigns(Login = NULL, Ids   = NULL, Token = NULL)`
Функция возобновляет показ по объявлениям по рекламным кампаниям и возвращает вектор с Id рекламных кампаний, по котором не удалось возобновить показы.

#### Аргументы
<b>Ids</b> - Числовой или текстовый вектор, содержащий Id рекламных кампаний по которым необходимо возобновить показ объявлений.

<b>Login</b> - Строковое значение, ваш логин на Яндексе.

<b>Token</b> - Строковое значение, ваш API token.

#### Пример кода для возобновления показа объявлений по рекламым кампаниям
```
#Получаем токен
tok <- yadirGetToken()

#Получаем список рекламных кампаний
my_camp <- yadirGetCampaignList(Login = "Логин", Token = tok)

#Возобнолвям показы объявлений
err <- yadirStartCampaigns(Login = "LOGIN", Token =  tok, Ids = my_camp$Id) 
```

### `yadirStopCampaigns(Login = NULL, Ids   = NULL, Token = NULL)`
Функция останавливает показ по объявлениям по рекламным кампаниям и возвращает вектор с Id рекламных кампаний, по котором не удалось возобновить показы.

#### Аргументы
<b>Ids</b> - Числовой или текстовый вектор, содержащий Id рекламных кампаний по которым необходимо остановить показ объявлений.

<b>Login</b> - Строковое значение, ваш логин на Яндексе.

<b>Token</b> - Строковое значение, ваш API token.

#### Пример кода для остановки показа объявлений по рекламным кампаниям
```
#Получаем токен
tok <- yadirGetToken()

#Получаем список рекламных кампаний
my_camp <- yadirGetCampaignList(Login = "Логин", Token = tok)

#Останавливаем показы объявлений
err <- yadirStopCampaigns(Login = "LOGIN", Token =  tok, Ids = my_camp$Id) 
```

### `yadirStartKeyWords(Login = NULL, Ids   = NULL, Token = NULL)`
Функция возобновляет показ объявлений по ключевым словам и возвращает вектор с Id ключевых слов, по котором не удалось возобновить показы.

#### Аргументы
<b>Ids</b> - Числовой или текстовый вектор, содержащий Id ключевых словй по которым необходимо возобновить показ объявлений.

<b>Login</b> - Строковое значение, ваш логин на Яндексе.

<b>Token</b> - Строковое значение, ваш API token.

#### Пример кода для возобновления показа объявлений по ключевым словам
```
#Получаем токен
tok <- yadirGetToken()

#Получаем список рекламных кампаний
my_camp <- yadirGetCampaignList(Login = "Логин", Token = tok)

#Получаем список ключевых слов
my_kw <- yadirGetKeyWords(Login = "Логин", Token = tok,CampaignIds = my_camp$Id[1:10])

#Возобнолвям показы объявлений
err <- yadirStartCampaigns(Login = "Логин", Token =  tok, Ids = my_kw$Id) 
```

### `yadirStopKeyWords(Login = NULL, Ids   = NULL, Token = NULL)`
Функция останавливает показ объявлениям по ключевым словам и возвращает вектор с Id ключевых слов, по котором не удалось возобновить показы.

#### Аргументы
<b>Ids</b> - Числовой или текстовый вектор, содержащий Id ключевых слов по которым необходимо остановить показ объявлений.

<b>Login</b> - Строковое значение, ваш логин на Яндексе.

<b>Token</b> - Строковое значение, ваш API token.

#### Пример кода для остановки показа объявлений по ключевым словам
```
#Получаем токен
tok <- yadirGetToken()

#Получаем список рекламных кампаний
my_camp <- yadirGetCampaignList(Login = "Логин", Token = tok)

#Получаем список ключевых слов
my_kw <- yadirGetKeyWords(Login = "Логин", Token = tok,CampaignIds = my_camp$Id[1:10])

#Останавливаем показы объявлений
err <- yadirStopKeyWords(Login = "Логин", Token =  tok, Ids = my_kw$Id) 
```

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

#### Структура возвращаемого функцией `yadirCurrencyRates` дата фрейма:
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
* <b>counter</b> - номер счётчика Яндекс Метрики
* <b>date_from</b> - начальная дата отчёта
* <b>date_to</b> - конечная дата отчёта
* <b>fields</b> - список полей которые вы отите получить, для visits актуальный список доступных полей можно получить [тут](https://tech.yandex.ru/metrika/doc/api2/logs/fields/visits-docpage/), для hits актуальный список полей можно получить [тут](https://tech.yandex.ru/metrika/doc/api2/logs/fields/hits-docpage/).
* <b>source</b> - Источник логов, возможные значения hits — просмотры или visits — визиты

Подробное описание аргументов можно посмотреть [тут](https://tech.yandex.ru/metrika/doc/api2/logs/queries/class_logrequest-docpage/).

### `yadirGetMetrikaGAData(start_date = "10daysAgo", end_date = "today", counter_ids = NULL, dimensions = NULL, metrics = NULL, filters = NULL, sort = NULL, samplingLevel = "HIGHER_PRECISION", token = NULL)`
Функция для работы с API Яндекс Метрики совместимым с Google Analytics Core Reporting API (v3) и Использовать привычные параметры запросов при сборе статистики, если ранее вы работали с Google Analytics Core Reporting API (v3).

#### Аргументы:
* start_date = Дата начала отчетного периода. Вы можете указывать дату в формате YYYY-MM-DD или использовать относительные временные значения: today, yesterday, NdaysAgo.
* end_date = Дата окончания отчетного периода. Вы можете указывать даты в формате YYYY-MM-DD или использовать относительные временные значения: today, yesterday, NdaysAgo.
* counter_ids = Номер счетчика, данные которого необходимо получить. Перед номером счетчика необходимо указать префикс ga:, пример: "ga:1111"
* dimensions = Группировки объединяют данные по критериям. Например, используйте параметр dimensions=ga:browser,ga:city, чтобы:
    * Получить данные по количеству посещений.
    * Сгруппировать эти данные по браузеру, который использовал посетитель и городу, в котором находился посетитель в момент посещения.
Если по указанной группировке данные не были получены, возвращается значение (not set).
Обратите внимание на следующие ограничения:
    * В состав одного запроса может входить не более 7 группировок.
    * Запрос не может состоять только из группировок, но должен содержать хотя бы одну метрику.
    * Не все группировки можно сочетать друг с другом в составе одного запроса. Подробнее о сочетании группировок и метрик можно почитать [тут](https://tech.yandex.ru/metrika/doc/api2/ga/ga/notimplemented/unsupported-docpage/) 
* metrics = Метрики позволяют получать данные о статистике посещаемости и активности пользователей сайта. Если в запросе вы не укажете ни одной группировки, то API вернет общее значение метрики для выбранного временного интервала без разделения его на какие-либо группы.
Обратите внимание на следующие особенности:
    * В состав одного запроса может входить не более 10 метрик. 
    * Большинство метрик можно использовать в сочетании друг с другом при условии, что не выбрана ни одна группировка.
    * Не все метрики можно сочетать с другими метриками и группировками в составе одного запроса. Подробнее о сочетании группировок и метрик можно почитать [тут](https://tech.yandex.ru/metrika/doc/api2/ga/ga/notimplemented/unsupported-docpage/) 
* filters = Фильтр позволяет ограничить данные, возвращаемые в результате запроса. Более подробно о правилах фильтрации можно узнать [тут](https://tech.yandex.ru/metrika/doc/api2/ga/segmentation-ga-docpage/)
Обратите внимание на следующие особенности:
    * Фильтрация по группировке производится до использования группировок. Таким образом результирующая метрика представляет собой итоговое значение только для данных, удовлетворяющих условию группировки.
    * Фильтрация по метрике производится после использования метрик.
    * Вы можете использовать для фильтрации те группировки и метрики, которые не входят в состав вашего запроса.
* sort = В качестве сортировки собранных данных может быть использован список метрик и группировок. По умолчанию используется сортировка по возрастанию. Чтобы использовать сортировку по убыванию, укажите знак «-» в запросе перед списком метрик и группировок.В качестве значения параметра sort вы можете использовать только те значения группировок и метрик, по которым были получены данные.
* samplingLevel = Используйте данный параметр для указания уровня семплирования (количества визитов, использованных при расчете итогового значения).
    * Значение по умолчанию: HIGHER_PRECISION
Допустимые значения:
    * HIGHER_PRECISION — возвращает наиболее точное значение, используя наибольшую выборку данных. Этот режим может потребовать дополнительное время и замедлить обработку запроса.
    * FASTER — возвращает быстрый результат на основе сокращенной выборки данных.
    * DEFAULT — возвращает результат на основе выборки, сочетающей скорость и точность данных.
* token = API токен полученный с помощью функции yadirGetToken

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
# пример работы с функцией yadirGetReport и загрузки данных из сервиса Reports.
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

Аргумент Login является векторизирован с версии 2.4.1 и может принимать на вход вектор логинов. Пример работы с векторизированной функцией `yadirGetReport`:
```
library(ryandexdirect)
myToken     <- yadirGetToken()
clientList  <- yadirGetClientList(myToken)

stat        <- yadirGetReport(ReportType = "ACCOUNT_PERFORMANCE_REPORT", 
                              DateRangeType = "CUSTOM_DATE", 
                              DateFrom = "2017-01-01", 
                              DateTo = Sys.Date(), 
                              FieldNames = c("Date","Impressions","Clicks","Cost"), 
                              Login = clientList$Login, 
                              Token = myToken)
```

# пример работы с функцией yadirGetDictionary для загрузки справочников из API v.5. Яндекс Директ.
```
library(ryandexdirect)
myToken <- yadirGetToken()
Regions <- yadirGetDictionary(DictionaryName = "GeoRegions", 
                              Language = "ru", 
                              login = <YourLogin>, 
                              token = myToken
```
Вместо <b>YourLogin</b> подставьте в виде строки ваш логин на Яндексе, данный запрос загрузит в R справочник регионов Яндекс Директ.

# пример работы с Logs API Яндекс Метрики.
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

# пример работы с API Яндекс Метрики совместимым с Google Analytics Core Reporting API (v3)
```
library(ryandexdirect)
myToken <- yadirGetToken()
metrikData6 <- yadirGetMetrikaGAData(start_date = "2017-08-01",
                                     end_date = "yesterday",
                                     counter_ids = "ga:111111",
                                     metrics = "ga:sessions,ga:bounces,ga:users",
                                     dimensions = "ga:date,ga:sourceMedium",
                                     token = myToken)
```

## как обратиться к API сервисов Яндекс.Директ и Яндекс.Метрика с помощью proxy сервера, необходимо в случае блокировки доступа к сервисам.
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

## подборка статей с примерами работы с пакетом ryandexdirect.
+ [Как получить и обработать сырые данные из Яндекс.Метрики](https://netpeak.net/ru/blog/kak-poluchit-i-obrabotat-syrye-dannye-iz-yandeks-metriki/)
+ [Как связать Яндекс.Директ с Microsoft Power BI](https://netpeak.net/ru/blog/kak-svyazat-yandeks-direkt-s-microsoft-power-bi/)
+ [Подключение Power BI к Yandex.Metrika](http://pm-partner.ru/articles/114/591/)
+ [Облако минус слов для Яндекс Директ](https://esliklientov.net/articles/%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%BA%D1%81%D1%82%D0%BD%D0%B0%D1%8F-%D1%80%D0%B5%D0%BA%D0%BB%D0%B0%D0%BC%D0%B0/%D1%8F%D0%BD%D0%B4%D0%B5%D0%BA%D1%81-%D0%B4%D0%B8%D1%80%D0%B5%D0%BA%D1%82/%D0%BE%D0%B1%D0%BB%D0%B0%D0%BA%D0%BE-%D0%BC%D0%B8%D0%BD%D1%83%D1%81-%D1%81%D0%BB%D0%BE%D0%B2-%D0%B4%D0%BB%D1%8F-%D1%8F%D0%BD%D0%B4%D0%B5%D0%BA%D1%81-%D0%B4%D0%B8%D1%80%D0%B5%D0%BA%D1%82.html)
+ [Как загрузить статистику из рекламных систем в Google BigQuery](https://ppc.world/analitika/kak-zagruzit-statistiku-iz-reklamnyh-sistem-v-google-bigquery/)

## *Автор пакета: Алексей Селезнёв, Head of Analytics Dept. at Netpeak*
 <p align="center">
<img src="https://lh3.googleusercontent.com/R-0jgJSxIIhpag2L6YCIhJVIcIWx6-Jt5UCTRJjWzJewo47u2QBnik5CRF2dNB79jmsN_BFRjVOAYfvCqFcn3UNS_thGbbxF-99c9lwBWWlFI7JCWE43K5Yk9HnIW8i8YpTDx3l28IuYswaI-qc9QosHT1lPCsVilTfXTyV2empF4S74daOJ6x5QHYRWumT_2MhUS0hPqUsKVtOoveqDnGf3cF_VsN-RfOAwG9uCeGOgNRgv_fhSr41rw4LBND4gf05nO8zMp4TZMrrcUjKvvx6qNgYDor5LFOHiRmfKISYRVkWYe4wLyGO1FgkgTDjg0300lcur2t3txVwZUgROLZdaxOLx4owa8Rc8B8VKwd3vHxjov_aVfNPT4xf9jSFBBEOI-mfYpa55ejKDw-rqTQ6miFRFWpp_hjrk9KbGyB-Z6iZvYL-2dZ6mzgpUfs2I0tEAGsV07yTzboJ0RNCByC2-U-ZVjWdp2_9Au3FFoUcdQUAmPYOVqOv4r3oLbkkJKLj2A5jp7vf4IAoExLIfJuqEf7XN7fFcv4geib029qJjBt28wnqSO6TKEwB2fesR3uPHvGB6_6NHD70UDH-aCRCK4UBeoajtU0Y8Ks8Vwxo0oZBwmoEu8gudTFBF6mDT7GjLoGLDeNxE-TG7OtWUdxsJk7yzXGW3hE-VxsMD9g=s351-no?w=300" data-canonical-src="https://alexeyseleznev.files.wordpress.com/2017/03/as.png?w=300" style="max-width:100%;">
</p>

### Контакты:
<nav class="jetpack-social-navigation jetpack-social-navigation-svg">
<div class="menu-%d1%81%d0%be%d1%86%d0%b8%d0%b0%d0%bb%d1%8c%d0%bd%d1%8b%d0%b5-%d1%81%d0%b5%d1%82%d0%b8-container">
<ul id="menu-%d1%81%d0%be%d1%86%d0%b8%d0%b0%d0%bb%d1%8c%d0%bd%d1%8b%d0%b5-%d1%81%d0%b5%d1%82%d0%b8" class="menu">
<li id="menu-item-13" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-13"><a href="http://www.facebook.com/selesnow" target="_blank"><span class="screen-reader-text">Facebook</span></a></li>
<li id="menu-item-14" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-14"><a href="https://www.linkedin.com/in/selesnow/" target="_blank"><span class="screen-reader-text">LinkedIn</span></a></li>
<li id="menu-item-15" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-15"><a href="http://www.vk.com/selesnow" target="_blank"><span class="screen-reader-text">Vkontakte</span></a></li>
<li id="menu-item-16" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-16"><a href="https://github.com/selesnow"><span class="screen-reader-text">GitHub</span></a></li>
<li class="menu-item menu-item-type-custom menu-item-object-custom menu-item-16"><a href="https://alexeyseleznev.wordpress.com/">Blog</a></li>
</ul>
</div>
</nav>
  
<p align="center">
<img src="https://alexeyseleznev.files.wordpress.com/2017/03/as.png?w=300" data-canonical-src="https://alexeyseleznev.files.wordpress.com/2017/03/as.png?w=300" style="max-width:100%;">
</p>

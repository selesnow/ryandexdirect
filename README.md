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
        <td>Discount/td><td>int</td><td>Текущая скидка рекламодателя (в процентах). В настоящее время не применяется.</td>
    </tr>
    <tr>
        <td>Login</td><td>chr</td><td>Логин рекламодателя — владельца общего счета.</a></td>
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
        <td>SmsNotification.SmsTimeFrom/td><td>chr</td><td>Время, начиная с которого разрешено отправлять SMS о событиях, связанных с общим счетом. Указывается в формате HH:MM, минуты задают кратно 15 (0, 15, 30, 45).</td>
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

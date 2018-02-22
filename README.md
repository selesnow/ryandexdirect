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

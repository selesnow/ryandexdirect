# ryandexdirect - пакет для работы с API Яндекс.Директ версии 4 и Live 4 на языке R.


## Краткое описание.

Пакет ryandexdirect помонает получить дата фрейм со списком клиентов агентств из аккаунта Яндекс.Директ, получить список и обшие параметры рекламных кампаний по каждому из проектов, а так же получить детальную статистику по кампаниям за каждый день.


## Установка пакета ryandexdirect.

Установка пакета осуществляется из репозитория GitHub, для этого сначала требуется установить и подключить пакет devtools.

`install.packages("devtools")`

`library(devtools)`

После чего можно устанавливать пакет ryandexdirect.

`install_github('selesnow/ryandexdirect')`


## Функции входящие в пакет ryandexdirect.

На данный момент в версию пакета 1.0.0 входит 4 функции:

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
        <td>ManagerName</td><td>Factor</td><td>Имя персонального менеджера в Яндексе.</td>
    </tr>
    <tr>
        <td>SumAvailableForTransfer</td><td>Factor</td><td>Сумма, доступная для перевода с помощью метода TransferMoney.</td>
    </tr>
    <tr>
        <td>Login</td><td>Factor</td><td>Логин владельца кампании (логин пользователя Яндекса, в пользу которого ведется рекламная кампания).</td>
    </tr>
    <tr>
        <td>Name</td><td>Factor</td><td>Название кампании.</td>
    </tr>
    <tr>
        <td>Clicks</td><td>Factor</td><td>Количество кликов за время существования кампании.</td>
    </tr>
    <tr>
        <td>CampaignID</td><td>Factor</td><td>Идентификатор кампании.</td>
    </tr>
    <tr>
        <td>Status</td><td>Factor</td><td>Статус кампании, например: «Идут показы», «Ожидает оплаты», «На модерации», «Остановлена».</td>
    </tr>
    <tr>
        <td>StatusActivating</td><td>Factor</td><td>Состояние активизации кампании:
Yes — активизирована;
Pending — ожидается активизация.</td>
    </tr>
    <tr>
        <td>Shows</td><td>Factor</td><td>Количество показов за время существования кампании.</td>
    </tr>
    <tr>
        <td>StatusModerate</td><td>Factor</td><td>Результат проверки модератором:
Yes — модератор одобрил хотя бы одно объявление;
No — модератор отклонил все объявления;
New — объявления не отправлялись на проверку (статус кампании «Черновик»);
Pending — проводится проверка.</td>
    </tr>
    <tr>
        <td>StatusShow</td><td>Factor</td><td>Показ объявлений кампании включен — Yes/No.</td>
    </tr>
    <tr>
        <td>Sum</td><td>Factor</td><td>Если у клиента подключен общий счет — сумма израсходованных средств за все время существования кампании.
                                    Если общий счет не подключен — сумма средств, зачисленных на баланс кампании за время ее существования.</td>
    </tr>
    <tr>
        <td>IsActive</td><td>Factor</td><td>Кампания активна, объявления показываются — Yes/No.</td>
    </tr>
    <tr>
        <td>StartDate</td><td>Factor</td><td>Начало показа объявлений, YYYY-MM-DD.</td>
    </tr>
    <tr>
        <td>Rest</td><td>Factor</td><td>Текущий баланс общего счета + сумма возврата на кампанию (если у рекламодателя подключен общий счет) или текущий баланс кампании (если общий счет не подключен).</td>
    </tr>
    <tr>
        <td>AgencyName</td><td>Factor</td><td>Название рекламного агентства.</td>
    </tr>
    <tr>
        <td>StatusArchive</td><td>Factor</td><td>Состояние архивации кампании:
            Yes — кампания помещена в архив;
            No — кампания не в архиве;
            Pending — происходит перенос кампании в архив либо возврат из архива;
            CurrencyConverted — кампания автоматически заархивирована при переходе клиента на работу в валюте и не может быть разархивирована</td>
    </tr>
</table>

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

## Пример работы с пакетом ryandexdirect.

###Подключаем пакет ryandexdirect
library(ryandexdirect)

###Получаем токен для доступа к API
myToken <- yadirGetToken()

После запуска функции автоматически будет открыт браузер, на странице с выданным вам токеном, скопируйте его и вставьте в консоль R.

<img src="http://picsee.net/upload/2016-07-29/5d6a84ad44f8.png" data-canonical-src="http://picsee.net/upload/2016-07-29/5d6a84ad44f8.png" style="max-width:100%;">


<img src="http://picsee.net/upload/2016-07-29/acfa15376aa6.png" data-canonical-src="http://picsee.net/upload/2016-07-29/acfa15376aa6.png" style="max-width:100%;">

После чего в рабочей области появится объект myToken, который вы будете использовать в остальных функциях.

Далее в случае если у вас агетский аккаунт получаем список всех клиентов:

`client <- yadirGetClientList(myToken)`

Следующий шаг получить список рекламных кампаний клиентов, для этого в функции `yadirGetCampaignList` необходимо задать вектор со списком логинов тех аккаунтов по которым вы хотите получить статистику.

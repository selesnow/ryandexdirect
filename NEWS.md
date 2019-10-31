# ryandexdirect 3.2.2

дата: 2019-10-31

* Функция `yadirGetCampaignList()` с версии 3.2.2 считается устаревшей. Она будет присутвовать в пакете, но не будет развиваться. Вместо неё рекомендуется использовать функцию `yadirGetCampaign()`.
* В таблицу возвращаемую функцией `yadirGetCampaign()` добавлены новые поля:
    * SourceId - Идентификатор исходной кампании в у. е., если текущая кампания была создана автоматически при переходе рекламодателя на работу в валюту.
	* FundsMode - Тип финансовых показателей кампании:
	    * CAMPAIGN_FUNDS — общий счет не подключен, финансовые показатели кампании возвращаются в поле CampaignFundsBalance;
		* SHARED_ACCOUNT_FUNDS — общий счет подключен, финансовые показатели кампании возвращаются в поле SharedAccountFundsSpend.
	* CampaignFundsBalance - Текущий баланс кампании в валюте рекламодателя, без учета НДС.
	* CampaignFundsBalanceBonus - Скидочный бонус. Параметр утратил актуальность.
	* CampaignFundsSumAvailableForTransfer - Сумма, доступная для переноса на другую кампанию, в валюте рекламодателя, без учета НДС.
	* SharedAccountFundsRefund - Параметр утратил актуальность, всегда возвращается значение 0.
	* SharedAccountFundsSpend - Сумма средств, израсходованных по данной кампании за все время ее существования, с учетом НДС.
	* AttributionModel - Модель атрибуции, используемая для оптимизации конверсий:
	    * FC — первый переход.
		* LC — последний переход.
		* LSC — последний значимый переход.
		* LYDC — последний переход из Яндекс.Директа.
* В пакете появился документ со всеми устаревшими функциями, посмотреть его можно с помощью команды `help("ryandexdirect-deprecated")`.

# ryandexdirect 3.2.1
* В `yadirGetKeyWordsBids` исправлена ошибка возникающая при запросе данных по 1 ключевому слову.
* В `yadirSetAutoKeyWordsBids` исправлена ошибка `object 'StrategyPriority' not found`.

# ryandexdirect 3.2.0
* В пакет добавлены функции для управления ставками ключевых слов
    * yadirGetKeyWordsBids
	* yadirSetKeyWordsBids
	* yadirSetAutoKeyWordsBids

Описание релиза на [GitHub](https://github.com/selesnow/ryandexdirect/releases/tag/3.2.0).

# ryandexdirect 3.1.6
* В пакет добавлены виньетки
    * Подробная виньетка о загрузке статистики из рекламных аккаунтов Яндекс Директ: `vignette("yandex-direct-get-statistic", package = "ryandexdirect")`
	* Подробная виньетка про авторизацию и работу с учётными данными: `vignette("yandex-direct-auth", package = "ryandexdirect")`
* Для обработки лимита в 1 000 000 строк в функцию `yadirGetReport` добавлен аргумент FetchBy. Подробнее об этом можно узнать из описания релиза на GitHub.
* Исправлена проблема, которая возникала при запросе статистики сразу из нескольких клиентских аккаунтов.

Описание релиза на [GitHub](https://github.com/selesnow/ryandexdirect/releases/tag/3.1.6).

# ryandexdirect 3.1.4
* В результат возвращаемый функцией `yadirGetCampaign` добалены следующие поля:
    * SearchBidStrategyType - Тип стратегии показа на поиске
    * NetworkBidStrategyType - Тип стратегии показа в сетях
	
Описание релиза на [GitHub](https://github.com/selesnow/ryandexdirect/releases/tag/3.1.5).

# ryandexdirect 3.1.1
* Исправлена ошибка в функции `yadirAuth`, возникающая после обновления просроченного токена.

# ryandexdirect 3.1.0
## Удалены функции
* Из пакета удалены следующие функции: `yadirGetSummaryStat`, `yadirGetCampaignListOld`, `yadirGetLogsData`, `yadirGetMetrikaGAData`
* Функция `yadirGetToken` теперь так же может сохранять полученный токен в локальный файл, если пользователь даст на это разрешение, но обновляться такой токен по истечению срока не будет, т.к. к нему не привязан refresh token.
* Для сокращении имени, и приведения названия функций к одному вижу у функции `yadirGetCampaignList` появилась дублируюая функция `yadirGetCampaign`, для совмещения новой версии пакета с кодом написанным под более ранними версиями обе функции в нём остаются.
* В функции `yadirGetCampaign` и `yadirGetCampaignList` по умолчанию в фильтр по типу кампаний включена загрузка кампаний с типом 'CPM_BANNER_CAMPAIGN'.


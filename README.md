<p align="center">
<a href="https://selesnow.github.io/"><img src="https://alexeyseleznev.files.wordpress.com/2017/03/as.png" height="80"></a>
</p>

# ryandexdirect - пакет для работы с API Яндекс.Директ версии 4, Live 4 и 5 на языке R.
<p align="center">
<img src="https://raw.githubusercontent.com/selesnow/selesnow.github.io/master/img_logo/ryandexdirect.png" height="200">
</p>

## CRAN
[Ссылка на страницу пакета на CRAN](https://CRAN.R-project.org/package=ryandexdirect)

### Бейджи
[![Rdoc](http://www.rdocumentation.org/badges/version/ryandexdirect)](http://www.rdocumentation.org/packages/ryandexdirect)
[![rpackages.io rank](http://www.rpackages.io/badge/ryandexdirect.svg)](http://www.rpackages.io/package/ryandexdirect)
[![](https://cranlogs.r-pkg.org/badges/ryandexdirect)](https://cran.r-project.org/package=ryandexdirect)

## Краткое описание.

Пакет ryandexdirect предназначен для загрузки данных из Яндекс Директ в R, с помощью функций данного пакета вы можете работать с перечисленными ниже сервисами и службами API Яндекса с помощью готовых функций, не углубляясь при этом в документацию по работе с этими API сервисами.

+ [Сервис Reports](https://tech.yandex.ru/direct/doc/reports/reports-docpage/) - Предназначен для получения статистики по аккаунту рекламодателя.
+ [API Директа версии 4 и Live 4](https://tech.yandex.ru/direct/doc/dg-v4/concepts/About-docpage/) - Через API внешние приложения добавляют и редактируют кампании, объявления, фразы, задают ставки, получают статистику показов.
+ [API Директа версии 5](https://tech.yandex.ru/direct/doc/dg/concepts/about-docpage/) - Через API внешние приложения добавляют и редактируют кампании, объявления, фразы, задают ставки, получают статистику показов.

Пакет позволяет вам выполнять следующие действия:

1. Авторизовываться в API.
2. Получать список различных объектов рекламного кабинета, рекламных кампаний, групп объявлений, объявлений, для агентских аккаунтов можно запрашивать список клиентов, и параметры каждого клиента.
3. Управлять показами на уровне рекламных кампаний, групп объявлений и объявлений.
4. Загружать статистику.

## Установка пакета ryandexdirect.

Для установки из CRAN воспользуйтесь стандартной командой: `install.packages("ryandexdirect")`

Установить dev версию можно из репозитория GitHub, для этого сначала требуется установить и подключить пакет devtools.

```r
install.packages("devtools")
devtools::install_github('selesnow/ryandexdirect')
```

### Ссылки
1. [Документация по работе с пакетом ryandexdirect](https://selesnow.github.io/ryandexdirect/).
2. Баг репорты, предложения по доработке и улучшению функционала ryandexdirect оставлять [тут](https://github.com/selesnow/ryandexdirect/issues). 
3. [Список релизов](https://github.com/selesnow/ryandexdirect/releases).
4. [Телеграмм канал R4marketing](https://t.me/R4marketing).
5. [Группа в Вконтакте](https://vk.com/data_club).

### Автор пакета
Алексей Селезнёв, Head of analytics dept. at [Netpeak](https://netpeak.net)
<Br>email: selesnow@gmail.com
<Br>skype: selesnow
<Br>facebook: [facebook.com/selesnow](https://facebook.com/selesnow)
<Br>linkedin: [linkedin.com/in/selesnow](https://linkedin.com/in/selesnow)
<Br>blog: [alexeyseleznev.wordpress.com](https://alexeyseleznev.wordpress.com/)

<p align="center">
<a href="https://selesnow.github.io/"><img src="https://alexeyseleznev.files.wordpress.com/2017/03/as.png" height="80"></a>
</p>


# ryandexdirect - пакет для работы с API Яндекс.Директ версии 4, Live 4 и 5 на языке R.<a href='https://selesnow.github.io/ryandexdirect/'><img src='https://raw.githubusercontent.com/selesnow/ryandexdirect/master/inst/ryandexdirect.png' align="right" height="139" /></a>

## CRAN
[Ссылка на страницу пакета на CRAN](https://CRAN.R-project.org/package=ryandexdirect)

### Бейджи
[![Rdoc](http://www.rdocumentation.org/badges/version/ryandexdirect)](https://www.rdocumentation.org/packages/ryandexdirect)
[![rpackages.io rank](http://www.rpackages.io/badge/ryandexdirect.svg)](http://www.rpackages.io/package/ryandexdirect)
[![](https://cranlogs.r-pkg.org/badges/ryandexdirect)](https://cran.r-project.org/package=ryandexdirect)

## Краткое описание.
Пакет ryandexdirect предназначен для загрузки данных из Яндекс Директ в R, с помощью функций данного пакета вы можете работать с перечисленными ниже сервисами и службами API Яндекса с помощью готовых функций, не углубляясь при этом в документацию по работе с этими API сервисами.

+ [Сервис Reports](https://yandex.ru/dev/direct/doc/reports/reports-docpage) - Предназначен для получения статистики по аккаунту рекламодателя.
+ [API Директа версии 4 и Live 4](https://yandex.ru/dev/direct/doc/dg-v4/concepts/About-docpage) - Через API внешние приложения добавляют и редактируют кампании, объявления, фразы, задают ставки, получают статистику показов.
+ [API Директа версии 5](https://yandex.ru/dev/direct/doc/dg/concepts/about-docpage) - Через API внешние приложения добавляют и редактируют кампании, объявления, фразы, задают ставки, получают статистику показов.

Пакет позволяет вам выполнять следующие действия:

1. Авторизовываться в API.
2. Получать список различных объектов рекламного кабинета, рекламных кампаний, групп объявлений, объявлений, для агентских аккаунтов можно запрашивать список клиентов, и параметры каждого клиента.
3. Управлять показами на уровне рекламных кампаний, групп объявлений и объявлений.
4. Загружать статистику.
5. Упаравлять ставками ключевых слов и автотаргетингов.

## Поддержать проект
Вы можете поддержать проект любой произвольной суммой перейдя по этой [ссылке](https://secure.wayforpay.com/button/b6dd4a7083fe0).

## Установка пакета ryandexdirect.
Для установки из CRAN воспользуйтесь стандартной командой: `install.packages("ryandexdirect")`

Установить dev версию можно из репозитория GitHub, для этого сначала требуется установить и подключить пакет devtools.

```r
install.packages("devtools")
devtools::install_github('selesnow/ryandexdirect')
```

### Ссылки
1. [Документация по работе с пакетом ryandexdirect](https://selesnow.github.io/ryandexdirect/).
2. [Видео уроки по работе с ryandexdirect](https://www.youtube.com/playlist?list=PLD2LDq8edf4oUo0L9Kw77ZXf0KcV1hu67)
2. Баг репорты, предложения по доработке и улучшению функционала ryandexdirect оставлять [тут](https://github.com/selesnow/ryandexdirect/issues). 
3. [Список релизов](https://github.com/selesnow/ryandexdirect/releases).
4. [Телеграмм канал R4marketing](https://t.me/R4marketing).

### Автор пакета
Алексей Селезнёв, Head of analytics dept. at [Netpeak](https://netpeak.net/en/gb/)
<Br>Telegram канал автора: [R4marketing](https://t.me/R4marketing)
<Br>Сайт с документацией к пакетам: [selesnow.github.io](https://selesnow.github.io)
<Br>email: selesnow@gmail.com
<Br>skype: selesnow
<Br>facebook: [facebook.com/selesnow](https://www.facebook.com/selesnow)
<Br>linkedin: [linkedin.com/in/selesnow](https://www.linkedin.com/in/selesnow)
<Br>blog: [alexeyseleznev.wordpress.com](https://alexeyseleznev.wordpress.com/)

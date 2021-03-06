Тестовое задание
==================

Приложение, имеющее стандартный тулбар с двумя разделами: "Расписание" и "О приложении"

#### 1. "Расписание"

Первый раздел позволяет выбрать:

 - Станцию «отправления»
 - Станцию «прибытия»
 - Дату отправления

Экран выбора станции построен на основе `UITableView` и выполняет следующие задачи:  

- Содержит общий перечень станций (см. вложенный файл), сгруппированный по значению «Страна, Город». Полный перечень групп и элементов представлен на одном экране, с возможностью пролистывания всего содержимого.
- Предоставляет возможность поиска по части имени (как начальной, так и входящей, независимо от регистра). Поиск осуществляется на том же экране, где представлен список станций, с использованием `UISearchController`.
- Предоставляет возможность просмотра детальной информации о конкретной станции (именование и ее полный адрес, включая город, регион и страну).

- Позволяет обновить список станций с сервера.

#### 2. "О приложении"

В данном разделе размещена информацию о:

 - Копирайте
 - Версии приложения

#### Скриншоты

![Расписание](/screenshots/1.png "")
![Поиск станции](/screenshots/2.png "")
![Информация о станции](/screenshots/3.png "")
![Выбор даты](/screenshots/4.png "")
![О приложении](/screenshots/5.png "")
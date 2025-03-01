# ClickHouse and Vector Install

## Что делает playbook:

Playbook разворачивает на хостах приложения:
- сlickhouse-client
- clickhouse-server
- clickhouse-common
- vector

Скачивает дистрибутив clickhouse-server и сlickhouse-client. Устанавливает clickhouse-server и сlickhouse-client, создает базу данных. Для работы приложения должны быть открыты порты 8123 и 9000.

Скачивает и устанавливает дистрибутив Vector. Создает файл параметров из шаблона. После выполнения действий запускает сервис Vector.

## Параметры
- способ подключения к целевому хосту необходимо указать в prod.yml.
- версии и архитектура пакетов указываются в файлах vars.yml

## Теги
- clickhouse
- vector

## Запуск

- Для запуска playbook нужно выполнить команду
```ansible-playbook -i inventory/prod.yml site.yml```, где ```inventory/prod.yml``` - путь к inventory файлу, ```site.yml``` - файл playbook.

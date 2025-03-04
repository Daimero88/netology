# Домашнее задание к занятию «Практическое применение Docker» - Сильчин Сергей
## Задача 1 

1. Сделайте в своем github пространстве fork репозитория:
![fork](https://github.com/user-attachments/assets/e8304c50-4ee9-4184-93ae-aca9fb69e0dd)

2. Создайте файл с именем Dockerfile.python для сборки данного проекта. Используйте базовый образ python:3.9-slim. Обязательно используйте конструкцию COPY . . в Dockerfile. Не забудьте исключить ненужные в имадже файлы с помощью dockerignore:

 ![dockerfile](https://github.com/user-attachments/assets/f6673d6c-4640-4d5a-8dc7-6fa95c4145ac)
 ![dockerignore](https://github.com/user-attachments/assets/12e79021-b398-4ba3-a6f3-1e0d1c61d3ca)

 [ссылка на репозиторий](https://github.com/Daimero88/shvirtd-example-python/tree/main)

## Задача 2 (*)
1. Создайте в yandex cloud container registry с именем "test" с помощью "yc tool" . [Инструкция](https://cloud.yandex.ru/ru/docs/container-registry/quickstart/?from=int-console-help)
2. Настройте аутентификацию вашего локального docker в yandex container registry.
3. Соберите и залейте в него образ с python приложением из задания №1.
4. Просканируйте образ на уязвимости.
5. В качестве ответа приложите отчет сканирования

Отчет сканирования:
[vulnerabilities.csv](https://github.com/user-attachments/files/18538770/vulnerabilities.csv)

![vulnerabilities](https://github.com/user-attachments/assets/4338320c-c7a3-4241-b4aa-75c3335cee53)

## Задача 3
1. Изучите файл "proxy.yaml"
2. Создайте в репозитории с проектом файл ```compose.yaml```. С помощью директивы "include" подключите к нему файл "proxy.yaml".
3. Опишите в файле ```compose.yaml``` следующие сервисы: 

- ```web```. Образ приложения должен ИЛИ собираться при запуске compose из файла ```Dockerfile.python``` ИЛИ скачиваться из yandex cloud container registry(из задание №2 со *). Контейнер должен работать в bridge-сети с названием ```backend``` и иметь фиксированный ipv4-адрес ```172.20.0.5```. Сервис должен всегда перезапускаться в случае ошибок.
Передайте необходимые ENV-переменные для подключения к Mysql базе данных по сетевому имени сервиса ```web``` 

- ```db```. image=mysql:8. Контейнер должен работать в bridge-сети с названием ```backend``` и иметь фиксированный ipv4-адрес ```172.20.0.10```. Явно перезапуск сервиса в случае ошибок. Передайте необходимые ENV-переменные для создания: пароля root пользователя, создания базы данных, пользователя и пароля для web-приложения.Обязательно используйте уже существующий .env file для назначения секретных ENV-переменных!

![compose](https://github.com/user-attachments/assets/09eb433e-4b44-4561-ad31-868b6d24ec37)

4. Запустите проект локально с помощью docker compose , добейтесь его стабильной работы: команда ```curl -L http://127.0.0.1:8090``` должна возвращать в качестве ответа время и локальный IP-адрес.

![curl](https://github.com/user-attachments/assets/c7fa9ac5-6b32-42cd-8582-532731db94e5)

5. Подключитесь к БД mysql с помощью команды ```docker exec -ti <имя_контейнера> mysql -uroot -p<пароль root-пользователя>```(обратите внимание что между ключем -u и логином root нет пробела. это важно!!! тоже самое с паролем) . Введите последовательно команды (не забываем в конце символ ; ): ```show databases; use <имя вашей базы данных(по-умолчанию example)>; show tables; SELECT * from requests LIMIT 10;```.

6. Остановите проект. В качестве ответа приложите скриншот sql-запроса.

![sql](https://github.com/user-attachments/assets/18338d2d-3a10-47b3-afc6-571d5931ddd4)


## Задача 4
1. Запустите в Yandex Cloud ВМ (вам хватит 2 Гб Ram).
2. Подключитесь к Вм по ssh и установите docker.
3. Напишите bash-скрипт, который скачает ваш fork-репозиторий в каталог /opt и запустит проект целиком.
4. Зайдите на сайт проверки http подключений, например(или аналогичный): ```https://check-host.net/check-http``` и запустите проверку вашего сервиса ```http://<внешний_IP-адрес_вашей_ВМ>:8090```. Таким образом трафик будет направлен в ingress-proxy.
5. (Необязательная часть) Дополнительно настройте remote ssh context к вашему серверу. Отобразите список контекстов и результат удаленного выполнения ```docker ps -a```
6. В качестве ответа повторите sql-запрос и приложите скриншот с данного сервера, bash-скрипт и ссылку на fork-репозиторий.

![sql2](https://github.com/user-attachments/assets/61b41a46-1c1f-45b5-82d9-a31bac8e8f3d)

![bash](https://github.com/user-attachments/assets/991cb031-ed37-4958-89e1-9a92a77120cd)

[Репозиторий](https://github.com/Daimero88/shvirtd-example-python)

## Задача 5 (*)
1. Напишите и задеплойте на вашу облачную ВМ bash скрипт, который произведет резервное копирование БД mysql в директорию "/opt/backup" с помощью запуска в сети "backend" контейнера из образа ```schnitzler/mysqldump``` при помощи ```docker run ...``` команды. Подсказка: "документация образа."
2. Протестируйте ручной запуск
3. Настройте выполнение скрипта раз в 1 минуту через cron, crontab или systemctl timer. Придумайте способ не светить логин/пароль в git!!
4. Предоставьте скрипт, cron-task и скриншот с несколькими резервными копиями в "/opt/backup"

## Задача 6
Скачайте docker образ ```hashicorp/terraform:latest``` и скопируйте бинарный файл ```/bin/terraform``` на свою локальную машину, используя dive и docker save.
Предоставьте скриншоты действий.
![pull](https://github.com/user-attachments/assets/e7464b72-4580-4857-b269-49687b2005ed)

![dive](https://github.com/user-attachments/assets/4c0d8cbe-0c59-448b-a8c4-f756d4627383)

![bin](https://github.com/user-attachments/assets/5692ef6c-c3c8-4b0c-83c2-95474fe57277)


## Задача 6.1
Добейтесь аналогичного результата, используя docker cp.  
Предоставьте скриншоты действий.

![cp](https://github.com/user-attachments/assets/1d80db3b-86a4-4499-9127-fa5b7384b7e1)


# Домашнее задание к занятию 12 «GitLab» - Сильчин Сергей

## Основная часть

### DevOps

В репозитории содержится код проекта на Python. Проект — RESTful API сервис. Ваша задача — автоматизировать сборку образа с выполнением python-скрипта:

1. Образ собирается на основе [centos:7](https://hub.docker.com/_/centos?tab=tags&page=1&ordering=last_updated).  
   Образ переделал на `fedora:latest`
3. Python версии не ниже 3.7.
4. Установлены зависимости: `flask` `flask-jsonpify` `flask-restful`.
5. Создана директория `/python_api`.
6. Скрипт из репозитория размещён в /python_api.
7. Точка вызова: запуск скрипта.
8. При комите в любую ветку должен собираться docker image с форматом имени hello:gitlab-$CI_COMMIT_SHORT_SHA . Образ должен быть выложен в Gitlab registry или yandex registry.

   Сборка прошла успешно:  
   ![image1](https://github.com/user-attachments/assets/72b8197c-e828-4620-933b-b0b16600d425)  
   Контейнер появился в Gitlab registry:  
   ![image2](https://github.com/user-attachments/assets/d65e2e1d-dbd0-42ed-981e-bb950c66ec7a)  

### Product Owner

Вашему проекту нужна бизнесовая доработка: нужно поменять JSON ответа на вызов метода GET `/rest/api/get_info`, необходимо создать Issue в котором указать:

1. Какой метод необходимо исправить.
2. Текст с `{ "message": "Already started" }` на `{ "message": "Running"}`.
3. Issue поставить label: feature.  

   ![image3](https://github.com/user-attachments/assets/81667ad2-e76e-434f-b467-def81b1a40b7)

### Developer

Пришёл новый Issue на доработку, вам нужно:

1. Создать отдельную ветку, связанную с этим Issue.
2. Внести изменения по тексту из задания.
3. Подготовить Merge Request, влить необходимые изменения в `master`, проверить, что сборка прошла успешно.


### Tester

Разработчики выполнили новый Issue, необходимо проверить валидность изменений:

1. Поднять докер-контейнер с образом `python-api:latest` и проверить возврат метода на корректность.
2. Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый.

## Итог

В качестве ответа пришлите подробные скриншоты по каждому пункту задания:

- файл gitlab-ci.yml;
- Dockerfile; 
- лог успешного выполнения пайплайна;
- решённый Issue.


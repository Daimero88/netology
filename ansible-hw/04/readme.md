# Домашнее задание к занятию 4 «Работа с roles» - Сильчин Сергей

## Подготовка к выполнению

1. * Необязательно. Познакомьтесь с [LightHouse](https://youtu.be/ymlrNlaHzIY?t=929).
2. Создайте два пустых публичных репозитория в любом своём проекте: vector-role и lighthouse-role.
3. Добавьте публичную часть своего ключа к своему профилю на GitHub.

## Основная часть

Ваша цель — разбить ваш playbook на отдельные roles. 

Задача — сделать roles для ClickHouse, Vector и LightHouse и написать playbook для использования этих ролей. 

Ожидаемый результат — существуют три ваших репозитория: два с roles и один с playbook.

**Что нужно сделать**

1. Создайте в старой версии playbook файл `requirements.yml` и заполните его содержимым:

   ```yaml
   ---
     - src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
       scm: git
       version: "1.13"
       name: clickhouse 
   ```  
   ![image1](https://github.com/user-attachments/assets/c418905e-c424-47fe-8fb7-e51d9fae985a)  

2. При помощи `ansible-galaxy` скачайте себе эту роль.  
   ![image2](https://github.com/user-attachments/assets/31e6eaa5-8ce0-4081-ba79-3800dbf1633e)  

3. Создайте новый каталог с ролью при помощи `ansible-galaxy role init vector-role`.
   ![image3](https://github.com/user-attachments/assets/2a9d2169-27cd-4b26-90cf-f47b823ef8b0)
   
4. На основе tasks из старого playbook заполните новую role. Разнесите переменные между `vars` и `default`.  
   [**vars**](https://github.com/Daimero88/vector-role/blob/main/vars/main.yml), [**defaults**](https://github.com/Daimero88/vector-role/blob/main/defaults/main.yml)  
5. Перенести нужные шаблоны конфигов в `templates`.  
   [**templates**](https://github.com/Daimero88/vector-role/blob/main/templates/vector.yaml.j2)   
6. Опишите в `README.md` обе роли и их параметры. Пример качественной документации ansible role [по ссылке](https://github.com/cloudalchemy/ansible-prometheus).  
   [**README.md**](https://github.com/Daimero88/vector-role/blob/main/README.md)
7. Повторите шаги 3–6 для LightHouse. Помните, что одна роль должна настраивать один продукт.  
   [**vars**](https://github.com/Daimero88/lighthouse-role/blob/main/vars/main.yml), [**defaults**](https://github.com/Daimero88/lighthouse-role/blob/main/defaults/main.yml), [**templates**](https://github.com/Daimero88/lighthouse-role/blob/main/templates/lighthouse.conf.j2), [**README.md**](https://github.com/Daimero88/lighthouse-role/blob/main/README.md)
9. Выложите все roles в репозитории. Проставьте теги, используя семантическую нумерацию. Добавьте roles в `requirements.yml` в playbook.  
10. Переработайте playbook на использование roles. Не забудьте про зависимости LightHouse и возможности совмещения `roles` с `tasks`.  
11. Выложите playbook в репозиторий.  
12. В ответе дайте ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.  

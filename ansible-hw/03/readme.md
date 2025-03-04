# Домашнее задание к занятию 3 «Использование Ansible» - Сильчин Сергей

1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.  
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.  
3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.  
4. Подготовьте свой inventory-файл `prod.yml`.  
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.  
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
   При запуске плэйбука с флагом `--check` получим ошибку во время установки, так как дистрибутивы ClickHouse не скачаны:  
   ![image1](https://github.com/user-attachments/assets/bb352ef8-6018-4ba2-9fb2-8eb1922996d5)
   Vector выдаст ошибку о невозможности скачивание архива в директорию, т.к. она не была создана:  
   ![image2](https://github.com/user-attachments/assets/163897e4-901a-43de-bf2d-03b0e8f117f3)
   Lighthouse выдаст ошибку на старте сервиса, т.к. сервис nginx не был установлен:
   ![image3](https://github.com/user-attachments/assets/289a8f4e-ddf2-45ea-8ac9-310d879d75eb)

7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.  
   ![image4](https://github.com/user-attachments/assets/bcc61283-0350-444c-b140-bffd4cff0e0e)

8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
   Три task Vector. `Install vector binary file`, `Vector. Create daemon` и `Lighthouse. Clone source code by git client` в статусе `skipped`, т.к. в playbook были добавлены проверки `when`. Playbook идемпотентен:  
   ![image5](https://github.com/user-attachments/assets/29e490f6-3880-47d3-81d9-8ba211ea426b)

11. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.  
12. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.  

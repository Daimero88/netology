# Домашнее задание к занятию 2 «Работа с Playbook» - Сильчин Сергей

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.  
   [**prod.yml**](https://github.com/Daimero88/netology/blob/main/ansible-hw/02/playbook/inventory/prod.yml)  
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2. От вас не требуется использовать все возможности шаблонизатора, просто вставьте стандартный конфиг в template файл. Информация по шаблонам по [ссылке](https://www.dmosk.ru/instruktions.php?object=ansible-nginx-install). не забудьте сделать handler на перезапуск vector в случае изменения конфигурации!  
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.  
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.  
   Playbook: [**site.yml**](https://github.com/Daimero88/netology/blob/main/ansible-hw/02/playbook/site.yml)
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.  
   Все ошибки были исправлены:  
  ![image1](https://github.com/user-attachments/assets/694cae18-4cf0-4205-9346-058aba290690)

6. Попробуйте запустить playbook на этом окружении с флагом `--check`.  
   Так как установочные пакеты еще не были скачаны, то получаем ошибки:  
   ![image2](https://github.com/user-attachments/assets/203b1057-d282-4669-bd54-c1e51696b2e8)

 
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.  
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
   ![image4](https://github.com/user-attachments/assets/33e505b6-c877-4a27-bfa2-3669d7038224)  

11. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook). Так же приложите скриншоты выполнения заданий №5-8  
12. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.  

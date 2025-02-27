# Домашнее задание к занятию 1 «Введение в Ansible» - Сильчин Сергей

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
   
    some_fact имеет значение 12:  
    ![image1](https://github.com/user-attachments/assets/ecd35989-38b6-4a68-96b9-ad781b8c8be7)  

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
   
   Переменная находится в ```group_vars/all/examp.yml```  
   ![image2](https://github.com/user-attachments/assets/69438948-80f7-42ae-8bec-d6dec31bf91e)

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.  
   ![image3](https://github.com/user-attachments/assets/44b50b2c-5f97-4722-9657-a707151203ab)

4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.  
   ![image4](https://github.com/user-attachments/assets/d7de6d88-aae7-422c-9a7f-a50f6c465db3)  
   Значение `some_fact` для managed host "centos7": `el`, для "ubuntu": `deb`  
   
5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.  
   ![image5](https://github.com/user-attachments/assets/c298675b-7889-4930-baa7-2f0601364d5b)  

6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.  
   ![image6](https://github.com/user-attachments/assets/dace034c-3b52-405c-9972-0be96a615989)  

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.  
   ![image7](https://github.com/user-attachments/assets/89ca6de2-f92c-4652-a843-2cf0528202af)  
   
8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
   ![image8](https://github.com/user-attachments/assets/c8eea495-6530-4271-9f23-067f190e6ee5)  

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.  
    ![image9](https://github.com/user-attachments/assets/0ba3e1d7-d754-4671-8c6b-b3a71ad86f41)
   Выбираем плагин `ansible.builtin.local`.  
    
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.  
    ![image10](https://github.com/user-attachments/assets/c2d57f11-cea5-4399-8380-0299d85bac02)  

11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
    ![image11](https://github.com/user-attachments/assets/058fcf0b-7b60-4d43-b0ea-36b8e3026c79)  


## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

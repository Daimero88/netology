# Домашнее задание к занятию 5 «Тестирование roles» - Сильчин Сергей

### Molecule

1. Запустите  `molecule test -s ubuntu_xenial` (или с любым другим сценарием, не имеет значения) внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками или не отработать вовсе, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу И из чего может состоять сценарий тестирования.  
   Команда отработала с ошибками при вызове, т.к. необходимо переписать файл `molecule.yml` (Molecule больше не использует параметр playbooks):
   ![image](https://github.com/user-attachments/assets/1efb3d9d-d1f6-4d29-a384-671a55f8150c)
 
2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.  
   ![image2](https://github.com/user-attachments/assets/439c7669-8dc3-4d80-9f67-57966447df47)  

3. Добавьте несколько разных дистрибутивов (oraclelinux:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.  
   Был выбран только дистрибутив `geerlingguy/docker-ubuntu2004-ansible`, т.к. на `oraclelixux:8` нет предустановленного python, а если устанавливать вручную из репозитория, то там старая версия `3.6.8`.  
   play `create`:  
   ![image3](https://github.com/user-attachments/assets/4336f8e8-d8f7-4322-9860-8b89aee3a976)  
   play `Converge`:  
   ![image4](https://github.com/user-attachments/assets/9e12191b-345b-4c3b-a502-ec64ba9ebf22)

5. Добавьте несколько assert в verify.yml-файл для проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.).  
   файл расположен по пути molecule/default/verify.yml:
      ```
      - name: Verify
        hosts: all
        gather_facts: false
        vars:
          vector_config_path: /etc/vector/vector.yaml
        tasks:
          - name: Get Vector validation
            ansible.builtin.command: "vector validate"
            changed_when: false
            register: vector_check

      - name: Assert Vector validation
        ansible.builtin.assert:
          that:
            - vector_check.rc == 0
          fail_msg: "Vector configuration validation failed"
          success_msg: "Vector configuration validation succeeded"
        
6. Запустите тестирование роли повторно и проверьте, что оно прошло успешно.  
   ![image5](https://github.com/user-attachments/assets/97c4b0f3-3692-4d96-8228-354c3359d642) 
7. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.
   

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example).
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
5. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.
6. Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий.
8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Не забудьте указать в ответе теги решений Tox и Molecule заданий. В качестве решения пришлите ссылку на  ваш репозиторий и скриншоты этапов выполнения задания. 

## Необязательная часть

1. Проделайте схожие манипуляции для создания роли LightHouse.
2. Создайте сценарий внутри любой из своих ролей, который умеет поднимать весь стек при помощи всех ролей.
3. Убедитесь в работоспособности своего стека. Создайте отдельный verify.yml, который будет проверять работоспособность интеграции всех инструментов между ними.
4. Выложите свои roles в репозитории.

В качестве решения пришлите ссылки и скриншоты этапов выполнения задания.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

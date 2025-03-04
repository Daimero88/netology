# ClickHouse, Vector, Lighthouse Install

## Что делает playbook:

Playbook разворачивает на хостах приложения:
- сlickhouse-client
- clickhouse-server
- clickhouse-common
- vector
- lighthouse
- nginx

Скачивает дистрибутив clickhouse-server и сlickhouse-client. Устанавливает clickhouse-server и сlickhouse-client, создает базу данных. Для работы приложения должны быть открыты порты 8123 и 9000.

Скачивает и устанавливает дистрибутив Vector. Создает файл параметров из шаблона. После выполнения действий запускает сервис Vector.

Скачивает и устанавливает дистрибутив Lighthouse, git, nginx. Создает файл параметров из шаблона. После выполнения действий запускает сервис Lighthouse и nginx.

## Параметры
- способ подключения к целевым хостам необходимо указать в prod.yml.
- версии и архитектура пакетов указываются в файлах vars.yml

## Теги
- clickhouse
- vector
- lighthouse

## Запуск

- Для запуска playbook нужно выполнить команду
```ansible-playbook -i inventory/prod.yml site.yml```, где ```inventory/prod.yml``` - путь к inventory файлу, ```site.yml``` - файл playbook.


[playbook/site.yml](playbook/site.yml) содержит 3 play'я task'ов. 
Каждый Play содержит в себе task'и по установке Clickhouse, Vector и Lighthouse соответственно. 
Каждый play можно выполнить отдельно, используя тэги: `clickhouse`, `vector` и `lighthouse`.  
Плейбук использует 4 файла с переменными: 3 файла для каждой из групп хостов индивидуально:  
- [playbook/group_vars/clickhouse/clickhouse_vars.yml](playbook/group_vars/clickhouse/vars.yml)  
- [playbook/group_vars/vector/vector_vars.yaml](playbook/group_vars/vector/vars.yaml)  
- [playbook/group_vars/lighthouse/lighthouse_vars.yaml](playbook/group_vars/lighthouse/vars.yaml)  
и один файл, применяемый для всех групп хостов:  
- [playbook/group_vars/all/all_vars.yml](playbook/group_vars/all/vars.yml)    

Для конфигурации Vector и Nginx используются шаблоны конфигов:  
- [playbook/templates/vector/vector.yaml.j2](playbook/templates/vector/vector.yaml.j2)
- [playbook/templates/nginx/ligthouse.conf.j2](playbook/templates/nginx/ligthouse.conf.j2)   
   

# Домашнее задание к занятию 15 «Система сбора логов Elastic Stack» - Сильчин Сергей

## Задание 1

Вам необходимо поднять в докере и связать между собой:

- elasticsearch (hot и warm ноды);
- logstash;
- kibana;
- filebeat.

Logstash следует сконфигурировать для приёма по tcp json-сообщений.

Filebeat следует сконфигурировать для отправки логов docker вашей системы в logstash.

В директории [help](./help) находится манифест docker-compose и конфигурации filebeat/logstash для быстрого 
выполнения этого задания.

Результатом выполнения задания должны быть:

- скриншот `docker ps` через 5 минут после старта всех контейнеров (их должно быть 5);  
![image1](https://github.com/user-attachments/assets/8037f8ac-fd22-46d7-a2f6-9fb77ffc43d7)  

- скриншот интерфейса kibana;  
![image2](https://github.com/user-attachments/assets/8de21dc9-a0cc-4a6f-924c-5986aa317e4f)




## Задание 2

Перейдите в меню [создания index-patterns  в kibana](http://localhost:5601/app/management/kibana/indexPatterns/create) и создайте несколько index-patterns из имеющихся.  
![image3](https://github.com/user-attachments/assets/b22f66ec-12ff-494b-ab46-b3899e79cf44)  


Перейдите в меню просмотра логов в kibana (Discover) и самостоятельно изучите, как отображаются логи и как производить поиск по логам.  
![image4](https://github.com/user-attachments/assets/a549e993-008a-4f62-99c1-68f6e0352e19)  

В манифесте директории help также приведенно dummy-приложение, которое генерирует рандомные события в stdout-контейнера.
Эти логи должны порождать индекс logstash-* в elasticsearch. Если этого индекса нет — воспользуйтесь советами и источниками из раздела «Дополнительные ссылки» этого задания.
 

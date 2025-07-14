# Домашнее задание к занятию «Вычислительные мощности. Балансировщики нагрузки»  - Сильчин Сергей

## Задание 1. Yandex Cloud 

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать файл доступным из интернета.
 
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
 - Настроить проверку состояния ВМ.
 
3. Подключить группу к сетевому балансировщику:

 - Создать сетевой балансировщик.
 - Проверить работоспособность, удалив одну или несколько ВМ.
4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.

---

## Решение  

1. Проверяем ```terraform plan```, что создадутся все необходимые ресурсы:  
 <img width="731" height="125" alt="image1" src="https://github.com/user-attachments/assets/5de30e88-9444-41f9-b9d1-cf50ffac7120" />  

 В том числе s3:  
 <img width="448" height="420" alt="image2" src="https://github.com/user-attachments/assets/6096f023-d450-42c7-b2db-92aaa369a122" />  

 После применения убеждаемся, что s3 создался и картинка в нем:  
 <img width="955" height="317" alt="image3" src="https://github.com/user-attachments/assets/4ffeae9b-5c61-4c16-97fc-b5b531dc76f2" />  

 И картинка доступна из интернета по адресу https://ssilchin-110725.storage.yandexcloud.net/image.jpg (скриншот сделан в telegram, где при указании ссылки она сразу же загружается):  
 <img width="424" height="433" alt="image4" src="https://github.com/user-attachments/assets/15dfabd3-607d-4312-9bd5-9d9aca824955" /> 
 
---

2. Убеждаемся, что создалась группа из трех ВМ в public подсети:
   <img width="1121" height="249" alt="image5" src="https://github.com/user-attachments/assets/19f9a3d5-0faf-43ab-9cdb-6a36baadb2b4" />
   <img width="1258" height="324" alt="image6" src="https://github.com/user-attachments/assets/bb204140-267b-4827-9e44-a573215d2639" />
   <img width="1385" height="337" alt="image7" src="https://github.com/user-attachments/assets/f124b61e-e278-4456-9e36-097217eaf47d" />

Проверяем, что страница доступна по публичному IP каждой из ВМ:
  <img width="547" height="253" alt="image8" src="https://github.com/user-attachments/assets/407fe0cc-d000-4774-a9cd-2593023a6afa" />
  <img width="556" height="275" alt="image9" src="https://github.com/user-attachments/assets/da4624f9-71f5-46e6-bea7-05331785c4f7" />
  <img width="555" height="259" alt="image10" src="https://github.com/user-attachments/assets/c32b9bad-63bc-4186-81c1-2eef2eb203bd" />

---

3. Убеждаемся, что сетевой балансировщик из [**nlb.tf**](https://github.com/Daimero88/netology/blob/main/clopro-hw/02/nlb.tf) создался в облаке:  
 <img width="1159" height="326" alt="image11" src="https://github.com/user-attachments/assets/c43d111e-8fb8-4c89-9602-dd59eb6cf662" />
 <img width="989" height="283" alt="image12" src="https://github.com/user-attachments/assets/74fbb6ea-1c9d-41ec-820e-0b9de320c87d" />  
 И проверим, что страница открывается по публичному IP балансировщика:  
 <img width="563" height="265" alt="image13" src="https://github.com/user-attachments/assets/db6d03aa-f71d-43d8-b5c4-361861255bc0" />  
 При остановке одной из машин, все продолжает работать:  
 <img width="598" height="191" alt="image14" src="https://github.com/user-attachments/assets/c8a9ae79-b486-4a9a-9c58-65f213b73108" />

---

4. Убеждаемся, что Application Load Balancer из [**alb.tf**](https://github.com/Daimero88/netology/blob/main/clopro-hw/02/alb.tf) с использованием [**instance-group.tf**](https://github.com/Daimero88/netology/blob/main/clopro-hw/02/instance-group.tf) создался в облаке:  
   <img width="974" height="238" alt="image15" src="https://github.com/user-attachments/assets/5eb26c8e-fd7e-4c76-96d6-31a21b394af2" />
   И проверим, что страница открывается по публичному IP alb:
   <img width="556" height="256" alt="image16" src="https://github.com/user-attachments/assets/7e5a09c8-cba4-4326-ad3b-dec24380293b" />




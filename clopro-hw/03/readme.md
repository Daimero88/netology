# Домашнее задание к занятию «Безопасность в облачных провайдерах»  - Сильчин Сергей

## Задание 1. Yandex Cloud   

1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:

 - создать ключ в KMS;
 - с помощью ключа зашифровать содержимое бакета, созданного ранее.
2. (Выполняется не в Terraform)* Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS:

 - создать сертификат;
 - создать статическую страницу в Object Storage и применить сертификат HTTPS;
 - в качестве результата предоставить скриншот на страницу с сертификатом в заголовке (замочек).

---

## Решение  

1. В [**main.tf**](https://github.com/Daimero88/netology/blob/main/clopro-hw/03/main.tf) создаем kms ключ и шифруем им s3-bucket.  
   Проверяем, что ключ создался:
   <img width="902" height="597" alt="image1" src="https://github.com/user-attachments/assets/c7fe6c4d-9c94-4433-9665-1ad715afbdf2" />  
   
   И файл зашифрован:  
   <img width="498" height="387" alt="image2" src="https://github.com/user-attachments/assets/1b50e311-8431-42a3-8a14-2b7acc5b2534" />  
   
   Теперь при попытке открыть файл по ссылке, получаем ошибку:  
   <img width="479" height="226" alt="image3" src="https://github.com/user-attachments/assets/c553b21f-d824-472b-9682-c030c1b08007" />  

   При этом можно сгенерировать ссылку и файл по ней будет доступен:  
   <img width="457" height="147" alt="image4" src="https://github.com/user-attachments/assets/3f4ffe6a-5d08-42b9-b26f-2549a308d5a3" />  

---

2. Добавляем сгенерированный сертификат:
   <img width="874" height="233" alt="image5" src="https://github.com/user-attachments/assets/ce24a74f-b4f0-44fe-9fa5-1903a82a8a17" />  

   Создаем страницу и добавляем ее в бакет:  
   <img width="463" height="283" alt="image6" src="https://github.com/user-attachments/assets/ab60954c-c3b9-45ee-9329-4010cd3b0524" />  

   В настройках бакета выбираем веб-сайт и указываем загруженную страницу:  
   <img width="555" height="273" alt="image" src="https://github.com/user-attachments/assets/eb4c0704-315e-46b8-97e9-a8aa804c499d" />

   В настройках бакета выбираем сертификат:  
   <img width="656" height="311" alt="image7" src="https://github.com/user-attachments/assets/2ebddf44-af2b-48e0-bec1-71c0766ace17" />  

   Заходим на страницу (в нашем случае на https://ssilchin-110725.website.yandexcloud.net/) и видим, что сама страница отображается и что подключение защищено:  
   <img width="438" height="161" alt="image" src="https://github.com/user-attachments/assets/d937f288-8207-4d07-bcd9-52b90d31e03c" />




   



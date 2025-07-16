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
   
2. 


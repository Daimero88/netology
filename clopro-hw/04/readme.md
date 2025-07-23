# Домашнее задание к занятию «Кластеры. Ресурсы под управлением облачных провайдеров» - Сильчин Сергей

## Задание 1. Yandex Cloud

1. Настроить с помощью Terraform кластер баз данных MySQL.

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно подсеть private в разных зонах, чтобы обеспечить отказоустойчивость. 
 - Разместить ноды кластера MySQL в разных подсетях.
 - Необходимо предусмотреть репликацию с произвольным временем технического обслуживания.
 - Использовать окружение Prestable, платформу Intel Broadwell с производительностью 50% CPU и размером диска 20 Гб.
 - Задать время начала резервного копирования — 23:59.
 - Включить защиту кластера от непреднамеренного удаления.
 - Создать БД с именем `netology_db`, логином и паролем.

2. Настроить с помощью Terraform кластер Kubernetes.

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно две подсети public в разных зонах, чтобы обеспечить отказоустойчивость.
 - Создать отдельный сервис-аккаунт с необходимыми правами. 
 - Создать региональный мастер Kubernetes с размещением нод в трёх разных подсетях.
 - Добавить возможность шифрования ключом из KMS, созданным в предыдущем домашнем задании.
 - Создать группу узлов, состояющую из трёх машин с автомасштабированием до шести.
 - Подключиться к кластеру с помощью `kubectl`.
 - *Запустить микросервис phpmyadmin и подключиться к ранее созданной БД.
 - *Создать сервис-типы Load Balancer и подключиться к phpmyadmin. Предоставить скриншот с публичным адресом и подключением к БД.

---

## Решение  

**1. Настроим с помощью Terraform кластер баз данных MySQL**:

   - Описываем переменные в [**variables.tf**](https://github.com/Daimero88/netology/blob/main/clopro-hw/04/variables.tf), где указываем private и public сети во всех 3 зонах яндекса. Далее в файле [**vpc.tf**](https://github.com/Daimero88/netology/blob/main/clopro-hw/04/vpc.tf) опишем создание ресурсов сетей, nat шлюза и таблицы маршрутизации.
   - В файле [**mysql.tf**](https://github.com/Daimero88/netology/blob/main/clopro-hw/04/mysql.tf) описываем создание кластера с необходимыми параметрами и созданием БД.  
     
После применения конфигурации, проверим, что все ресурсы создались в облаке:  

  - Сети в разных зонах:  
    <img width="1529" height="716" alt="image1" src="https://github.com/user-attachments/assets/b3ff430f-756d-4e10-8591-cce5867e75a9" />  
  - Таблица маршрутизации через nat gateway:  
    <img width="1128" height="225" alt="image2" src="https://github.com/user-attachments/assets/62fafc16-4808-4b68-ad07-3ac22eb66945" />  
  - Кластер MySQL:  
    <img width="546" height="735" alt="image3" src="https://github.com/user-attachments/assets/87bb9958-9974-46e3-85c0-04e34fcb95a6" />  
    <img width="405" height="278" alt="image4" src="https://github.com/user-attachments/assets/570eab48-d2e7-4446-8a36-afaaeb498fea" />
  - Хосты:  
    <img width="1046" height="268" alt="image5" src="https://github.com/user-attachments/assets/b4a13f64-baf2-4eb6-8388-a9c29b2f3e91" />
  - Пользователи:  
    <img width="511" height="179" alt="image6" src="https://github.com/user-attachments/assets/25b490ca-c45a-43b3-afa0-06bea5964186" />  
  - База данных:  
    <img width="517" height="181" alt="image7" src="https://github.com/user-attachments/assets/fe6bafe5-501a-4d9f-bb23-eaf464d2a95a" />  



**2. Настроим с помощью Terraform кластер Kubernetes:**

   - Опишем создание кластера с сервисными аккаунтами в [**k8s.tf**](https://github.com/Daimero88/netology/blob/main/clopro-hw/04/k8s.tf), добавим в [**variables.tf**](https://github.com/Daimero88/netology/blob/main/clopro-hw/04/variables.tf) необходимые переменные
   - Добавим возможность шифрования ключом из [**kms.tf**](https://github.com/Daimero88/netology/blob/main/clopro-hw/04/kms.tf)  

После применения конфигурации, проверим, что все ресурсы создались в облаке:  

  - Сервисный аккаунт:  
    <img width="764" height="239" alt="image8" src="https://github.com/user-attachments/assets/446e3a0a-55f6-452c-925f-ce95a87cbb38" />
  - Группа безопасности:  
    <img width="848" height="496" alt="image9" src="https://github.com/user-attachments/assets/5c5a53fd-4175-4a7e-acda-8d6c399614d6" />
  - Ключ шифрования:  
    <img width="559" height="412" alt="image10" src="https://github.com/user-attachments/assets/70ee5a9a-8453-4203-abc7-e9fe816fdbd1" />
  - Кластер:  
    <img width="511" height="471" alt="image11" src="https://github.com/user-attachments/assets/dfbc5d3c-76ec-427f-962f-3a678c7eacf3" />  
  - Группы узлов с автомасштабированием:  
    <img width="590" height="236" alt="image" src="https://github.com/user-attachments/assets/dc8fd15d-595d-4425-ac08-ab9f455cd9cc" />  
  - Ноды:  
    <img width="560" height="381" alt="image12" src="https://github.com/user-attachments/assets/577beb76-0fc9-40fa-8566-97ad1c6c231b" />  
  - Подключаемся к кластеру с помощью kubectl и проверяем список нод:  
    <img width="516" height="89" alt="image13" src="https://github.com/user-attachments/assets/0d4fd0f7-d17c-412a-a6cd-a57898753b20" />  
  - Создание микросервиса phpmyadmin с сервисом Load Balancer описываем также в [**k8s.tf**](https://github.com/Daimero88/netology/blob/main/clopro-hw/04/k8s.tf), из [**outputs.tf**](https://github.com/Daimero88/netology/blob/main/clopro-hw/04/outputs.tf) берем IP балансера и адрес базы данных:  
    <img width="425" height="217" alt="image14" src="https://github.com/user-attachments/assets/7d41c4aa-b1ad-4849-a0a0-2e406a46508b" />  
    Проверяем что страница доступна:  
    <img width="918" height="605" alt="image15" src="https://github.com/user-attachments/assets/5f276867-ac3f-4613-99fd-277a4906a5e5" />  
    И подключаемся к базе данных:  
    <img width="844" height="301" alt="image" src="https://github.com/user-attachments/assets/0e9f2e02-1c7b-4e2d-b17d-dca94d78638f" />  

    





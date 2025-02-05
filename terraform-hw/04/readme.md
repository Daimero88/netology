# Домашнее задание к занятию «Продвинутые методы работы с Terraform» - Сильчин Сергей

### Задание 1

1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания с помощью двух вызовов remote-модуля -> двух ВМ, относящихся к разным проектам(marketing и analytics) используйте labels для обозначения принадлежности.  В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
Воспользуйтесь [**примером**](https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/). Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.  
![key](https://github.com/user-attachments/assets/70a03d47-6541-4725-b191-ea6b43e93079)
![varssh](https://github.com/user-attachments/assets/ae6e6471-5c77-44d3-98be-db1ece8f68fe)  

3. Добавьте в файл cloud-init.yml установку nginx.  
   Для этого в [**cloud-init.yml**](https://github.com/Daimero88/netology/blob/main/terraform-hw/04/src/cloud-init.yml) необходимо в packages добавить ```- nginx```  
4. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```, скриншот консоли ВМ yandex cloud с их метками. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.marketing_vm
![cloud](https://github.com/user-attachments/assets/63caae92-82e4-4316-b4ed-56bbb603c946)  
![nginx](https://github.com/user-attachments/assets/8b040d67-944e-46b8-8b88-5a37d01c3bcf)  
![console](https://github.com/user-attachments/assets/e8eb5a12-89d2-400f-b25e-3b6f3286c941)


### Задание 2

1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля, например: ```ru-central1-a```.  
   [**vpc-network.tf**](https://github.com/Daimero88/netology/blob/main/terraform-hw/04/src/vpc/vpc-network.tf)  
   ![image](https://github.com/user-attachments/assets/b6e28185-9e60-4955-a964-0206f56f97f8)

2. Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.  
   [**variables.tf**](https://github.com/Daimero88/netology/blob/main/terraform-hw/04/src/vpc/variables.tf)  
   ![var](https://github.com/user-attachments/assets/384be53d-2484-4bbc-8ff6-5e81ef4c528a)  

3. Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev  
   ![moduleconsole](https://github.com/user-attachments/assets/a795ffa3-1666-40f9-bd2e-add9c4c2dbd1)

4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
   ![1](https://github.com/user-attachments/assets/9d5b3504-c0d2-48c0-be0e-fdac83f8d98f)
   ![2](https://github.com/user-attachments/assets/c2c1e061-6bd5-45eb-a4f5-724dd0a7e28a)  

5. Сгенерируйте документацию к модулю с помощью terraform-docs.

Генерируем документацию с помощью контейнера:  
```docker run --rm --volume "$(pwd):/terraform-docs" -u $(id -u) quay.io/terraform-docs/terraform-docs:0.19.0 markdown /terraform-docs > doc.md```  
В результате получаем файл [**doc**](https://github.com/Daimero88/netology/blob/main/terraform-hw/04/src/vpc/doc.md)

### Задание 3
1. Выведите список ресурсов в стейте.  
![state](https://github.com/user-attachments/assets/51c88145-5041-486a-befc-b3aa9640e62c)  

2. Полностью удалите из стейта модуль vpc.  
![rm](https://github.com/user-attachments/assets/b813b93f-e5c9-4b78-98a3-62c5a2be9bca)  

3. Полностью удалите из стейта модуль vm.  
![rmvm](https://github.com/user-attachments/assets/03cde188-e200-438c-8618-10a5cbf956c4)  

4. Импортируйте всё обратно. Проверьте terraform plan. Значимых(!!) изменений быть не должно.
Приложите список выполненных команд и скриншоты процессы.

Импортируем командной ```terraform import module.<module_name> <id>```  
После импортирования модулей изменений нет.


## Дополнительные задания (со звёздочкой*)

### Задание 4*

1. Измените модуль vpc так, чтобы он мог создать подсети во всех зонах доступности, переданных в переменной типа list(object) при вызове модуля.  
  
Пример вызова
```
module "vpc_prod" {
  source       = "./vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}
```

Предоставьте код, план выполнения, результат из консоли YC.

### Задание 5*

1. Напишите модуль для создания кластера managed БД Mysql в Yandex Cloud с одним или несколькими(2 по умолчанию) хостами в зависимости от переменной HA=true или HA=false. Используйте ресурс yandex_mdb_mysql_cluster: передайте имя кластера и id сети.
2. Напишите модуль для создания базы данных и пользователя в уже существующем кластере managed БД Mysql. Используйте ресурсы yandex_mdb_mysql_database и yandex_mdb_mysql_user: передайте имя базы данных, имя пользователя и id кластера при вызове модуля.
3. Используя оба модуля, создайте кластер example из одного хоста, а затем добавьте в него БД test и пользователя app. Затем измените переменную и превратите сингл хост в кластер из 2-х серверов.
4. Предоставьте план выполнения и по возможности результат. Сразу же удаляйте созданные ресурсы, так как кластер может стоить очень дорого. Используйте минимальную конфигурацию.

### Задание 6*
1. Используя готовый yandex cloud terraform module и пример его вызова(examples/simple-bucket): https://github.com/terraform-yc-modules/terraform-yc-s3 .
Создайте и не удаляйте для себя s3 бакет размером 1 ГБ(это бесплатно), он пригодится вам в ДЗ к 5 лекции.

### Задание 7*

1. Разверните у себя локально vault, используя docker-compose.yml в проекте.
2. Для входа в web-интерфейс и авторизации terraform в vault используйте токен "education".
3. Создайте новый секрет по пути http://127.0.0.1:8200/ui/vault/secrets/secret/create
Path: example  
secret data key: test 
secret data value: congrats!  
4. Считайте этот секрет с помощью terraform и выведите его в output по примеру:
```
provider "vault" {
 address = "http://<IP_ADDRESS>:<PORT_NUMBER>"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 

Можно обратиться не к словарю, а конкретному ключу:
terraform console: >nonsensitive(data.vault_generic_secret.vault_example.data.<имя ключа в секрете>)
```
5. Попробуйте самостоятельно разобраться в документации и записать новый секрет в vault с помощью terraform. 

### Задание 8*
Попробуйте самостоятельно разобраться в документаци и с помощью terraform remote state разделить root модуль на два отдельных root-модуля: создание VPC , создание ВМ . 





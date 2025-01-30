# Домашнее задание к занятию «Введение в Terraform» - Сильчин Сергей

### Чек-лист готовности к домашнему заданию

1. Скачайте и установите **Terraform** версии >=1.8.4 . Приложите скриншот вывода команды ```terraform --version```.
 ![terraform](https://github.com/user-attachments/assets/0cba7260-446f-405a-8057-b8b5fa1c974a)

2. Скачайте на свой ПК этот git-репозиторий. Исходный код для выполнения задания расположен в директории **01/src**.
3. Убедитесь, что в вашей ОС установлен docker:
![docker](https://github.com/user-attachments/assets/81e8e415-9b22-40dd-a75d-d930dfa820e0)
------

### Задание 1

1. Перейдите в каталог [**src**](https://github.com/netology-code/ter-homeworks/tree/main/01/src). Скачайте все необходимые зависимости, использованные в проекте.  
   ![init](https://github.com/user-attachments/assets/34d1e355-b76b-473f-9f23-7c3885e21a33)

2. Изучите файл **.gitignore**. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?(логины,пароли,ключи,токены итд)  
 ```Директории .terraform/ и *.tfstate ```
 
3. Выполните код проекта. Найдите  в state-файле секретное содержимое созданного ресурса **random_password**, пришлите в качестве ответа конкретный ключ и его значение.
   ![result](https://github.com/user-attachments/assets/6f1b08d4-7dc5-4b5a-b491-7d98ec4856d9)  
 ```"result": "VDGlIdt40irbQjik"```

4. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла **main.tf**.
Выполните команду ```terraform validate```. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.  
![validate](https://github.com/user-attachments/assets/13622e23-d6e5-4805-84ff-e69bcc50fe2a)  
На строке 23 отсутствует имя ресурса (объявлен только тип)  
На строке 28 имя начинается с цифры, а должно с буквы
![fake](https://github.com/user-attachments/assets/42885ca4-f29a-4621-a453-d896ce1bd3cb)
![randomT](https://github.com/user-attachments/assets/0e941eae-e1f9-4c2f-a936-1a164aed4513)  
Данных "random_string_FAKE" нет в ресурсе "random_password" и в result буква T в uppercase

5. Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды ```docker ps```.  
```
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"
```
![docker](https://github.com/user-attachments/assets/f49af107-d32c-4b30-8799-9c514d465512)  

6. Замените имя docker-контейнера в блоке кода на ```hello_world```. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду ```terraform apply -auto-approve```.
Объясните своими словами, в чём может быть опасность применения ключа  ```-auto-approve```. Догадайтесь или нагуглите зачем может пригодиться данный ключ? В качестве ответа дополнительно приложите вывод команды ```docker ps```.
![new-docker](https://github.com/user-attachments/assets/81106961-8558-4afc-82e1-174e25d773ef)  
Ключ ```-auto-approve``` автоматически одобряет выполнение всех операцией, это может привести к незапланируемым изменениям. Команда полезна для любой автоматизации тестирования и других задач, для которых автоодобрение не критично.

8. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**.  
 ![destroy](https://github.com/user-attachments/assets/b8860270-d8ab-4566-9941-bb204916736c)  

9. Объясните, почему при этом не был удалён docker-образ **nginx:latest**. Ответ **ОБЯЗАТЕЛЬНО НАЙДИТЕ В ПРЕДОСТАВЛЕННОМ КОДЕ**, а затем **ОБЯЗАТЕЛЬНО ПОДКРЕПИТЕ** строчкой из документации [**terraform провайдера docker**](https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs).  (ищите в классификаторе resource docker_image)  
![keep](https://github.com/user-attachments/assets/73b3970e-f233-49ed-a206-d232f06ef8ba)  
Чтобы docker-образ удалился, необходимо строку ```keep_locally = true``` заменить на ```keep_locally = false```  
![keep-doc](https://github.com/user-attachments/assets/13050f72-1520-4feb-a3f2-9bfa3d00bd24)

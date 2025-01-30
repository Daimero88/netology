# Домашнее задание "Основы Terraform. Yandex Cloud" - Сильчин Сергей  
### Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.
Убедитесь что ваша версия **Terraform** ~>1.8.4

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net).
3. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.
4. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
   ![error](https://github.com/user-attachments/assets/f1db5280-cfb7-4bb3-bd89-b738ef27d1e2)
   Ошибка говорит о том, что платформы с именем standart-v4 не существует (в официальной документации стандартные платформы заканчиваются на v3 и должны писаться как standard с "d" на конце)
   ![error2](https://github.com/user-attachments/assets/3592d0d5-1ed0-485b-a829-b18a444e4e67)
   Доля вычислительных ресурсов 5 слишком мала, рекомендуемо использовать 20,50,100
   ![error3](https://github.com/user-attachments/assets/dbd2ff1c-5a0f-4973-a435-4ea1916717cb)
   Количество используемых vCPU не должно быть равным 1

5. Подключитесь к консоли ВМ через ssh и выполните команду ``` curl ifconfig.me```.  
![curl](https://github.com/user-attachments/assets/5c0f38e0-cfce-4fa5-a8cf-446b96a48d85)  

6. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ.  
Включение прерывания VM (preemptible = true) отлично подходят для тестов. ВМ при этом может отключиться при неиспользовании. Также стоимость ВМ с включенной функцией значительно падает.  
Core Fraction позволяет ограничить процент мощности выделяемого виртуального процессора. Если задачи легкие, то можно задать 20% одного ядра, чтобы не переплачивать за лишние ресурсы.  
В качестве решения приложите:
- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
  ![vm1](https://github.com/user-attachments/assets/3f9c7a07-7c27-402a-bead-0b3d306193e2)  


### Задание 2

1. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
![new_vars](https://github.com/user-attachments/assets/5ef5ae3c-a701-4612-baed-8d8149193a24)  
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf.  
![maintf](https://github.com/user-attachments/assets/dc5d8069-0b33-4dd0-b0e8-201716779b95)  
3. Проверьте terraform plan. Изменений быть не должно. 
![plan](https://github.com/user-attachments/assets/4175f282-acfb-4390-9699-2229822577a1)  


### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле mai.tf: **"netology-develop-platform-db"** ,  ```cores  = 2, memory = 2, core_fraction = 20```. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').  ВМ должна работать в зоне "ru-central1-b"  
Добавляем ресурсы для новой ВМ в файле vms_platform.tf:  
![newdb](https://github.com/user-attachments/assets/24bd2515-c33a-4dc1-9ab0-b4358ab103cd)  
Добавляем в конфигурацию новую сеть в зоне ru-central1-b в файле variables.tf:  
![zoneb](https://github.com/user-attachments/assets/38d30f0b-cbc6-46be-8340-1654eb922814)  
![cidr](https://github.com/user-attachments/assets/2e9f4139-4bf0-4c63-82ae-a94494a6cf14)  
![vpc](https://github.com/user-attachments/assets/82ce541a-f539-4ee9-95df-1918f45c0b61)  
Описываем создание ВМ в файле main.tf:  
![mainnew](https://github.com/user-attachments/assets/3b8104c1-fc0f-4f87-acc0-4f7575194fb1)  
4. Примените изменения.  
![vmdb](https://github.com/user-attachments/assets/f1b0aa4a-be35-44b8-a5e5-0e4849da85d9)


### Задание 4

1. Объявите в файле outputs.tf **один** output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)  
![outputs](https://github.com/user-attachments/assets/ebccd08a-2b77-40a4-9474-fe3910d221fe)

2. Примените изменения.  
В качестве решения приложите вывод значений ip-адресов команды ```terraform output```.  
![output](https://github.com/user-attachments/assets/271b0b1e-c6ef-4559-b79c-87dd6085dce6)
  

### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.  
![locals](https://github.com/user-attachments/assets/b3544032-5606-4ca6-a70c-f89ae96222e2)  
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.  
![web](https://github.com/user-attachments/assets/db746b0e-1531-41f4-a93a-6d3ffa0738b4)  
![db](https://github.com/user-attachments/assets/bce086b7-9671-4bfe-b0e2-ff2f9e4929ff)  
3. Примените изменения.  
![apply](https://github.com/user-attachments/assets/8cf20f2a-2d16-4764-b6c4-956fc1bca84a)


### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map(object).  
Объявляем переменную и записываем значения в terraform.tfvars:  
![tfvars](https://github.com/user-attachments/assets/ad4b021d-0433-430e-b015-c35f4444eec8)  
![tfvars](https://github.com/user-attachments/assets/7a9df520-18ef-4b0c-b289-41294c87324d)  
Изменяем конфигурацию в main.tf:  
![1](https://github.com/user-attachments/assets/aad1e703-3b8c-4c11-a5fe-b3430f8bd199)  
![2](https://github.com/user-attachments/assets/42cc2d0d-3bb2-4290-a740-d85cb7450a8d)  
2. Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.  
Объявляем переменную и записываем значения в terraform.tfvars:  
![image](https://github.com/user-attachments/assets/f5e394b6-da88-401e-beb9-b03838740af1)  
![image](https://github.com/user-attachments/assets/1f92d704-2e44-443a-ae5d-940f5e519c5e)  
Добавляем строку ```metadata = var.metadata``` в main.tf для каждой ВМ.  
3. Найдите и закоментируйте все, более не используемые переменные проекта.
4. Проверьте terraform plan. Изменений быть не должно.  
![plan3](https://github.com/user-attachments/assets/f53d93af-a388-46a0-9532-b382516e7e96)


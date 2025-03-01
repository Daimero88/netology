# Домашнее задание к занятию «Управляющие конструкции в коде Terraform» - Сильчин Сергей

### Задание 1

1. Изучите проект.  
2. Инициализируйте проект, выполните код. 

Приложите скриншот входящих правил «Группы безопасности» в ЛК Yandex Cloud .
![secgroup](https://github.com/user-attachments/assets/f0473702-0d72-4782-9b3f-8bf570233a56)  


### Задание 2

1. Создайте файл count-vm.tf. Опишите в нём создание двух **одинаковых** ВМ  web-1 и web-2 (не web-0 и web-1) с минимальными параметрами, используя мета-аргумент **count loop**. Назначьте ВМ созданную в первом задании группу безопасности:

[**count-vm**](https://github.com/Daimero88/netology/blob/main/terraform-hw/03/src/count-vm.tf)

2. Создайте файл for_each-vm.tf. Опишите в нём создание двух ВМ для баз данных с именами "main" и "replica" **разных** по cpu/ram/disk_volume , используя мета-аргумент **for_each loop**. Используйте для обеих ВМ одну общую переменную типа:
```
variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number }))
}
```  
При желании внесите в переменную все возможные параметры: 

[**for_each-vm.tf**](https://github.com/Daimero88/netology/blob/main/terraform-hw/03/src/for_each-vm.tf)  

3. ВМ из пункта 2.1 должны создаваться после создания ВМ из пункта 2.2.

Для этого добавляем в ресурс создания ВМ из пункта 2.1 ```resource "yandex_compute_instance" "web"``` строку ```depends_on = [ yandex_compute_instance.db ]``` где yandex_compute_instance.db - ресурс создания ВМ из пункта 2.2

4. Используйте функцию file в local-переменной для считывания ключа ~/.ssh/id_rsa.pub и его последующего использования в блоке metadata, взятому из ДЗ 2.

В файле [locals.tf](https://github.com/Daimero88/netology/blob/main/terraform-hw/03/src/locals.tf) описываем переменную metadata, где обращаемся через функцию file к ключу, который находится в [terraform.tfvars](https://github.com/Daimero88/netology/blob/main/terraform-hw/03/src/terraform.tfvars), затем можно присваивать значение переменной: ```metadata = local.metadata```
  
5. Инициализируйте проект, выполните код.  
![create-vms](https://github.com/user-attachments/assets/19831faf-f1f0-4519-beaa-778999c79abd)

------

### Задание 3

1. Создайте 3 одинаковых виртуальных диска размером 1 Гб с помощью ресурса yandex_compute_disk и мета-аргумента count в файле **disk_vm.tf** .  
   [**disk_vm.tf**](https://github.com/Daimero88/netology/blob/main/terraform-hw/03/src/disk_vm.tf)
   
2. Создайте в том же файле **одиночную**(использовать count или for_each запрещено из-за задания №4) ВМ c именем "storage"  . Используйте блок **dynamic secondary_disk{..}** и мета-аргумент for_each для подключения созданных вами дополнительных дисков.

![add-disk](https://github.com/user-attachments/assets/fdc93169-9fe8-420d-bb1c-aca38bfa05c0)  
![yandex-disks](https://github.com/user-attachments/assets/894f8c9d-ac9c-4fdd-a665-46a5624a0c21)

------

### Задание 4

1. В файле ansible.tf создайте inventory-файл для ansible.
Используйте функцию tepmplatefile и файл-шаблон для создания ansible inventory-файла из лекции.
Готовый код возьмите из демонстрации к лекции [**demonstration2**](https://github.com/netology-code/ter-homeworks/tree/main/03/demo).
Передайте в него в качестве переменных группы виртуальных машин из задания 2.1, 2.2 и 3.2, т. е. 5 ВМ.

[**ansible.tf**](https://github.com/Daimero88/netology/blob/main/terraform-hw/03/src/ansible.tf)

2. Инвентарь должен содержать 3 группы и быть динамическим, т. е. обработать как группу из 2-х ВМ, так и 999 ВМ.    
3. Добавьте в инвентарь переменную  [**fqdn**](https://cloud.yandex.ru/docs/compute/concepts/network#hostname).
``` 
[webservers]
web-1 ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
web-2 ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>

[databases]
main ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
replica ansible_host<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>

[storage]
storage ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
```
Пример fqdn: ```web1.ru-central1.internal```(в случае указания переменной hostname(не путать с переменной name)); ```fhm8k1oojmm5lie8i22a.auto.internal```(в случае отсутвия перменной hostname - автоматическая генерация имени,  зона изменяется на auto). нужную вам переменную найдите в документации провайдера или terraform console.  

[**hosts.tftpl**](https://github.com/Daimero88/netology/blob/main/terraform-hw/03/src/hosts.tftpl)

4. Выполните код. Приложите скриншот получившегося файла.  
![hosts.cfg](https://github.com/user-attachments/assets/13f0a55a-50be-4bee-b97b-d994d2dc82d4)

------

### Задание 5* (необязательное)
1. Напишите output, который отобразит ВМ из ваших ресурсов count и for_each в виде списка словарей :
``` 
[
 {
  "name" = 'имя ВМ1'
  "id"   = 'идентификатор ВМ1'
  "fqdn" = 'Внутренний FQDN ВМ1'
 },
 {
  "name" = 'имя ВМ2'
  "id"   = 'идентификатор ВМ2'
  "fqdn" = 'Внутренний FQDN ВМ2'
 },
 ....
...итд любое количество ВМ в ресурсе(те требуется итерация по ресурсам, а не хардкод) !!!!!!!!!!!!!!!!!!!!!
]
```
Приложите скриншот вывода команды ```terrafrom output```.  
![output](https://github.com/user-attachments/assets/2547a13d-9edc-4339-bacd-9e42eed42913)

------

### Задание 6* (необязательное)

1. Используя null_resource и local-exec, примените ansible-playbook к ВМ из ansible inventory-файла.
Готовый код возьмите из демонстрации к лекции [**demonstration2**](https://github.com/netology-code/ter-homeworks/tree/main/03/demo).
2. Модифицируйте файл-шаблон hosts.tftpl. Необходимо отредактировать переменную ```ansible_host="<внешний IP-address или внутренний IP-address если у ВМ отсутвует внешний адрес>```.

Для проверки работы уберите у ВМ внешние адреса(nat=false). Этот вариант используется при работе через bastion-сервер.  
![image](https://github.com/user-attachments/assets/a5b3f4ab-63bf-48c2-83bf-0a15b76af0ea)


### Задание 8* (необязательное)
Идентифицируйте и устраните намеренно допущенную в tpl-шаблоне ошибку. Обратите внимание, что terraform сам сообщит на какой строке и в какой позиции ошибка!
```
[webservers]
%{~ for i in webservers ~}
${i["name"]} ansible_host=${i["network_interface"][0]["nat_ip_address"] platform_id=${i["platform_id "]}}
%{~ endfor ~}
```

Пропущена фигурная закрывающая скобка } и после platform_id есть пробел. Исправленный вариант:  
```
[webservers]
%{~ for i in webservers ~}
${i["name"]} ansible_host=${i["network_interface"][0]["nat_ip_address"]} platform_id=${i["platform_id"]}
%{~ endfor ~}
```

### Задание 9* (необязательное)
Напишите  terraform выражения, которые сформируют списки:
1. ["rc01","rc02","rc03","rc04",rc05","rc06",rc07","rc08","rc09","rc10....."rc99"] те список от "rc01" до "rc99"

```formatlist("rc%02d", range(1, 100))```

2. ["rc01","rc02","rc03","rc04",rc05","rc06","rc11","rc12","rc13","rc14",rc15","rc16","rc19"....."rc96"] те список от "rc01" до "rc96", пропуская все номера, заканчивающиеся на "0","7", "8", "9", за исключением "rc19"

```[for i in range(1, 96) : format("rc%02d", i) if !contains([0, 7, 8, 9], i % 10) || i == 19]```

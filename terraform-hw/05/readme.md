# Домашнее задание к занятию «Использование Terraform в команде» - Сильчин Сергей

### Задание 1

1. Возьмите код:
- из [ДЗ к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/src),
- из [демо к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1).
2. Проверьте код с помощью tflint и checkov. Вам не нужно инициализировать этот проект.  
3. Перечислите, какие **типы** ошибок обнаружены в проекте (без дублей).  
    Проверка tflint:  
    ![tflint](https://github.com/user-attachments/assets/f1478b61-3711-435f-94ce-58686823f3f5)
    Модуль использует в качестве версии по умолчанию основную ветку (main) репитория, для повышения надежности рекомендуется указывать конкретный коммит или тег в качестве версии модуля. Также в файле конфигурации отсутствует указание версии для провайдера 'yandex', рекомендуется явно указывать версию плагина провайдера. 
Есть объявленные, но неиспользуемые переменные.

    Проверка checkov:
![chekov](https://github.com/user-attachments/assets/0acd2d5a-845e-4e57-8aec-029d76a37c94)  
```CKV_TF_1: "Ensure Terraform module sources use a commit hash"```  
Если используется git-репозиторий в качестве источника модуля, checkov рекомендует указывать хэш коммита (commit hash), а не ветку (например, main или master) или тег. Это гарантирует, что мы всегда будем использовать одну и ту же версию модуля.  
```CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"```  
Ошибка CKV_TF_2 означает, что для модулей не указана версия тега.

------
### Задание 2

1. Возьмите ваш GitHub-репозиторий с **выполненным ДЗ 4** в ветке 'terraform-04' и сделайте из него ветку 'terraform-05'.  
   [**новая ветка**](https://github.com/Daimero88/netology/tree/terraform-05/terraform-hw/04)
   
2. Повторите демонстрацию лекции: настройте YDB, S3 bucket, yandex service account, права доступа и мигрируйте state проекта в S3 с блокировками. Предоставьте скриншоты процесса в качестве ответа.  
    ![s3](https://github.com/user-attachments/assets/b0cd035f-1eb8-4bcb-897d-d62a2ffecc9e)  
    ![ydb](https://github.com/user-attachments/assets/1a5e6616-baec-4104-ba11-968aa8828f86)  
    ![table](https://github.com/user-attachments/assets/92e2f42e-fb03-4fcc-adc7-2c402f1c47a8)  
    ![tfstate](https://github.com/user-attachments/assets/02df5fb3-9a40-42b0-9b88-3633d510470b)  
   
3. Закоммитьте в ветку 'terraform-05' все изменения.  
Изменения были только в [providers.tf](https://github.com/Daimero88/netology/blob/terraform-05/terraform-hw/04/src/providers.tf), куда добавился backend
4. Откройте в проекте terraform console, а в другом окне из этой же директории попробуйте запустить terraform apply.
5. Пришлите ответ об ошибке доступа к state.  
   ![error](https://github.com/user-attachments/assets/9f7916ef-713b-4c2e-a883-166ce9e100dd)  

6. Принудительно разблокируйте state. Пришлите команду и вывод.
   ![force-unlock](https://github.com/user-attachments/assets/6aad905f-8c6f-4a39-a717-89190617affa)  

------
### Задание 3  

1. Сделайте в GitHub из ветки 'terraform-05' новую ветку 'terraform-hotfix'.  
[**terraform-hotfix**](https://github.com/Daimero88/netology/tree/terraform-hotfix)

2. Проверье код с помощью tflint и checkov, исправьте все предупреждения и ошибки в 'terraform-hotfix', сделайте коммит.  
![tflint2](https://github.com/user-attachments/assets/d79af286-88e4-4aa0-8832-2e72af523688)  
![checkov2](https://github.com/user-attachments/assets/289f1843-bbf3-49d5-97cd-adc94aa11af7)  
![commit](https://github.com/user-attachments/assets/74ecb1fb-8c0e-4064-8a2c-13834fdb7933)  

3. Откройте новый pull request 'terraform-hotfix' --> 'terraform-05'. 
4. Вставьте в комментарий PR результат анализа tflint и checkov, план изменений инфраструктуры из вывода команды terraform plan.
5. Пришлите ссылку на PR для ревью. Вливать код в 'terraform-05' не нужно.
[**pull request**](https://github.com/Daimero88/netology/pull/1)  

------
### Задание 4

1. Напишите переменные с валидацией и протестируйте их, заполнив default верными и неверными значениями. Предоставьте скриншоты проверок из terraform console. 

- type=string, description="ip-адрес" — проверка, что значение переменной содержит верный IP-адрес с помощью функций cidrhost() или regex(). Тесты:  "192.168.0.1" и "1920.1680.0.1";
- type=list(string), description="список ip-адресов" — проверка, что все адреса верны. Тесты:  ["192.168.0.1", "1.1.1.1", "127.0.0.1"] и ["192.168.0.1", "1.1.1.1", "1270.0.0.1"].  
![validIP](https://github.com/user-attachments/assets/5a4a740f-1b4c-4729-9880-56dbc2a16af7)  
Если передавать верные значения, то оишбка не возникает при вызове консоли.

------
### Задание 5*
1. Напишите переменные с валидацией:
- type=string, description="любая строка" — проверка, что строка не содержит символов верхнего регистра;  
```condition = can(regex("^[^A-Z]*$", var.uppercase_symbol))```  
![image](https://github.com/user-attachments/assets/738bfa45-0726-4a44-ae66-fc10d5e5880d)  

- type=object — проверка, что одно из значений равно true, а второе false, т. е. не допускается false false и true true:
```
variable "in_the_end_there_can_be_only_one" {
    description="Who is better Connor or Duncan?"
    type = object({
        Dunkan = optional(bool)
        Connor = optional(bool)
    })

    default = {
        Dunkan = true
        Connor = false
    }

    validation {
        error_message = "There can be only one MacLeod"
        condition = <проверка>
    }
}
```  
**Ответ**: ```condition = var.in_the_end_there_can_be_only_one.Dunkan != var.in_the_end_there_can_be_only_one.Connor```

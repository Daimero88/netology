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
   [**новая ветка**](https://github.com/Daimero88/netology/tree/terraform-05/terraform-hw/05)  
2. Повторите демонстрацию лекции: настройте YDB, S3 bucket, yandex service account, права доступа и мигрируйте state проекта в S3 с блокировками. Предоставьте скриншоты процесса в качестве ответа.
    ![s3](https://github.com/user-attachments/assets/70214002-45cb-4c9a-95a3-2242a087ed86)  
    ![ydb](https://github.com/user-attachments/assets/1a5e6616-baec-4104-ba11-968aa8828f86)  


4. Закоммитьте в ветку 'terraform-05' все изменения.
5. Откройте в проекте terraform console, а в другом окне из этой же директории попробуйте запустить terraform apply.
6. Пришлите ответ об ошибке доступа к state.
7. Принудительно разблокируйте state. Пришлите команду и вывод.


------
### Задание 3  

1. Сделайте в GitHub из ветки 'terraform-05' новую ветку 'terraform-hotfix'.
2. Проверье код с помощью tflint и checkov, исправьте все предупреждения и ошибки в 'terraform-hotfix', сделайте коммит.
3. Откройте новый pull request 'terraform-hotfix' --> 'terraform-05'. 
4. Вставьте в комментарий PR результат анализа tflint и checkov, план изменений инфраструктуры из вывода команды terraform plan.
5. Пришлите ссылку на PR для ревью. Вливать код в 'terraform-05' не нужно.

------
### Задание 4

1. Напишите переменные с валидацией и протестируйте их, заполнив default верными и неверными значениями. Предоставьте скриншоты проверок из terraform console. 

- type=string, description="ip-адрес" — проверка, что значение переменной содержит верный IP-адрес с помощью функций cidrhost() или regex(). Тесты:  "192.168.0.1" и "1920.1680.0.1";
- type=list(string), description="список ip-адресов" — проверка, что все адреса верны. Тесты:  ["192.168.0.1", "1.1.1.1", "127.0.0.1"] и ["192.168.0.1", "1.1.1.1", "1270.0.0.1"].

------
### Задание 5*
1. Напишите переменные с валидацией:
- type=string, description="любая строка" — проверка, что строка не содержит символов верхнего регистра;
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
------
### Задание 6*

1. Настройте любую известную вам CI/CD-систему. Если вы ещё не знакомы с CI/CD-системами, настоятельно рекомендуем вернуться к этому заданию после изучения Jenkins/Teamcity/Gitlab.
2. Скачайте с её помощью ваш репозиторий с кодом и инициализируйте инфраструктуру.
3. Уничтожьте инфраструктуру тем же способом.


------
### Задание 7*
1. Настройте отдельный terraform root модуль, который будет создавать YDB, s3 bucket для tfstate и сервисный аккаунт с необходимыми правами. 

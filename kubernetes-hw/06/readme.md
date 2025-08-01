# Домашнее задание к занятию «Хранение в K8s. Часть 1» - Сильчин Сергей

### Задание 1 

**Что нужно сделать**

Создать Deployment приложения, состоящего из двух контейнеров и обменивающихся данными.

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Сделать так, чтобы busybox писал каждые пять секунд в некий файл в общей директории.
3. Обеспечить возможность чтения файла контейнером multitool.
4. Продемонстрировать, что multitool может читать файл, который периодоически обновляется.
5. Предоставить манифесты Deployment в решении, а также скриншоты или вывод команды из п. 4.


**Решение**
1. Создаем [**deployment.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/06/deployment.yaml)
2. Чтобы контейнер busybox писал дату каждые 5 секунд добавляем в манифест ```command: ["/bin/sh", "-c"]``` и ```args: ["while true; do echo $(date) >> /shared-data/log.txt; sleep 5; done"]```
3. Для чтения из контейнера multitool добавляем в манифест ```command: ["/bin/sh", "-c"]``` и ```args: ["tail -f /shared-data/log.txt"]```
4. Проверяем, что multitool читает файл, который периодически обновляется командой ```kubectl logs -l app=shared-volume -c multitool```:  
![image1](https://github.com/user-attachments/assets/b0fa12c5-2e5d-4bf4-ae40-c96876153ba1)  

------

### Задание 2

**Что нужно сделать**

Создать DaemonSet приложения, которое может прочитать логи ноды.

1. Создать DaemonSet приложения, состоящего из multitool.
2. Обеспечить возможность чтения файла `/var/log/syslog` кластера MicroK8S.
3. Продемонстрировать возможность чтения файла изнутри пода.
4. Предоставить манифесты Deployment, а также скриншоты или вывод команды из п. 2.


**Решение**
1. Создаем [**daemonset.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/06/daemonset.yaml)
2. Т.к. в моей системе (Debian12) нет /var/log/syslog, то подключаею другой каталог в контейнере multitool ```args: ["tail -f /host/var/log/journal/*/system.journal"]```
3. Заходим внутрь пода и проверяем, что папка примонитировалась корректно и файлы доступны на чтение:  
![image2](https://github.com/user-attachments/assets/e64c4ae0-9731-473e-b4f8-c12efbac997c)


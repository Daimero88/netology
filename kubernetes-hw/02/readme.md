# Домашнее задание к занятию «Базовые объекты K8S» - Сильчин Сергей

### Задание 1. Создать Pod с именем hello-world

1. Создать манифест (yaml-конфигурацию) Pod.
2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Подключиться локально к Pod с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

**Решение:**  
Создали манифест (pod-hello-world.yaml)[] с указанием image gcr.io/kubernetes-e2e-test-images/echoserver:2.2  
Создали Pod и пробросили порт 8080:  
![image1](https://github.com/user-attachments/assets/3bd28b3f-0bbf-4011-93cc-1b51ba3d453f)  
Сделали curl из другого окна консоли:  
![image2](https://github.com/user-attachments/assets/d64e6be0-88c1-44a1-a2d8-b494aedfdef3)


------

### Задание 2. Создать Service и подключить его к Pod

1. Создать Pod с именем netology-web.
2. Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Создать Service с именем netology-svc и подключить к netology-web.
4. Подключиться локально к Service с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

------

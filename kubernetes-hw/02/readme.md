# Домашнее задание к занятию «Базовые объекты K8S» - Сильчин Сергей

### Задание 1. Создать Pod с именем hello-world

1. Создать манифест (yaml-конфигурацию) Pod.
2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Подключиться локально к Pod с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

**Решение:**  
Создали манифест [**pod-hello-world.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/02/pod-hello-world.yaml) с указанием image gcr.io/kubernetes-e2e-test-images/echoserver:2.2  
Создали pod и пробросили порт 8080:  
![image1](https://github.com/user-attachments/assets/3bd28b3f-0bbf-4011-93cc-1b51ba3d453f)  
Сделали curl из другого окна консоли:  
![image2](https://github.com/user-attachments/assets/d64e6be0-88c1-44a1-a2d8-b494aedfdef3)


------

### Задание 2. Создать Service и подключить его к Pod

1. Создать Pod с именем netology-web.
2. Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Создать Service с именем netology-svc и подключить к netology-web.
4. Подключиться локально к Service с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

**Решение:**  
Создали манифесты [**pod-netology-web.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/02/pod-netology-web.yaml) c label ```app: netology-web``` и [**netology-svc.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/02/netology-svc.yaml) с селектором по данному label.  
Создали pod и service, убедились, что сервис работает корректно и пробросили порт сервиса 8080 на 80 порт pod:  
![image3](https://github.com/user-attachments/assets/d77940ef-6a11-4fde-92ca-f22fd6e5e766)  
Сделали curl из другого окна консоли:  
![image4](https://github.com/user-attachments/assets/0e8040af-50e0-4975-b337-e667f387351c)  

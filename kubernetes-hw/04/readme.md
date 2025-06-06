# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 1» - Сильчин Сергей

### Задание 1. Создать Deployment и обеспечить доступ к контейнерам приложения по разным портам из другого Pod внутри кластера

1. Создать Deployment приложения, состоящего из двух контейнеров (nginx и multitool), с количеством реплик 3 шт.
2. Создать Service, который обеспечит доступ внутри кластера до контейнеров приложения из п.1 по порту 9001 — nginx 80, по 9002 — multitool 8080.
3. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложения из п.1 по разным портам в разные контейнеры.
4. Продемонстрировать доступ с помощью `curl` по доменному имени сервиса.
5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.

**Решение**  
1. Создаем [**deployment.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/04/deployment.yaml) с двумя контейнерами и тремя репликами:  
  ![image1](https://github.com/user-attachments/assets/eb17bf72-85b0-4ec6-8d47-b1d787ca6c8c)  
2. Создаем [**service.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/04/service.yaml) с необходимыми портами:  
  ![image2](https://github.com/user-attachments/assets/b233593f-1a6a-464b-9edd-c23d51b2dd86)  
3. Создаем pod для тестирования командой ```kubectl run test-multitool --image=wbitt/network-multitool --restart=Never -- sleep infinity``` и проверяем с него доступ до подов через сервис curl командами ```kubectl exec test-multitool -- curl -s http://nginx-multitool-service:9001``` и ```kubectl exec test-multitool -- curl -s http://nginx-multitool-service:9002```:  
  ![image3](https://github.com/user-attachments/assets/3ce19a42-890a-4893-aa0e-3a02204d095d)

------

### Задание 2. Создать Service и обеспечить доступ к приложениям снаружи кластера

1. Создать отдельный Service приложения из Задания 1 с возможностью доступа снаружи кластера к nginx, используя тип NodePort.
2. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
3. Предоставить манифест и Service в решении, а также скриншоты или вывод команды п.2.

**Решение**  
1. Создаем отдельный [**nodeport-service**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/04/nodeport-service.yaml) с типом NodePort:
  ![image4](https://github.com/user-attachments/assets/ef8ef626-eb13-4513-aecf-18b01ec6f68e)  
2. Проверяем curl по IP-адресу самой ноды с использованием порта 30080, указанного в манифесте:  
  ![image5](https://github.com/user-attachments/assets/3ec91645-2d17-4f13-b274-b64d80347238)

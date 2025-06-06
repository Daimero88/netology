# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 2» - Сильчин Сергей

### Задание 1. Создать Deployment приложений backend и frontend

1. Создать Deployment приложения _frontend_ из образа nginx с количеством реплик 3 шт.
2. Создать Deployment приложения _backend_ из образа multitool. 
3. Добавить Service, которые обеспечат доступ к обоим приложениям внутри кластера. 
4. Продемонстрировать, что приложения видят друг друга с помощью Service.
5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.


**Решение**  
1. Создаем [**frontend-deployment.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/05/frontend-deployment.yaml) с образом nginx и количеством реплик 3шт.
2. Создаем [**backend-deployment.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/05/backend-deployment.yaml) с образом multitool.
3. Создаем [**frontend-service**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/05/frontend-service.yaml) и [**backend-service**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/05/backend-service.yaml).
4. Запускаем deployment'ы, создаем тестовый pod командой ```kubectl run tester --image=wbitt/network-multitool --restart=Never -- sleep infinity``` и проверяем доступность сервисов командами ```kubectl exec tester -- curl -s http://frontend-service``` и ```kubectl exec tester -- curl -s http://backend-service:8080```:  
  ![image1](https://github.com/user-attachments/assets/de8e2c70-4e55-4674-b98b-907db6db4be2)  
Также берем любой frontend pod и проверяем с него доступность backend pod командой ```kubectl exec frontend-54758c4c55-2lm6z -- curl -s http://backend-service:8080```:  
  ![image2](https://github.com/user-attachments/assets/ebf04a35-6bc4-4772-a266-b4259fd4cc7d)


------

### Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера

1. Включить Ingress-controller в MicroK8S.
2. Создать Ingress, обеспечивающий доступ снаружи по IP-адресу кластера MicroK8S так, чтобы при запросе только по адресу открывался _frontend_ а при добавлении /api - _backend_.
3. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
4. Предоставить манифесты и скриншоты или вывод команды п.2.

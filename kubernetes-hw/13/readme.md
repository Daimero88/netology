# Домашнее задание к занятию «Как работает сеть в K8s» - Сильчин Сергей

### Задание 1. Создать сетевую политику или несколько политик для обеспечения доступа

1. Создать deployment'ы приложений frontend, backend и cache и соответсвующие сервисы.
2. В качестве образа использовать network-multitool.
3. Разместить поды в namespace App.
4. Создать политики, чтобы обеспечить доступ frontend -> backend -> cache. Другие виды подключений должны быть запрещены.
5. Продемонстрировать, что трафик разрешён и запрещён.

**Решение**  
1. Создаем deployment'ы: [**frontend-deployment.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/13/frontend-deployment.yaml), [**backend-deployment.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/13/backend-deployment.yaml), [**cache-deployment.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/13/cache-deployment.yaml)  
  Создаем сервисы: [**frontend-service.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/13/frontend-service.yaml), [**backend-service.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/13/backend-service.yaml), [**cache-service.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/13/cache-service.yaml)
2. Создаем namespace командой ```kubectl create namespace app``` и применяем созданные deployment'ы и сервисы.  
   Проверяем, что все создалось, командой ```kubectl get pods,svc -n app```:  
   ![image1](https://github.com/user-attachments/assets/6701ae06-a165-493f-9c23-29ae8712beb1)  
3. Создаем сетевые политики: [**front-to-back-netpolicy.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/13/front-to-back-netpolicy.yaml), [**back-to-cache-netpolicy.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/13/back-to-cache-netpolicy.yaml), и общую запрещающую политику [**deny-all-ingress.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/13/deny-all-ingress.yaml) и применяем их.  
  Проверяем, что все создалось, командой ```kubectl get networkpolicies -n app```:  
  ![image2](https://github.com/user-attachments/assets/9f5ebf68-e2ce-4969-ae91-278da3e10ce8)  
4. Проверим, что доступы из подов frontend в backend и из backend в cache разрешены:  
   ![image3](https://github.com/user-attachments/assets/f6c0e62a-6841-42e0-8a0b-76673e671c2e)  
   ![image4](https://github.com/user-attachments/assets/739c45f4-8a4e-423d-8791-ada83815e9fc)  
   Убедимся, что другие виды подключений запрещены:
    - из backend в frontend:  
      ![image5](https://github.com/user-attachments/assets/43e626fa-a07e-43be-9d36-fb2018db58d6)  
    - из frontend в cache:  
      ![image6](https://github.com/user-attachments/assets/bd5b5042-69c8-4ddf-9939-6baec2dbcccc)  
    - из cache в frontend и backend:  
      ![image7](https://github.com/user-attachments/assets/68174496-8f8c-4071-9adc-9178056ba2df)




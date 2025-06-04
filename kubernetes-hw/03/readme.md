# Домашнее задание к занятию «Запуск приложений в K8S» - Сильчин Сергей

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.
2. После запуска увеличить количество реплик работающего приложения до 2.
3. Продемонстрировать количество подов до и после масштабирования.
4. Создать Service, который обеспечит доступ до реплик приложений из п.1.
5. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложений из п.1.

**Решение**  
1. Создали [**deployment.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/03/deployment.yaml) и запустили командой ```kubectl apply -f deployment.yaml```  
  Команда ```kubectl get pods``` выдает статус одного из контейнеров CrashLoopBackOff:  
  ![image1](https://github.com/user-attachments/assets/3717a180-282d-4147-8b1f-0785e687e219)  
  Это происходит из-за того, что контейнер multitool завершает свою работу после запуска, так как не имеет долгоживущего процесса. Для решения проблемы добавляем команду ```command: ["/bin/sh", "-c", "sleep infinity"]``` для поддержания работы контейнера. После применяем изменения и убеждаемся, что статус поменялся на running:  
  ![image2](https://github.com/user-attachments/assets/daccfdd6-4376-46ec-935d-c77dbb3f5822)  
2. Увеличиваем количество реплик до 2 командой ```kubectl scale deployment nginx-multitool --replicas=2``` и проверяем, что теперь их 2:  
   ![image3](https://github.com/user-attachments/assets/83f1ae4f-5787-4080-94a1-72d7cc1ece01)
3. Создаем [**service.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/03/service.yaml) с selector ```app: nginx-multitool``` для доступа до реплик и применяем его командой ```kubectl apply -f service.yaml```:  
   ![image4](https://github.com/user-attachments/assets/72edde22-9945-4b37-a429-d4a98d31e27d)  
4. Создаем отдельный pod [**multitool-pod.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/03/multitool-pod.yaml), применяем его командой ```kubectl apply -f multitool-pod.yaml```.  
  Проверяем командой ```kubectl exec -it multitool-test -- curl nginx-multitool-service``` доступ до приложений:  
  ![image5](https://github.com/user-attachments/assets/e496c4a4-5eba-44e9-bcd2-d642b97b0fe4)  

------

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.
2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.
3. Создать и запустить Service. Убедиться, что Init запустился.
4. Продемонстрировать состояние пода до и после запуска сервиса.


# Домашнее задание к занятию «Helm» - Сильчин Сергей

### Задание 1. Подготовить Helm-чарт для приложения

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. Каждый компонент приложения деплоится отдельным deployment’ом или statefulset’ом.
3. В переменных чарта измените образ приложения для изменения версии.

**Решение**
1. Создаем чарт командой ```helm create myapp-chart```, наполняем его файлами для деплоя nginx и redis.
2. Находясь в папке с чартом, устанавливаем его командой ```helm install myapp .```:  
   ![image1](https://github.com/user-attachments/assets/274ea367-fb2b-4501-9f4b-c8558e177abd)  
   Проверяем, что все создалось:  
   ![image2](https://github.com/user-attachments/assets/c7dda5eb-1245-4bc7-90db-b3237505e709)  
3. Попробуем изменить образ приложения, поменяв версию nginx командой ```helm upgrade myapp . --set nginx.image="nginx:1.26.0"```:  
   ![image3](https://github.com/user-attachments/assets/094031cf-aa45-428a-8be5-90dabf5e9c7a)  
   Видим, что старый под удалился, а новый с версией 1.26.0 создался


------
### Задание 2. Запустить две версии в разных неймспейсах

1. Подготовив чарт, необходимо его проверить. Запуститe несколько копий приложения.
2. Одну версию в namespace=app1, вторую версию в том же неймспейсе, третью версию в namespace=app2.
3. Продемонстрируйте результат.

**Решение**
1. Создадим два новых namespace app1 и app2 командами
   ```
   kubectl create namespace app1
   kubectl create namespace app2
   ```  
   Запустим несколько копий приложения, изменив namespace и версии приложений командами:
   ```
   helm install v1-app1 . --namespace app1 --set nginx.image="nginx:1.25.0" --set redis.image="redis:7.2-alpine"
   helm install v2-app1 . --namespace app1 --set nginx.image="nginx:1.26.0" --set redis.image="redis:7.0-alpine"
   helm install v3-app2 . --namespace app2 --set nginx.image="nginx:latest" --set redis.image="redis:latest"
   ```
   
3. Проверим, что установилось 3 версии приложения:  
  ![image4](https://github.com/user-attachments/assets/5aead39d-ed97-47bf-a535-1f8afbc59168)  
  ![image5](https://github.com/user-attachments/assets/249ae4f3-d06c-4562-b147-f0db636e9ba9)  
   Также проверяем, что все поды и сервисы в статусе Running:  
   ![image6](https://github.com/user-attachments/assets/92d7cc8d-973a-4a39-be06-ea90cd3a3f6b)  
   И проверим, что в каждом поде версии nginx, указанные при установке:
   ![image7](https://github.com/user-attachments/assets/d12d556c-4fa1-4d3e-8e78-f00c59783584)



# Домашнее задание к занятию «Конфигурация приложений» - Сильчин Сергей

### Задание 1. Создать Deployment приложения и решить возникшую проблему с помощью ConfigMap. Добавить веб-страницу

1. Создать Deployment приложения, состоящего из контейнеров nginx и multitool.
2. Решить возникшую проблему с помощью ConfigMap.
3. Продемонстрировать, что pod стартовал и оба конейнера работают.
4. Сделать простую веб-страницу и подключить её к Nginx с помощью ConfigMap. Подключить Service и показать вывод curl или в браузере.
5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.


**Решение**  
1. Создаем [**Deployment.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/08/deployment.yaml) состоящего из двух контейнеров.
2. Проблема возникает в связи с тем, что оба контейнера по умолчанию пытаются слушать порт 80. Исправим это через [**ConfigMap**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/08/multitool-config.yaml), где добавим пару ключ:значение ```HTTP_PORT: "8080"``` и передадим ее через ```env``` в Deployment, заменив в контейнере multitool порт c 80 на 8080.
3. Проверяем, что pod стартовал командой ```kubectl get pods``` и убеждаемся, что статус Running:  
  ![image1](https://github.com/user-attachments/assets/b6bec36c-04ec-4544-8b13-4e5c323b4e7e)
4. Создаем страницу через ConfigMap [**nginx-html**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/08/nginx-html.yaml), подключаем ее через ```volume``` в Deployment и добавляем ее по пути ```mountPath: /usr/share/nginx/html``` в контейнер nginx.  
  Подключаем [**Service**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/08/service.yaml) и проверяем через curl:
  ![image2](https://github.com/user-attachments/assets/bccdd406-03c9-48db-9f81-9f65748653b5)

------

### Задание 2. Создать приложение с вашей веб-страницей, доступной по HTTPS 

1. Создать Deployment приложения, состоящего из Nginx.
2. Создать собственную веб-страницу и подключить её как ConfigMap к приложению.
3. Выпустить самоподписной сертификат SSL. Создать Secret для использования сертификата.
4. Создать Ingress и необходимый Service, подключить к нему SSL в вид. Продемонстировать доступ к приложению по HTTPS. 
5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.


**Решение**  
1. Создаем

Проверяем с помощью curl, что страница доступна через https:  
![image3](https://github.com/user-attachments/assets/a71ce912-db86-4b6a-bb47-49b8eb572161)

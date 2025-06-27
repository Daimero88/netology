# Домашнее задание к занятию «Обновление приложений» - Сильчин Сергей

### Задание 1. Выбрать стратегию обновления приложения и описать ваш выбор

1. Имеется приложение, состоящее из нескольких реплик, которое требуется обновить.
2. Ресурсы, выделенные для приложения, ограничены, и нет возможности их увеличить.
3. Запас по ресурсам в менее загруженный момент времени составляет 20%.
4. Обновление мажорное, новые версии приложения не умеют работать со старыми.
5. Вам нужно объяснить свой выбор стратегии обновления приложения.

### Решение:
Оптимальной стратегией обновления приложения будет rolling update с дополнительными настройками, обеспечивающими безопасность обновления в условиях ограниченных ресурсов и несовместимости версий.
Rolling update выбран потому что:
1. Постепенное обновление – rolling update заменяет поды по одному (или небольшими группами), что позволяет минимизировать простои и держать приложение доступным.
2. Работа в рамках ограниченных ресурсов – так как нет возможности увеличить ресурсы, стратегии, требующие временного удвоения реплик (например, blue-green или canary), не подходят. Rolling Update обходится текущими ресурсами.
3. Контроль над процессом – можно настроить параметры maxSurge (сколько дополнительных подов можно создать) и maxUnavailable (сколько подов могут быть недоступны во время обновления).

Настройки для данного случая:  
maxSurge: 0 – Запрещает создание дополнительных подов сверх желаемого количества, так как нет свободных ресурсов  
maxUnavailable: 20% – Позволяет выводить из работы не более 20% подов за раз, что соответствует запасу по ресурсам  

Почему не другие стратегии?  
Recreate – убирает все старые поды перед созданием новых, что приводит к простою. Не подходит, так как требуется минимальный даунтайм.  
Blue-Green – требует развертывания второй полноценной копии приложения, что невозможно из-за нехватки ресурсов.  
Canary – Тоже требует дополнительных ресурсов для параллельного запуска новой версии.  

---

### Задание 2. Обновить приложение

1. Создать deployment приложения с контейнерами nginx и multitool. Версию nginx взять 1.19. Количество реплик — 5.
2. Обновить версию nginx в приложении до версии 1.20, сократив время обновления до минимума. Приложение должно быть доступно.
3. Попытаться обновить nginx до версии 1.28, приложение должно оставаться доступным.
4. Откатиться после неудачного обновления.

### Решение:  
1. Создаем [**deployment.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/14/deployment.yaml) и применяем его командой ```kubectl apply -f deployment.yaml```  
   И проверяем что поды создались командой ```kubectl get pods```:  
   ![image1](https://github.com/user-attachments/assets/3a9a55e5-af67-42ee-863c-ad68eb857849)  
2. Обновляем nginx до версии 1.20 командой ```kubectl set image deployment/nginx-multitool nginx=nginx:1.20``` и проверяем, что новые контейнеры постепенно создаются, а старые постепенно удаляются командой ```kubectl get pods -w```:  
  ![image2](https://github.com/user-attachments/assets/d5e27036-2fe3-4510-b24b-20976df7e1fe)  
Убеждаемся, что все поды работают:
  ![image3](https://github.com/user-attachments/assets/c56f89e6-80f9-4fb6-97b6-1190c126d675)
3. Попытаемся обновить nginx до несуществующей версии командой ```kubectl set image deployment/nginx-multitool nginx=nginx:1.28```  
   Командой ```kubectl get pods``` увидим, что новые поды в статусе Terminating, а предыдущие в статусе Running:  
   ![image3](https://github.com/user-attachments/assets/2b2a8087-f345-4f89-9557-6e0cb5ee8106)  
 Приложение остается доступным, так как старые поды (nginx:1.20) продолжают работать.
4. Проверяем, что в текущем deployment установлена версия nginx:1.28 командой ```kubectl describe deployment nginx-multitool```:  
   ![image5](https://github.com/user-attachments/assets/fc5282b5-540f-4f87-8b50-279ebef347a3)  
   Выполняем откат командой ```kubectl rollout undo deployment/nginx-multitool```  
   И проверяем командой ```kubectl describe deployment nginx-multitool```, что версия nginx вернулась к предыдущей 1.20:  
   ![image6](https://github.com/user-attachments/assets/d0aef469-6c1a-4ff4-a7c9-3dd29132b498)  
   И поды также продолжают работать:  
   ![image7](https://github.com/user-attachments/assets/675bae8a-fd9e-4a6c-bfa3-a2b8d3a664f3)
   
---

### Задание 3*. Создать Canary deployment

1. Создать два deployment'а приложения nginx.
2. При помощи разных ConfigMap сделать две версии приложения — веб-страницы.
3. С помощью ingress создать канареечный деплоймент, чтобы можно было часть трафика перебросить на разные версии приложения.

### Решение:  
1. Создаем [**main-deployment.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/14/main-deployment.yaml) и [**canary-deployment.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/14/canary-deployment.yaml). Также создаем сервисы: [**main-service.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/14/main-service.yaml) и [**canary-service.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/14/canary-service.yaml)
2. Создаем [**main-configmap.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/14/main-version-configmap.yaml) и [**canary-configmap.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/14/canary-version-configmap.yaml) с разными версиями страницы
3. Создаем [**nginx-main-ingress.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/14/nginx-main-ingress.yaml) и [**nginx-canary-ingress.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/14/nginx-canary-ingress.yaml)  
   Создадим запись в файле /etc/hosts ```127.0.0.1 myapp.example.com``` и проверяем, что запросы распределяют трафик между основной и канареечной версиями согласно заданному весу (80/20):  
   ![image8](https://github.com/user-attachments/assets/64a85252-91e9-4b7d-be74-cc919bcf8c61)


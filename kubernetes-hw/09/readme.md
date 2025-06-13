# Домашнее задание к занятию «Управление доступом» - Сильчин Сергей

### Задание 1. Создайте конфигурацию для подключения пользователя

1. Создайте и подпишите SSL-сертификат для подключения к кластеру.
2. Настройте конфигурационный файл kubectl для подключения.
3. Создайте роли и все необходимые настройки для пользователя.
4. Предусмотрите права пользователя. Пользователь может просматривать логи подов и их конфигурацию (`kubectl logs pod <pod_id>`, `kubectl describe pod <pod_id>`).
5. Предоставьте манифесты и скриншоты и/или вывод необходимых команд.

**Решение**  
1. Создаем ключ для пользователя командой ```openssl genrsa -out ssilchin.key 2048```  
   Создаем CSR (Certificate Signing Request) командой ```openssl req -new -key ssilchin.key -out ssilchin.csr -subj "/CN=ssilchin/O=netology"```  
   Подписываем CSR командой ```openssl x509 -req -in ssilchin.csr -CA /var/snap/microk8s/current/certs/ca.crt -CAkey /var/snap/microk8s/current/certs/ca.key -CAcreateserial -out ssilchin.crt -days 365```  
   Консоль возвращает успешное выполнение выпуска подписанного сертификата:  
   ![image1](https://github.com/user-attachments/assets/ed196494-bff5-4841-a30d-2cc01a2340d3)
2. Добавляем пользователя в конфиг kubectl командой ```kubectl config set-credentials ssilchin --client-certificate=ssilchin.crt --client-key=ssilchin.key```:  
   ![image2](https://github.com/user-attachments/assets/d79db286-3362-4292-aff6-de06c5f2cffc)
   Добавляем контекст командой ```kubectl config set-context ssilchin-context --cluster=microk8s-cluster --user=ssilchin```:
   ![image3](https://github.com/user-attachments/assets/cc8f644e-a348-4a60-9c6f-b4aa66525a96)
   Проверяем командой ```kubectl --context=ssilchin-context get pods```, что контекст создан, но получаем ошибку доступа, т.к. RBAC еще не настроен:  
   ![image4](https://github.com/user-attachments/assets/3bdeb228-3d76-46be-b492-01a59fd13c46)  
3. 


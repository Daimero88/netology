# Домашнее задание к занятию «Kubernetes. Причины появления. Команда kubectl» - Сильчин Сергей

### Задание 1. Установка MicroK8S

1. Установить MicroK8S на локальную машину или на удалённую виртуальную машину.
   Устанавливаем с помощью команд  
```  
  apt install snapd  
  snap install microk8s --classic  
  usermod -a -G microk8s admin  
  chown -f -R admin ~/.kube  
  newgrp microk8s  
```
2. Установить dashboard.  
   Устанавливается командой ```microk8s enable dashboard```
   
3. Сгенерировать сертификат для подключения к внешнему ip-адресу.  
   Добавляем в файл /var/snap/microk8s/current/certs/csr.conf.template ip-адрес сервера в блок alt_names и генерируем сертификат для подключения ```microk8s refresh-certs --cert front-proxy-client.crt```

------

### Задание 2. Установка и настройка локального kubectl

1. Установить на локальную машину kubectl.
   Устанавливаем командами:
```
  curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl  
  chmod +x ./kubectl  
  sudo mv ./kubectl /usr/local/bin/kubectl  
```

2. Настроить локально подключение к кластеру.
   Генерируем файл конфигурации ```microk8s config``` и копируем его по пути ~/.kube/config ```microk8s config > config```
   
3. Подключиться к дашборду с помощью port-forward.
   По умолчанию kubectl port-forward биндится только на 127.0.0.1. Чтобы разрешить внешний доступ, используем команду:  
   ```microk8s kubectl port-forward -n kube-system --address 0.0.0.0 service/kubernetes-dashboard 10443:443```  
  Для подключения необходим токен, который генерируется на сервере командой ```microk8s kubectl create token default```  
  После вставляем полученный токен и открывается dashboard:    
![image2](https://github.com/user-attachments/assets/2216b78c-b7bc-4ba9-a07e-eeb26f52a01c)


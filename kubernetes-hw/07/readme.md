# Домашнее задание к занятию «Хранение в K8s. Часть 2» - Сильчин Сергей

### Задание 1

Создать Deployment приложения, использующего локальный PV, созданный вручную.

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Создать PV и PVC для подключения папки на локальной ноде, которая будет использована в поде.
3. Продемонстрировать, что multitool может читать файл, в который busybox пишет каждые пять секунд в общей директории. 
4. Удалить Deployment и PVC. Продемонстрировать, что после этого произошло с PV. Пояснить, почему.
5. Продемонстрировать, что файл сохранился на локальном диске ноды. Удалить PV.  Продемонстрировать что произошло с файлом после удаления PV. Пояснить, почему.
6. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

**Решение**  
1. Создаем [**deployment.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/07/deployment.yaml), состоящий из контейнеров busybox и multitool.
2. Создаем [**local-pv.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/07/local-pv.yaml) и [**local-pvc.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/07/local-pvc.yaml) для подключения папки на локальной ноде.
3. Проверяем, что multitool может читать файл, в который busybox пишет каждые 5 секунд дату командой ```kubectl exec -it busybox-multitool-76cc96f888-vpjfw -c multitool -- cat /shared-data/log.txt```:  
  ![image1](https://github.com/user-attachments/assets/7ee8682e-ba12-4e21-8ef7-019480ea6dcd)  
4. Удаляем Deployment и PVC. Видим, что у PV статус поменялся на Released (а не Available), потому что мы установили ```persistentVolumeReclaimPolicy: Retain```. Это означает, что том не будет автоматически удален или очищен:  
  ![image2](https://github.com/user-attachments/assets/8edc2332-4c84-4bfe-bfba-e61a38c42f63)  
5. Проверяем файл на ноде, видим, что он сохранился со всеми записями:  
  ![image3](https://github.com/user-attachments/assets/c7aca2e5-6b97-4359-ba61-8f6e964ce387)
  Удаляем PV и видим, что файл и данные в нем остались, т.к. удаление PV не удаляет данные на диске и является по сути лишь ссылкой на существующую директорию:
  ![image4](https://github.com/user-attachments/assets/e399cc16-8d28-488b-8a3d-1e64ff1ed337)


------

### Задание 2

Создать Deployment приложения, которое может хранить файлы на NFS с динамическим созданием PV.

1. Включить и настроить NFS-сервер на MicroK8S.
2. Создать Deployment приложения состоящего из multitool, и подключить к нему PV, созданный автоматически на сервере NFS.
3. Продемонстрировать возможность чтения и записи файла изнутри пода. 
4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.


**Решение**  
1. Включаем и настраиваем NFS-сервер на MicroK8S:
```
  microk8s enable helm3 rbac
  microk8s helm3 repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
  microk8s helm3 install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=$(hostname -I | awk '{print $1}') \
    --set nfs.path=/srv/nfs \
    --set storageClass.defaultClass=true
```
  Проверим, что StorageClass создан:  
  ![image5](https://github.com/user-attachments/assets/a88a2a4b-5810-42cb-9462-74c5b8be4822)  
  2. Создаем [**deployment-nfs.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/07/deployment-nfs.yaml) и [**nfs-pvc.yaml**](https://github.com/Daimero88/netology/blob/main/kubernetes-hw/07/nfs-pvc.yaml) и запускаем их:  
  ![image6](https://github.com/user-attachments/assets/405cf02f-2678-443a-8013-8688abd70fc8)  
  Проверяем, что все успешно создалось:  
  ![image7](https://github.com/user-attachments/assets/e461d8cb-dff4-4a80-8824-71ed8d124c10)  
  3. Запишем в файл из пода командой ```microk8s kubectl exec -it multitool-nfs-5b87784887-jpmw4 -- sh -c "echo 'Hello world' > /shared-data/test.txt"``` затем проверим командой ```microk8s kubectl exec -it multitool-nfs-5b87784887-jpmw4 -- cat /shared-data/test.txt```
  ![image8](https://github.com/user-attachments/assets/d2341942-8bde-4bd5-ab67-0f70a43e23f2)  
  Проверим файл на сервере:  
  ![image9](https://github.com/user-attachments/assets/cb1a928d-b4ae-4cab-99db-ee3b368e5313)



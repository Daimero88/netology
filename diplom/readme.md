# Дипломный практикум в Yandex.Cloud - Сильчин Сергей
  * [Цели:](#цели)
  * [Этапы выполнения:](#этапы-выполнения)
     * [Создание облачной инфраструктуры](#создание-облачной-инфраструктуры)
     * [Создание Kubernetes кластера](#создание-kubernetes-кластера)
     * [Создание тестового приложения](#создание-тестового-приложения)
     * [Подготовка cистемы мониторинга и деплой приложения](#подготовка-cистемы-мониторинга-и-деплой-приложения)
     * [Установка и настройка CI/CD](#установка-и-настройка-cicd)
  * [Что необходимо для сдачи задания?](#что-необходимо-для-сдачи-задания)

---
## Цели:

1. Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.
2. Запустить и сконфигурировать Kubernetes кластер.
3. Установить и настроить систему мониторинга.
4. Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.
5. Настроить CI для автоматической сборки и тестирования.
6. Настроить CD для автоматического развёртывания приложения.

---
## Этапы выполнения:


### Создание облачной инфраструктуры

Для начала необходимо подготовить облачную инфраструктуру в ЯО при помощи [Terraform](https://www.terraform.io/).

Предварительная подготовка к установке и запуску Kubernetes кластера.

1. Создайте сервисный аккаунт, который будет в дальнейшем использоваться Terraform для работы с инфраструктурой с необходимыми и достаточными правами. Не стоит использовать права суперпользователя
2. Подготовьте [backend](https://developer.hashicorp.com/terraform/language/backend) для Terraform:  
   а. Рекомендуемый вариант: S3 bucket в созданном ЯО аккаунте(создание бакета через TF)
   б. Альтернативный вариант:  [Terraform Cloud](https://app.terraform.io/)
3. Создайте конфигурацию Terrafrom, используя созданный бакет ранее как бекенд для хранения стейт файла. Конфигурации Terraform для создания сервисного аккаунта и бакета и основной инфраструктуры следует сохранить в разных папках.
4. Создайте VPC с подсетями в разных зонах доступности.
5. Убедитесь, что теперь вы можете выполнить команды `terraform destroy` и `terraform apply` без дополнительных ручных действий.

Ожидаемые результаты:

1. Terraform сконфигурирован и создание инфраструктуры посредством Terraform возможно без дополнительных ручных действий, стейт основной конфигурации сохраняется в бакете или Terraform Cloud
2. Полученная конфигурация инфраструктуры является предварительной, поэтому в ходе дальнейшего выполнения задания возможны изменения.

### Решение создания облачной инфраструктуры:  
1. Создаем сервисный аккаунт из папки [**service-account**](https://github.com/Daimero88/netology/tree/main/diplom/service-account) с правами editor. Для дальнейшей работы из под этого сервисного аккаунта понадобятся его id и ключ, их выводим в output как sensitive данные, которые можно будет затем увидеть командами ```terraform output -json service_account_keys | jq -r '.access_key'``` и ```terraform output -json service_account_keys | jq -r '.secret_key'``` . Они нам понадобятся в дальнейшем в terraform.tfvars файлах:  
   <img width="1116" height="685" alt="image1" src="https://github.com/user-attachments/assets/26c2a12f-20c2-4820-8c53-a9b84f6e28e6" />
   Убеждаемся, что сервисный аккаунт создан:  
   <img width="478" height="107" alt="image2" src="https://github.com/user-attachments/assets/ceb6425a-b716-4f9c-9040-87024eec7bda" />  

2. Подготавливаем папку [**backend**](https://github.com/Daimero88/netology/tree/main/diplom/backend), где в файле terraform.tfvars вставляем полученные ранее id и ключ при создании сервисного аккаунта (пример в [**terraform.tfvars.example**](https://github.com/Daimero88/netology/blob/main/diplom/backend/terraform.tfvars.example)). В [**main.tf**](https://github.com/Daimero88/netology/blob/main/diplom/backend/main.tf) создаем s3-bucket с именем ssilchin-diplom:
   <img width="505" height="536" alt="image3" src="https://github.com/user-attachments/assets/9952db07-5b79-4b7a-acf8-89597ec72950" />
   <img width="696" height="135" alt="image4" src="https://github.com/user-attachments/assets/614fa4b6-34ce-43f4-a212-3818fda70e3d" />

3. Подготавливаем папку [**infrastructure**](https://github.com/Daimero88/netology/tree/main/diplom/infrastructure), где в [**main.tf**](https://github.com/Daimero88/netology/blob/main/diplom/infrastructure/main.tf) описываем ранее созданный бакет как бекенд для хранения стейт файла terraform.tfstate. Так как мы не можем использовать переменные в блоке backend "s3", то запишем значения ключей в файл backend.hcl (пример в [**backend.hcl.example**](https://github.com/Daimero88/netology/blob/main/diplom/infrastructure/backend.hcl.example)), и запустим инициализацию с ключом ```terraform init -backend-config=backend.hcl```. После применения убедимся, что файл terraform.tfstate создался в нашем бакете:  
  <img width="892" height="243" alt="image5" src="https://github.com/user-attachments/assets/0f7d3c61-3e13-4cb6-a173-0b92072448c4" />

5. Также в [**main.tf**](https://github.com/Daimero88/netology/blob/main/diplom/infrastructure/main.tf) описываем создание VPC с подсетями в разных зонах доступности (ru-central1-a,ru-central1-b,ru-central1-d) и применяем его:  
   <img width="479" height="164" alt="image6" src="https://github.com/user-attachments/assets/30c93db4-1e54-4757-a616-1fdf9cbd4296" />  
   Убеждаемся, что сети созданы в различных зонах:  
   <img width="1037" height="543" alt="image7" src="https://github.com/user-attachments/assets/c865f675-09d6-41c6-81ea-ce86d0dc26a9" />  

---
### Создание Kubernetes кластера

На этом этапе необходимо создать [Kubernetes](https://kubernetes.io/ru/docs/concepts/overview/what-is-kubernetes/) кластер на базе предварительно созданной инфраструктуры. Требуется обеспечить доступ к ресурсам из Интернета.

1. Рекомендуемый вариант: самостоятельная установка Kubernetes кластера.  
   а. При помощи Terraform подготовить как минимум 3 виртуальных машины Compute Cloud для создания Kubernetes-кластера. Тип виртуальной машины следует выбрать самостоятельно с учётом требовании к производительности и стоимости. Если в дальнейшем поймете, что необходимо сменить тип инстанса, используйте Terraform для внесения изменений.  
   б. Подготовить [ansible](https://www.ansible.com/) конфигурации, можно воспользоваться, например [Kubespray](https://kubernetes.io/docs/setup/production-environment/tools/kubespray/)  
   в. Задеплоить Kubernetes на подготовленные ранее инстансы, в случае нехватки каких-либо ресурсов вы всегда можете создать их при помощи Terraform.
  
Ожидаемый результат:

1. Работоспособный Kubernetes кластер.
2. В файле `~/.kube/config` находятся данные для доступа к кластеру.
3. Команда `kubectl get pods --all-namespaces` отрабатывает без ошибок.

### Решение создания Kubernetes кластера  
1. Описываем в [**k8s-nodes.tf**](https://github.com/Daimero88/netology/blob/main/diplom/infrastructure/k8s-nodes.tf) создание виртуальных машин, размещенных в ранее созданных сетях:
   <img width="576" height="232" alt="image8" src="https://github.com/user-attachments/assets/b15bbce6-1097-401e-9eb1-c553bb531ed2" />
2. Воспользуемся Kubespray для деплоя кластера. Для этого склонируем его репозиторий ```git clone https://github.com/kubernetes-sigs/kubespray```, перейдем в скачанную папку, включим виртуальное окружение и установим необходимые зависимости `pip install -r requirements.txt`.
   После скопируем папку `cp -rfp inventory/sample inventory/mycluster` и отредактируем файлы inventory/mycluster/inventory.ini, куда добавим IP адреса созданных ВМ, в group_vars/all/all.yml добавим версию `kube_version: 1.32.0`, а в inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml добавим `supplementary_addresses_in_ssl_keys:`, который будет содержать значение внешнего IP-адреса мастера в сертификате.
3. После запуска `ansible-playbook -i inventory/mycluster/inventory.ini cluster.yml -b -v` получаем успешный результат:
   <img width="922" height="82" alt="image9" src="https://github.com/user-attachments/assets/67415302-b58e-4f60-9e0f-164738b3769c" />   
4. Забираем файл конфигурации с сервера для подключения к кластеру `ssh ubuntu@51.250.71.224 "sudo cat /etc/kubernetes/admin.conf" > ~/.kube/config`, меняем внутри файла адрес сервера 127.0.0.1 на наш внешний ip мастера и даем на него права `chmod 600 ~/.kube/config`. После чего проверяем доступ командой `kubectl get pods -n kube-system`:  
   <img width="479" height="310" alt="image10" src="https://github.com/user-attachments/assets/0c5ba3e3-d5f7-4ced-a8b4-c994abe62f7f" />  
  

---
### Создание тестового приложения

Для перехода к следующему этапу необходимо подготовить тестовое приложение, эмулирующее основное приложение разрабатываемое вашей компанией.

Способ подготовки:

1. Рекомендуемый вариант:  
   а. Создайте отдельный git репозиторий с простым nginx конфигом, который будет отдавать статические данные.  
   б. Подготовьте Dockerfile для создания образа приложения.  

Ожидаемый результат:

1. Git репозиторий с тестовым приложением и Dockerfile.
2. Регистри с собранным docker image. В качестве регистри может быть DockerHub или [Yandex Container Registry](https://cloud.yandex.ru/services/container-registry), созданный также с помощью terraform.

### Решение создания тестового приложения  
1. Добавим файл [**ycr.tf**](https://github.com/Daimero88/netology/blob/main/diplom/infrastructure/ycr.tf), который создаст Yandex Container Registry.
2. Создадим новый репозиторий [**test-nginx-app**](https://github.com/Daimero88/test-nginx-app), который наполним файлами [**Dockerfile**](https://github.com/Daimero88/test-nginx-app/blob/main/Dockerfile), [**index.html**](https://github.com/Daimero88/test-nginx-app/blob/main/index.html) и [**nginx.conf**](https://github.com/Daimero88/test-nginx-app/blob/main/nginx.conf)
3. Соберем локально образ ```docker build -t cr.yandex/crpvsmu99smr232mo9ci/test-nginx:1.1 .``` и запушим его в наш регистри ```docker push cr.yandex/crpvsmu99smr232mo9ci/test-nginx:1.1```


---
### Подготовка cистемы мониторинга и деплой приложения

Уже должны быть готовы конфигурации для автоматического создания облачной инфраструктуры и поднятия Kubernetes кластера.  
Теперь необходимо подготовить конфигурационные файлы для настройки нашего Kubernetes кластера.

Цель:
1. Задеплоить в кластер [prometheus](https://prometheus.io/), [grafana](https://grafana.com/), [alertmanager](https://github.com/prometheus/alertmanager), [экспортер](https://github.com/prometheus/node_exporter) основных метрик Kubernetes.
2. Задеплоить тестовое приложение, например, [nginx](https://www.nginx.com/) сервер отдающий статическую страницу.

Способ выполнения:
1. Воспользоваться пакетом [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus), который уже включает в себя [Kubernetes оператор](https://operatorhub.io/) для [grafana](https://grafana.com/), [prometheus](https://prometheus.io/), [alertmanager](https://github.com/prometheus/alertmanager) и [node_exporter](https://github.com/prometheus/node_exporter). Альтернативный вариант - использовать набор helm чартов от [bitnami](https://github.com/bitnami/charts/tree/main/bitnami).

### Решение подготовки cистемы мониторинга  
1. Добавим helm репозиторий `helm repo add prometheus-community https://prometheus-community.github.io/helm-charts`, и запустим установку командой `helm install kube-prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace`  
   Проверим, что все поды в namespace monitoring запустились:  
   <img width="800" height="263" alt="image12" src="https://github.com/user-attachments/assets/d87e1524-be7b-469d-8151-784a6d041cb0" />  
2. Для деплоя тестового приложения папке [**k8s-configs**](https://github.com/Daimero88/netology/tree/main/diplom/k8s-configs) создадим [**namespace.yaml**](https://github.com/Daimero88/netology/blob/main/diplom/k8s-configs/namespace.yaml),[**deployment.yaml**](https://github.com/Daimero88/netology/blob/main/diplom/k8s-configs/deployment.yaml) и [**service.yaml**](https://github.com/Daimero88/netology/blob/main/diplom/k8s-configs/service.yaml) и применим их:  
   <img width="765" height="72" alt="image13" src="https://github.com/user-attachments/assets/d1d6cadb-bf85-42d0-bb45-69a997403f60" />  
3. Для того чтобы и grafana и наше приложение работали по одному 80 порту, установим ingress-nginx контроллер из helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx и запустим со следующими параметрами `helm install my-nginx-ingress-controller ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace --set controller.hostNetwork=true --set controller.service.enabled=false`. Далее напишем app-ingress.yaml и grafana-ingress.yaml и применим их.
   Убедимся, что по внешнему IP открывается grafana:  
   <img width="1900" height="832" alt="image15" src="https://github.com/user-attachments/assets/0e8e8749-34d9-4127-938d-81f984d2f474" />  
   А по адресу http:<ip>/app откроется наша статичная страница:  
   <img width="478" height="151" alt="image" src="https://github.com/user-attachments/assets/5e83fbf9-13df-4063-a580-e06e678a8f49" />  


### Деплой инфраструктуры в terraform pipeline

1. Если на первом этапе вы не воспользовались [Terraform Cloud](https://app.terraform.io/), то задеплойте и настройте в кластере [atlantis](https://www.runatlantis.io/) для отслеживания изменений инфраструктуры. Альтернативный вариант 3 задания: вместо Terraform Cloud или atlantis настройте на автоматический запуск и применение конфигурации terraform из вашего git-репозитория в выбранной вами CI-CD системе при любом комите в main ветку. Предоставьте скриншоты работы пайплайна из CI/CD системы.

Ожидаемый результат:
1. Git репозиторий с конфигурационными файлами для настройки Kubernetes.
2. Http доступ на 80 порту к web интерфейсу grafana.
3. Дашборды в grafana отображающие состояние Kubernetes кластера.
4. Http доступ на 80 порту к тестовому приложению.
5. Atlantis или terraform cloud или ci/cd-terraform

### Деплой инфраструктуры в terraform pipeline
1. Добавим официальный helm atlantis `helm repo add runatlantis https://runatlantis.github.io/helm-charts`, создадим файл values.yaml с данными нашего репозитория и токеном.
2. Установим atlantis `helm install atlantis runatlantis/atlantis --namespace atlantis --create-namespace -f atlantis/values.yaml`
3. Т.к. после запуска pod висит в pending из-за ожидания с PVC (atlantis необходимо где-то хранить данные), то создадим pv-atlantis.yaml и применим его
4. Убедимся, что atlantis запустился успешно:
   <img width="951" height="381" alt="image" src="https://github.com/user-attachments/assets/63098d32-7de2-4e22-b89e-69594a3e65db" />  
5. Добавим webhook в настройках репозитория, где укажем в url: http://<внешний_ip>:32001/events  
  <img width="405" height="777" alt="image" src="https://github.com/user-attachments/assets/b2cfa01d-2b49-4620-9141-3b73fab652db" />
6. Проверим что тестовый push проходит успешно:
   <img width="779" height="249" alt="image" src="https://github.com/user-attachments/assets/aa07b84d-a2d5-4348-b9e3-28d66baeb32e" />



---
### Установка и настройка CI/CD

Осталось настроить ci/cd систему для автоматической сборки docker image и деплоя приложения при изменении кода.

Цель:

1. Автоматическая сборка docker образа при коммите в репозиторий с тестовым приложением.
2. Автоматический деплой нового docker образа.

Можно использовать [teamcity](https://www.jetbrains.com/ru-ru/teamcity/), [jenkins](https://www.jenkins.io/), [GitLab CI](https://about.gitlab.com/stages-devops-lifecycle/continuous-integration/) или GitHub Actions.

Ожидаемый результат:

1. Интерфейс ci/cd сервиса доступен по http.
2. При любом коммите в репозиторие с тестовым приложением происходит сборка и отправка в регистр Docker образа.
3. При создании тега (например, v1.0.0) происходит сборка и отправка с соответствующим label в регистри, а также деплой соответствующего Docker образа в кластер Kubernetes.

---
## Что необходимо для сдачи задания?

1. Репозиторий с конфигурационными файлами Terraform и готовность продемонстрировать создание всех ресурсов с нуля.
2. Пример pull request с комментариями созданными atlantis'ом или снимки экрана из Terraform Cloud или вашего CI-CD-terraform pipeline.
3. Репозиторий с конфигурацией ansible, если был выбран способ создания Kubernetes кластера при помощи ansible.
4. Репозиторий с Dockerfile тестового приложения и ссылка на собранный docker image.
5. Репозиторий с конфигурацией Kubernetes кластера.
6. Ссылка на тестовое приложение и веб интерфейс Grafana с данными доступа.
7. Все репозитории рекомендуется хранить на одном ресурсе (github, gitlab)

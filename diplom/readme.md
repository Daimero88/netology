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
   <img width="288" height="229" alt="image" src="https://github.com/user-attachments/assets/96b73793-f131-4ac5-bb02-61406bfa5f9d" />

2. Воспользуемся Kubespray для деплоя кластера. Для этого склонируем его репозиторий ```git clone https://github.com/kubernetes-sigs/kubespray```, перейдем в скачанную папку, включим виртуальное окружение и установим необходимые зависимости `pip install -r requirements.txt`.  
   После скопируем папку `cp -rfp inventory/sample inventory/mycluster` и отредактируем файлы inventory/mycluster/inventory.ini, куда добавим IP адреса созданных ВМ, в group_vars/all/all.yml добавим версию `kube_version: 1.32.0`, а в inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml добавим `supplementary_addresses_in_ssl_keys:`, который будет содержать значение внешнего IP-адреса мастера в сертификате.  
3. После запуска `ansible-playbook -i inventory/mycluster/inventory.ini cluster.yml -b -v` получаем успешный результат:
   <img width="922" height="82" alt="image9" src="https://github.com/user-attachments/assets/67415302-b58e-4f60-9e0f-164738b3769c" />   
4. Забираем файл конфигурации с сервера для подключения к кластеру `ssh ubuntu@158.160.44.46 "sudo cat /etc/kubernetes/admin.conf" > ~/.kube/config`, меняем внутри файла адрес сервера 127.0.0.1 на наш внешний ip мастера и даем на него права `chmod 600 ~/.kube/config`. После чего проверяем доступ командой `kubectl get pods -n kube-system`:  
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
3. Соберем образ ```docker build -t cr.yandex/crpvsmu99smr232mo9ci/test-nginx:1.1 .``` и запушим его в наш регистри ```docker push cr.yandex/crpvsmu99smr232mo9ci/test-nginx:1.1```
4. Проверим, что образ появился в нашем registry:  
   <img width="392" height="299" alt="image" src="https://github.com/user-attachments/assets/bf7d9ea9-07a0-4a18-9bf1-7bf198ec272d" />  
   <img width="480" height="249" alt="image" src="https://github.com/user-attachments/assets/0bce7c37-ff17-4e4c-8ce9-9af6414a43ef" />



---
### Подготовка cистемы мониторинга и деплой приложения

Уже должны быть готовы конфигурации для автоматического создания облачной инфраструктуры и поднятия Kubernetes кластера.  
Теперь необходимо подготовить конфигурационные файлы для настройки нашего Kubernetes кластера.

Цель:
1. Задеплоить в кластер [prometheus](https://prometheus.io/), [grafana](https://grafana.com/), [alertmanager](https://github.com/prometheus/alertmanager), [экспортер](https://github.com/prometheus/node_exporter) основных метрик Kubernetes.
2. Задеплоить тестовое приложение, например, [nginx](https://www.nginx.com/) сервер отдающий статическую страницу.

Способ выполнения:
1. Воспользоваться пакетом [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus), который уже включает в себя [Kubernetes оператор](https://operatorhub.io/) для [grafana](https://grafana.com/), [prometheus](https://prometheus.io/), [alertmanager](https://github.com/prometheus/alertmanager) и [node_exporter](https://github.com/prometheus/node_exporter). Альтернативный вариант - использовать набор helm чартов от [bitnami](https://github.com/bitnami/charts/tree/main/bitnami).

### Решение подготовки cистемы мониторинга и деплоя приложения  
1. Добавим helm репозиторий `helm repo add prometheus-community https://prometheus-community.github.io/helm-charts`, и запустим установку командой `helm install kube-prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace`  
   Проверим, что все поды в namespace monitoring запустились:  
   <img width="800" height="263" alt="image12" src="https://github.com/user-attachments/assets/d87e1524-be7b-469d-8151-784a6d041cb0" />  
2. Для деплоя тестового приложения в папке [**k8s-configs**](https://github.com/Daimero88/netology/tree/main/diplom/k8s-configs) создадим [**namespace.yaml**](https://github.com/Daimero88/netology/blob/main/diplom/k8s-configs/namespace.yaml), [**deployment.yaml.tmpl**](https://github.com/Daimero88/netology/blob/main/diplom/k8s-configs/templates/deployment.yaml.tmpl), из которого автоматически создастся файл [**deployment.yaml**](https://github.com/Daimero88/netology/blob/main/diplom/k8s-configs/deployment.yaml), и [**service.yaml**](https://github.com/Daimero88/netology/blob/main/diplom/k8s-configs/service.yaml) и применим их:  
   <img width="765" height="72" alt="image13" src="https://github.com/user-attachments/assets/d1d6cadb-bf85-42d0-bb45-69a997403f60" />  
3. Для того чтобы и grafana и наше приложение работали по одному 80 порту, установим ingress-nginx контроллер из `helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx` и запустим со следующими параметрами `helm install my-nginx-ingress-controller ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace --set controller.hostNetwork=true --set controller.service.enabled=false`.  
   Далее напишем [**app-ingress.yaml**](https://github.com/Daimero88/netology/blob/main/diplom/k8s-configs/app-ingress.yaml) и [**grafana-ingress.yaml**](https://github.com/Daimero88/netology/blob/main/diplom/k8s-configs/grafana-ingress.yaml) и применим их.
   Убедимся, что по внешнему IP http://158.160.44.46 открывается grafana (логин admin, пароль prom-operator), и дашборды мониторинга с данными присутствуют:  
   <img width="1662" height="823" alt="image" src="https://github.com/user-attachments/assets/25d25d2b-d2ba-4436-b4f9-617febf182c2" />  
   А по адресу http://158.160.44.46/app откроется наша статичная страница:  
   <img width="477" height="155" alt="image" src="https://github.com/user-attachments/assets/cb0a38d5-a4f1-4f42-af1f-cd68f1d58d72" />  
  

### Деплой инфраструктуры в terraform pipeline

1. Если на первом этапе вы не воспользовались [Terraform Cloud](https://app.terraform.io/), то задеплойте и настройте в кластере [atlantis](https://www.runatlantis.io/) для отслеживания изменений инфраструктуры. Альтернативный вариант 3 задания: вместо Terraform Cloud или atlantis настройте на автоматический запуск и применение конфигурации terraform из вашего git-репозитория в выбранной вами CI-CD системе при любом комите в main ветку. Предоставьте скриншоты работы пайплайна из CI/CD системы.

Ожидаемый результат:
1. Git репозиторий с конфигурационными файлами для настройки Kubernetes.
2. Http доступ на 80 порту к web интерфейсу grafana.
3. Дашборды в grafana отображающие состояние Kubernetes кластера.
4. Http доступ на 80 порту к тестовому приложению.
5. Atlantis или terraform cloud или ci/cd-terraform

### Решение деплоя инфраструктуры в terraform pipeline
1. Модифицируем официальный yaml файл [**atlantis.yaml**](https://github.com/Daimero88/netology/blob/main/diplom/atlantis/atlantis.yaml) из-за санкций, также опишем необходимые переменные в [**secrets.yaml.example**](https://github.com/Daimero88/netology/blob/main/diplom/atlantis/secrets.yaml.example). Применяем через `kubectl apply -f` вначале [**atlantis-ns.yaml**](https://github.com/Daimero88/netology/blob/main/diplom/atlantis/atlantis-ns.yaml), затем [**secrets.yaml.example**](https://github.com/Daimero88/netology/blob/main/diplom/atlantis/secrets.yaml.example), затем [**atlantis.yaml**](https://github.com/Daimero88/netology/blob/main/diplom/atlantis/atlantis.yaml).
   
2. Добавим webhook в настройках нашего репозитория, где укажем в url: http://158.160.44.46:32001/events  
  <img width="344" height="363" alt="image" src="https://github.com/user-attachments/assets/d0431ce1-b4a0-493a-b1fa-a927a55142cd" />

3. Проверим что тестовый push проходит успешно:  
   <img width="353" height="280" alt="image" src="https://github.com/user-attachments/assets/7ae4bf89-6929-4bac-800e-51328d46852c" />
   
4. Создадим в отдельной ветке тестовый файл test.tf, запушим его, создадим pull request и убедимся, что все проверки atlantis прошли успешно:  
   <img width="927" height="609" alt="image" src="https://github.com/user-attachments/assets/b02f4be1-f793-4acc-98c3-7f1bda20789e" />  
   <img width="1320" height="665" alt="image" src="https://github.com/user-attachments/assets/1a30c4b6-0cb3-4cb1-a7cc-893a5f1523ec" />  
   <img width="1182" height="728" alt="image" src="https://github.com/user-attachments/assets/c9f20bdc-a56f-45ab-9443-4ffc007e7c7d" />  


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


### Решение установки и настройки CI/CD  
1. Так как репозиторий находится в GitHub, было решено развернуть CI/CD систему через GitHub Actions. Создаем сервисный аккаунт, используя cicd-sa.tf, с правами container-registry.images.pusher и container-registry.images.puller.  
2. Создадим в репозитории test-nginx-app папку .github, в которой в папке workflows создадим 2 workflow: [**build.yaml**](https://github.com/Daimero88/test-nginx-app/blob/main/.github/workflows/build.yaml) и [**deploy.yaml**](https://github.com/Daimero88/test-nginx-app/blob/main/.github/workflows/deploy.yaml). Добавим в secrets в настройках репозитория переменные, содержащие конфигурацию для подключения к кластеру, id registry, и YC_SA_KEY, куда положим json ключ для авторизации под сервисным аккаунтом:  
   <img width="144" height="221" alt="image" src="https://github.com/user-attachments/assets/b0a95ef8-7005-4be9-97ff-0639835e41ba" />  
3. Сделаем тестовый коммит, убедимся, что workflow отработал:  
   <img width="666" height="326" alt="image" src="https://github.com/user-attachments/assets/9f29f338-4428-44fc-9d71-8d6a413130c3" />  
   и новый образ создался с тэгом latest в нашем registry:  
   <img width="411" height="242" alt="image" src="https://github.com/user-attachments/assets/9c794fd3-8c13-4b12-afb0-ff2af522f7e3" />  
4. Для наглядности добавим строку с номером версии страницы. Создадим тэг командой `git tag v1.2 -m "Release version 1.2"`, запушим его `git push origin v1.2` в наш репозиторий. Убедимся, что workflow отработал:  
   <img width="713" height="218" alt="image" src="https://github.com/user-attachments/assets/3410dbc6-6fbb-4165-bf67-62f62183ad72" />  
   В регистри создался docker образ с новым тэгом:  
   <img width="414" height="333" alt="image" src="https://github.com/user-attachments/assets/c16fbce7-18a3-4def-8ddd-da2e4864306f" />  
   Поды в кластере k8s используют новую версию образа приложения:  
   <img width="1079" height="136" alt="image" src="https://github.com/user-attachments/assets/cd1f1591-ea1f-4191-896b-e36c4ef77d3a" />  
   И проверим на странице, что у нас новая версия сайта. Было 1.1:  
   <img width="470" height="192" alt="image" src="https://github.com/user-attachments/assets/abd8bd2e-ed2d-4282-b543-a67cac84e834" />  
   Стало v1.2:  
   <img width="476" height="211" alt="image" src="https://github.com/user-attachments/assets/230a870f-13cc-47f5-9bac-be6cafce6089" />  

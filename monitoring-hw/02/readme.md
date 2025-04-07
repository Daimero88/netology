# Домашнее задание к занятию 14 «Средство визуализации Grafana» - Сильчин Сергей

## Обязательные задания

### Задание 1

1. Используя директорию [help](./help) внутри этого домашнего задания, запустите связку prometheus-grafana.
2. Зайдите в веб-интерфейс grafana, используя авторизационные данные, указанные в манифесте docker-compose.
3. Подключите поднятый вами prometheus, как источник данных.
4. Решение домашнего задания — скриншот веб-интерфейса grafana со списком подключенных Datasource.  
   10.93.18.213 - VM сервер, где поднимается связка prometheus-grafana:
   ![image1](https://github.com/user-attachments/assets/a8a6fffa-b955-4bea-b301-179bb66b4ed9)  

## Задание 2

Изучите самостоятельно ресурсы:

1. [PromQL tutorial for beginners and humans](https://valyala.medium.com/promql-tutorial-for-beginners-9ab455142085).
2. [Understanding Machine CPU usage](https://www.robustperception.io/understanding-machine-cpu-usage).
3. [Introduction to PromQL, the Prometheus query language](https://grafana.com/blog/2020/02/04/introduction-to-promql-the-prometheus-query-language/).

Создайте Dashboard и в ней создайте Panels:

- утилизация CPU для nodeexporter (в процентах, 100-idle);  
  Metrics: `100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[1m]))) * 100`  
- CPULA 1/5/15;  
  Metrics:
  ```
  node_load1{instance="nodeexporter:9100"}
  node_load5{instance="nodeexporter:9100"}
  node_load15{instance="nodeexporter:9100"}
  ```
- количество свободной оперативной памяти;  
  Metrics: `node_memory_MemFree_bytes{instance="nodeexporter:9100"}`
- количество места на файловой системе.  
  Metrics: `node_filesystem_avail_bytes{instance="nodeexporter:9100", mountpoint="/"}`

Для решения этого задания приведите promql-запросы для выдачи этих метрик, а также скриншот получившейся Dashboard.  
![image2](https://github.com/user-attachments/assets/f8bfdcb4-a08c-41f7-b4d4-56fd0511f394)


## Задание 3

1. Создайте для каждой Dashboard подходящее правило alert — можно обратиться к первой лекции в блоке «Мониторинг».  
   Создаем alerts:  
   ![image4](https://github.com/user-attachments/assets/dd567e28-cb79-4fc9-a77c-107b03c6db10)  
   ![image5](https://github.com/user-attachments/assets/78c9929f-68c3-4564-b56e-b48e8a0e5f91)  
   ![image6](https://github.com/user-attachments/assets/3c23f85c-96e4-458c-b5b9-6b0b58ab4e24)  

2. В качестве решения задания приведите скриншот вашей итоговой Dashboard.  
   ![image](https://github.com/user-attachments/assets/e4ed217e-2249-471d-ae49-7b1a318e9842)  


## Задание 4

1. Сохраните ваш Dashboard.Для этого перейдите в настройки Dashboard, выберите в боковом меню «JSON MODEL». Далее скопируйте отображаемое json-содержимое в отдельный файл и сохраните его.  
2. В качестве решения задания приведите листинг этого файла.  
[**grafana.json**](https://github.com/Daimero88/netology/blob/main/monitoring-hw/02/grafana.json)

# Домашнее задание к занятию «Практическое применение Docker» - Сильчин Сергей
## Задача 1 

1. Сделайте в своем github пространстве fork репозитория:
![fork](https://github.com/user-attachments/assets/e8304c50-4ee9-4184-93ae-aca9fb69e0dd)

2. Создайте файл с именем Dockerfile.python для сборки данного проекта. Используйте базовый образ python:3.9-slim. Обязательно используйте конструкцию COPY . . в Dockerfile. Не забудьте исключить ненужные в имадже файлы с помощью dockerignore:

 ![dockerfile](https://github.com/user-attachments/assets/f6673d6c-4640-4d5a-8dc7-6fa95c4145ac)
 ![dockerignore](https://github.com/user-attachments/assets/12e79021-b398-4ba3-a6f3-1e0d1c61d3ca)

## Задача 2 (*)
1. Создайте в yandex cloud container registry с именем "test" с помощью "yc tool" . [Инструкция](https://cloud.yandex.ru/ru/docs/container-registry/quickstart/?from=int-console-help)
2. Настройте аутентификацию вашего локального docker в yandex container registry.
3. Соберите и залейте в него образ с python приложением из задания №1.
4. Просканируйте образ на уязвимости.
5. В качестве ответа приложите отчет сканирования
Отчет сканирования:
[vulnerabilities.csv](https://github.com/user-attachments/files/18538770/vulnerabilities.csv)
   [vulnerabilities](https://github.com/user-attachments/assets/4338320c-c7a3-4241-b4aa-75c3335cee53)

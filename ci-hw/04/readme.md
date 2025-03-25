# Домашнее задание к занятию 10 «Jenkins» - Сильчин Сергей

## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
   ![image1](https://github.com/user-attachments/assets/f8627cde-b9df-4f60-95e9-c0450d2b87bd)  
   ![image2](https://github.com/user-attachments/assets/f08d758d-b67b-4255-812a-1f9ad0a83514)  

2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
   Pipeline script:  
```
   pipeline {
    agent{
        label 'jenkins-agent'
    }
    stages {
        stage ('Copy Git repo') {
            steps {
                sh 'sudo -i'
                sh 'git clone https://github.com/Daimero88/vector-role.git'
            }
        }
        stage ('Run molecule test') {
            steps {
                dir('vector-role') {
                    sh 'molecule test'
                }
            }
        }
    }
}
```
   ![image4](https://github.com/user-attachments/assets/d4fadfe3-6de2-4797-a1a5-4670efc305b3)

3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.
4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.
5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).
6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.
9. Сопроводите процесс настройки скриншотами для каждого пункта задания!!

## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, завершившиеся хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением и названием `AllJobFailure.groovy`.
2. Создать Scripted Pipeline так, чтобы он мог сначала запустить через Yandex Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Мы должны при нажатии кнопки получить готовую к использованию систему.

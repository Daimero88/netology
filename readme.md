Task1: https://hub.docker.com/repository/docker/daimero/custom-nginx/general

Task2: ![task2](https://github.com/user-attachments/assets/0da16689-73cd-4b2d-91b1-2996a3549ce8)

Task3: ![CTRL+C](https://github.com/user-attachments/assets/29727593-9246-41e8-8fa3-b21e3415666e)
Контейнер остановился, поскольку комбинация горячих клавиш Ctrl+C послала сигнал завершения основному процессу nginx в контейнере

Замена порта с 80 на 81:
![change_port](https://github.com/user-attachments/assets/9e8d0a4c-cbc3-4f3e-a5e4-6e6f0777afc6)

Получаем ошибку сброса соединения, т.к. был изменен порт сервиса nginx с 80 на 81 внутри контейнера, а контейнер был запущен с перенаправлением порта хоста 8080 на 80 порт внутри контейнера:

![connection_reset](https://github.com/user-attachments/assets/f8bf9dae-6722-4b29-83b1-b76a6fd34bab)

Удаление запущенного контейнера без остановки:
![delete_container](https://github.com/user-attachments/assets/de2e2f0e-c7f3-4d13-a951-1a71ae1a771e)

Task4:
![task4](https://github.com/user-attachments/assets/6e2dfc68-27aa-49c8-b602-50d2f7a89f70)

Task5:

Чтобы было запущено оба файла конфигурации добавили в файл compose.yaml:

include:
 - docker-compose.yaml

Container inspect:

![Container inspect](https://github.com/user-attachments/assets/fa2f0004-4b96-40cc-b7d7-346e9cc1d5e0)

Поскольку настройка производилась на ubuntu server, пришлось пробросить порты для настройки с другого ПК в браузере:

![compose.yaml](https://github.com/user-attachments/assets/cf7d3d64-2fde-48c6-b1e9-375dc37cdad9)

заливка образа custom-nginx как custom-nginx:latest в запущенное локальное registry:

![commands](https://github.com/user-attachments/assets/bc91c4ee-3b90-429b-98d2-20b6b732799d)

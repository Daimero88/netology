Task1: https://hub.docker.com/repository/docker/daimero/custom-nginx/general

Task2: ![task2](https://github.com/user-attachments/assets/0da16689-73cd-4b2d-91b1-2996a3549ce8)

Task3: ![CTRL+C](https://github.com/user-attachments/assets/29727593-9246-41e8-8fa3-b21e3415666e)
Контейнер остановился, поскольку комбинация горячих клавиш Ctrl+C послала сигнал завершения основному процессу nginx в контейнере

Замена порта с 80 на 81:
![change_port](https://github.com/user-attachments/assets/9e8d0a4c-cbc3-4f3e-a5e4-6e6f0777afc6)

![connection_reset](https://github.com/user-attachments/assets/f8bf9dae-6722-4b29-83b1-b76a6fd34bab)

Получаем ошибку сброса соединения, т.к. был изменен порт сервиса nginx с 80 на 81 внутри контейнера, а контейнер был запущен с перенаправлением порта хоста 8080 на 80 порт внутри контейнера.

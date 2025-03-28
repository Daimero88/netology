# Домашнее задание к занятию 7 «Жизненный цикл ПО» - Сильчин Сергей

## Основная часть

Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:

1. Open -> On reproduce.
2. On reproduce -> Open, Done reproduce.
3. Done reproduce -> On fix.
4. On fix -> On reproduce, Done fix.
5. Done fix -> On test.
6. On test -> On fix, Done.
7. Done -> Closed, Open.
   
Создаем новый workflow по пути `settings > issues > workflows > add workflow > bug`:
![image1](https://github.com/user-attachments/assets/841596f5-53fc-4574-8f94-2451ac3ff98b)


Остальные задачи должны проходить по упрощённому workflow:

1. Open -> On develop.
2. On develop -> Open, Done develop.
3. Done develop -> On test.
4. On test -> On develop, Done.
5. Done -> Closed, Open.

Создаем новый workflow по пути `settings > issues > workflows > add workflow > simple_workflow`
![image2](https://github.com/user-attachments/assets/06064490-7873-4116-9067-35a181e80c6f)  

**Что нужно сделать**

1. Создайте задачу с типом bug, попытайтесь провести его по всему workflow до Done.  
   Добавляем созданные workflow на проект вместо используемых по умолчанию:  
   ![image3](https://github.com/user-attachments/assets/af192ace-5127-424d-b9fd-82ee413def57)
   Проводим по всему workflow до Done:
   ![image4](https://github.com/user-attachments/assets/648df1a7-5b95-4dde-bf2d-378655dda79c)  

2. Создайте задачу с типом epic, к ней привяжите несколько задач с типом task, проведите их по всему workflow до Done.  
   Создаем epic и несколько задач, указывая parent на epic, и проводим их по workflow:  
   ![image5](https://github.com/user-attachments/assets/56e7a95a-934a-493c-ae12-9d2bf6b00255)  

3. При проведении обеих задач по статусам используйте kanban.  
4. Верните задачи в статус Open.  
5. Перейдите в Scrum, запланируйте новый спринт, состоящий из задач эпика и одного бага, стартуйте спринт, проведите задачи до состояния Closed. Закройте спринт:  
   ![image6](https://github.com/user-attachments/assets/b786a173-3694-4a9a-a68b-f523e1065abf)

6. Если всё отработалось в рамках ожидания — выгрузите схемы workflow для импорта в XML. Файлы с workflow и скриншоты workflow приложите к решению задания.  
[**bug**](https://github.com/Daimero88/netology/blob/main/ci-hw/01/bug.xml), [**simple_workflow**](https://github.com/Daimero88/netology/blob/main/ci-hw/01/simple_workflow.xml)

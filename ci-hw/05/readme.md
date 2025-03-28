# Домашнее задание к занятию 11 «Teamcity» - Сильчин Сергей

## Основная часть

1. Создайте новый проект в teamcity на основе fork.   
  ![image](https://github.com/user-attachments/assets/c5de5f11-18e1-425e-8ca5-7b1420e3dd49)  

2. Сделайте autodetect конфигурации.  
  ![image2](https://github.com/user-attachments/assets/f7eef7dc-12b3-4651-a41c-7cacd8df25d3)  
   
3. Сохраните необходимые шаги, запустите первую сборку master.  
  ![image3](https://github.com/user-attachments/assets/4ae1d8a5-4a1e-4ad7-b9d6-59557ec8f085)  

4. Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean deploy`, иначе `mvn clean test`.
   
   Создаем новую ветку dev:
   ```
   git clone git@github.com:Daimero88/example-teamcity.git
   cd example-teamcity
   git checkout -b "dev"
   git push origin dev
   ```
  ![image4](https://github.com/user-attachments/assets/5d736f37-7f37-4e77-97d5-2f520fcf5938)
   Создаем новый build с условиями по ветке:  
  ![image5](https://github.com/user-attachments/assets/e1c5f808-26bf-4335-a55a-9b76cd666030)  

5. Для deploy будет необходимо загрузить [settings.xml](./teamcity/settings.xml) в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus.
6. В pom.xml необходимо поменять ссылки на репозиторий и nexus.
7. Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus.
8. Мигрируйте `build configuration` в репозиторий.
9. Создайте отдельную ветку `feature/add_reply` в репозитории.
10. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`.
11. Дополните тест для нового метода на поиск слова `hunter` в новой реплике.
12. Сделайте push всех изменений в новую ветку репозитория.
13. Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно.
14. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`.
15. Убедитесь, что нет собранного артефакта в сборке по ветке `master`.
16. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки.
17. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны.
18. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.
19. В ответе пришлите ссылку на репозиторий.

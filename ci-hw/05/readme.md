# Домашнее задание к занятию 11 «Teamcity» - Сильчин Сергей

## Основная часть

1. Создайте новый проект в teamcity на основе fork.   
  ![image1](https://github.com/user-attachments/assets/c5de5f11-18e1-425e-8ca5-7b1420e3dd49)  

2. Сделайте autodetect конфигурации.  
  ![image2](https://github.com/user-attachments/assets/f7eef7dc-12b3-4651-a41c-7cacd8df25d3)  
   
3. Сохраните необходимые шаги, запустите первую сборку master.  
  ![image3](https://github.com/user-attachments/assets/4ae1d8a5-4a1e-4ad7-b9d6-59557ec8f085)  

4. Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean deploy`, иначе `mvn clean test`.  
   Создаем новый build с условиями по ветке:  
  ![image5](https://github.com/user-attachments/assets/e1c5f808-26bf-4335-a55a-9b76cd666030)  

5. Для deploy будет необходимо загрузить [settings.xml](./teamcity/settings.xml) в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus.  
  ![image6](https://github.com/user-attachments/assets/159414bc-ab75-416c-b7cd-a56a14a02f29)  

6. В pom.xml необходимо поменять ссылки на репозиторий и nexus.  
   [**pom.xml**](https://github.com/Daimero88/example-teamcity/blob/master/pom.xml)
   
7. Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus.  
  Build прошел успешно:  
  ![image7](https://github.com/user-attachments/assets/b1d13808-4c80-4819-87ce-41e7fe27ecba)
  Артефакт появился в nexus:  
  ![image8](https://github.com/user-attachments/assets/4d4fd1c5-f59b-4527-82ad-863e29d16af6)  

8. Мигрируйте `build configuration` в репозиторий.  
  [**build configuration**](https://github.com/Daimero88/example-teamcity/blob/master/.teamcity/settings.kts)  
9. Создайте отдельную ветку `feature/add_reply` в репозитории.  
  [**feature/add_reply**](https://github.com/Daimero88/example-teamcity/tree/feature/add_reply)

10. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`.  
    ```
    	public String sayHunterwho() {
	    return "Who is the hunter?";
	}	
    ```
12. Дополните тест для нового метода на поиск слова `hunter` в новой реплике.  
    ```
    @Test
    public void welcomerSaysHunterwho() {
        assertThat(welcomer.sayHunterwho(), containsString("hunter"));
    }
    ```  
14. Сделайте push всех изменений в новую ветку репозитория.
15. Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно.
    
17. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`.
    
19. Убедитесь, что нет собранного артефакта в сборке по ветке `master`.  
20. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки.  
21. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны.  
22. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.  
23. В ответе пришлите ссылку на репозиторий.

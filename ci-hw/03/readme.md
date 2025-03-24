# Домашнее задание к занятию 9 «Процессы CI/CD» - Сильчин Сергей  

## Знакомоство с SonarQube

### Основная часть

1. Создайте новый проект, название произвольное.
2. Скачайте пакет sonar-scanner, который вам предлагает скачать SonarQube.
3. Сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ).
4. Проверьте `sonar-scanner --version`.
   ![image1](https://github.com/user-attachments/assets/49a05d54-14a6-4ef2-a97d-3ff78874e1eb)  
5. Запустите анализатор против кода из директории [example](./example) с дополнительным ключом `-Dsonar.coverage.exclusions=fail.py`.
   ```
   sonar-scanner \
   -Dsonar.projectKey=netology \
   -Dsonar.sources=. \
   -Dsonar.host.url=http://localhost:9000 \
   -Dsonar.login=cea98921d53bbe1d6fb461973b68c6a50812exxx \
   -Dsonar.coverage.exclusions=fail.py
   ```
6. Посмотрите результат в интерфейсе.  
   Было найдено 3 ошибки:  
![image2](https://github.com/user-attachments/assets/4d8343c0-5d06-447a-a994-391402ce9760)  

7. Исправьте ошибки, которые он выявил, включая warnings.  
   Исправленный вариант:  
```
def increment(index):
    return index + 1

def get_square(numb):
    return numb * numb

def print_numb(numb):
    print("Number is {}".format(numb))

index = 0
while index < 10:
    index = increment(index)
    print(get_square(index))
```
8. Запустите анализатор повторно — проверьте, что QG пройдены успешно.  
9. Сделайте скриншот успешного прохождения анализа, приложите к решению ДЗ.  
![image3](https://github.com/user-attachments/assets/9dd17213-658d-4f34-a9e4-bf559e2cd02b)


## Знакомство с Nexus

### Основная часть

1. В репозиторий `maven-public` загрузите артефакт с GAV-параметрами:

 *    groupId: netology;
 *    artifactId: java;
 *    version: 8_282;
 *    classifier: distrib;
 *    type: tar.gz.  
   
2. В него же загрузите такой же артефакт, но с version: 8_102.
3. Проверьте, что все файлы загрузились успешно.  
![image5](https://github.com/user-attachments/assets/eae3f597-8b6f-4970-ae66-a777270c7228)  

4. В ответе пришлите файл `maven-metadata.xml` для этого артефекта.  
[**maven-metadata.xml**](https://github.com/Daimero88/netology/blob/main/ci-hw/03/maven-metadata.xml)

### Знакомство с Maven

### Подготовка к выполнению

1. Скачайте дистрибутив с [maven](https://maven.apache.org/download.cgi).
2. Разархивируйте, сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ).
3. Удалите из `apache-maven-<version>/conf/settings.xml` упоминание о правиле, отвергающем HTTP- соединение — раздел mirrors —> id: my-repository-http-unblocker.
4. Проверьте `mvn --version`.  
   ![image6](https://github.com/user-attachments/assets/a9f0afbb-abba-41ba-8589-9639bf5f636d)  
5. Заберите директорию [mvn](./mvn) с pom.

### Основная часть

1. Поменяйте в `pom.xml` блок с зависимостями под ваш артефакт из первого пункта задания для Nexus (java с версией 8_282).
2. Запустите команду `mvn package` в директории с `pom.xml`, ожидайте успешного окончания.
   ![image7](https://github.com/user-attachments/assets/f486ab7d-da5d-414a-9705-3557fd43c9b4)  

3. Проверьте директорию `~/.m2/repository/`, найдите ваш артефакт.
   ![image8](https://github.com/user-attachments/assets/34fbc4a7-effe-4b68-a84f-c2d61ec2bc4c)  

4. В ответе пришлите исправленный файл `pom.xml`.  
   [**pom.xml**](https://github.com/Daimero88/netology/blob/main/ci-hw/03/mvn/pom.xml)


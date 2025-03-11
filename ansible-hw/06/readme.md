# Домашнее задание к занятию 6 «Создание собственных модулей» - Сильчин Сергей

**Шаг 1.** В виртуальном окружении создайте новый `my_own_module.py` файл.  

**Шаг 2.** Наполните его содержимым или возьмите это наполнение [из статьи](https://docs.ansible.com/ansible/latest/dev_guide/developing_modules_general.html#creating-a-module).  

**Шаг 3.** Заполните файл в соответствии с требованиями Ansible так, чтобы он выполнял основную задачу: module должен создавать текстовый файл на удалённом хосте по пути, определённом в параметре `path`, с содержимым, определённым в параметре `content`.  

```    if not (os.path.exists(module.params['path']) and
            os.path.isfile(module.params['path']) and
            open(module.params['path'], 'r').read() == module.params['content']):
        try:
            with open(module.params['path'], 'w') as file:
                file.write(module.params['content'])
                result['changed'] = True
        except Exception as exp:
            module.fail_json(msg=f"Something gone wrong: {exp}", **result)
```
**Шаг 4.** Проверьте module на исполняемость локально.  
Первый запуск: ```{"changed": true, "invocation": {"module_args": {"path": "daimero88.md", "content": "Silchin Sergey - ansible-hw-06"}}}```  
Файл создался, результат `changed": true`.  
Второй запуск: ```{"changed": false, "invocation": {"module_args": {"path": "daimero88.md", "content": "Silchin Sergey - ansible-hw-06"}}}```  
Т.к. файл уже создан результат `changed": false`.  

**Шаг 5.** Напишите single task playbook и используйте module в нём.  
```
---
- name: Test Module
  hosts: localhost
  tasks:
  - name: Create file with context
    my_own_module:
      path: './daimero88_playbook.txt'
      content: "This file was created by ansible-playbook"
```
**Шаг 6.** Проверьте через playbook на идемпотентность.  
![image1](https://github.com/user-attachments/assets/d25fede7-5059-42ce-baa5-d5b9c417b83f)  

**Шаг 7.** Выйдите из виртуального окружения.  
Команда `deactivate`:  
![image5](https://github.com/user-attachments/assets/b0cfbbdc-6af0-45a5-86ec-638ecd5ee779)  

**Шаг 8.** Инициализируйте новую collection: `ansible-galaxy collection init my_own_namespace.yandex_cloud_elk`.  
![image6](https://github.com/user-attachments/assets/63118e5c-a6b3-4fc3-9508-45cc8985da3b)  

**Шаг 9.** В эту collection перенесите свой module в соответствующую директорию.  
Переносим файл `my_own_module.py` в папку `daimero88/yandex_cloud_elk/plugins/modules/`  

**Шаг 10.** Single task playbook преобразуйте в single task role и перенесите в collection. У role должны быть default всех параметров module.  
tasks/main.yml:
```
---
- name: Create file with content
  my_own_module:
    path: "{{ path }}"
    content: "{{ content }}"
```
defaults/main.yml:
```
---
path: './file.txt'
content: "Hello world =)"
```
**Шаг 11.** Создайте playbook для использования этой role.  
```
---
- name: Test playbook
  hosts: localhost
  gather_facts: false
  remote_user: root
  roles:
    - role: daimero88.yandex_cloud_elk.my_module
```

**Шаг 12.** Заполните всю документацию по collection, выложите в свой репозиторий, поставьте тег `1.0.0` на этот коммит.  
[**1.0.0**](https://github.com/Daimero88/my_own_collection/releases/tag/1.0.0)

**Шаг 13.** Создайте .tar.gz этой collection: `ansible-galaxy collection build` в корневой директории collection.  
![image4](https://github.com/user-attachments/assets/e305179f-a6c7-4682-bee4-5008294820ca)

**Шаг 14.** Создайте ещё одну директорию любого наименования, перенесите туда single task playbook и архив c collection.

**Шаг 15.** Установите collection из локального архива: `ansible-galaxy collection install <archivename>.tar.gz`.  
![image3](https://github.com/user-attachments/assets/fe0c23c8-d62b-408a-85f3-563709cc0b5d)

**Шаг 16.** Запустите playbook, убедитесь, что он работает.  
Playbook работает и идемпотентен:
![image2](https://github.com/user-attachments/assets/612f6934-6ab9-477a-86e8-6416e6fa3a9f)

**Шаг 17.** В ответ необходимо прислать ссылки на collection и tar.gz архив, а также скриншоты выполнения пунктов 4, 6, 15 и 16.  
[**collection**](https://github.com/Daimero88/my_own_collection/tree/main/daimero88/yandex_cloud_elk)
[**daimero88-yandex_cloud_elk-1.0.0.tar.gz**](https://github.com/Daimero88/my_own_collection/blob/main/daimero88/yandex_cloud_elk/daimero88-yandex_cloud_elk-1.0.0.tar.gz)

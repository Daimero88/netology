Задача 2: Выберите один из вариантов платформы в зависимости от задачи.
1) высоконагруженная база данных MySql, критичная к отказу: кластер из физических серверов с репликацией базы данных, таким образом исключаем расходы мощностей серверов на виртуализацию.
2) различные web-приложения: виртуализация уровня ОС. Решение позволяет оперативно свернуть приложение в контейнер и развернуть из него быстрее в другом месте, плюс легче масштабировать проект.
3) Windows системы для использования бухгалтерским отделом: паравиртуализация, т.к. зачастую отдельный хост является избыточным решением.
4) системы, выполняющие высокопроизводительные расчеты на GPU: в зависимости от задач. Если GPU одно, то физический сервер, если несколько, то можно использовать полную (аппарутную) виртуализацию по каждой GPU на отдельную VM (по крайней мере в работе мы так и делаем=)

Задача 3: Выберите подходящую систему управления виртуализацией для предложенного сценария.
1) 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based-инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий: VMWare ESXi под управлением vSphere (едва ли 100 VM "влезут" на один физический сервер)
2) Требуется наиболее производительное бесплатное open source-решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин: XEN из open source стабильный и надежный
3) Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows-инфраструктуры: Hyper-V Server от Microsoft наиболее совместимое решения для виртуализации Windows
4) Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux: KVM нативное решение для большинства дистрибутивов Linux

Задача 4: Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, создавали бы вы гетерогенную среду или нет?
Использование гетерогенной среды является неудачным решением по нескольким причинам:
1) Отсутствие сковозного управления инфрастуктурой VM (невозможность миграции из одной системы виртуализации в другую)
2) Возможно отсутствие совместимости ОС VM под разными системами виртуализации
3) Необходимость специалистам мониторить и бэкапить сразу несколько развернутых систем
4) Это просто неудобно =)
Для мимизации рисков и проблем лучше всего мигрировать в единую систему виртуализации (например, VMWare), которая полностью покроет ваши потребности.

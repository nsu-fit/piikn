# Ожидаемые свойства решения

В корректной работе:

- topology отделяет primary, replica и backup target;
- read path не используется для read-after-write-sensitive сценариев без оговорок;
- lag checks связаны с PostgreSQL-представлениями или демонстрационным логом;
- каждый риск имеет проверку или mitigation;
- failover описан как прикладной и инфраструктурный процесс.

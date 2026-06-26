# Ожидаемые свойства решения

Корректная работа:

- запускает PostgreSQL воспроизводимо;
- создает базу, роли, схему и seed-таблицы;
- отделяет owner/migration role от application role;
- содержит smoke checks, которые можно выполнить повторно;
- явно предупреждает о destructive cleanup.

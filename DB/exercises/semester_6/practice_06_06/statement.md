# Практика 6.6. WAL, checkpoint и backup/restore

Вы готовите минимальный backup/restore runbook для учебного PostgreSQL-контура и проверяете восстановление в безопасную отдельную цель.

## Что нужно сдать

```text
semester-6/practice-06-backup-restore/
  README.md
  runbook.md
  commands.ps1 или commands.sh
  checks.sql
  recovery-notes.md
```

## Задания

1. В `runbook.md` опишите цель backup: учебное восстановление базы `db_course`.
2. Создайте логический backup через `pg_dump`.
3. Восстановите backup в отдельную базу `db_course_restore` или отдельную схему, не затирая рабочую БД.
4. В `checks.sql` добавьте smoke checks:
   - наличие таблиц;
   - количество строк в `events`, `orders`, `documents`;
   - один контрольный агрегат по `orders`;
   - один контрольный запрос по `documents.metadata`.
5. В `recovery-notes.md` зафиксируйте:
   - текущий WAL LSN до/после тестовой записи, если доступно;
   - что логический backup не покрывает;
   - как избежать восстановления в неправильную цель.

## Минимальные команды

Команды зависят от ОС, но должны явно показывать:

- `pg_dump`;
- создание restore target;
- `psql` или `pg_restore`;
- запуск smoke checks.

## Контрольные вопросы

1. Почему backup без restore-проверки не считается надежным?
2. Что не покрывает логический backup?
3. Как убедиться, что восстановление попало в безопасную цель?
4. Какие smoke checks проверяют смысловые данные?

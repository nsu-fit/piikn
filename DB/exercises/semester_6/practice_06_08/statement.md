# Практика 6.8. Эксплуатационный чеклист

Вы собираете operational checklist для учебного PostgreSQL-контура и демонстрируете один checkpoint-артефакт: backup/restore или эквивалентный recovery check.

## Что нужно сдать

```text
semester-6/practice-08-operations-checklist/
  README.md
  operations-checklist.md
  checks.sql
  demo-result.md
```

## Обязательные разделы `operations-checklist.md`

1. Роли и минимальные права.
2. Connection string policy: где хранятся секреты, какие параметры обязательны.
3. Health checks: не только "порт открыт", но и простой SQL.
4. Slow query diagnostics: где фиксируется baseline и как искать проблему.
5. Backup/restore или recovery check.
6. Vacuum/analyze maintenance notes.
7. Открытые риски.

## `checks.sql`

Добавьте:

- `q01_current_user_and_database`;
- `q02_table_counts`;
- `q03_slow_query_candidate` с `EXPLAIN (ANALYZE, BUFFERS)`;
- `q04_role_visibility` или запрос к `information_schema.role_table_grants`;
- `q05_health_check`.

## `demo-result.md`

Коротко зафиксируйте, какой checkpoint был показан преподавателю:

- backup/restore;
- lag/topology;
- slow query baseline;
- роли и права;
- другой согласованный эксплуатационный сценарий.

## Контрольные вопросы

1. Что должен проверять health check БД?
2. Почему connection string является эксплуатационным артефактом?
3. Какие признаки slow query нужно сохранить в baseline?
4. Почему checklist не должен требовать суперпользователя для обычных операций?

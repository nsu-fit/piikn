# Практика 6.3. Физическое хранение и первичные индексы

Вы измеряете размер таблиц, индексов и payload-данных в учебной базе, затем формулируете первые индексные гипотезы.

## Что нужно сдать

```text
semester-6/practice-03-physical-storage-indexes/
  README.md
  measurements.sql
  plans.sql
  report.md
```

## `measurements.sql`

Добавьте запросы:

- `q01_relation_sizes`: `pg_relation_size`, `pg_indexes_size`, `pg_total_relation_size` для `app.events`, `app.orders`, `app.documents`;
- `q02_column_types`: типы и nullable-статус столбцов этих таблиц;
- `q03_indexes`: существующие индексы;
- `q04_toast_relations`: TOAST-связи, если они есть;
- `q05_payload_samples`: 5 примеров размера `payload` или `metadata` через `pg_column_size`.

## `plans.sql`

Зафиксируйте baseline для двух запросов:

- `q06_orders_by_tenant_status`: поиск заказов по `tenant_id`, `status`, сортировка по `created_at DESC`;
- `q07_documents_by_metadata_category`: поиск документов по `metadata->>'category'`;
- для каждого используйте `EXPLAIN (ANALYZE, BUFFERS)`.

## `report.md`

Укажите:

1. Какие таблицы занимают больше всего места.
2. Где размер индексов заметен относительно таблицы.
3. Какие payload-поля потенциально уходят в TOAST.
4. Две индексные гипотезы для практики 6.4.
5. Побочные эффекты каждого индекса.

## Контрольные вопросы

1. Чем `pg_relation_size` отличается от `pg_total_relation_size`?
2. Почему JSONB/text payload может влиять на TOAST?
3. Почему baseline нужен до создания индекса?
4. Какие побочные эффекты есть у индекса?

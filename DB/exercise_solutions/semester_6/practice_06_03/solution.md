# Решение 6.3. Физическое хранение и первичные индексы

## `measurements.sql`

```sql
-- q01_relation_sizes
SELECT
    relid::regclass AS relation_name,
    pg_relation_size(relid) AS table_bytes,
    pg_indexes_size(relid) AS indexes_bytes,
    pg_total_relation_size(relid) AS total_bytes
FROM pg_statio_user_tables
WHERE schemaname = 'app'
  AND relname IN ('events', 'orders', 'documents')
ORDER BY total_bytes DESC;

-- q02_column_types
SELECT table_name, column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'app'
  AND table_name IN ('events', 'orders', 'documents')
ORDER BY table_name, ordinal_position;

-- q03_indexes
SELECT schemaname, tablename, indexname, indexdef
FROM pg_indexes
WHERE schemaname = 'app'
ORDER BY tablename, indexname;

-- q04_toast_relations
SELECT
    c.relname AS table_name,
    t.relname AS toast_table_name
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
LEFT JOIN pg_class t ON t.oid = c.reltoastrelid
WHERE n.nspname = 'app'
  AND c.relname IN ('events', 'orders', 'documents');

-- q05_payload_samples
SELECT event_id, pg_column_size(payload) AS payload_bytes
FROM app.events
ORDER BY payload_bytes DESC
LIMIT 5;
```

## `plans.sql`

```sql
-- q06_orders_by_tenant_status
EXPLAIN (ANALYZE, BUFFERS)
SELECT order_id, tenant_id, status, total_amount, created_at
FROM app.orders
WHERE tenant_id = 1
  AND status = 'created'
ORDER BY created_at DESC
LIMIT 50;

-- q07_documents_by_metadata_category
EXPLAIN (ANALYZE, BUFFERS)
SELECT document_id, tenant_id, title
FROM app.documents
WHERE metadata->>'category' = 'billing'
ORDER BY created_at DESC
LIMIT 50;
```

## Правильные выводы

- `pg_relation_size` - heap/основной relation; `pg_total_relation_size` включает индексы и TOAST.
- JSONB/text payload может создавать TOAST relation.
- Индексные гипотезы должны ссылаться на `WHERE` и `ORDER BY`, а не просто на "большую таблицу".

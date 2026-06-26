# Решение 6.2. Устройство кластера и storage/MVCC-наблюдения

## `catalog_queries.sql`

```sql
-- q01_database_and_settings
SELECT current_database(), current_user, current_setting('server_version'), current_setting('data_directory');

-- q02_course_schemas
SELECT schema_name
FROM information_schema.schemata
WHERE schema_name IN ('app', 'public')
ORDER BY schema_name;

-- q03_app_relations
SELECT c.relname, c.relkind, n.nspname
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'app'
  AND c.relkind IN ('r', 'i', 'p')
ORDER BY c.relkind, c.relname;

-- q04_relation_files
SELECT
    relname,
    pg_relation_filepath(c.oid) AS relation_file
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'app'
  AND c.relname IN ('events', 'orders', 'documents')
ORDER BY relname;

-- q05_activity
SELECT pid, usename, datname, state, wait_event_type, wait_event
FROM pg_stat_activity
WHERE datname = current_database()
ORDER BY pid;

-- q06_relation_sizes
SELECT
    relid::regclass AS relation_name,
    pg_relation_size(relid) AS heap_bytes,
    pg_indexes_size(relid) AS index_bytes,
    pg_total_relation_size(relid) AS total_bytes
FROM pg_catalog.pg_statio_user_tables
WHERE schemaname = 'app'
ORDER BY total_bytes DESC;
```

## MVCC/storage observation

Приемлемое наблюдение:

1. Снять `pg_total_relation_size('app.orders')`.
2. Выполнить `UPDATE app.orders SET updated_at = current_timestamp WHERE order_id <= 150;`.
3. Снова снять размер.
4. Выполнить `VACUUM app.orders;`.
5. Зафиксировать, что физический след может измениться не так, как логическое количество строк.

Нельзя вручную редактировать файлы data directory.

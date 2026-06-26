# Пример ожидаемых артефактов 6.2

```text
semester-6/practice-02-cluster-internals/
  README.md
  catalog_queries.sql
  cluster-map.md
  mvcc-observation.md
```

## `catalog_queries.sql`

```sql
-- q04_relation_files
SELECT relname, pg_relation_filepath(c.oid) AS relation_file
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'app'
  AND c.relname IN ('events', 'orders', 'documents')
ORDER BY relname;

-- q06_relation_sizes
SELECT relid::regclass AS relation_name,
       pg_relation_size(relid) AS heap_bytes,
       pg_indexes_size(relid) AS index_bytes,
       pg_total_relation_size(relid) AS total_bytes
FROM pg_statio_user_tables
WHERE schemaname = 'app'
ORDER BY total_bytes DESC;
```

## `cluster-map.md`

```md
# Cluster map

Cluster is started by Docker Compose from practice 6.1.
Data directory is inside the container volume mounted at `/var/lib/postgresql/data`.

Logical structure:

- database: `db_course`;
- schema: `app`;
- key tables: `events`, `orders`, `documents`;
- roles: owner, app, readonly.

Relation files are discovered through `pg_relation_filepath`; files are read-only for this exercise and must not be edited manually.
```

## `mvcc-observation.md`

```md
# MVCC observation

Before update, `pg_total_relation_size('app.orders')` was recorded.
Then I updated 150 rows and committed.
The logical row count did not change, but storage statistics changed.
After `VACUUM app.orders`, PostgreSQL could reclaim or mark dead tuples reusable.

This is an observed storage effect. I did not edit data directory files.
```

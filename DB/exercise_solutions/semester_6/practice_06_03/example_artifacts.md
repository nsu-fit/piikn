# Пример ожидаемых артефактов 6.3

```text
semester-6/practice-03-physical-storage-indexes/
  README.md
  measurements.sql
  plans.sql
  report.md
```

## `measurements.sql`

```sql
-- q01_relation_sizes
SELECT relid::regclass AS relation_name,
       pg_relation_size(relid) AS table_bytes,
       pg_indexes_size(relid) AS indexes_bytes,
       pg_total_relation_size(relid) AS total_bytes
FROM pg_statio_user_tables
WHERE schemaname = 'app'
ORDER BY total_bytes DESC;

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
```

## `report.md`

```md
# Storage report

`app.events` is the largest table in this seed dataset.
`pg_total_relation_size` is larger than `pg_relation_size` because it includes indexes and possibly TOAST.

Index hypotheses:

1. `(tenant_id, status, created_at DESC)` for order list query.
2. expression index on `(metadata->>'category')` for document category search.

Cost: indexes increase write cost, disk usage and backup size.
```

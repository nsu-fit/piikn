# Пример ожидаемых артефактов 6.4

```text
semester-6/practice-04-advanced-indexes-jsonb/
  README.md
  before.sql
  indexes.sql
  after.sql
  report.md
```

## `indexes.sql`

```sql
CREATE INDEX IF NOT EXISTS orders_tenant_status_created_idx
ON app.orders (tenant_id, status, created_at DESC);

CREATE INDEX IF NOT EXISTS documents_metadata_category_created_idx
ON app.documents ((metadata->>'category'), created_at DESC);
```

## `after.sql`

```sql
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
# Index experiment

Hypothesis 1: composite B-tree index helps because the query filters by `tenant_id` and `status`, then orders by `created_at DESC`.

Hypothesis 2: expression index helps only if the query uses the same expression `metadata->>'category'`.

Trade-off: both indexes increase storage and slow down writes to the indexed columns.
```

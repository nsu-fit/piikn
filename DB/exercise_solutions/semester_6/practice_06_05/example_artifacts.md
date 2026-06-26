# Пример ожидаемых артефактов 6.5

Вариант: `documents_by_jsonb_category`.

```text
semester-6/checkpoint-optimization-practicum/
  README.md
  before.sql
  after.sql
  explain_before.md
  explain_after.md
  report.md
```

## `before.sql`

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT document_id, tenant_id, title, created_at
FROM app.documents
WHERE metadata->>'category' = 'billing'
ORDER BY created_at DESC
LIMIT 100;
```

## `after.sql`

```sql
CREATE INDEX IF NOT EXISTS documents_category_created_idx
ON app.documents ((metadata->>'category'), created_at DESC);

EXPLAIN (ANALYZE, BUFFERS)
SELECT document_id, tenant_id, title, created_at
FROM app.documents
WHERE metadata->>'category' = 'billing'
ORDER BY created_at DESC
LIMIT 100;
```

## `report.md`

```md
# Optimization report

Problem: the baseline plan had to evaluate `metadata->>'category'` for many rows before sorting.

Change: expression index on `(metadata->>'category')` plus `created_at DESC`.

Expected effect: fewer rows scanned and cheaper ordering for this predicate.

Cost: index consumes disk and slows writes to `metadata`/`created_at`.
```

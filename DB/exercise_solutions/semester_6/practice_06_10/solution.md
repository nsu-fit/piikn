# Решение 6.10. Миграция схемы

## `migration.sql`

```sql
ALTER TABLE app.orders
ADD COLUMN IF NOT EXISTS external_reference text;

CREATE UNIQUE INDEX IF NOT EXISTS orders_tenant_external_reference_uq
ON app.orders (tenant_id, external_reference)
WHERE external_reference IS NOT NULL;
```

Это expand-шаг: старый writer продолжает писать строки без `external_reference`.

## `test-data.sql`

```sql
INSERT INTO app.orders
    (tenant_id, status, total_amount, idempotency_key, created_at, updated_at)
VALUES
    (10, 'created', 100.00, 'old-writer-1', current_timestamp, current_timestamp);

INSERT INTO app.orders
    (tenant_id, status, total_amount, idempotency_key, external_reference, created_at, updated_at)
VALUES
    (10, 'created', 200.00, 'new-writer-1', 'EXT-100', current_timestamp, current_timestamp);
```

## `checks.sql`

```sql
-- old writer works
SELECT order_id
FROM app.orders
WHERE tenant_id = 10
  AND idempotency_key = 'old-writer-1'
  AND external_reference IS NULL;

-- new writer works
SELECT order_id
FROM app.orders
WHERE tenant_id = 10
  AND external_reference = 'EXT-100';

-- duplicate in same tenant should be rejected
DO $$
BEGIN
    INSERT INTO app.orders
        (tenant_id, status, total_amount, idempotency_key, external_reference, created_at, updated_at)
    VALUES
        (10, 'created', 300.00, 'new-writer-duplicate', 'EXT-100', current_timestamp, current_timestamp);

    RAISE EXCEPTION 'duplicate external_reference was accepted';
EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'ok: duplicate external_reference rejected';
END $$;
```

## Rollback/forward-fix

Если код не использует новый столбец, безопасный rollback - откат приложения. Если данные уже пишутся, предпочтительнее forward-fix: исправить индекс/валидацию, не удаляя столбец и данные.

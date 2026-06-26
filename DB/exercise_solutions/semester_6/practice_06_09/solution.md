# Решение 6.9. Application integration и advanced SQL-паттерны

## Idempotency key

```sql
BEGIN;

INSERT INTO app.orders
    (tenant_id, status, total_amount, idempotency_key, created_at, updated_at)
VALUES
    ($1, 'created', $2, $3, current_timestamp, current_timestamp)
ON CONFLICT (tenant_id, idempotency_key)
DO UPDATE SET updated_at = app.orders.updated_at
RETURNING order_id, tenant_id, status, total_amount, idempotency_key;

COMMIT;
```

Ключевая гарантия находится в БД: `UNIQUE (tenant_id, idempotency_key)`.

## Queue pattern

```sql
BEGIN;

WITH picked AS (
    SELECT event_id
    FROM app.events
    WHERE event_type = $1
    ORDER BY created_at
    FOR UPDATE SKIP LOCKED
    LIMIT $2
)
SELECT e.*
FROM app.events e
JOIN picked p ON p.event_id = e.event_id;

COMMIT;
```

В реальной очереди нужен отдельный статус/lease, потому что простой `SELECT` не фиксирует обработку.

## Keyset pagination

```sql
SELECT document_id, tenant_id, title, created_at
FROM app.documents
WHERE tenant_id = $1
  AND (created_at, document_id) < ($2, $3)
ORDER BY created_at DESC, document_id DESC
LIMIT $4;
```

`OFFSET` на больших данных становится дорогим и нестабильным при конкурентных изменениях.

## Тесты

- successful path;
- duplicate/retry path;
- concurrent workers или boundary page;
- проверка tenant boundary.

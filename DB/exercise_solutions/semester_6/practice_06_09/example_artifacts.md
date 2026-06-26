# Пример ожидаемых артефактов 6.9

Вариант: `order_creation_idempotency`.

```text
semester-6/practice-09-application-integration/
  README.md
  data-access-scenario.md
  sql-pattern.sql
  test-sketch.md
```

## `data-access-scenario.md`

```md
# Order creation idempotency

Action: API receives a request to create an order.

Tables:

- `app.orders`;
- optionally `app.events` for audit/event publishing.

Transaction boundary:

Begin before inserting order, commit after order row and event row are consistent.

Parameters:

- tenant id;
- total amount;
- idempotency key.

Errors:

- unique violation means duplicate request;
- serialization failure or deadlock should be retried at use-case level.
```

## `sql-pattern.sql`

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

## `test-sketch.md`

```md
# Tests

1. New idempotency key creates one order.
2. Repeated request with the same key returns the same order.
3. Same key in another tenant is allowed.
4. Concurrent duplicate requests do not create two orders.
```

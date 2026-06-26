# Решение 5.7. DML-сценарии на основе SELECT

Default-вариант: `min_total_amount = 100000`, `stale_before = '2026-01-01 00:00:00'`, `processing_timestamp = '2026-02-04 09:00:00'`.

## `changes.sql`

```sql
BEGIN;

-- q01_preselect_processing_candidates
SELECT order_id, customer_id, total_amount, status, idempotency_key
FROM course_lab.order_queue
WHERE status = 'pending'
  AND total_amount >= 100000
ORDER BY order_id;

-- q02_insert_audit_for_candidates
INSERT INTO course_lab.order_audit (order_id, action)
SELECT q.order_id, 'picked_for_processing'
FROM course_lab.order_queue q
WHERE q.status = 'pending'
  AND q.total_amount >= 100000
ON CONFLICT (order_id, action) DO NOTHING;

-- q03_mark_processing
UPDATE course_lab.order_queue q
SET status = 'processing',
    processed_at = timestamp '2026-02-04 09:00:00'
FROM (
    SELECT order_id
    FROM course_lab.order_queue
    WHERE status = 'pending'
      AND total_amount >= 100000
) candidates
WHERE q.order_id = candidates.order_id
RETURNING q.order_id, q.customer_id, q.status, q.total_amount, q.processed_at;

-- q04_cancel_old_drafts
UPDATE course_lab.order_queue
SET status = 'cancelled',
    cancelled_reason = 'stale draft'
WHERE status = 'draft'
  AND created_at < timestamp '2026-01-01 00:00:00'
RETURNING order_id, customer_id, status, cancelled_reason;

COMMIT;
```

## `checks.sql`

```sql
-- q01_processing_count
SELECT count(*)::bigint AS processing_count
FROM course_lab.order_queue
WHERE status = 'processing';

-- q02_duplicate_audit_events
SELECT order_id, action, count(*)::bigint AS event_count
FROM course_lab.order_audit
GROUP BY order_id, action
HAVING count(*) > 1;

-- q03_stale_drafts_left
SELECT order_id, created_at
FROM course_lab.order_queue
WHERE status = 'draft'
  AND created_at < timestamp '2026-01-01 00:00:00';

-- q04_invalid_statuses
SELECT order_id, status
FROM course_lab.order_queue
WHERE status NOT IN ('draft', 'pending', 'processing', 'cancelled', 'done');
```

## Пояснения

Предварительный `SELECT` защищает от слишком широкого `UPDATE`. Audit-вставка идемпотентна из-за `UNIQUE (order_id, action)` и `ON CONFLICT DO NOTHING`. `RETURNING` фиксирует фактически измененные строки. Мягкая отмена сохраняет историю заказа.

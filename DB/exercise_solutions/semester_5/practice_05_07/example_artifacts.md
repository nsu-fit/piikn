# Пример ожидаемых артефактов 5.7

```text
semester-5/practice-07-dml-select-scenarios/
  README.md
  changes.sql
  checks.sql
  answers.md
```

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
SELECT order_id, 'picked_for_processing'
FROM course_lab.order_queue
WHERE status = 'pending'
  AND total_amount >= 100000
ON CONFLICT (order_id, action) DO NOTHING;

-- q03_mark_processing
UPDATE course_lab.order_queue q
SET status = 'processing',
    processed_at = timestamp '2026-02-04 09:00:00'
WHERE q.status = 'pending'
  AND q.total_amount >= 100000
RETURNING order_id, customer_id, status, total_amount, processed_at;

-- q04_cancel_old_drafts
UPDATE course_lab.order_queue
SET status = 'cancelled',
    cancelled_reason = 'stale draft'
WHERE status = 'draft'
  AND created_at < timestamp '2026-01-01 00:00:00'
RETURNING order_id, status, cancelled_reason;

COMMIT;
```

## `answers.md`

```md
# Answers

The preliminary SELECT uses the same predicate as the UPDATE, so I can inspect the target rows before changing them.
Audit insert is idempotent because `(order_id, action)` is unique and `ON CONFLICT DO NOTHING` handles reruns.
`RETURNING` records exactly which rows were changed.
Soft cancellation keeps historical rows and is safer than deleting drafts.
```

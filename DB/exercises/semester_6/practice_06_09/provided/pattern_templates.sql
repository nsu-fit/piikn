-- Keyset pagination template.
SELECT document_id, tenant_id, title, created_at
FROM app.documents
WHERE tenant_id = $1
  AND (created_at, document_id) < ($2, $3)
ORDER BY created_at DESC, document_id DESC
LIMIT $4;

-- Queue template.
SELECT event_id
FROM app.events
WHERE event_type = $1
ORDER BY created_at
FOR UPDATE SKIP LOCKED
LIMIT $2;

-- Idempotency template.
INSERT INTO app.orders (tenant_id, status, total_amount, idempotency_key, created_at, updated_at)
VALUES ($1, 'created', $2, $3, current_timestamp, current_timestamp)
ON CONFLICT (tenant_id, idempotency_key)
DO UPDATE SET updated_at = app.orders.updated_at
RETURNING order_id, tenant_id, status, total_amount, idempotency_key;

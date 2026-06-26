-- Пример класса вариантов. На контрольной преподаватель выдает конкретный запрос.

-- variant_orders_by_tenant_status_date
SELECT order_id, tenant_id, status, total_amount, created_at
FROM app.orders
WHERE tenant_id = 2
  AND status = 'created'
  AND created_at >= timestamp '2026-01-01 00:00:00+00'
ORDER BY created_at DESC
LIMIT 100;

-- variant_documents_by_jsonb_category
SELECT document_id, tenant_id, title, created_at
FROM app.documents
WHERE metadata->>'category' = 'billing'
ORDER BY created_at DESC
LIMIT 100;

-- variant_events_by_time_range_and_type
SELECT event_id, tenant_id, event_type, created_at
FROM app.events
WHERE event_type = 'payment_failed'
  AND created_at >= timestamp '2026-01-02 00:00:00+00'
  AND created_at < timestamp '2026-01-03 00:00:00+00'
ORDER BY created_at;

SELECT 'events' AS table_name, count(*)::bigint AS row_count FROM app.events
UNION ALL
SELECT 'orders', count(*)::bigint FROM app.orders
UNION ALL
SELECT 'documents', count(*)::bigint FROM app.documents;

SELECT tenant_id, count(*)::bigint AS order_count, sum(total_amount) AS total_amount
FROM app.orders
GROUP BY tenant_id
ORDER BY tenant_id;

SELECT metadata->>'category' AS category, count(*)::bigint AS document_count
FROM app.documents
GROUP BY metadata->>'category'
ORDER BY category;

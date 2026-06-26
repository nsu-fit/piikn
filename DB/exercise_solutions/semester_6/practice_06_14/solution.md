# Решение 6.14. Аналитическая витрина

## Fact/dim split

- Fact: order/day/status aggregate или raw order fact.
- Dimensions: date, tenant, status, event_type.
- Source of truth остается OLTP-таблицами `app.orders` и `app.events`.

## `queries.sql`

```sql
-- q01_orders_by_day_status
SELECT
    date_trunc('day', created_at)::date AS order_day,
    tenant_id,
    status,
    count(*)::bigint AS order_count,
    sum(total_amount) AS total_amount
FROM app.orders
GROUP BY order_day, tenant_id, status
ORDER BY order_day, tenant_id, status;

-- q02_running_total_window
WITH daily AS (
    SELECT
        date_trunc('day', created_at)::date AS order_day,
        tenant_id,
        sum(total_amount) AS day_amount
    FROM app.orders
    GROUP BY order_day, tenant_id
)
SELECT
    order_day,
    tenant_id,
    day_amount,
    sum(day_amount) OVER (
        PARTITION BY tenant_id
        ORDER BY order_day
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_amount
FROM daily
ORDER BY tenant_id, order_day;

-- q03_events_by_day_type
SELECT
    date_trunc('day', created_at)::date AS event_day,
    tenant_id,
    event_type,
    count(*)::bigint AS event_count
FROM app.events
GROUP BY event_day, tenant_id, event_type
ORDER BY event_day, tenant_id, event_count DESC;

-- q04_data_quality_late_or_duplicate_events
SELECT tenant_id, payload->>'order_id' AS order_id, event_type, count(*)::bigint
FROM app.events
GROUP BY tenant_id, payload->>'order_id', event_type
HAVING count(*) > 1
ORDER BY count(*) DESC;
```

## Materialized view

Materialized view допустима для дневных агрегатов, но должна иметь refresh policy, индекс по `(tenant_id, order_day)` и описание staleness.

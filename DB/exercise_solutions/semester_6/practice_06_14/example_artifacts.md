# Пример ожидаемых артефактов 6.14

```text
semester-6/practice-14-analytics-mart/
  README.md
  mart-design.md
  queries.sql
  materialized-view.md
  schema.sql
```

## `mart-design.md`

```md
# Analytics mart

Facts:

- order amount by day, tenant and status;
- event count by day, tenant and event type.

Dimensions:

- date;
- tenant;
- order status;
- event type.

Source of truth remains `app.orders` and `app.events`.
```

## `queries.sql`

```sql
-- q02_running_total_window
WITH daily AS (
    SELECT date_trunc('day', created_at)::date AS order_day,
           tenant_id,
           sum(total_amount) AS day_amount
    FROM app.orders
    GROUP BY order_day, tenant_id
)
SELECT order_day, tenant_id, day_amount,
       sum(day_amount) OVER (PARTITION BY tenant_id ORDER BY order_day) AS running_amount
FROM daily
ORDER BY tenant_id, order_day;
```

## `materialized-view.md`

```md
# Materialized view

Candidate: daily order aggregate.
Refresh: hourly for dashboard, manual refresh for exercise.
Staleness: dashboard may be up to one hour behind OLTP.
Index: `(tenant_id, order_day)`.
```

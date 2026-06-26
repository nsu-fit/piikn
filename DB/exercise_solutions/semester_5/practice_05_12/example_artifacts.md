# Пример ожидаемых артефактов 5.12

```text
semester-5/practice-12-views-functions/
  README.md
  views.sql
  functions.sql
  usage.sql
```

## `views.sql`

```sql
CREATE OR REPLACE VIEW course_lab.v_route_revenue AS
SELECT f.route_no, r.departure_airport, r.arrival_airport,
       count(*)::bigint AS segment_count,
       sum(s.price) AS total_revenue
FROM bookings.segments s
JOIN bookings.flights f ON f.flight_id = s.flight_id
JOIN bookings.routes r
  ON r.route_no = f.route_no
 AND r.validity @> f.scheduled_departure
GROUP BY f.route_no, r.departure_airport, r.arrival_airport;
```

## `functions.sql`

```sql
CREATE OR REPLACE FUNCTION course_lab.booking_total_delta(p_booking_ref text)
RETURNS numeric
LANGUAGE sql
STABLE
AS $$
    SELECT b.total_amount - coalesce(sum(s.price), 0)
    FROM bookings.bookings b
    LEFT JOIN bookings.tickets t ON t.book_ref = b.book_ref
    LEFT JOIN bookings.segments s ON s.ticket_no = t.ticket_no
    WHERE b.book_ref = p_booking_ref
    GROUP BY b.book_ref, b.total_amount
$$;
```

## `usage.sql`

```sql
-- q01_top_routes
SELECT *
FROM course_lab.v_route_revenue
ORDER BY total_revenue DESC, route_no
LIMIT 10;

-- q04_function_missing_booking
SELECT course_lab.booking_total_delta('NO_SUCH_BOOKING') AS delta;
```

## `README.md`

```md
# Views and function

The views hide repeated joins and make checks reusable.
The function is narrow and read-only.
Materialized view would need a refresh policy and staleness notes.
```

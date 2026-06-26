# Решение 5.12. Представления и простые функции

## `views.sql`

```sql
CREATE SCHEMA IF NOT EXISTS course_lab;

CREATE OR REPLACE VIEW course_lab.v_route_revenue AS
SELECT
    f.route_no,
    r.departure_airport,
    r.arrival_airport,
    count(*)::bigint AS segment_count,
    sum(s.price) AS total_revenue
FROM bookings.segments s
JOIN bookings.flights f ON f.flight_id = s.flight_id
JOIN bookings.routes r
  ON r.route_no = f.route_no
 AND r.validity @> f.scheduled_departure
GROUP BY f.route_no, r.departure_airport, r.arrival_airport;

CREATE OR REPLACE VIEW course_lab.v_booking_quality AS
SELECT
    b.book_ref AS booking_ref,
    b.total_amount,
    coalesce(sum(s.price), 0) AS calculated_amount,
    b.total_amount - coalesce(sum(s.price), 0) AS amount_delta
FROM bookings.bookings b
LEFT JOIN bookings.tickets t ON t.book_ref = b.book_ref
LEFT JOIN bookings.segments s ON s.ticket_no = t.ticket_no
GROUP BY b.book_ref, b.total_amount;
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

-- q02_booking_mismatches
SELECT *
FROM course_lab.v_booking_quality
WHERE amount_delta <> 0
ORDER BY abs(amount_delta) DESC, booking_ref
LIMIT 20;

-- q03_function_existing_booking
SELECT course_lab.booking_total_delta(
    (SELECT book_ref FROM bookings.bookings ORDER BY book_ref LIMIT 1)
) AS delta;

-- q04_function_missing_booking
SELECT course_lab.booking_total_delta('NO_SUCH_BOOKING') AS delta;

-- q05_view_reuse
SELECT departure_airport, sum(total_revenue) AS departure_revenue
FROM course_lab.v_route_revenue
GROUP BY departure_airport
ORDER BY departure_revenue DESC
LIMIT 10;
```

## Пояснение

Обычный `VIEW` удобен для повторяемого чтения, но не кеширует результат. Materialized view потребовала бы refresh policy и явной работы со staleness.

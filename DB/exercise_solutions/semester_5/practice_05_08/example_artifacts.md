# Пример ожидаемых артефактов 5.8

Пример для условного варианта: `departure_airport = 'OVB'`, `arrival_airport = 'DME'`, `min_total_amount = 100000`.

```text
semester-5/checkpoint-02-select-dml/
  README.md
  solution.sql
  answers.md
```

## `solution.sql`

```sql
-- task_01
SELECT book_ref, book_date, total_amount
FROM bookings.bookings
WHERE total_amount >= 100000
ORDER BY total_amount DESC, book_ref
LIMIT 20;

-- task_02
SELECT route_no, departure_airport, arrival_airport
FROM bookings.routes
WHERE departure_airport = 'OVB'
  AND arrival_airport = 'DME'
ORDER BY route_no;

-- task_03
SELECT t.ticket_no, s.flight_id, f.route_no, s.price
FROM bookings.tickets t
JOIN bookings.segments s ON s.ticket_no = t.ticket_no
JOIN bookings.flights f ON f.flight_id = s.flight_id
ORDER BY t.ticket_no, s.flight_id
LIMIT 50;

-- task_04
SELECT fare_conditions, count(*)::bigint AS segment_count, sum(price) AS revenue
FROM bookings.segments
GROUP BY fare_conditions
ORDER BY revenue DESC;

-- task_05
SELECT a.airport_code, a.airport_name
FROM bookings.airports a
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings.routes r
    WHERE r.departure_airport = a.airport_code
)
ORDER BY a.airport_code;

-- task_06_preselect
SELECT order_id, total_amount
FROM course_lab.order_queue
WHERE status = 'pending'
  AND total_amount >= 100000;

-- task_06_update
UPDATE course_lab.order_queue
SET status = 'processing'
WHERE status = 'pending'
  AND total_amount >= 100000
RETURNING order_id, status;
```

## `answers.md`

```md
# Answers

The join chain is correct because tickets connect to flights only through `segments`.
The aggregation in task 04 is at fare condition level.
The DML task affects only pending orders above the threshold.
The wrong SQL fragment from the variant is wrong because it joins unrelated rows or updates too broad a set.
```

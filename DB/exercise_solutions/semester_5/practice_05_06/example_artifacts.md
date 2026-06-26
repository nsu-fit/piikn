# Пример ожидаемых артефактов 5.6

```text
semester-5/practice-06-basic-select/
  README.md
  queries.sql
  answers.md
```

## `queries.sql`

```sql
SET bookings.lang = 'en';

-- q01_recent_bookings
SELECT book_ref, book_date, total_amount
FROM bookings.bookings
WHERE total_amount >= 100000
ORDER BY book_date DESC, book_ref
LIMIT 20;

-- q03_ticket_segments
SELECT t.ticket_no, s.flight_id, f.route_no, s.fare_conditions, s.price
FROM bookings.tickets t
JOIN bookings.segments s ON s.ticket_no = t.ticket_no
JOIN bookings.flights f ON f.flight_id = s.flight_id
WHERE f.status = 'Scheduled'
ORDER BY s.flight_id, t.ticket_no
LIMIT 50;

-- q06_airports_without_departure_routes
SELECT a.airport_code, a.airport_name, a.city
FROM bookings.airports a
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings.routes r
    WHERE r.departure_airport = a.airport_code
)
ORDER BY a.airport_code;
```

В полном артефакте должны быть все метки `q01` - `q07`.

## `answers.md`

```md
# Answers

The main row multiplication risk is in joins through `tickets -> segments -> flights`: if I skip `segments`, the query becomes meaningless.

The most important explicit `ORDER BY` is in `q01_recent_bookings`, because `LIMIT 20` without ordering does not mean "latest 20".

`q06` is an anti-join. It is better than a manual list because it adapts to any database size.

The wrong join `JOIN flights ON true` creates a Cartesian product. Correct chain: `tickets -> segments -> flights`.
```

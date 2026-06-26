# Решение 5.6. Базовый SELECT

Default-вариант: `departure_airport = 'OVB'`, `arrival_airport = 'DME'`, `min_total_amount = 100000`, `status = 'Scheduled'`.

```sql
SET bookings.lang = 'en';

-- q01_recent_bookings
SELECT book_ref, book_date, total_amount
FROM bookings.bookings
WHERE total_amount >= 100000
ORDER BY book_date DESC, book_ref
LIMIT 20;

-- q02_route_flights
SELECT
    f.flight_id,
    f.route_no,
    f.scheduled_departure,
    f.scheduled_arrival,
    f.status
FROM bookings.flights f
JOIN bookings.routes r
  ON r.route_no = f.route_no
 AND r.validity @> f.scheduled_departure
WHERE r.departure_airport = 'OVB'
  AND r.arrival_airport = 'DME'
  AND f.scheduled_departure >= bookings.now()
ORDER BY f.scheduled_departure, f.flight_id
LIMIT 30;

-- q03_ticket_segments
SELECT
    t.ticket_no,
    s.flight_id,
    f.route_no,
    s.fare_conditions,
    s.price
FROM bookings.tickets t
JOIN bookings.segments s ON s.ticket_no = t.ticket_no
JOIN bookings.flights f ON f.flight_id = s.flight_id
WHERE f.status = 'Scheduled'
ORDER BY s.flight_id, t.ticket_no
LIMIT 50;

-- q04_fare_summary
SELECT
    fare_conditions,
    count(*)::bigint AS segment_count,
    min(price) AS min_price,
    max(price) AS max_price,
    avg(price) AS avg_price
FROM bookings.segments
GROUP BY fare_conditions
ORDER BY segment_count DESC, fare_conditions;

-- q05_route_revenue
SELECT
    f.route_no,
    r.arrival_airport,
    count(*)::bigint AS segment_count,
    sum(s.price) AS total_amount
FROM bookings.segments s
JOIN bookings.flights f ON f.flight_id = s.flight_id
JOIN bookings.routes r
  ON r.route_no = f.route_no
 AND r.validity @> f.scheduled_departure
WHERE r.departure_airport = 'OVB'
GROUP BY f.route_no, r.arrival_airport
ORDER BY total_amount DESC, f.route_no
LIMIT 10;

-- q06_airports_without_departure_routes
SELECT a.airport_code, a.airport_name, a.city
FROM bookings.airports a
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings.routes r
    WHERE r.departure_airport = a.airport_code
)
ORDER BY a.airport_code;

-- q07_bookings_ticket_count
SELECT
    b.book_ref,
    b.total_amount,
    count(t.ticket_no)::bigint AS ticket_count
FROM bookings.bookings b
LEFT JOIN bookings.tickets t ON t.book_ref = b.book_ref
WHERE b.total_amount >= 100000
GROUP BY b.book_ref, b.total_amount
ORDER BY b.total_amount DESC, b.book_ref
LIMIT 30;
```

## Ответ на q08

`JOIN ... ON true` создает декартово произведение билетов и рейсов: каждая строка `tickets` соединяется с каждым рейсом, хотя такой связи в предметной области нет.

Корректная цепочка:

```sql
FROM bookings.tickets t
JOIN bookings.segments s ON s.ticket_no = t.ticket_no
JOIN bookings.flights f ON f.flight_id = s.flight_id
```

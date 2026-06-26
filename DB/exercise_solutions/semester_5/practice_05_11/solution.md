# Решение 5.11. Нормализация учебной схемы

## `decomposition.sql`

```sql
DROP TABLE IF EXISTS course_lab.norm_segments;
DROP TABLE IF EXISTS course_lab.norm_flights;
DROP TABLE IF EXISTS course_lab.norm_tickets;
DROP TABLE IF EXISTS course_lab.norm_bookings;

CREATE TABLE course_lab.norm_bookings (
    booking_ref text PRIMARY KEY,
    book_date timestamp NOT NULL,
    total_amount numeric(12, 2) NOT NULL
);

CREATE TABLE course_lab.norm_tickets (
    ticket_no text PRIMARY KEY,
    booking_ref text NOT NULL REFERENCES course_lab.norm_bookings(booking_ref),
    passenger_id text NOT NULL,
    passenger_name text NOT NULL
);

CREATE TABLE course_lab.norm_flights (
    flight_id integer PRIMARY KEY,
    route_no text NOT NULL,
    departure_airport text NOT NULL,
    arrival_airport text NOT NULL,
    scheduled_departure timestamp NOT NULL
);

CREATE TABLE course_lab.norm_segments (
    ticket_no text NOT NULL REFERENCES course_lab.norm_tickets(ticket_no),
    flight_id integer NOT NULL REFERENCES course_lab.norm_flights(flight_id),
    fare_conditions text NOT NULL,
    price numeric(12, 2) NOT NULL,
    PRIMARY KEY (ticket_no, flight_id)
);

INSERT INTO course_lab.norm_bookings (booking_ref, book_date, total_amount)
SELECT DISTINCT booking_ref, book_date, total_amount
FROM course_lab.flight_sales_flat;

INSERT INTO course_lab.norm_tickets (ticket_no, booking_ref, passenger_id, passenger_name)
SELECT DISTINCT ticket_no, booking_ref, passenger_id, passenger_name
FROM course_lab.flight_sales_flat;

INSERT INTO course_lab.norm_flights
    (flight_id, route_no, departure_airport, arrival_airport, scheduled_departure)
SELECT DISTINCT flight_id, route_no, departure_airport, arrival_airport, scheduled_departure
FROM course_lab.flight_sales_flat;

INSERT INTO course_lab.norm_segments (ticket_no, flight_id, fare_conditions, price)
SELECT DISTINCT ticket_no, flight_id, fare_conditions, price
FROM course_lab.flight_sales_flat;
```

## `checks.sql`

```sql
-- q01_row_count_original
SELECT count(*)::bigint AS row_count
FROM course_lab.flight_sales_flat;

-- q02_row_count_reconstructed
WITH reconstructed AS (
    SELECT
        b.booking_ref, b.book_date, b.total_amount,
        t.ticket_no, t.passenger_id, t.passenger_name,
        f.flight_id, f.route_no, f.departure_airport, f.arrival_airport,
        f.scheduled_departure, s.fare_conditions, s.price
    FROM course_lab.norm_bookings b
    JOIN course_lab.norm_tickets t ON t.booking_ref = b.booking_ref
    JOIN course_lab.norm_segments s ON s.ticket_no = t.ticket_no
    JOIN course_lab.norm_flights f ON f.flight_id = s.flight_id
)
SELECT count(*)::bigint AS row_count
FROM reconstructed;

-- q03_original_minus_reconstructed
WITH reconstructed AS (
    SELECT
        b.booking_ref, b.book_date, b.total_amount,
        t.ticket_no, t.passenger_id, t.passenger_name,
        f.flight_id, f.route_no, f.departure_airport, f.arrival_airport,
        f.scheduled_departure, s.fare_conditions, s.price
    FROM course_lab.norm_bookings b
    JOIN course_lab.norm_tickets t ON t.booking_ref = b.booking_ref
    JOIN course_lab.norm_segments s ON s.ticket_no = t.ticket_no
    JOIN course_lab.norm_flights f ON f.flight_id = s.flight_id
)
SELECT * FROM course_lab.flight_sales_flat
EXCEPT
SELECT * FROM reconstructed;

-- q04_reconstructed_minus_original
WITH reconstructed AS (
    SELECT
        b.booking_ref, b.book_date, b.total_amount,
        t.ticket_no, t.passenger_id, t.passenger_name,
        f.flight_id, f.route_no, f.departure_airport, f.arrival_airport,
        f.scheduled_departure, s.fare_conditions, s.price
    FROM course_lab.norm_bookings b
    JOIN course_lab.norm_tickets t ON t.booking_ref = b.booking_ref
    JOIN course_lab.norm_segments s ON s.ticket_no = t.ticket_no
    JOIN course_lab.norm_flights f ON f.flight_id = s.flight_id
)
SELECT * FROM reconstructed
EXCEPT
SELECT * FROM course_lab.flight_sales_flat;
```

## Пояснение

Количество строк полезно как smoke check, но проверка без потерь должна сравнивать сами строки через `EXCEPT` в обе стороны.

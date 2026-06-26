# Пример ожидаемых артефактов 5.11

```text
semester-5/practice-11-normalization/
  README.md
  decomposition.sql
  checks.sql
  answers.md
```

## `decomposition.sql`

```sql
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
```

## `checks.sql`

```sql
-- q03_original_minus_reconstructed
WITH reconstructed AS (
    SELECT b.booking_ref, b.book_date, b.total_amount,
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
```

## `answers.md`

```md
# Answers

Each normalized table preserves one main dependency group.
Lossless join matters because equal row count alone can hide wrong duplicated rows.
The segment table uses `(ticket_no, flight_id)` because a ticket may contain several flights and one flight is sold to many tickets.
```

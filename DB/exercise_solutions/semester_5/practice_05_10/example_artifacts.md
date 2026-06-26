# Пример ожидаемых артефактов 5.10

```text
semester-5/practice-10-functional-dependencies/
  README.md
  answers.md
  checks.sql
  decomposition_draft.md
```

## `answers.md`

```md
# Functional dependencies

- `booking_ref -> book_date, total_amount`: domain rule.
- `ticket_no -> booking_ref, passenger_id, passenger_name`: domain rule for issued ticket.
- `flight_id -> route_no, departure_airport, arrival_airport, scheduled_departure`: domain rule for a concrete flight.
- `(ticket_no, flight_id) -> fare_conditions, price`: sold segment rule.
- `passenger_id -> passenger_name`: hypothesis, not safe as a universal dependency.

Candidate key for `flight_sales_flat`: `(ticket_no, flight_id)`.

## Anomalies

Update anomaly: changing `arrival_airport` for a flight requires updating multiple sales rows.
Insert anomaly: a new flight cannot be represented before a ticket segment exists.
Deletion anomaly: deleting the last sold segment of a flight removes information about that flight from the flat table.
```

## `checks.sql`

```sql
-- q03_duplicate_segments
SELECT ticket_no, flight_id, count(*)::bigint AS row_count
FROM course_lab.flight_sales_flat
GROUP BY ticket_no, flight_id
HAVING count(*) > 1;

-- q04_booking_total_delta
SELECT booking_ref, max(total_amount) AS stored_total, sum(price) AS calculated_total
FROM course_lab.flight_sales_flat
GROUP BY booking_ref
HAVING max(total_amount) <> sum(price);
```

## `decomposition_draft.md`

```md
# Decomposition draft

- `bookings(booking_ref PK, book_date, total_amount)`;
- `tickets(ticket_no PK, booking_ref FK, passenger_id, passenger_name)`;
- `flights(flight_id PK, route_no, departure_airport, arrival_airport, scheduled_departure)`;
- `segments(ticket_no FK, flight_id FK, fare_conditions, price, PK(ticket_no, flight_id))`.
```

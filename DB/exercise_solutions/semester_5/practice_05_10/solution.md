# Решение 5.10. Функциональные зависимости и аномалии

## Функциональные зависимости

Минимальный корректный набор:

- `booking_ref -> book_date, total_amount`;
- `ticket_no -> booking_ref, passenger_id, passenger_name`;
- `flight_id -> route_no, departure_airport, arrival_airport, scheduled_departure`;
- `(ticket_no, flight_id) -> fare_conditions, price`;
- `route_no, scheduled_departure -> flight_id` допустимо как предметная гипотеза для расписания, но лучше помечать осторожно;
- `passenger_id -> passenger_name` допустимо только как спорная гипотеза: имя пассажира может меняться или быть записано по-разному.

Кандидатный ключ плоской таблицы: `(ticket_no, flight_id)`, потому что строка описывает сегмент конкретного билета на конкретном рейсе.

## Аномалии

- Update anomaly: изменение аэропорта рейса `501` нужно повторять во всех строках с `flight_id = 501`.
- Insert anomaly: нельзя занести новый рейс без продажи сегмента, если единственная таблица - `flight_sales_flat`.
- Delete anomaly: удаление последней продажи рейса удаляет информацию о самом рейсе.

## `checks.sql`

```sql
-- q01_flight_conflicts
SELECT
    flight_id,
    count(DISTINCT route_no) AS route_count,
    count(DISTINCT departure_airport) AS departure_count,
    count(DISTINCT arrival_airport) AS arrival_count,
    count(DISTINCT scheduled_departure) AS departure_time_count
FROM course_lab.flight_sales_flat
GROUP BY flight_id
HAVING count(DISTINCT route_no) > 1
    OR count(DISTINCT departure_airport) > 1
    OR count(DISTINCT arrival_airport) > 1
    OR count(DISTINCT scheduled_departure) > 1;

-- q02_ticket_conflicts
SELECT
    ticket_no,
    count(DISTINCT booking_ref) AS booking_count,
    count(DISTINCT passenger_id) AS passenger_id_count,
    count(DISTINCT passenger_name) AS passenger_name_count
FROM course_lab.flight_sales_flat
GROUP BY ticket_no
HAVING count(DISTINCT booking_ref) > 1
    OR count(DISTINCT passenger_id) > 1
    OR count(DISTINCT passenger_name) > 1;

-- q03_duplicate_segments
SELECT ticket_no, flight_id, count(*)::bigint AS row_count
FROM course_lab.flight_sales_flat
GROUP BY ticket_no, flight_id
HAVING count(*) > 1;

-- q04_booking_total_delta
SELECT
    booking_ref,
    max(total_amount) AS stored_total,
    sum(price) AS calculated_total,
    max(total_amount) - sum(price) AS delta
FROM course_lab.flight_sales_flat
GROUP BY booking_ref
HAVING max(total_amount) <> sum(price);
```

## Черновик декомпозиции

- `bookings(booking_ref PK, book_date, total_amount)`;
- `tickets(ticket_no PK, booking_ref FK, passenger_id, passenger_name)`;
- `flights(flight_id PK, route_no, departure_airport, arrival_airport, scheduled_departure)`;
- `segments(ticket_no FK, flight_id FK, fare_conditions, price, PK(ticket_no, flight_id))`.

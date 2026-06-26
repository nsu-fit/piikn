-- Шаблон можно адаптировать, если вы добавили дополнительные таблицы.
-- Имена и порядок столбцов в reconstructed должны совпадать с flight_sales_flat.

WITH reconstructed AS (
    SELECT
        b.booking_ref,
        b.book_date,
        b.total_amount,
        t.ticket_no,
        t.passenger_id,
        t.passenger_name,
        f.flight_id,
        f.route_no,
        f.departure_airport,
        f.arrival_airport,
        f.scheduled_departure,
        s.fare_conditions,
        s.price
    FROM course_lab.norm_bookings b
    JOIN course_lab.norm_tickets t ON t.booking_ref = b.booking_ref
    JOIN course_lab.norm_segments s ON s.ticket_no = t.ticket_no
    JOIN course_lab.norm_flights f ON f.flight_id = s.flight_id
)
SELECT *
FROM course_lab.flight_sales_flat
EXCEPT
SELECT *
FROM reconstructed;

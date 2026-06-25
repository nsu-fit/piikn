-- Практика 5.2. Готовый профиль схемы.
-- Студенты запускают этот файл и интерпретируют фрагменты результата.

SET bookings.lang = 'en';

-- q01_columns
SELECT
    c.table_name,
    c.column_name,
    c.data_type,
    c.is_nullable,
    c.ordinal_position
FROM information_schema.columns c
WHERE c.table_schema = 'bookings'
  AND c.table_name IN (
      'bookings',
      'tickets',
      'segments',
      'flights',
      'routes',
      'boarding_passes',
      'seats',
      'airports_data',
      'airplanes_data'
  )
ORDER BY c.table_name, c.ordinal_position;

-- q02_constraints
SELECT
    n.nspname AS schema_name,
    cls.relname AS table_name,
    con.conname AS constraint_name,
    CASE con.contype
        WHEN 'p' THEN 'primary key'
        WHEN 'f' THEN 'foreign key'
        WHEN 'u' THEN 'unique'
        WHEN 'c' THEN 'check'
        WHEN 'x' THEN 'exclude'
        ELSE con.contype::text
    END AS constraint_type,
    pg_get_constraintdef(con.oid) AS constraint_definition
FROM pg_catalog.pg_constraint con
JOIN pg_catalog.pg_class cls ON cls.oid = con.conrelid
JOIN pg_catalog.pg_namespace n ON n.oid = cls.relnamespace
WHERE n.nspname = 'bookings'
ORDER BY cls.relname, constraint_type, con.conname;

-- q03a_tickets_per_booking
SELECT
    ticket_count,
    count(*)::bigint AS booking_count
FROM (
    SELECT book_ref, count(*) AS ticket_count
    FROM bookings.tickets
    GROUP BY book_ref
) s
GROUP BY ticket_count
ORDER BY ticket_count;

-- q03b_segments_per_ticket
SELECT
    segment_count,
    count(*)::bigint AS ticket_count
FROM (
    SELECT ticket_no, count(*) AS segment_count
    FROM bookings.segments
    GROUP BY ticket_no
) s
GROUP BY segment_count
ORDER BY segment_count;

-- q03c_seats_per_airplane
SELECT
    airplane_code,
    fare_conditions,
    count(*)::bigint AS seat_count
FROM bookings.seats
GROUP BY airplane_code, fare_conditions
ORDER BY airplane_code, fare_conditions;

-- q03d_flights_per_route
SELECT
    route_no,
    count(*)::bigint AS flight_count
FROM bookings.flights
GROUP BY route_no
ORDER BY flight_count DESC, route_no
LIMIT 20;

-- q04a_booking_total_mismatch
SELECT
    b.book_ref,
    b.total_amount,
    sum(s.price) AS calculated_amount,
    b.total_amount - sum(s.price) AS difference
FROM bookings.bookings b
JOIN bookings.tickets t ON t.book_ref = b.book_ref
JOIN bookings.segments s ON s.ticket_no = t.ticket_no
GROUP BY b.book_ref, b.total_amount
HAVING b.total_amount <> sum(s.price)
ORDER BY abs(b.total_amount - sum(s.price)) DESC, b.book_ref
LIMIT 20;

-- q04b_tickets_without_segments
SELECT
    t.ticket_no,
    t.book_ref,
    t.passenger_id
FROM bookings.tickets t
LEFT JOIN bookings.segments s ON s.ticket_no = t.ticket_no
WHERE s.ticket_no IS NULL
ORDER BY t.ticket_no
LIMIT 20;

-- q04c_boarding_pass_seat_not_in_airplane_configuration
SELECT
    bp.ticket_no,
    bp.flight_id,
    bp.seat_no,
    f.route_no,
    r.airplane_code
FROM bookings.boarding_passes bp
JOIN bookings.flights f ON f.flight_id = bp.flight_id
JOIN bookings.routes r
  ON r.route_no = f.route_no
 AND r.validity @> f.scheduled_departure
LEFT JOIN bookings.seats st
  ON st.airplane_code = r.airplane_code
 AND st.seat_no = bp.seat_no
WHERE st.seat_no IS NULL
ORDER BY bp.flight_id, bp.seat_no
LIMIT 20;

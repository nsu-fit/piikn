-- Практика 5.3. Готовые диагностические запросы для ER-реконструкции.
-- Студенты запускают этот файл и интерпретируют результат.

-- check: keys_and_foreign_keys
SELECT
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
  AND cls.relname IN (
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
ORDER BY cls.relname, constraint_type, con.conname;

-- check: tickets_per_booking
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

-- check: segments_per_ticket
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

-- check: boarding_passes_per_flight
SELECT
    boarding_pass_count,
    count(*)::bigint AS flight_count
FROM (
    SELECT flight_id, count(*) AS boarding_pass_count
    FROM bookings.boarding_passes
    GROUP BY flight_id
) s
GROUP BY boarding_pass_count
ORDER BY boarding_pass_count
LIMIT 20;

-- check: flights_per_route
SELECT
    route_no,
    count(*)::bigint AS flight_count
FROM bookings.flights
GROUP BY route_no
ORDER BY flight_count DESC, route_no
LIMIT 20;

-- check: tickets_without_segments
SELECT
    t.ticket_no,
    t.book_ref,
    t.passenger_id
FROM bookings.tickets t
LEFT JOIN bookings.segments s ON s.ticket_no = t.ticket_no
WHERE s.ticket_no IS NULL
ORDER BY t.ticket_no
LIMIT 20;

-- check: boarding_pass_seat_not_in_airplane_configuration
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

-- check: route_temporal_join_misses
SELECT
    f.flight_id,
    f.route_no,
    f.scheduled_departure
FROM bookings.flights f
LEFT JOIN bookings.routes r
  ON r.route_no = f.route_no
 AND r.validity @> f.scheduled_departure
WHERE r.route_no IS NULL
ORDER BY f.scheduled_departure, f.flight_id
LIMIT 20;

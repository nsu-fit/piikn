-- Практика 5.1. Готовый вводный сценарий.
-- Студенты запускают этот файл без изменений и интерпретируют результат.

-- q01_environment
SELECT
    bookings.version() AS demo_version,
    bookings.now() AS snapshot_time,
    current_setting('search_path') AS search_path,
    current_user AS db_user;

-- q02_schema_objects
SELECT
    c.relname AS object_name,
    CASE c.relkind
        WHEN 'r' THEN 'table'
        WHEN 'v' THEN 'view'
        WHEN 'S' THEN 'sequence'
        ELSE c.relkind::text
    END AS object_type
FROM pg_catalog.pg_class c
JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'bookings'
  AND c.relkind IN ('r', 'v', 'S')
ORDER BY object_type, object_name;

-- q03_table_counts
SELECT 'bookings' AS table_name, count(*)::bigint AS row_count FROM bookings.bookings
UNION ALL
SELECT 'tickets', count(*)::bigint FROM bookings.tickets
UNION ALL
SELECT 'segments', count(*)::bigint FROM bookings.segments
UNION ALL
SELECT 'flights', count(*)::bigint FROM bookings.flights
UNION ALL
SELECT 'routes', count(*)::bigint FROM bookings.routes
UNION ALL
SELECT 'boarding_passes', count(*)::bigint FROM bookings.boarding_passes
UNION ALL
SELECT 'seats', count(*)::bigint FROM bookings.seats
UNION ALL
SELECT 'airports_data', count(*)::bigint FROM bookings.airports_data
UNION ALL
SELECT 'airplanes_data', count(*)::bigint FROM bookings.airplanes_data
ORDER BY row_count DESC, table_name;

-- q04a_seats_by_airplane_and_class
SELECT
    airplane_code,
    fare_conditions,
    count(*)::bigint AS seat_count
FROM bookings.seats
GROUP BY airplane_code, fare_conditions
ORDER BY airplane_code, fare_conditions;

-- q04b_next_scheduled_flights
SELECT
    flight_id,
    route_no,
    departure_airport,
    arrival_airport,
    scheduled_departure,
    status
FROM bookings.timetable
WHERE scheduled_departure >= bookings.now()
ORDER BY scheduled_departure, flight_id
LIMIT 10;

-- q04c_airports_by_country
SET bookings.lang = 'en';

SELECT
    country,
    count(*)::bigint AS airport_count
FROM bookings.airports
GROUP BY country
ORDER BY airport_count DESC, country
LIMIT 10;

# Решения к дополнительному банку SQL-задач

```sql
SET bookings.lang = 'en';
```

## s01_airports_by_country

```sql
SELECT country, count(*)::bigint AS airport_count
FROM bookings.airports
GROUP BY country
ORDER BY airport_count DESC, country;
```

## s02_departure_routes_by_country

```sql
SELECT a.country, count(r.route_no)::bigint AS route_count
FROM bookings.routes r
JOIN bookings.airports a ON a.airport_code = r.departure_airport
GROUP BY a.country
ORDER BY a.country;
```

## s03_revenue_by_departure_country

```sql
SELECT
    a.country,
    count(*)::bigint AS segment_count,
    sum(s.price) AS total_revenue
FROM bookings.segments s
JOIN bookings.flights f ON f.flight_id = s.flight_id
JOIN bookings.routes r
  ON r.route_no = f.route_no
 AND r.validity @> f.scheduled_departure
JOIN bookings.airports a ON a.airport_code = r.departure_airport
GROUP BY a.country
ORDER BY total_revenue DESC, a.country;
```

## s04_fare_conditions_in_country

```sql
SELECT DISTINCT s.fare_conditions
FROM bookings.segments s
JOIN bookings.flights f ON f.flight_id = s.flight_id
JOIN bookings.routes r
  ON r.route_no = f.route_no
 AND r.validity @> f.scheduled_departure
JOIN bookings.airports a ON a.airport_code = r.departure_airport
WHERE a.country = 'Russia'
ORDER BY s.fare_conditions;
```

## s05_routes_with_max_segments

```sql
SELECT rc.route_no, rc.segment_count
FROM (
    SELECT f.route_no, count(*)::bigint AS segment_count
    FROM bookings.segments s
    JOIN bookings.flights f ON f.flight_id = s.flight_id
    GROUP BY f.route_no
) rc
WHERE rc.segment_count = (
    SELECT max(rc2.segment_count)
    FROM (
        SELECT f2.route_no, count(*)::bigint AS segment_count
        FROM bookings.segments s2
        JOIN bookings.flights f2 ON f2.flight_id = s2.flight_id
        GROUP BY f2.route_no
    ) rc2
)
ORDER BY rc.route_no;
```

## s06_segments_above_route_average

```sql
SELECT
    s.ticket_no,
    s.flight_id,
    f.route_no,
    s.price,
    (
        SELECT avg(s2.price)
        FROM bookings.segments s2
        JOIN bookings.flights f2 ON f2.flight_id = s2.flight_id
        WHERE f2.route_no = f.route_no
    ) AS route_avg_price
FROM bookings.segments s
JOIN bookings.flights f ON f.flight_id = s.flight_id
WHERE s.price > (
    SELECT avg(s2.price)
    FROM bookings.segments s2
    JOIN bookings.flights f2 ON f2.flight_id = s2.flight_id
    WHERE f2.route_no = f.route_no
)
ORDER BY f.route_no, s.price DESC, s.ticket_no;
```

## s07_airports_without_arrival_routes

```sql
SELECT a.airport_code, a.airport_name, a.city
FROM bookings.airports a
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings.routes r
    WHERE r.arrival_airport = a.airport_code
)
ORDER BY a.airport_code;
```

## s08_top_months_by_departures

```sql
SELECT mc.departure_month, mc.flight_count
FROM (
    SELECT
        date_trunc('month', scheduled_departure)::date AS departure_month,
        count(*)::bigint AS flight_count
    FROM bookings.flights
    GROUP BY departure_month
) mc
WHERE mc.flight_count = (
    SELECT max(mc2.flight_count)
    FROM (
        SELECT
            date_trunc('month', scheduled_departure)::date AS departure_month,
            count(*)::bigint AS flight_count
        FROM bookings.flights
        GROUP BY departure_month
    ) mc2
)
ORDER BY mc.departure_month;
```

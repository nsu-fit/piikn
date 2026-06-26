CREATE SCHEMA IF NOT EXISTS course_lab;

DROP TABLE IF EXISTS course_lab.flight_sales_flat;

CREATE TABLE course_lab.flight_sales_flat (
    booking_ref text NOT NULL,
    book_date timestamp NOT NULL,
    total_amount numeric(12, 2) NOT NULL,
    ticket_no text NOT NULL,
    passenger_id text NOT NULL,
    passenger_name text NOT NULL,
    flight_id integer NOT NULL,
    route_no text NOT NULL,
    departure_airport text NOT NULL,
    arrival_airport text NOT NULL,
    scheduled_departure timestamp NOT NULL,
    fare_conditions text NOT NULL,
    price numeric(12, 2) NOT NULL
);

INSERT INTO course_lab.flight_sales_flat
    (booking_ref, book_date, total_amount, ticket_no, passenger_id, passenger_name,
     flight_id, route_no, departure_airport, arrival_airport, scheduled_departure,
     fare_conditions, price)
VALUES
    ('BR001', timestamp '2026-02-01 09:00:00', 25000.00, 'T001', 'P001', 'Ivan Petrov',
     501, 'PG0101', 'OVB', 'DME', timestamp '2026-02-15 08:00:00', 'Economy', 12000.00),
    ('BR001', timestamp '2026-02-01 09:00:00', 25000.00, 'T001', 'P001', 'Ivan Petrov',
     502, 'PG0202', 'DME', 'LED', timestamp '2026-02-15 15:00:00', 'Economy', 13000.00),
    ('BR002', timestamp '2026-02-02 10:30:00', 31000.00, 'T002', 'P002', 'Anna Sidorova',
     501, 'PG0101', 'OVB', 'DME', timestamp '2026-02-15 08:00:00', 'Comfort', 19000.00),
    ('BR002', timestamp '2026-02-02 10:30:00', 31000.00, 'T002', 'P002', 'Anna Sidorova',
     502, 'PG0202', 'DME', 'LED', timestamp '2026-02-15 15:00:00', 'Economy', 12000.00),
    ('BR003', timestamp '2026-02-03 11:00:00', 21000.00, 'T003', 'P003', 'Maria Kim',
     503, 'PG0303', 'LED', 'AER', timestamp '2026-02-16 12:00:00', 'Economy', 21000.00),
    ('BR004', timestamp '2026-02-04 14:00:00', 50000.00, 'T004', 'P004', 'Pavel Orlov',
     504, 'PG0404', 'OVB', 'AER', timestamp '2026-02-17 07:30:00', 'Business', 50000.00);

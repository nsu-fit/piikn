# Пример ожидаемых артефактов 5.2

Вариант: `ticket_sales`.

```text
semester-5/practice-05-02/
  README.md
  schema_profile.sql
  data_dictionary.md
  query_observations.md
  answers.md
```

## `data_dictionary.md`

```md
# Data dictionary: ticket sales

## bookings

Purpose: booking header. It groups one or more tickets and stores booking timestamp and total amount.

Key attributes:

- `book_ref` - primary key of booking.
- `book_date` - booking timestamp.
- `total_amount` - stored total amount for all tickets/segments in booking.

Business rules:

- every ticket references an existing booking;
- booking total should match the sum of sold segments, but this needs a diagnostic check.

## tickets

Purpose: passenger ticket inside a booking.

Key attributes:

- `ticket_no` - primary key;
- `book_ref` - reference to booking;
- `passenger_id`, `passenger_name` - passenger identity fields.

## segments

Purpose: sold flight segment inside a ticket.

Key attributes:

- natural candidate: (`ticket_no`, `flight_id`);
- `fare_conditions` and `price` describe sold service class and amount.
```

## `query_observations.md`

```md
# Observations

## columns

`book_ref` connects `bookings` and `tickets`. `ticket_no` connects `tickets` and `segments`.

## constraints

Primary keys identify booking and ticket. Foreign keys express mandatory references from child rows to parent rows.

## cardinality

The profile shows that a booking can contain several tickets, and a ticket can have several flight segments.

## quality checks

`booking_total_mismatch` checks whether stored booking total equals the sum of segment prices.
`tickets_without_segments` checks suspicious tickets without any sold flight segment.
```

## `answers.md`

```md
# Answers

The fragment describes the sale of tickets and flight segments inside a booking.

Mandatory references: ticket -> booking, segment -> ticket, segment -> flight.
Potentially optional in the business process: a booking with no completed ticket should be discussed separately.

Guaranteed rules are those expressed by PK/FK/UNIQUE/CHECK. Rules like "booking total is always exact" require diagnostics or application logic.
```

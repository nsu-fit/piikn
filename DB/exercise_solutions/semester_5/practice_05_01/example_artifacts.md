# Пример ожидаемых артефактов 5.1

```text
semester-5/practice-05-01/
  README.md
  intro_queries.sql
  run_log.md
  answers.md
```

## `run_log.md`

```md
# Run log

- Date: 2026-09-05
- Environment: Taidon/sqlrs, Postgres Pro demo database 3 months
- Demo version: 2025-09-01
- Scenario: intro_queries.sql copied from provided/intro_queries.sql

## Blocks

- q01_environment: ok
- q02_schema_objects: ok
- q03_table_counts: ok
- q04a_seats_by_airplane_and_class: ok
- q04b_next_scheduled_flights: ok
- q04c_airports_by_country: ok

No SQL errors.
```

## `answers.md`

```md
# Answers

1. `bookings.version()` returned `2025-09-01`.
2. The schema contains ordinary tables, views and sequences.
3. The largest objects in my run were factual tables: `segments`, `boarding_passes`, `tickets`.
4. `airports_data` stores localized JSON-like data. `airports` is a view that exposes readable airport fields using `bookings.lang`.
5. `bookings.now()` is stable inside the demo dataset. Ordinary `now()` depends on the real execution date.
6. Reproducibility comes from fixed demo version, unchanged SQL file, explicit language setting and saved run log.
```

## `README.md`

```md
# Practice 05-01

Run `intro_queries.sql` in Taidon/sqlrs connected to the `bookings` database.

Submitted files:

- `intro_queries.sql` - unchanged provided SQL.
- `run_log.md` - execution log.
- `answers.md` - interpretation of the output.
```

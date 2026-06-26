# Пример ожидаемых артефактов 6.8

```text
semester-6/practice-08-operations-checklist/
  README.md
  operations-checklist.md
  checks.sql
  demo-result.md
```

## `operations-checklist.md`

```md
# Operations checklist

## Roles

- `db_course_owner`: migrations only.
- `db_course_app`: application reads/writes.
- `db_course_readonly`: support read-only diagnostics.

## Health check

`SELECT 1` plus a read from `app.orders` with timeout.

## Slow query baseline

Use `EXPLAIN (ANALYZE, BUFFERS)` for the known dashboard query.

## Recovery

Last restore check: see practice 6.6 runbook.

## Open risks

- stale replica reads;
- missing alert on backup failure;
- growing indexes.
```

## `demo-result.md`

```md
# Demo result

Checkpoint shown: backup/restore.
Restore target: `db_course_restore`.
Smoke checks passed for `events`, `orders`, `documents`.
One issue remains: backup command still uses local credentials and should be moved to environment variables.
```

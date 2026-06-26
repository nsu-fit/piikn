# Пример ожидаемых артефактов 6.11

```text
semester-6/practice-11-partitioning-retention/
  README.md
  partitioning.sql
  retention.md
  adr-draft.md
```

## `partitioning.sql`

```sql
CREATE TABLE app.events_partitioned (
    event_id bigint NOT NULL,
    tenant_id integer NOT NULL,
    event_type text NOT NULL,
    payload jsonb NOT NULL,
    created_at timestamptz NOT NULL,
    PRIMARY KEY (event_id, created_at)
) PARTITION BY RANGE (created_at);

CREATE TABLE app.events_2026_01
    PARTITION OF app.events_partitioned
    FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');

CREATE TABLE app.events_2026_02
    PARTITION OF app.events_partitioned
    FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');
```

## `retention.md`

```md
# Retention

Policy: keep hot events for 90 days.

Monthly job:

1. Verify next month partition exists.
2. Verify old partition is outside retention.
3. Confirm backup/archive for the old month.
4. Drop old partition, for example `DROP TABLE app.events_2025_10`.

Risk: reports that need deleted months must read from archive, not OLTP.
```

## `adr-draft.md`

```md
# ADR draft

Decision: range partitioning by `created_at`.

Alternatives:

- no partitioning + index: simpler, but retention deletes are expensive;
- tenant partitioning: helps tenant isolation, but does not match time retention.

Consequence: partition management becomes an operational task.
```

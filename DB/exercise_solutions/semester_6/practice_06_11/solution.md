# Решение 6.11. Partitioning и retention

## DDL sketch

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

CREATE INDEX events_2026_01_tenant_type_created_idx
ON app.events_2026_01 (tenant_id, event_type, created_at);

CREATE INDEX events_2026_02_tenant_type_created_idx
ON app.events_2026_02 (tenant_id, event_type, created_at);
```

## Query with pruning

```sql
EXPLAIN
SELECT *
FROM app.events_partitioned
WHERE tenant_id = 1
  AND event_type = 'payment_failed'
  AND created_at >= timestamp '2026-02-01'
  AND created_at < timestamp '2026-03-01';
```

## Retention

Для retention 90 дней месячная партиция удаляется как эксплуатационная операция:

```sql
DROP TABLE app.events_2025_10;
```

Перед этим нужно проверить, что есть партиции будущего периода, backup/архивирование выполнены, а отчеты не требуют удаляемый период.

## ADR decision

Range partitioning по времени оправдан, если основные запросы и удаление старых данных используют `created_at`. Если объем малый, достаточно непартиционированной таблицы и индекса.

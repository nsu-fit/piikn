# Решение 6.7. Репликация и эксплуатационные риски

## Правильная topology

```text
application writes -> primary PostgreSQL
application read-only reports -> read replica
backup job -> backup/restore target
monitoring -> primary + replica
```

Primary принимает записи. Replica обслуживает только чтения, которые допускают задержку.

## Lag checks

```sql
SELECT pg_current_wal_lsn() AS primary_current_wal_lsn;

SELECT application_name, state, sent_lsn, write_lsn, flush_lsn, replay_lsn, replay_lag
FROM pg_stat_replication;

SELECT
    pg_last_wal_receive_lsn(),
    pg_last_wal_replay_lsn(),
    pg_last_xact_replay_timestamp();
```

Последний запрос выполняется на replica, если она есть.

## Риски и mitigation

- Stale read: read-after-write сценарии читают primary.
- Failover split-brain: fencing старой primary.
- Потеря write availability: приложение умеет возвращать degraded status.
- Backup принят за replica: явно разделить recovery target и read replica.
- Lag растет: мониторинг lag и алерт.
- Секреты репликации: отдельные роли и ротация credentials.

Репликация не заменяет backup: ошибка приложения или `DROP TABLE` может реплицироваться.

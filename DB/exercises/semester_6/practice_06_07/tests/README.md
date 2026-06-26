# Контракт проверки

Автоматически проверяются:

- наличие `topology.md`, `risks.md`, `lag_checks.sql`;
- наличие `pg_stat_replication` или `pg_last_wal_replay_lsn` либо явно описанного fallback;
- минимум 6 рисков в `risks.md`;
- наличие слов primary, replica, backup.

Вручную проверяются:

- корректность topology;
- качество risk/mitigation pairs;
- понимание stale reads и failover.

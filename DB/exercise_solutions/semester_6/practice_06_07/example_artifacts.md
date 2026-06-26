# Пример ожидаемых артефактов 6.7

```text
semester-6/practice-07-replication-topology/
  README.md
  topology.md
  risks.md
  lag_checks.sql
```

## `topology.md`

```text
# Replication topology

application writes -> primary
application read-only reports -> replica
backup job -> backup storage / restore target
monitoring -> primary and replica

Writes always go to primary. Read replica can serve reports that tolerate lag.
Read-after-write screens, permissions and account balance reads use primary.
```

## `risks.md`

```md
# Risks

| Risk | Mitigation |
|---|---|
| Stale read | route read-after-write queries to primary |
| Lag grows | monitor replay lag |
| Backup confused with replica | document separate purpose |
| Failover split-brain | fence old primary |
| Permission changes stale on replica | read permissions from primary |
| Secrets leak | separate replication credentials |
```

## `lag_checks.sql`

```sql
SELECT pg_current_wal_lsn() AS primary_lsn;
SELECT application_name, state, replay_lag
FROM pg_stat_replication;
```

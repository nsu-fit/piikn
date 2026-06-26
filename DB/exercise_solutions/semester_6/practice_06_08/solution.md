# Решение 6.8. Эксплуатационный чеклист

## Минимальный checklist

1. Роли:
   - owner/migration;
   - application;
   - readonly/support.
2. Connection strings:
   - секреты не в репозитории;
   - указаны host, port, dbname, user, ssl/pool policy.
3. Health check:
   - `SELECT 1`;
   - проверка доступности ключевой схемы;
   - timeout.
4. Slow query diagnostics:
   - baseline через `EXPLAIN (ANALYZE, BUFFERS)`;
   - где смотреть логи/pg_stat_statements, если доступно.
5. Backup/restore:
   - ссылка на runbook 6.6;
   - дата последнего restore-check.
6. Maintenance:
   - `VACUUM/ANALYZE`;
   - рост таблиц и индексов.
7. Open risks:
   - stale reads;
   - runaway queries;
   - secrets leakage;
   - missing restore test.

## `checks.sql`

```sql
-- q01_current_user_and_database
SELECT current_user, current_database();

-- q02_table_counts
SELECT 'events' AS table_name, count(*)::bigint FROM app.events
UNION ALL
SELECT 'orders', count(*)::bigint FROM app.orders
UNION ALL
SELECT 'documents', count(*)::bigint FROM app.documents;

-- q03_slow_query_candidate
EXPLAIN (ANALYZE, BUFFERS)
SELECT tenant_id, status, count(*)::bigint
FROM app.orders
GROUP BY tenant_id, status
ORDER BY tenant_id, status;

-- q04_role_visibility
SELECT grantee, table_schema, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'app'
ORDER BY grantee, table_name, privilege_type;

-- q05_health_check
SELECT 1 AS ok;
```

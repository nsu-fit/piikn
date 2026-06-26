# Решение 6.6. Backup/restore runbook

## Пример команд

PowerShell-вариант:

```powershell
pg_dump -h localhost -U db_course_owner -d db_course -Fc -f .\backup\db_course.dump
createdb -h localhost -U db_course_owner db_course_restore
pg_restore -h localhost -U db_course_owner -d db_course_restore .\backup\db_course.dump
psql -h localhost -U db_course_readonly -d db_course_restore -f .\checks.sql
```

Bash-вариант:

```bash
pg_dump -h localhost -U db_course_owner -d db_course -Fc -f ./backup/db_course.dump
createdb -h localhost -U db_course_owner db_course_restore
pg_restore -h localhost -U db_course_owner -d db_course_restore ./backup/db_course.dump
psql -h localhost -U db_course_readonly -d db_course_restore -f ./checks.sql
```

## `checks.sql`

```sql
SELECT 'events' AS table_name, count(*)::bigint AS row_count FROM app.events
UNION ALL
SELECT 'orders', count(*)::bigint FROM app.orders
UNION ALL
SELECT 'documents', count(*)::bigint FROM app.documents;

SELECT tenant_id, count(*)::bigint AS order_count, sum(total_amount) AS total_amount
FROM app.orders
GROUP BY tenant_id
ORDER BY tenant_id;

SELECT metadata->>'category' AS category, count(*)::bigint AS document_count
FROM app.documents
GROUP BY metadata->>'category'
ORDER BY category;
```

## Recovery notes

Логический backup не покрывает настройки кластера, роли вне dump scope, WAL-архив, физическое состояние data directory и point-in-time recovery. Restore должен идти в отдельную цель, например `db_course_restore`.

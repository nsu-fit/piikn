# Пример ожидаемых артефактов 6.1

```text
semester-6/practice-01-postgres-local-setup/
  README.md
  compose.yml
  init.sql
  seed.sql
  checks.sql
```

## `compose.yml`

```yaml
services:
  postgres:
    image: postgres:16
    environment:
      POSTGRES_PASSWORD: postgres
    ports:
      - "5432:5432"
    volumes:
      - pgdata:/var/lib/postgresql/data

volumes:
  pgdata:
```

## `README.md`

```text
# PostgreSQL local setup

Start:

docker compose up -d

Initialize:

psql -h localhost -U postgres -f init.sql
psql -h localhost -U db_course_owner -d db_course -f seed.sql
psql -h localhost -U db_course_readonly -d db_course -f checks.sql

Dangerous cleanup:

docker compose down -v

`down -v` removes the database volume.
```

## `checks.sql`

```sql
SELECT version();
SELECT current_database(), current_user;
SELECT 'events' AS table_name, count(*)::bigint FROM app.events
UNION ALL
SELECT 'orders', count(*)::bigint FROM app.orders
UNION ALL
SELECT 'documents', count(*)::bigint FROM app.documents;
```

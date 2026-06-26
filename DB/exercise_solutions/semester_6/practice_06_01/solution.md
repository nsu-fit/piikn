# Решение 6.1. Локальное или контейнерное развертывание PostgreSQL

## Минимальный `init.sql`

```sql
CREATE ROLE db_course_owner LOGIN PASSWORD 'change-me-owner';
CREATE ROLE db_course_app LOGIN PASSWORD 'change-me-app';
CREATE ROLE db_course_readonly LOGIN PASSWORD 'change-me-readonly';

CREATE DATABASE db_course OWNER db_course_owner;

\connect db_course

CREATE SCHEMA IF NOT EXISTS app AUTHORIZATION db_course_owner;

GRANT CONNECT ON DATABASE db_course TO db_course_app, db_course_readonly;
GRANT USAGE ON SCHEMA app TO db_course_app, db_course_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA app TO db_course_app;
GRANT SELECT ON ALL TABLES IN SCHEMA app TO db_course_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA app
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO db_course_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA app
    GRANT SELECT ON TABLES TO db_course_readonly;
```

## `checks.sql`

```sql
SELECT version();
SELECT current_database(), current_user;

SELECT rolname
FROM pg_roles
WHERE rolname IN ('db_course_owner', 'db_course_app', 'db_course_readonly')
ORDER BY rolname;

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'app'
ORDER BY table_name;

SELECT 'events' AS table_name, count(*)::bigint FROM app.events
UNION ALL
SELECT 'orders', count(*)::bigint FROM app.orders
UNION ALL
SELECT 'documents', count(*)::bigint FROM app.documents;
```

## Что должно быть в README

- Команда запуска контейнера или локальной службы.
- Как выполнить `init.sql` и `seed.sql`.
- Как подключиться как application role и readonly role.
- Команда остановки.
- Отдельно помеченная команда удаления volume/data directory.

Application role не должен быть суперпользователем и не должен владеть схемой.

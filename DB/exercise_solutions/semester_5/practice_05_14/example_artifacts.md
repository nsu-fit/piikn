# Пример ожидаемых артефактов 5.14

```text
semester-5/practice-14-sql-security/
  README.md
  secure_sql.md
  fixed_queries.sql
```

## `fixed_queries.sql`

```sql
-- Safe status filter
SELECT order_id, status, total_amount
FROM course_lab.order_queue
WHERE status = $1
ORDER BY created_at DESC;

-- Tenant boundary
SELECT document_id, title, body
FROM app.documents
WHERE tenant_id = $1
  AND document_id = $2;
```

## `secure_sql.md`

```md
# Secure SQL

## Status filter

`$1` is a value placeholder. Payload `' OR true --` becomes a string value and does not change the SQL structure.

Allowed statuses are validated by application code or DB constraints.

## Dynamic ORDER BY

Column names cannot be passed as ordinary placeholders. The application must map user input through a whitelist:

- `created_at`;
- `total_amount`;
- `status`.

Direction whitelist: `asc`, `desc`.

## Tenant boundary

Missing `tenant_id` is an authorization bug. Parameterization alone does not prevent reading another tenant's document.
```

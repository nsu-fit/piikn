# Пример ожидаемых артефактов 6.10

```text
semester-6/practice-10-schema-migration/
  README.md
  migration.sql
  rollback-or-forward-fix.md
  test-data.sql
  checks.sql
  adr.md
```

## `migration.sql`

```sql
ALTER TABLE app.orders
ADD COLUMN IF NOT EXISTS external_reference text;

CREATE UNIQUE INDEX IF NOT EXISTS orders_tenant_external_reference_uq
ON app.orders (tenant_id, external_reference)
WHERE external_reference IS NOT NULL;
```

## `checks.sql`

```sql
-- old writer remains compatible
INSERT INTO app.orders (tenant_id, status, total_amount, idempotency_key, created_at, updated_at)
VALUES (99, 'created', 10.00, 'old-writer-ok', current_timestamp, current_timestamp);

-- new writer can use external_reference
INSERT INTO app.orders (tenant_id, status, total_amount, idempotency_key, external_reference, created_at, updated_at)
VALUES (99, 'created', 20.00, 'new-writer-ok', 'EXT-99', current_timestamp, current_timestamp);
```

## `adr.md`

```md
# ADR: add external reference to orders

Decision: add nullable `external_reference` and partial unique index `(tenant_id, external_reference)`.

Reason: old writers stay compatible, new writer can enforce external id uniqueness.

Rejected: mandatory column in first migration, because old application version would fail.
```

## `rollback-or-forward-fix.md`

```md
If application rollback is needed, keep the column. It is nullable and does not break old writers.
If index semantics are wrong, use forward-fix with a corrected partial index after checking duplicate data.
```

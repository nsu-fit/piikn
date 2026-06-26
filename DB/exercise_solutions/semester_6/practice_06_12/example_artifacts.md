# Пример ожидаемых артефактов 6.12

Вариант: document attributes.

```text
semester-6/practice-12-storage-alternatives/
  README.md
  storage-tradeoff.md
  access-policy-sketch.md
  adr-draft.md
  model-example.sql
```

## `storage-tradeoff.md`

```md
# Storage trade-off

| Option | Fit |
|---|---|
| Normalized tables | good for stable fields, too rigid for changing metadata |
| JSONB in PostgreSQL | good default for moderate metadata with transactional source of truth |
| Key-value table | flexible, but weak typing and harder queries |
| Object storage reference | good for large files, not for authoritative searchable metadata |

Decision: keep core document columns relational and store variable metadata in JSONB.
```

## `access-policy-sketch.md`

```md
# Access policy

Tenant boundary: `documents.tenant_id`.

Read: users can read only documents of their tenant.
Write: editors can update documents of their tenant.

Possible RLS policy is shown in `model-example.sql`.
```

## `model-example.sql`

```sql
CREATE POLICY documents_tenant_read
ON app.documents
USING (tenant_id = current_setting('app.tenant_id')::integer);

SELECT document_id, title
FROM app.documents
WHERE tenant_id = $1
  AND metadata->>'category' = $2;
```

# Пример ожидаемых артефактов 6.15

```text
semester-6/practice-15-search-ai-data/
  README.md
  search-design.md
  search.sql
  quality-notes.md
```

## `search-design.md`

```md
# Document search

Scenario: tenant user searches own documents by words in title/body.

Source of truth: `app.documents`.
Derived index: PostgreSQL GIN full-text index.
Tenant boundary: every query includes `tenant_id`.

Update pipeline: index is maintained transactionally by PostgreSQL. If moved to external search later, freshness policy must be added.
```

## `search.sql`

```sql
CREATE INDEX IF NOT EXISTS documents_fts_idx
ON app.documents
USING gin (to_tsvector('english', coalesce(title, '') || ' ' || coalesce(body, '')));

SELECT document_id, tenant_id, title,
       ts_rank_cd(
           to_tsvector('english', coalesce(title, '') || ' ' || coalesce(body, '')),
           websearch_to_tsquery('english', $1)
       ) AS rank
FROM app.documents
WHERE tenant_id = $2
  AND to_tsvector('english', coalesce(title, '') || ' ' || coalesce(body, ''))
      @@ websearch_to_tsquery('english', $1)
ORDER BY rank DESC, created_at DESC
LIMIT 20;
```

## `quality-notes.md`

```md
# Quality notes

Test queries:

- database course;
- billing;
- support document.

Risks:

- false negatives for typos;
- English configuration may be wrong for Russian text;
- tenant boundary must be preserved;
- vector search would require privacy and cost analysis.
```

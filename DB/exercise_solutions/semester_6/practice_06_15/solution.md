# Решение 6.15. Search и AI-сценарии

## `search.sql`

```sql
CREATE INDEX IF NOT EXISTS documents_fts_idx
ON app.documents
USING gin (to_tsvector('english', coalesce(title, '') || ' ' || coalesce(body, '')));

-- q01_search_documents
SELECT
    document_id,
    tenant_id,
    title,
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

## Test queries

- `database course`;
- `billing`;
- `support document`;
- запрос с опечаткой должен быть отмечен как limitation, если нет fuzzy-поиска.

## Quality notes

- Source of truth: `app.documents`.
- Derived index: GIN full-text index.
- Tenant boundary обязателен в поисковом запросе.
- Stale index рискован, если индекс внешний; встроенный PostgreSQL index обновляется транзакционно.
- Vector search опционален и не заменяет права доступа, freshness policy и оценку качества.

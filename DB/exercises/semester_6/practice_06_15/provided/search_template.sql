CREATE INDEX IF NOT EXISTS documents_fts_idx
ON app.documents
USING gin (to_tsvector('english', coalesce(title, '') || ' ' || coalesce(body, '')));

SELECT
    document_id,
    tenant_id,
    title,
    ts_rank(
        to_tsvector('english', coalesce(title, '') || ' ' || coalesce(body, '')),
        websearch_to_tsquery('english', $1)
    ) AS rank
FROM app.documents
WHERE tenant_id = $2
  AND to_tsvector('english', coalesce(title, '') || ' ' || coalesce(body, ''))
      @@ websearch_to_tsquery('english', $1)
ORDER BY rank DESC, created_at DESC
LIMIT 20;

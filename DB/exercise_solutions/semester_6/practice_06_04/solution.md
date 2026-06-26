# Решение 6.4. Специализированные индексы и JSONB

## `indexes.sql`

```sql
-- Гипотеза 1: tenant/status + сортировка по времени.
CREATE INDEX IF NOT EXISTS orders_tenant_status_created_idx
ON app.orders (tenant_id, status, created_at DESC);

-- Гипотеза 2a: expression index для конкретного JSONB-ключа.
CREATE INDEX IF NOT EXISTS documents_metadata_category_created_idx
ON app.documents ((metadata->>'category'), created_at DESC);

-- Альтернатива 2b: GIN для более общих JSONB containment-запросов.
CREATE INDEX IF NOT EXISTS documents_metadata_gin_idx
ON app.documents
USING gin (metadata);
```

## До/после

В `before.sql` и `after.sql` должен быть один и тот же запрос с `EXPLAIN (ANALYZE, BUFFERS)`. Менять одновременно запрос и данные нельзя.

Для JSONB expression index запрос должен сохранять то же выражение:

```sql
WHERE metadata->>'category' = 'billing'
```

Для GIN лучше переписать под containment:

```sql
WHERE metadata @> '{"category": "billing"}'::jsonb
```

## Trade-off

Индекс ускоряет часть чтений, но увеличивает место, стоимость `INSERT/UPDATE/DELETE`, время backup и maintenance.

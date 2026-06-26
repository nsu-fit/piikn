# Практика 6.4. Специализированные индексы и JSONB

Вы проверяете две индексные гипотезы на учебной базе: одну для обычных столбцов, одну для JSONB или специализированного сценария.

## Что нужно сдать

```text
semester-6/practice-04-advanced-indexes-jsonb/
  README.md
  before.sql
  indexes.sql
  after.sql
  report.md
```

## Гипотеза 1. B-tree или partial index

Запрос-кандидат:

```sql
SELECT order_id, tenant_id, status, total_amount, created_at
FROM app.orders
WHERE tenant_id = 1
  AND status = 'created'
ORDER BY created_at DESC
LIMIT 50;
```

1. В `before.sql` зафиксируйте `EXPLAIN (ANALYZE, BUFFERS)`.
2. В `indexes.sql` создайте индекс, который помогает этому запросу.
3. В `after.sql` повторите план.

## Гипотеза 2. JSONB GIN или expression index

Запрос-кандидат:

```sql
SELECT document_id, tenant_id, title
FROM app.documents
WHERE metadata->>'category' = 'billing'
ORDER BY created_at DESC
LIMIT 50;
```

Выберите:

- expression B-tree index по `(metadata->>'category')`; или
- GIN index по `metadata`, если переписываете запрос под JSONB-оператор.

## `report.md`

Для каждой гипотезы укажите:

- исходный план;
- созданный индекс;
- план после изменения;
- изменилось ли время, buffers или форма доступа;
- почему индекс может быть не выбран;
- цена индекса: запись, место, maintenance.

## Контрольные вопросы

1. Чем partial index отличается от обычного B-tree?
2. Когда GIN полезен для JSONB?
3. Почему expression index требует совпадения выражения в запросе?
4. Почему индекс может не использоваться даже после создания?

# Решение 6.5. Контрольная: оптимизационный практикум

Контрольная вариантная. Конкретный пример сдачи для варианта `documents_by_jsonb_category` вынесен в `example_artifacts.md`.

## Правильный цикл

1. Baseline:

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT ...
```

2. В отчете назван конкретный проблемный узел: например `Seq Scan`, большой `Sort`, неверная оценка строк, лишний nested loop.
3. Изменение связано с причиной:
   - индекс под selective predicate;
   - covering/sort-friendly индекс;
   - expression index под выражение;
   - переписывание запроса без изменения смысла.
4. Повторный `EXPLAIN (ANALYZE, BUFFERS)`.
5. Сравнение: время, rows, loops, buffers, форма доступа.

## Пример вывода в `report.md`

```md
The baseline plan evaluates `metadata->>'category'` for many rows and sorts after filtering.
I added an expression index on `(metadata->>'category'), created_at DESC`.
The after-plan can use the expression index if the query keeps the same expression.
Trade-off: the index increases write cost and backup size.
```

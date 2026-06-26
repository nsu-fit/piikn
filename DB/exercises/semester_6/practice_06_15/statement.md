# Практика 6.15. Поиск и AI-сценарии

Вы проектируете search design slice и отделяете source of truth от производного поискового индекса.

## Что нужно сдать

```text
semester-6/practice-15-search-ai-data/
  README.md
  search-design.md
  search.sql или prototype.md
  quality-notes.md
```

## Сценарий

Постройте полнотекстовый поиск по `app.documents.title` и `app.documents.body`.

## Задания

1. В `search-design.md` опишите:
   - пользовательский поисковый сценарий;
   - source data;
   - derived index;
   - pipeline обновления индекса;
   - права доступа и tenant boundary.
2. В `search.sql` реализуйте PostgreSQL full-text prototype:
   - `to_tsvector`;
   - `plainto_tsquery` или `websearch_to_tsquery`;
   - ранжирование через `ts_rank` или `ts_rank_cd`;
   - индекс GIN или design sketch индекса.
3. Добавьте 3-5 тестовых пользовательских запросов.
4. В `quality-notes.md` оцените:
   - false positives/false negatives;
   - stale index;
   - privacy/security;
   - ограничения vector search, если вы его упоминаете.

## Контрольные вопросы

1. Чем source of truth отличается от поискового индекса?
2. Как проверить качество поиска?
3. Почему stale index опасен?
4. Почему vector search не заменяет проектирование прав доступа?

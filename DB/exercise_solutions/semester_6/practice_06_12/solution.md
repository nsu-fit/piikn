# Решение 6.12. Storage alternatives и access policies

## Пример решения: document attributes

Authoritative source: `app.documents` в PostgreSQL.

| Option | Verdict |
|---|---|
| Normalized relational | Хорошо для стабильных атрибутов и строгих FK, но плохо для часто меняющегося набора полей. |
| PostgreSQL JSONB | Подходит для умеренно изменяемых metadata при сохранении транзакций и tenant boundary. |
| Key-value pattern | Гибко, но сложнее валидировать типы и писать запросы. |
| Object storage reference | Подходит для крупных binary artifacts, но не для авторитетных searchable metadata. |

Выбор: JSONB для metadata плюс обычные реляционные столбцы для `tenant_id`, `title`, `created_at`.

## Access policy sketch

```sql
-- Псевдо-RLS sketch.
CREATE POLICY documents_tenant_isolation
ON app.documents
USING (tenant_id = current_setting('app.tenant_id')::integer);
```

Если приложение уже централизованно и надежно проверяет tenant boundary, можно оставить authorization в application layer, но это должно быть осознанное решение.

## Non-goals

- Не решаем полнотекстовый поиск в этом решении.
- Не переносим source of truth во внешний search index.
- Не храним крупные файлы внутри JSONB.

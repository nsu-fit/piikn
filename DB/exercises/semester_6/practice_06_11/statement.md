# Практика 6.11. Partitioning и retention

Вы проектируете partitioning/retention-решение для событийной таблицы `app.events`.

## Что нужно сдать

```text
semester-6/practice-11-partitioning-retention/
  README.md
  partitioning.sql или partitioning-design.md
  retention.md
  adr-draft.md
```

## Требования сценария

- `app.events` растет append-only.
- Типовые запросы выбирают `tenant_id`, `event_type` и диапазон `created_at`.
- Горячие данные хранятся 90 дней.
- Старые данные удаляются помесячно.
- Нужно избегать удаления миллионов строк через обычный `DELETE`, если можно удалить партицию.

## Задания

1. Выберите ключ партиционирования.
2. Предложите DDL для range partitioning по `created_at` или обоснуйте отказ.
3. Покажите пример создания двух месячных партиций.
4. Покажите типовой запрос, где ожидается partition pruning.
5. В `retention.md` опишите процедуру удаления старой партиции и проверки покрытия будущего месяца.
6. В `adr-draft.md` сравните минимум две альтернативы:
   - непартиционированная таблица + индекс;
   - range partitioning по времени;
   - tenant/time composite strategy.

## Контрольные вопросы

1. Почему retention часто ведет к time-based partitioning?
2. Что такое partition pruning?
3. Какие риски создает слишком мелкое партиционирование?
4. Как partitioning связан с backup/restore?

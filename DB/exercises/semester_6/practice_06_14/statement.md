# Практика 6.14. Аналитическая витрина на PostgreSQL

Вы проектируете простую аналитическую витрину поверх учебных OLTP-таблиц и фиксируете вопросы качества данных.

## Что нужно сдать

```text
semester-6/practice-14-analytics-mart/
  README.md
  mart-design.md
  queries.sql
  materialized-view.md
  schema.sql
```

## Сценарий

На основе `app.orders` и `app.events` нужно отвечать на вопросы:

1. Сколько заказов и какая сумма по tenant/day/status?
2. Как меняется сумма заказов по дням: текущий день и накопительный итог?
3. Какие типы событий чаще всего возникают по tenant/day?

## Задания

1. В `mart-design.md` выделите факты и измерения.
2. В `schema.sql` набросайте star-schema или близкую витрину:
   - fact table;
   - time dimension или date key;
   - tenant/status/event dimensions, если они нужны.
3. В `queries.sql` напишите:
   - `q01_orders_by_day_status`;
   - `q02_running_total_window`;
   - `q03_events_by_day_type`;
   - `q04_data_quality_late_or_duplicate_events`.
4. В `materialized-view.md` опишите materialized view, refresh policy, staleness и индексы.

## Контрольные вопросы

1. Чем fact table отличается от dimension table?
2. Почему аналитическая витрина может дублировать OLTP-данные?
3. Чем window-запрос отличается от `GROUP BY`?
4. Почему materialized view не является source of truth?

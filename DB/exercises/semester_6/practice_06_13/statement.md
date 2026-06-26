# Практика 6.13. Графоподобные данные и architecture trade-off review

Вы готовите ADR по выбору модели хранения или traversal-подхода для графоподобных данных.

## Что нужно сдать

```text
semester-6/practice-13-graph-tradeoff/
  README.md
  adr.md
  graph-model.md
  traversal.sql или traversal.md
```

## Выберите сценарий

- иерархия подразделений;
- зависимости задач;
- lineage данных;
- связи документов;
- dependency graph сервисов.

## Обязательные элементы

В `graph-model.md`:

- вершины и ребра;
- ключевые свойства;
- 2-3 traversal-запроса;
- ограничения размера и глубины.

В `traversal.sql` или `traversal.md`:

- adjacency list schema sketch;
- пример recursive CTE; или
- объяснение, почему нужен другой подход.

В `adr.md` сравните минимум три варианта:

- adjacency list + recursive CTE в PostgreSQL;
- materialized path или closure table;
- отдельная graph DB.

## Checkpoint review

Подготовьте 3-5 минут объяснения:

- problem statement;
- выбранное решение;
- почему альтернативы хуже в вашем контексте;
- последствия для разработки и эксплуатации.

## Контрольные вопросы

1. Когда данные являются графовыми по сути?
2. Что такое traversal-сценарий?
3. Когда recursive CTE достаточно?
4. Почему отдельная graph DB увеличивает эксплуатационную стоимость?

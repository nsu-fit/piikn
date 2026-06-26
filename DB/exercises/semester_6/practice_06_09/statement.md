# Практика 6.9. Интеграция PostgreSQL с приложением и advanced SQL-паттерны

Вы описываете один backend-сценарий работы с PostgreSQL и применяете один advanced SQL-паттерн: keyset pagination, таблица как очередь задач или REST-идемпотентность.

## Что нужно сдать

```text
semester-6/practice-09-application-integration/
  README.md
  data-access-scenario.md
  sql-pattern.sql
  test-sketch.md
```

## Выберите один сценарий

1. `order_creation_idempotency`: создание заказа с `idempotency_key`.
2. `worker_queue`: выбор задач через `FOR UPDATE SKIP LOCKED`.
3. `keyset_pagination`: постраничная выдача документов без `OFFSET`.

## Обязательные элементы

В `data-access-scenario.md` укажите:

- user/system action;
- участвующие таблицы;
- где начинается и заканчивается транзакция;
- какие SQL-запросы выполняются;
- какие параметры должны быть placeholders;
- какие ошибки БД обрабатывает приложение.

В `sql-pattern.sql` реализуйте выбранный паттерн:

- idempotency: `INSERT ... ON CONFLICT ...` или эквивалент;
- queue: `SELECT ... FOR UPDATE SKIP LOCKED` и смена статуса;
- keyset pagination: фильтр по последнему `(created_at, id)` без `OFFSET`.

В `test-sketch.md` опишите минимум 3 теста: successful path, duplicate/retry path, concurrent or boundary path.

## Контрольные вопросы

1. Где проходит транзакционная граница use case?
2. Почему keyset pagination устойчивее `OFFSET`?
3. Как `FOR UPDATE SKIP LOCKED` меняет поведение конкурирующих worker-ов?
4. Почему idempotency key должен быть ограничением в БД?

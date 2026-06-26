# Практика 5.11. Нормализация учебной схемы

Вы продолжаете работу с `course_lab.flight_sales_flat` из практики 5.10 и проектируете декомпозицию до 3НФ для учебного фрагмента.

## Что нужно сдать

```text
semester-5/practice-11-normalization/
  README.md
  decomposition.sql
  checks.sql
  answers.md
```

## Подготовка

1. Выполните `../practice_05_10/provided/seed_denormalized_sales.sql` или копию этого сценария, выданную преподавателем.
2. В `decomposition.sql` создайте нормализованные таблицы в схеме `course_lab`.
3. В `checks.sql` покажите, что обратное соединение не теряет строки на учебных данных.

## Требуемая декомпозиция

Минимальный набор таблиц:

- `course_lab.norm_bookings(booking_ref, book_date, total_amount)`;
- `course_lab.norm_tickets(ticket_no, booking_ref, passenger_id, passenger_name)`;
- `course_lab.norm_flights(flight_id, route_no, departure_airport, arrival_airport, scheduled_departure)`;
- `course_lab.norm_segments(ticket_no, flight_id, fare_conditions, price)`.

Можно добавить таблицу маршрутов или пассажиров, если вы явно объясните, какую зависимость она сохраняет.

## `decomposition.sql`

Сценарий должен:

1. Удалять старые `norm_*` таблицы, если они существуют.
2. Создавать таблицы с первичными и внешними ключами.
3. Переносить данные из `flight_sales_flat` через `INSERT INTO ... SELECT DISTINCT`.
4. Не изменять исходную таблицу `flight_sales_flat`.

## `checks.sql`

Добавьте проверки:

- `q01_row_count_original`: количество строк в исходной таблице;
- `q02_row_count_reconstructed`: количество строк после обратного соединения;
- `q03_original_minus_reconstructed`: строки, потерянные при декомпозиции;
- `q04_reconstructed_minus_original`: лишние строки после обратного соединения.

Для `q03` и `q04` используйте `EXCEPT`.

## `answers.md`

Ответьте:

1. Какие зависимости сохраняет каждая таблица?
2. Почему декомпозиция без потерь важнее совпадения общего количества строк?
3. Какие зависимости сохраняются не полностью, если вы не выделяете отдельные справочники?
4. Какой практический компромисс вы бы допустили в промышленной схеме?

## Контрольные вопросы

1. Что означает lossless join на этом примере?
2. Почему `SELECT DISTINCT` нужен при переносе справочников?
3. Какой ключ должен быть у таблицы сегментов?
4. Почему декомпозиция не должна превращаться в таблицу на каждый атрибут?

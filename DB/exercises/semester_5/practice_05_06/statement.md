# Практика 5.6. Базовый SELECT

Вы начинаете самостоятельно писать SQL. Все запросы должны работать на Postgres Pro demo database "Авиаперевозки" в схеме `bookings`.

## Что нужно сдать

```text
semester-5/practice-06-basic-select/
  README.md
  queries.sql
  answers.md
```

## Общие требования

- Каждый запрос должен быть помечен комментарием `-- qNN_name`.
- Если порядок строк важен, используйте явный `ORDER BY`.
- Не используйте hard-code конкретных `ticket_no`, `book_ref`, `flight_id`, если они не заданы в варианте.
- Запросы должны переноситься между размерами демобазы.
- Не используйте CTE, оконные функции и рекурсивные запросы: они не входят в эту практику.

## Параметры варианта

Преподаватель назначает:

- `departure_airport`;
- `arrival_airport`;
- `min_total_amount`;
- `status`.

Если вариант не назначен, используйте значения из `variant.yaml`.

## Запросы

### q01_recent_bookings

Выведите 20 последних бронирований с суммой не ниже `min_total_amount`.

Столбцы:

- `book_ref`;
- `book_date`;
- `total_amount`.

Сортировка: сначала более поздние бронирования, затем `book_ref`.

### q02_route_flights

Выведите ближайшие 30 рейсов по маршрутам из `departure_airport` в `arrival_airport`.

Столбцы:

- `flight_id`;
- `route_no`;
- `scheduled_departure`;
- `scheduled_arrival`;
- `status`.

Учитывайте только рейсы с `scheduled_departure >= bookings.now()`.

Сортировка: `scheduled_departure`, затем `flight_id`.

### q03_ticket_segments

Выведите билеты и сегменты для рейсов со статусом `status`.

Столбцы:

- `ticket_no`;
- `flight_id`;
- `route_no`;
- `fare_conditions`;
- `price`.

Ограничьте результат 50 строками. Сортировка: `flight_id`, затем `ticket_no`.

### q04_fare_summary

Посчитайте по `fare_conditions`:

- количество сегментов;
- минимальную цену;
- максимальную цену;
- среднюю цену.

Сортировка: по количеству сегментов по убыванию.

### q05_route_revenue

Для маршрутов из `departure_airport` посчитайте суммарную выручку по сегментам.

Столбцы:

- `route_no`;
- `arrival_airport`;
- `segment_count`;
- `total_amount`.

Верните 10 маршрутов с максимальной суммой.

### q06_airports_without_departure_routes

Найдите аэропорты, из которых нет маршрутов отправления в `routes`.

Столбцы:

- `airport_code`;
- `airport_name`;
- `city`.

Используйте `NOT EXISTS` или `LEFT JOIN ... IS NULL`.

### q07_bookings_ticket_count

Для бронирований с суммой не ниже `min_total_amount` посчитайте количество билетов.

Столбцы:

- `book_ref`;
- `total_amount`;
- `ticket_count`.

Верните 30 строк с максимальной суммой бронирования.

Сортировка: `total_amount DESC`, затем `book_ref`.

### q08_explain_wrong_join

В `answers.md` объясните, почему запрос ниже неверен:

```sql
SELECT t.ticket_no, f.flight_id
FROM bookings.tickets t
JOIN bookings.flights f ON true
LIMIT 100;
```

Предложите корректную цепочку соединения между `tickets` и `flights`.

## `answers.md`

Ответьте коротко:

1. Где в ваших запросах есть риск случайного размножения строк?
2. В каком запросе важнее всего явный `ORDER BY`?
3. Почему `q06` лучше писать через anti-join, а не через ручной список аэропортов?
4. Почему `q08` возвращает бессмысленный результат?

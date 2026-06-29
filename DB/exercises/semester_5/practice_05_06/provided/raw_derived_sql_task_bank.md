# Дополнительный банк SQL-задач

Источник идей: `DB/raw/Рабочая группа РГБД 2025/материалы от В.Г. Казакова/SQL DQL`.

Задачи ниже адаптируют паттерны Oracle HR-упражнений к текущей учебной схеме `bookings` Postgres Pro demo database. Их можно использовать как тренировку после практики 5.6 или как источник вариантов для контрольной 5.8.

Общие правила:

- использовать `SET bookings.lang = 'en';`;
- не подгонять запрос под конкретные `flight_id`, `ticket_no`, `book_ref`;
- при `LIMIT` всегда указывать `ORDER BY`;
- решения должны переноситься между размерами демобазы.

## Блок S1. Aggregates and joins

### s01_airports_by_country

Посчитайте количество аэропортов в каждой стране.

Columns: `country`, `airport_count`.

Sort: `airport_count DESC`, `country`.

### s02_departure_routes_by_country

Для каждой страны посчитайте количество маршрутов, которые из нее отправляются.

Columns: `country`, `route_count`.

Sort: `country`.

### s03_revenue_by_departure_country

Для каждой страны отправления посчитайте суммарную выручку по проданным сегментам.

Columns: `country`, `segment_count`, `total_revenue`.

Sort: `total_revenue DESC`, `country`.

### s04_fare_conditions_in_country

Верните неповторяющийся список классов обслуживания, встречающихся на рейсах из страны `Russia`.

Columns: `fare_conditions`.

Sort: `fare_conditions`.

## Блок S2. Group extrema and subqueries

Этот блок сложнее основного задания 5.6. Его лучше выдавать после разбора подзапросов или использовать как источник вариантов для контрольной 5.8. Если CTE еще не вводились, задачи решаются через вложенные подзапросы.

### s05_routes_with_max_segments

Найдите маршруты с максимальным количеством проданных сегментов.

Columns: `route_no`, `segment_count`.

Sort: `route_no`.

### s06_segments_above_route_average

Выведите сегменты, цена которых выше средней цены сегмента на том же маршруте.

Columns: `ticket_no`, `flight_id`, `route_no`, `price`, `route_avg_price`.

Sort: `route_no`, `price DESC`, `ticket_no`.

### s07_airports_without_arrival_routes

Найдите аэропорты, в которые не прилетает ни один маршрут из `routes`.

Columns: `airport_code`, `airport_name`, `city`.

Sort: `airport_code`.

### s08_top_months_by_departures

Найдите месяцы, в которые запланировано больше всего рейсов.

Columns: `departure_month`, `flight_count`.

Sort: `departure_month`.

Подсказка: в PostgreSQL можно использовать `date_trunc('month', scheduled_departure)::date`.

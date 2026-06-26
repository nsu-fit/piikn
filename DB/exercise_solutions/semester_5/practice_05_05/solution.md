# Решение 5.5. Реляционная алгебра

## 1. Airports from Russia

Выражение:

```text
pi_{airport_code, city}(sigma_{country = 'Russia'}(Airports))
```

Результат:

| airport_code | city |
|---|---|
| OVB | Novosibirsk |
| DME | Moscow |
| LED | Saint Petersburg |

## 2. Routes with departure and arrival city

Выражение:

```text
pi_{route_no, dep.city, arr.city}(
  (Routes join_{departure_airport = dep.airport_code} rho_dep(Airports))
  join_{arrival_airport = arr.airport_code} rho_arr(Airports)
)
```

Для `R1`, `R2`, `R3`:

| route_no | departure_city | arrival_city |
|---|---|---|
| R1 | Novosibirsk | Moscow |
| R2 | Moscow | Saint Petersburg |
| R3 | Novosibirsk | Almaty |

## 3. Passengers flying `F102`

Выражение:

```text
pi_{ticket_no, passenger_name, flight_id}(
  sigma_{flight_id = 'F102'}(Segments)
  join_{Segments.ticket_no = Tickets.ticket_no} Tickets
)
```

Результат:

| ticket_no | passenger_name | flight_id |
|---|---|---|
| T1 | Ada Lovelace | F102 |
| T2 | Grace Hopper | F102 |
| T3 | Donald Knuth | F102 |

## 4. Tickets without segments

Выражение:

```text
Tickets - pi_{ticket_no, passenger_name}(Tickets join Segments)
```

Результат:

| ticket_no | passenger_name |
|---|---|
| T4 | Barbara Liskov |

Это антисоединение: нужны строки из `Tickets`, для которых нет связанной строки в `Segments`.

## 5. Tickets with all RequiredFlights

Выражение:

```text
pi_{ticket_no, flight_id}(Segments) ÷ RequiredFlights
```

Затем соединяем результат с `Tickets` для имени пассажира.

Результат:

| ticket_no | passenger_name |
|---|---|
| T1 | Ada Lovelace |
| T3 | Donald Knuth |

## 6. Эквивалентность

Формы эквивалентны:

```text
sigma_{flight_id = 'F102'}(Tickets join Segments)
```

и

```text
Tickets join sigma_{flight_id = 'F102'}(Segments)
```

Selection можно протолкнуть к `Segments`, потому что условие использует только атрибут `Segments.flight_id`.

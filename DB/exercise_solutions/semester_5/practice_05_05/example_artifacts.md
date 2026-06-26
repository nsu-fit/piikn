# Пример ожидаемых артефактов 5.5

```text
semester-5/practice-05-relational-algebra/
  README.md
  answers.md
  result_tables.md
```

## `answers.md`

```md
# Relational algebra answers

## 1

`pi_{airport_code, city}(sigma_{country = 'Russia'}(Airports))`

## 2

`Routes` must be joined with `Airports` twice: once for departure city and once for arrival city.

## 3

`pi_{ticket_no, passenger_name, flight_id}(sigma_{flight_id = 'F102'}(Segments) join Tickets)`

## 4

`Tickets - pi_{ticket_no, passenger_name}(Tickets join Segments)`

This is anti-join/difference: keep tickets without matching rows in `Segments`.

## 5

`pi_{ticket_no, flight_id}(Segments) ÷ RequiredFlights`

Then join the resulting ticket numbers with `Tickets`.

## 6

Selection by `flight_id` can be pushed down to `Segments`, because the predicate uses only attributes of `Segments`.
```

## `result_tables.md`

```md
# Result tables

## 1

| airport_code | city |
|---|---|
| OVB | Novosibirsk |
| DME | Moscow |
| LED | Saint Petersburg |

## 3

| ticket_no | passenger_name | flight_id |
|---|---|---|
| T1 | Ada Lovelace | F102 |
| T2 | Grace Hopper | F102 |
| T3 | Donald Knuth | F102 |

## 5

| ticket_no | passenger_name |
|---|---|
| T1 | Ada Lovelace |
| T3 | Donald Knuth |
```

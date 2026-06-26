# Пример варианта контрольной 3

Это пример структуры, а не публичный банк ответов.

## Часть A/B. Плоская таблица `order_delivery_flat`

Атрибуты:

- `order_id`;
- `order_date`;
- `customer_id`;
- `customer_name`;
- `address_id`;
- `city`;
- `item_id`;
- `item_name`;
- `category`;
- `quantity`.

Предметные правила:

- заказ имеет дату, покупателя и адрес доставки;
- покупатель имеет имя;
- адрес находится в городе;
- товар имеет название и категорию;
- строка заказа задается парой `(order_id, item_id)` и количеством.

## Часть C. Timeline

Начальное состояние: `inventory(item_id = 10, stock = 5)`.

```text
A1: BEGIN ISOLATION LEVEL READ COMMITTED;
A2: SELECT stock FROM inventory WHERE item_id = 10; -- 5
B1: BEGIN ISOLATION LEVEL READ COMMITTED;
B2: UPDATE inventory SET stock = 4 WHERE item_id = 10;
B3: COMMIT;
A3: SELECT stock FROM inventory WHERE item_id = 10;
A4: COMMIT;
```

Вопрос: что увидит `A3` и как называется наблюдаемое поведение?

## Часть D. Небезопасный SQL

```pseudo
sql = "SELECT * FROM orders WHERE customer_id = " + customer_id
```

Исправьте фрагмент и укажите минимальные права application role.

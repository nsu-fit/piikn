# Решение 5.15. Контрольная 3

Контрольная вариантная, поэтому решение задает эталонную логику ответа.

## Часть A. Зависимости и ключи

Для примера `order_delivery_flat`:

- `order_id -> order_date, customer_id, address_id`;
- `customer_id -> customer_name`;
- `address_id -> city`;
- `item_id -> item_name, category`;
- `(order_id, item_id) -> quantity`.

Кандидатный ключ строки заказа: `(order_id, item_id)`.

Аномалии:

- update anomaly: имя товара нужно менять во всех строках с `item_id`;
- deletion anomaly: удаление последней строки товара удаляет сведения о товаре;
- insertion anomaly: нельзя добавить товар без заказа.

## Часть B. Декомпозиция

Приемлемая 3НФ:

- `orders(order_id PK, order_date, customer_id, address_id)`;
- `customers(customer_id PK, customer_name)`;
- `addresses(address_id PK, city)`;
- `items(item_id PK, item_name, category)`;
- `order_items(order_id FK, item_id FK, quantity, PK(order_id, item_id))`.

Проверка без потерь должна сравнивать исходную плоскую таблицу с обратным соединением через `EXCEPT` в обе стороны.

## Часть C. Timeline

В приведенном примере `READ COMMITTED`:

```text
A2 видит stock = 5.
B обновляет stock до 4 и commit.
A3 повторно читает строку и видит stock = 4.
```

Это non-repeatable read: повторное чтение той же строки в одной транзакции дает другое значение из-за commit другой транзакции.

## Часть D. Безопасный SQL

Небезопасно:

```pseudo
"SELECT * FROM orders WHERE customer_id = " + customer_id
```

Безопасно:

```sql
SELECT *
FROM orders
WHERE customer_id = $1;
```

Если есть tenant boundary:

```sql
SELECT *
FROM orders
WHERE tenant_id = $1
  AND customer_id = $2;
```

Application role получает только необходимые права на чтение/изменение, migration role владеет схемой.

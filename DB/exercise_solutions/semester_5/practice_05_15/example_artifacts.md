# Пример ожидаемых артефактов 5.15

Пример для варианта `order_delivery_flat`.

```text
semester-5/checkpoint-03-integrated/
  README.md
  answers.md
  solution.sql
  decomposition.sql
```

## `answers.md`

```md
# Checkpoint 03

## Functional dependencies

- `order_id -> order_date, customer_id, address_id`;
- `customer_id -> customer_name`;
- `address_id -> city`;
- `item_id -> item_name, category`;
- `(order_id, item_id) -> quantity`.

Candidate key: `(order_id, item_id)`.

Update anomaly: item name is repeated in every order row.
Deletion anomaly: deleting the last order row for an item removes item metadata.

## Transaction timeline

At READ COMMITTED, session A reads stock = 5, B commits stock = 4, then A reads stock = 4. This is non-repeatable read.

## Security

Unsafe concatenation of `customer_id` is replaced with `$1`.
```

## `decomposition.sql`

```sql
CREATE TABLE customers (customer_id bigint PRIMARY KEY, customer_name text NOT NULL);
CREATE TABLE addresses (address_id bigint PRIMARY KEY, city text NOT NULL);
CREATE TABLE items (item_id bigint PRIMARY KEY, item_name text NOT NULL, category text NOT NULL);
CREATE TABLE orders (order_id bigint PRIMARY KEY, order_date date NOT NULL, customer_id bigint REFERENCES customers, address_id bigint REFERENCES addresses);
CREATE TABLE order_items (order_id bigint REFERENCES orders, item_id bigint REFERENCES items, quantity integer NOT NULL, PRIMARY KEY(order_id, item_id));
```

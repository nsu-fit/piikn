# Решения к raw-derived интегрированным вариантам

## Вариант I-COOK

### Functional dependencies

- `recipe_name -> recipe_description, servings`;
- `product_name -> product_unit, product_price, calories_per_unit`;
- `(recipe_name, product_name) -> quantity`;
- если есть surrogate ids, зависимости переносятся на `recipe_id` и `product_id`.

Candidate key for flat table: `(recipe_name, product_name)`.

### Anomalies

- Update anomaly: изменение цены продукта нужно повторять во всех рецептах с этим продуктом.
- Insertion anomaly: нельзя добавить новый продукт, пока он не используется в рецепте.
- Deletion anomaly: удаление последнего рецепта с продуктом удаляет сведения о продукте.

### 3NF decomposition

```sql
CREATE TABLE recipes (
    recipe_id bigint PRIMARY KEY,
    recipe_name text NOT NULL UNIQUE,
    recipe_description text,
    servings integer NOT NULL CHECK (servings > 0)
);

CREATE TABLE products (
    product_id bigint PRIMARY KEY,
    product_name text NOT NULL UNIQUE,
    product_unit text NOT NULL,
    product_price numeric(12, 2) NOT NULL CHECK (product_price >= 0),
    calories_per_unit numeric(12, 2) NOT NULL CHECK (calories_per_unit >= 0)
);

CREATE TABLE recipe_components (
    recipe_id bigint NOT NULL REFERENCES recipes(recipe_id),
    product_id bigint NOT NULL REFERENCES products(product_id),
    quantity numeric(12, 3) NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (recipe_id, product_id)
);
```

### Security fix

```sql
SELECT *
FROM recipes
WHERE recipe_name = $1;
```

## Вариант I-LIB

Core dependencies:

- `branch_name -> branch_address` if branch names are unique in the variant;
- `book_isbn -> book_title, publisher_name`;
- `(book_isbn, copy_no) -> branch_name`;
- `(book_isbn, copy_no, loaned_at) -> reader_id, returned_at` for a simple loan history.

Possible decomposition:

- `branches(branch_id, branch_name, branch_address)`;
- `readers(reader_id, reader_name)`;
- `books(book_isbn, book_title, publisher_name)`;
- `book_copies(book_isbn, copy_no, branch_id)`;
- `loans(book_isbn, copy_no, reader_id, loaned_at, returned_at)`.

## Вариант I-PHARM

Core dependencies:

- `supplier_inn -> supplier_name`;
- `product_name -> product_type, supplier_inn, prescription_required`;
- sale rows should have a surrogate `sale_id` or a composite event key.

DDL fragment:

```sql
quantity numeric(12, 3) NOT NULL CHECK (quantity > 0),
unit_price numeric(12, 2) NOT NULL CHECK (unit_price >= 0)
```

Security fix:

```sql
SELECT *
FROM sales
WHERE buyer_phone = $1;
```

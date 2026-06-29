# Банк интегрированных вариантов для контрольной 3

Источник идей: `DB/raw/Рабочая группа РГБД 2025/Контрольная работа №2/Варианты заданий.docx` и `Практические задания/ER-диаграммы.docx`.

Формат каждого варианта соответствует контрольной 5.15: зависимости, ключ, аномалии, декомпозиция, короткий SQL-фрагмент и вопрос по безопасности.

## Вариант I-COOK. Кулинарная книга

### Flat table

`recipe_flat(recipe_name, recipe_description, servings, product_name, product_unit, product_price, calories_per_unit, quantity)`

### Domain rules

- рецепт имеет название, описание и число порций;
- продукт имеет название, цену, единицу измерения и калорийность;
- строка компонента задается парой `(recipe_name, product_name)`;
- количество продукта в рецепте положительное.

### Required tasks

1. Выпишите функциональные зависимости.
2. Найдите кандидатный ключ плоской таблицы.
3. Опишите update anomaly и insertion anomaly.
4. Предложите 3НФ-декомпозицию.
5. Напишите SQL-проверку lossless join через `EXCEPT`.
6. Исправьте небезопасный SQL:

```pseudo
sql = "SELECT * FROM recipes WHERE name = '" + recipe_name + "'"
```

## Вариант I-LIB. Библиотека

### Flat table

`library_loan_flat(branch_name, branch_address, reader_id, reader_name, book_isbn, book_title, publisher_name, copy_no, loaned_at, returned_at)`

### Domain rules

- филиал имеет название и адрес;
- книга определяется ISBN;
- физический экземпляр задается парой `(book_isbn, copy_no)`;
- выдача связывает экземпляр и читателя;
- дата возврата не раньше даты выдачи.

### Required tasks

1. Выпишите зависимости для филиала, книги, экземпляра и выдачи.
2. Найдите ключ строки выдачи.
3. Опишите deletion anomaly.
4. Предложите декомпозицию.
5. Исправьте SQL с missing reader/tenant-like boundary: поиск выдачи только по `copy_no`.

## Вариант I-PHARM. Аптека

### Flat table

`pharmacy_sale_flat(branch_name, supplier_inn, supplier_name, product_name, product_type, prescription_required, unit_price, buyer_phone, buyer_name, sold_at, quantity)`

### Domain rules

- поставщик определяется ИНН;
- товар имеет тип, поставщика и признак рецептурности;
- продажа фиксирует филиал, покупателя, товар, время и количество;
- количество положительное, цена неотрицательная.

### Required tasks

1. Выпишите зависимости.
2. Объясните, почему текущая таблица смешивает справочники и факты.
3. Предложите декомпозицию.
4. Напишите DDL-фрагмент для `CHECK quantity > 0`.
5. Исправьте SQL injection в фильтре по телефону покупателя.

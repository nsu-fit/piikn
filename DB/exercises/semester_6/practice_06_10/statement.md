# Практика 6.10. Миграция схемы или design slice

Вы проектируете небольшое изменение схемы с учетом совместимости приложения, тестовых данных и rollback/forward-fix.

## Что нужно сдать

```text
semester-6/practice-10-schema-migration/
  README.md
  migration.sql или design-slice.md
  rollback-or-forward-fix.md
  test-data.sql
  checks.sql
  adr.md
```

## Рекомендуемый сценарий

Добавить к `app.orders` поле `external_reference text` для связи с внешней системой.

Ограничения:

- старая версия приложения продолжает писать заказы без этого поля;
- новая версия может писать поле;
- значение уникально в рамках tenant, если оно не `NULL`;
- разрушительные действия запрещены без отдельного contract-шагa.

## Задания

1. Опишите readers/writers, которых затрагивает изменение.
2. В `migration.sql` реализуйте expand-шаг: новый nullable столбец и ограничение/индекс.
3. В `test-data.sql` добавьте тестовые строки для старого и нового writers.
4. В `checks.sql` проверьте:
   - старые вставки без `external_reference`;
   - новые вставки с `external_reference`;
   - запрет дубля в рамках tenant;
   - разрешение одинакового значения у разных tenant, если вы выбрали такую семантику.
5. В `rollback-or-forward-fix.md` объясните, что делать при ошибке после деплоя.
6. В `adr.md` кратко зафиксируйте решение и альтернативы.

## Контрольные вопросы

1. Что такое expand-contract?
2. Почему nullable столбец может быть совместимым expand-шагом?
3. Когда rollback хуже forward-fix?
4. Как migration order связан с deployment order?

# Решение 5.14. Безопасный SQL из приложения

## 1. Поиск заказов по статусу

Небезопасно:

```pseudo
WHERE status = '" + user_status + "'
```

Безопасно:

```sql
SELECT order_id, status, total_amount
FROM course_lab.order_queue
WHERE status = $1
ORDER BY created_at DESC;
```

Приложение дополнительно проверяет, что `$1` входит в допустимый набор статусов. Payload вроде `' OR true --` становится строковым значением, а не частью SQL.

## 2. Динамическая сортировка

Имена столбцов нельзя параметризовать обычным placeholder-ом. Нужен whitelist:

```pseudo
allowed_columns = {"created_at", "total_amount", "status"}
allowed_directions = {"asc", "desc"}
column = allowed_columns[user_column]
direction = allowed_directions[user_direction]
sql = "ORDER BY " + column + " " + direction
```

Если вход не найден в whitelist, запрос отклоняется.

## 3. Tenant boundary

Правильно:

```sql
SELECT document_id, title, body
FROM app.documents
WHERE tenant_id = $1
  AND document_id = $2;
```

Это не только injection-защита. Отсутствие `tenant_id` - authorization bug: пользователь может прочитать чужой документ, даже если SQL параметризован.

## 4. Роли

- `owner/migration role`: создает и меняет схему, не используется приложением.
- `application role`: выполняет нужные `SELECT/INSERT/UPDATE/DELETE` только на разрешенных объектах.
- `read-only support role`: читает диагностические представления и безопасные таблицы, не меняет данные.

Приложение не работает от владельца схемы и тем более от суперпользователя.

# Небезопасные фрагменты

## 1. Поиск заказов по статусу

```pseudo
sql = "SELECT order_id, status, total_amount " +
      "FROM course_lab.order_queue " +
      "WHERE status = '" + user_status + "' " +
      "ORDER BY created_at DESC"
```

## 2. Динамическая сортировка

```pseudo
sql = "SELECT order_id, status, total_amount, created_at " +
      "FROM course_lab.order_queue " +
      "ORDER BY " + sort_column + " " + sort_direction
```

## 3. Tenant boundary

```sql
SELECT document_id, title, body
FROM app.documents
WHERE document_id = $1;
```

Контекст: приложение знает `current_tenant_id`, но исходный запрос его не использует.

# Контракт автопроверки

Автоматически проверяются:

- наличие `README.md`, `views.sql`, `functions.sql`, `usage.sql`;
- выполнение файлов в порядке `views.sql`, `functions.sql`, `usage.sql`;
- наличие view `course_lab.v_route_revenue` и `course_lab.v_booking_quality`;
- наличие функции `course_lab.booking_total_delta(text)`;
- наличие ожидаемых столбцов в представлениях;
- выполнение запросов `q01` - `q05` без ошибок;
- отсутствие `INSERT`, `UPDATE`, `DELETE` в функции.

Вручную проверяются:

- уместность логики в БД;
- объяснение materialized view;
- читаемость SQL и README.

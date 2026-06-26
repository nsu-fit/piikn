# Контракт проверки

Автоматически проверяются:

- наличие `README.md`, `answers.md`, `checks.sql`, `decomposition_draft.md`;
- выполнение `provided/seed_denormalized_sales.sql`;
- выполнение `checks.sql` без ошибок;
- наличие меток `q01_flight_conflicts` - `q04_booking_total_delta`;
- отсутствие `INSERT`, `UPDATE`, `DELETE`, `CREATE`, `DROP`, `ALTER` в `checks.sql`.

Вручную проверяются:

- корректность функциональных зависимостей;
- обоснование кандидатного ключа;
- качество примеров аномалий;
- различение предметного правила и наблюдения по данным.

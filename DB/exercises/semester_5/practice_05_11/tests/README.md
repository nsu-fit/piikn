# Контракт автопроверки

Автоматически проверяются:

- наличие `README.md`, `decomposition.sql`, `checks.sql`, `answers.md`;
- выполнение seed-сценария из практики 5.10;
- выполнение `decomposition.sql` и `checks.sql` без ошибок;
- наличие таблиц `norm_bookings`, `norm_tickets`, `norm_flights`, `norm_segments`;
- наличие первичных и внешних ключей;
- пустой результат проверок `q03_original_minus_reconstructed` и `q04_reconstructed_minus_original`.

Вручную проверяются:

- соответствие декомпозиции заявленным зависимостям;
- объяснение сохранения зависимостей;
- аргументация практических компромиссов.

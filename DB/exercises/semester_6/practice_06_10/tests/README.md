# Контракт проверки

Автоматически проверяются:

- наличие обязательных файлов;
- выполнение `migration.sql`, `test-data.sql`, `checks.sql`;
- наличие нового столбца или design slice с эквивалентным контрактом;
- наличие проверки уникальности;
- отсутствие `DROP COLUMN`, `DROP TABLE` без contract-плана.

Вручную проверяются:

- readers/writers analysis;
- реалистичность rollback/forward-fix;
- качество ADR.

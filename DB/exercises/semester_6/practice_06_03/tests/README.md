# Контракт проверки

Автоматически проверяются:

- наличие `README.md`, `measurements.sql`, `plans.sql`, `report.md`;
- наличие функций `pg_relation_size`, `pg_indexes_size`, `pg_total_relation_size`;
- наличие `EXPLAIN (ANALYZE, BUFFERS)`;
- отсутствие `CREATE INDEX` в этой практике.

Вручную проверяются:

- корректность выводов по размерам;
- качество индексных гипотез;
- понимание baseline.

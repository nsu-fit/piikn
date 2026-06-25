# Контракт автопроверки

Автопроверка запускается на видимой базе `3 months`.

## Проверки файлов

- существует `README.md`;
- существует `intro_queries.sql`;
- существует `run_log.md`;
- существует `answers.md`;
- `intro_queries.sql` выполняется без ошибок.

## SQL checks

- `intro_queries.sql` возвращает блок с `bookings.version()`;
- в выводе schema objects присутствуют `bookings`, `tickets`, `segments`, `flights`, `routes`, `airports`, `airplanes`, `timetable`;
- блок table counts содержит обязательные таблицы;
- запросы с `LIMIT 10` имеют `ORDER BY`.

## Manual review

- `run_log.md` и `answers.md` проверяются вручную.
- На защите студент объясняет, что он запускал готовый SQL, а не писал собственное решение.

# Лекция 6.8. Администрирование и эксплуатация

Место в курсе: лекция собирает минимальный эксплуатационный набор, необходимый разработчику программных систем с БД.

## Цели

- Показать базовые задачи эксплуатации PostgreSQL в приложении.
- Объяснить роли, схемы, connection pooling, vacuum/analyze, health checks и slow query diagnostics.
- Научить превращать эксплуатационные требования в чеклист.
- Подготовить студентов к составлению operator-facing checklist для сервиса с БД.

## План лекции

1. Разработчик и администратор: где граница ответственности в современной команде.
2. Конфигурация подключения: host, port, database, user, password/secret, SSL, timeout.
3. Роли и права: owner, application user, migration user, read-only user, least privilege.
4. Схемы БД: пространства имен, изоляция модулей, search path и риски.
5. Connection pooling: зачем нужен пул, максимальное число соединений, transaction pooling.
6. Vacuum/analyze: удаление старых версий строк и обновление статистики.
7. Health checks: проверка доступности, миграций, критических запросов.
8. Slow query diagnostics: логи, `pg_stat_statements`, планы выполнения.
9. Maintenance windows: операции, которые нельзя выполнять незаметно для пользователей.
10. Эксплуатационная документация: runbook, checklist, known failure modes, rollback steps.

## Ключевые понятия

Role, privilege, schema, connection pooling, vacuum, analyze, health check, slow query, `pg_stat_statements`, runbook, maintenance window.

## Связь с практикой

Студенты составляют эксплуатационный чеклист для сервиса с БД: роли БД, connection strings, pooling, health checks, vacuum/analyze, slow query diagnostics и maintenance tasks.

## Контрольные вопросы: что вы должны были узнать за эту лекцию

1. Какие роли БД нужны типичному приложению?
2. Почему приложение не должно работать под владельцем схемы или суперпользователем?
3. Для чего нужен connection pool?
4. Что делают `VACUUM` и `ANALYZE`?
5. Какие сигналы помогают обнаружить медленные запросы?
6. Что должно входить в эксплуатационный чеклист сервиса с БД?

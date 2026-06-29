# Практика 5.9. Минимальный DDL и ограничения

Теперь вы уже умеете читать и изменять данные. В этой практике DDL рассматривается как способ явно зафиксировать инварианты небольшой учебной схемы.

## Что нужно сдать

```text
semester-5/practice-09-minimal-ddl-constraints/
  README.md
  schema.sql
  check_observations.md
  answers.md
```

## Сценарий

Нужно описать минимальную схему issue tracker для внутренних задач.

Альтернативные предметные варианты для повторной тренировки или индивидуальной выдачи находятся в `provided/raw_derived_domain_variant_bank.md`. Они не заменяют основной контракт issue tracker, если преподаватель явно не назначил другой вариант.

Сущности:

- проект;
- задача;
- комментарий к задаче.

Проверочный сценарий находится в `provided/check_constraints.sql`. Он предполагает конкретные имена таблиц и столбцов, поэтому соблюдайте контракт ниже.

## Требуемая схема

Создайте схему `course_lab`, если ее нет.

### `course_lab.issue_projects`

Столбцы:

- `project_id` - surrogate primary key;
- `code` - короткий код проекта, обязательный, уникальный;
- `name` - название проекта, обязательное.

Ограничения:

- `code` должен состоять из 2-12 заглавных латинских букв, цифр или `_`.

### `course_lab.issue_tickets`

Столбцы:

- `ticket_id` - surrogate primary key;
- `project_id` - внешний ключ на `issue_projects`;
- `title` - обязательный текст;
- `status` - обязательный статус;
- `priority` - обязательный приоритет;
- `external_key` - внешний ключ задачи из другой системы, опциональный, но уникальный;
- `created_at` - timestamp с default;
- `closed_at` - timestamp, nullable.

Ограничения:

- `status` входит в набор `open`, `in_progress`, `closed`;
- `priority` от 1 до 5;
- если `status = 'closed'`, то `closed_at IS NOT NULL`;
- если `status <> 'closed'`, то `closed_at IS NULL`.

### `course_lab.issue_comments`

Столбцы:

- `comment_id` - surrogate primary key;
- `ticket_id` - внешний ключ на `issue_tickets`;
- `author` - обязательный текст;
- `body` - обязательный текст;
- `created_at` - timestamp с default.

## Порядок работы

1. Напишите `schema.sql`.
2. Выполните `schema.sql` в чистом учебном снапшоте.
3. Выполните `provided/check_constraints.sql`.
4. Сохраните результат проверок в `check_observations.md`.
5. В `answers.md` объясните выбранные ограничения.

## `answers.md`

Ответьте:

1. Какие инварианты фиксируются через `CHECK`?
2. Почему `external_key` уникален, но может быть `NULL`?
3. Почему комментарий связан внешним ключом с задачей?
4. Какие DDL-темы сознательно не рассматриваются в этой практике и уйдут в 6-й семестр?
5. Какой дефект данных был бы возможен без ограничения на `closed_at`?

# Решение 5.16. Защита SQL-портфолио

Это защита, поэтому в `example_artifacts.md` показан конкретный пример портфолио с `index.md` и `selected_artifacts.md`.

## Минимально правильный `index.md`

```text
1. Schema analysis -> practice-05-02/data_dictionary.md
2. ER fragment -> practice-05-03/er.md
3. Basic SELECT -> practice-05-06/queries.sql
4. DML scenario -> practice-05-07/changes.sql
5. DDL constraints -> practice-05-09/schema.sql
6. Functional dependencies -> practice-05-10/answers.md
7. Normalization -> practice-05-11/decomposition.sql
8. View/function -> practice-05-12/
9. Transactions -> practice-05-13/experiment_log.md
10. SQL security -> practice-05-14/secure_sql.md
```

## Правильный `selected_artifacts.md`

Для 3-5 артефактов должны быть:

- путь;
- какой навык показывает;
- как воспроизвести;
- ограничения решения.

## Пример выбранного артефакта

```text
Path: practice-05-13/experiment_log.md
Skill: two-session transaction experiment.
Reproduce: run setup.sql, then execute session_a.sql and session_b.sql step by step.
Limitation: PostgreSQL MVCC internals are not analyzed here; this is an observed-behavior artifact.
```

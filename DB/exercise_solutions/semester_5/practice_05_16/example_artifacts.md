# Пример ожидаемых артефактов 5.16

```text
semester-5/sql-portfolio/
  README.md
  index.md
  selected_artifacts.md
  practice-05-06/
  practice-05-07/
  practice-05-09/
  practice-05-13/
  practice-05-14/
```

## `index.md`

```md
# SQL portfolio index

| Topic | Artifact |
|---|---|
| Schema analysis | `practice-05-02/data_dictionary.md` |
| ER fragment | `practice-05-03/er.md` |
| Basic SELECT | `practice-05-06/queries.sql` |
| DML | `practice-05-07/changes.sql` |
| DDL constraints | `practice-05-09/schema.sql` |
| Normalization | `practice-05-11/decomposition.sql` |
| Transactions | `practice-05-13/experiment_log.md` |
| SQL security | `practice-05-14/secure_sql.md` |
```

## `selected_artifacts.md`

```md
# Selected artifacts

## 1. Basic SELECT

Path: `practice-05-06/queries.sql`.
Skill: joins, aggregates, anti-join.
Reproduce: run against demo database 3 months.
Limitation: query plans are not analyzed yet.

## 2. Transaction experiment

Path: `practice-05-13/experiment_log.md`.
Skill: two-session experiment and lost update explanation.
Reproduce: run `setup.sql`, then session scripts in order.
Limitation: MVCC internals are not analyzed in semester 5.
```

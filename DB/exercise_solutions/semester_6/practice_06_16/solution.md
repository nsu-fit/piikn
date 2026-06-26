# Решение 6.16. Финальная защита проектного артефакта

Финальный проект не имеет одного правильного SQL. В `example_artifacts.md` показан конкретный пример проекта про оптимизацию поиска по JSONB-категории.

## Минимальный состав

```text
semester-6/final-project/
  README.md
  project-artifact.md или основной SQL/runbook/ADR
  demo.md
  risks.md
  links.md
```

## Правильный README

Содержит:

- problem statement;
- контекст и ограничения;
- порядок воспроизведения или design walkthrough;
- ссылки на checkpoint-работы;
- связь минимум с двумя темами курса.

## Правильный demo

Должно быть одно из:

- SQL before/after с планами;
- migration + checks;
- backup/restore runbook + smoke checks;
- partitioning/retention DDL + ADR;
- search/storage/graph design slice + проверяемый prototype.

## Пример связи с теорией

```md
This project connects to:

- B-tree/expression indexes and query planning;
- JSONB storage and expression evaluation;
- operational cost of indexes: write amplification, storage, backup size.
```

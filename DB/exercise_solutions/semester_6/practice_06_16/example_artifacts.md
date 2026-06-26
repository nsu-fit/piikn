# Пример ожидаемых артефактов 6.16

Вариант проекта: query/index optimization.

```text
semester-6/final-project/
  README.md
  project-artifact.md
  demo.md
  risks.md
  links.md
```

## `README.md`

```md
# Final project: optimize document category search

Problem: document category search scans too many rows and is used by support dashboard.

Context:

- source table: `app.documents`;
- predicate: `metadata->>'category' = :category`;
- tenant boundary is mandatory.

Main artifact: `project-artifact.md`.
Demo: `demo.md`.
Related checkpoints: practice 6.3 baseline, practice 6.4 index experiment, practice 6.15 search design.
```

## `demo.md`

```md
# Demo

1. Run baseline query with `EXPLAIN (ANALYZE, BUFFERS)`.
2. Create expression index on `(metadata->>'category')`.
3. Run the same query again.
4. Compare access method, buffers and execution time.

Expected result: query plan can use the expression index when the expression matches.
```

## `risks.md`

```md
# Risks

- Index increases write cost and backup size.
- If query changes to JSONB containment, expression index may not help.
- Small tables may still use seq scan.
- Tenant boundary must remain in every query.
```

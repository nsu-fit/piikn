# Пример ожидаемых артефактов 6.13

Вариант: task dependencies.

```text
semester-6/practice-13-graph-tradeoff/
  README.md
  adr.md
  graph-model.md
  traversal.sql
```

## `graph-model.md`

```md
# Task dependency graph

Vertices: tasks.
Edges: task A depends on task B.

Traversal scenarios:

1. Find all transitive dependencies of a task.
2. Detect a cycle before adding a dependency.
3. Show tasks blocked by a given task.

Expected depth: usually below 10, but cycles must be prevented.
```

## `traversal.sql`

```sql
WITH RECURSIVE deps AS (
    SELECT task_id, depends_on_task_id, 1 AS depth, ARRAY[task_id] AS path
    FROM app.task_dependencies
    WHERE task_id = $1
    UNION ALL
    SELECT d.task_id, d.depends_on_task_id, deps.depth + 1, deps.path || d.task_id
    FROM app.task_dependencies d
    JOIN deps ON d.task_id = deps.depends_on_task_id
    WHERE NOT d.task_id = ANY(deps.path)
)
SELECT *
FROM deps
ORDER BY depth;
```

## `adr.md`

```md
# ADR: task dependencies

Decision: adjacency list + recursive CTE in PostgreSQL.

Alternatives:

- closure table: faster reads, more complex writes;
- graph DB: powerful traversal, but extra operational system.

Consequence: recursive queries must have cycle protection and depth expectations.
```

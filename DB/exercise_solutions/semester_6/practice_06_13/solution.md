# Решение 6.13. Graph trade-off review

## Пример: зависимости задач

Вершины: `task`. Ребра: `task A depends on task B`.

Adjacency list:

```sql
CREATE TABLE app.tasks (
    task_id bigint PRIMARY KEY,
    title text NOT NULL
);

CREATE TABLE app.task_dependencies (
    task_id bigint NOT NULL REFERENCES app.tasks(task_id),
    depends_on_task_id bigint NOT NULL REFERENCES app.tasks(task_id),
    PRIMARY KEY (task_id, depends_on_task_id),
    CHECK (task_id <> depends_on_task_id)
);
```

Traversal:

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

## ADR decision

Для умеренной глубины и объема достаточно adjacency list + recursive CTE. Closure table подходит, если traversal частый и глубина большая. Отдельная graph DB оправдана только при сложных traversal, graph algorithms, отдельной команде эксплуатации и явной выгоде.

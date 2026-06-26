WITH RECURSIVE dependency_tree AS (
    SELECT
        task_id,
        depends_on_task_id,
        1 AS depth,
        ARRAY[task_id] AS path
    FROM app.task_dependencies
    WHERE task_id = $1

    UNION ALL

    SELECT
        d.task_id,
        d.depends_on_task_id,
        dt.depth + 1,
        dt.path || d.task_id
    FROM app.task_dependencies d
    JOIN dependency_tree dt ON d.task_id = dt.depends_on_task_id
    WHERE NOT d.task_id = ANY(dt.path)
)
SELECT *
FROM dependency_tree
ORDER BY depth, task_id;

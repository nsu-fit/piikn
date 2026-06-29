# Решение к варианту оптимизации "студенты и группы"

## Baseline

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT s.student_id, s.last_name, s.first_name, g.group_no, s.enrolled_at
FROM opt_lab.students s
JOIN opt_lab.study_groups g ON g.group_id = s.group_id
WHERE s.status = 'active'
  AND lower(s.last_name) = lower('Ivanov')
ORDER BY s.enrolled_at DESC
LIMIT 50;
```

Проблема: предикат `lower(s.last_name) = lower('Ivanov')` не может использовать обычный индекс по `last_name`. При большом числе строк это ведет к дорогому чтению и фильтрации.

## One acceptable change

```sql
CREATE INDEX students_active_lower_last_name_enrolled_idx
ON opt_lab.students (lower(last_name), enrolled_at DESC)
WHERE status = 'active';

ANALYZE opt_lab.students;
```

## After

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT s.student_id, s.last_name, s.first_name, g.group_no, s.enrolled_at
FROM opt_lab.students s
JOIN opt_lab.study_groups g ON g.group_id = s.group_id
WHERE s.status = 'active'
  AND lower(s.last_name) = lower('Ivanov')
ORDER BY s.enrolled_at DESC
LIMIT 50;
```

## Report fragment

The expression partial index matches both the expression `lower(last_name)` and the stable predicate `status = 'active'`. Ordering by `enrolled_at DESC` can also benefit from the index order.

Trade-off:

- extra disk space;
- slower writes to `students`;
- only helps active-student queries with the same expression;
- if search becomes prefix/full-text search, this index is not enough.

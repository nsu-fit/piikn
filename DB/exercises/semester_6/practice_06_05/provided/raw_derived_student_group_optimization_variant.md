# Вариант оптимизационного практикума: студенты и группы

Источник идей: `DB/raw/Рабочая группа РГБД 2025/Оптимизация запросов/Задание на оптимизацию запросов.docx`.

Этот вариант можно использовать для контрольной 6.5 или как тренировочную работу перед ней.

## Setup

```sql
CREATE SCHEMA IF NOT EXISTS opt_lab;

DROP TABLE IF EXISTS opt_lab.students;
DROP TABLE IF EXISTS opt_lab.study_groups;

CREATE TABLE opt_lab.study_groups (
    group_id integer PRIMARY KEY,
    group_no text NOT NULL UNIQUE,
    program text NOT NULL
);

CREATE TABLE opt_lab.students (
    student_id integer PRIMARY KEY,
    group_id integer NOT NULL REFERENCES opt_lab.study_groups(group_id),
    last_name text NOT NULL,
    first_name text NOT NULL,
    enrolled_at date NOT NULL,
    status text NOT NULL CHECK (status IN ('active', 'academic_leave', 'graduated'))
);

INSERT INTO opt_lab.study_groups (group_id, group_no, program)
SELECT g, 'PI-' || g, CASE WHEN g % 2 = 0 THEN 'Software Engineering' ELSE 'Computer Science' END
FROM generate_series(1, 200) AS g;

INSERT INTO opt_lab.students (student_id, group_id, last_name, first_name, enrolled_at, status)
SELECT
    s,
    1 + (s % 200),
    CASE WHEN s % 20 = 0 THEN 'Ivanov' ELSE 'Student' || (s % 5000) END,
    'Name' || s,
    date '2020-09-01' + (s % 1500)::integer,
    CASE WHEN s % 17 = 0 THEN 'academic_leave' WHEN s % 19 = 0 THEN 'graduated' ELSE 'active' END
FROM generate_series(1, 200000) AS s;

ANALYZE opt_lab.study_groups;
ANALYZE opt_lab.students;
```

## Baseline query

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

## Task

1. Снимите baseline plan.
2. Назовите проблемный узел.
3. Предложите одно изменение.
4. Снимите plan после изменения.
5. Объясните цену решения.

Разрешенные изменения:

- expression index;
- partial expression index;
- переписывание предиката при сохранении смысла;
- дополнительный составной индекс под фильтр и сортировку.

# Решения к дополнительным вариантам по реляционной алгебре

## Вариант RA-U1

### 1. Students from `PI-21`

```text
pi_{student_id, last_name}(sigma_{group_no = 'PI-21'}(Students))
```

Result:

| student_id | last_name |
|---:|---|
| 101 | Ivanov |
| 102 | Petrova |
| 105 | Kim |

### 2. Groups without students

```text
Groups - pi_{group_no, program, year}(Groups join Students)
```

Result:

| group_no | program | year |
|---|---|---:|
| DS-23 | Data Science | 2023 |

### 3. Students enrolled in `DB`

```text
pi_{student_id, last_name, first_name}(
  Students join_{Students.student_id = Enrollments.student_id}
  sigma_{course_code = 'DB'}(Enrollments)
)
```

Result:

| student_id | last_name | first_name |
|---:|---|---|
| 101 | Ivanov | Ivan |
| 102 | Petrova | Anna |
| 103 | Sidorov | Petr |
| 105 | Kim | Maria |

### 4. Students enrolled in all required courses

```text
pi_{student_id, course_code}(Enrollments) ÷ RequiredCourses
```

Then join with `Students`.

Result:

| student_id | last_name | first_name |
|---:|---|---|
| 101 | Ivanov | Ivan |
| 105 | Kim | Maria |

### 5. Equivalence

```text
Students join sigma_{course_code = 'DB'}(Enrollments)
```

is equivalent to:

```text
sigma_{course_code = 'DB'}(Students join Enrollments)
```

because the predicate uses only `Enrollments.course_code`.

## Вариант RA-W1

### 1. Loaders

```text
sigma_{model = 'Loader'}(Machines)
```

Result: machines `10` and `13`.

### 2. Machines and workplace city

```text
pi_{machine_id, model, city}(Machines join Workplaces)
```

### 3. Workplaces without machines

There are no such workplaces in this dataset.

### 4. Machines with all required repairs

```text
pi_{machine_id, repair_type}(Repairs) ÷ RequiredRepairTypes
```

Result: machine `10`.

### 5. Machines without repairs

```text
Machines - pi_{machine_id, model, workplace_id}(Machines join Repairs)
```

Result: machine `13`.

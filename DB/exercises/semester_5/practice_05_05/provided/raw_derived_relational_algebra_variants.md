# Дополнительные варианты по реляционной алгебре

Источник идей: `DB/raw/Рабочая группа РГБД 2025/Упражнения по реляционной алгебре`.

Этот файл предназначен для преподавателя как банк дополнительных вариантов. В основной практике 5.5 используется `small_relations.md`; варианты ниже можно выдавать как замену или как тренировку перед контрольной.

## Вариант RA-U1. Учебная группа

### Relations

`Students(student_id, last_name, first_name, group_no)`

| student_id | last_name | first_name | group_no |
|---:|---|---|---|
| 101 | Ivanov | Ivan | PI-21 |
| 102 | Petrova | Anna | PI-21 |
| 103 | Sidorov | Petr | CS-22 |
| 104 | Ivanov | Oleg | CS-22 |
| 105 | Kim | Maria | PI-21 |

`Groups(group_no, program, year)`

| group_no | program | year |
|---|---|---:|
| PI-21 | Software Engineering | 2021 |
| CS-22 | Computer Science | 2022 |
| DS-23 | Data Science | 2023 |

`Enrollments(student_id, course_code)`

| student_id | course_code |
|---:|---|
| 101 | DB |
| 101 | SE |
| 102 | DB |
| 103 | DB |
| 104 | OS |
| 105 | DB |
| 105 | SE |

`RequiredCourses(course_code)`

| course_code |
|---|
| DB |
| SE |

### Tasks

1. Верните студентов из группы `PI-21`: `student_id`, `last_name`.
2. Верните группы, в которых нет студентов.
3. Верните студентов, записанных на курс `DB`.
4. Верните студентов, записанных на все курсы из `RequiredCourses`.
5. Покажите две эквивалентные формы для задачи 3: selection до join и selection после join.

## Вариант RA-W1. Работы техники

Сценарий вдохновлен raw-упражнениями про рабочие места техники.

`Workplaces(workplace_id, name, city)`

| workplace_id | name | city |
|---:|---|---|
| 1 | North Depot | Novosibirsk |
| 2 | South Depot | Novosibirsk |
| 3 | Airport Site | Ob |

`Machines(machine_id, model, workplace_id)`

| machine_id | model | workplace_id |
|---:|---|---:|
| 10 | Loader | 1 |
| 11 | Tractor | 1 |
| 12 | Crane | 2 |
| 13 | Loader | 3 |

`Repairs(machine_id, repair_type)`

| machine_id | repair_type |
|---:|---|
| 10 | engine |
| 10 | hydraulic |
| 11 | engine |
| 12 | electrical |

`RequiredRepairTypes(repair_type)`

| repair_type |
|---|
| engine |
| hydraulic |

### Tasks

1. Верните технику модели `Loader`.
2. Верните технику и город ее рабочего места.
3. Верните рабочие места без техники.
4. Верните технику, у которой есть все виды ремонта из `RequiredRepairTypes`.
5. Выразите "техника без ремонтов" через разность или антисоединение.

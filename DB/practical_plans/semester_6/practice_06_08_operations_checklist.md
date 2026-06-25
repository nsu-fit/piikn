# Практическое занятие 6.8. Эксплуатационный чеклист

Место в курсе: обычная практика с checkpoint-артефактом. Студент собирает минимальный эксплуатационный набор для работы БД в backend-системе.

Тип занятия: практика с checkpoint-артефактом. Вся пара не резервируется под контроль.

## Цели

- Собрать operational checklist для учебного PostgreSQL-контура.
- Проверить роли, connection strings, health checks и slow query diagnostics.
- Обсудить vacuum/analyze и maintenance windows на практическом уровне.
- Провести короткую демонстрацию backup/restore или эквивалентного эксплуатационного сценария.

## Входные условия

- Выполнены практики 6.6 и 6.7.
- У студента есть черновик runbook и список рисков.
- Доступна учебная БД или подготовленный имитатор эксплуатационного контура.

## План занятия

1. Разбор минимального operational checklist.
2. Проверка ролей: application, migration, read-only/operator.
3. Проверка connection strings и секретов на уровне учебной модели.
4. Health check: что именно должен проверять сервис.
5. Slow query diagnostics: где искать медленный запрос и как зафиксировать baseline.
6. Vacuum/analyze: когда это эксплуатационная проблема.
7. Короткие демонстрации checkpoint-артефактов.
8. Фиксация замечаний для доработки runbook.

## Задание

Студент должен доработать runbook до operational checklist.

Обязательные элементы:

- роли и минимальные права;
- connection string policy;
- health checks;
- slow query baseline;
- backup/restore или другой recovery check;
- maintenance notes;
- список открытых рисков.

## Артефакт сдачи

Папка `semester-6/practice-08-operations-checklist`:

- `operations-checklist.md`;
- `checks.sql`;
- фрагменты команд или ссылки на runbook из практики 6.6.

## Критерии зачета

- Checklist пригоден для повторной проверки контура.
- Роли не сводятся к одному суперпользователю.
- Health checks проверяют не только "порт открыт".
- Slow query diagnostics содержит конкретный запрос или способ обнаружения.
- Backup/restore демонстрация подтверждена результатом smoke checks.

## Контрольные вопросы: что вы должны уметь после занятия

1. Какие роли БД обычно нужны приложению, миграциям и read-only доступу?
2. Что должен проверять health check БД?
3. Почему connection string является эксплуатационным артефактом?
4. Как зафиксировать slow query baseline?
5. Когда vacuum/analyze становится заметным для приложения?
6. Какие пункты checklist должны быть обязательными перед production rollout?

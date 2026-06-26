# Практика 5.7. DML-сценарии на основе SELECT

Вы тренируете DML на подготовленной учебной схеме `course_lab`. Схема создается выданным файлом `provided/seed_dml_lab.sql`; этот файл не оценивается как ваше DDL-решение.

## Что нужно сдать

```text
semester-5/practice-07-dml-select-scenarios/
  README.md
  changes.sql
  checks.sql
  answers.md
```

## Подготовка

1. Скопируйте и выполните `provided/seed_dml_lab.sql`.
2. Убедитесь, что таблицы `course_lab.order_queue` и `course_lab.order_audit` созданы.
3. Все свои изменения пишите в `changes.sql`.
4. Проверочные запросы пишите в `checks.sql`.

## Сценарий

В системе есть очередь заказов. Нужно выбрать крупные ожидающие заказы, отметить их как взятые в обработку и записать audit-событие. Отдельно нужно мягко отменить старые черновики.

Параметры берите из `variant.yaml`.

## `changes.sql`

Файл должен содержать один воспроизводимый сценарий.

### q01_preselect_processing_candidates

Предварительный `SELECT`: покажите заказы со статусом `pending` и суммой не ниже `min_total_amount`.

Столбцы:

- `order_id`;
- `customer_id`;
- `total_amount`;
- `status`;
- `idempotency_key`.

### q02_insert_audit_for_candidates

Добавьте в `course_lab.order_audit` события `picked_for_processing` для кандидатов из `q01`.

Требование: повторный запуск не должен создавать дубликаты audit-событий для одного `order_id` и действия.

### q03_mark_processing

Обновите выбранные заказы:

- `status = 'processing'`;
- `processed_at = processing_timestamp` из варианта.

Используйте `UPDATE ... FROM` и `RETURNING`.

### q04_cancel_old_drafts

Мягко отмените черновики:

- `status = 'cancelled'`;
- `cancelled_reason = 'stale draft'`.

Условие: `status = 'draft'` и `created_at < stale_before`.

Используйте `RETURNING`.

## `checks.sql`

Добавьте проверки:

1. Сколько заказов находится в статусе `processing`.
2. Есть ли дубликаты audit-событий по `(order_id, action)`.
3. Остались ли старые `draft` до `stale_before`.
4. Есть ли заказы с недопустимым статусом.

## `answers.md`

Ответьте:

1. Какой предварительный `SELECT` защищает от слишком широкого `UPDATE`?
2. Почему audit-вставка должна быть идемпотентной?
3. Что возвращает `RETURNING` и как вы использовали этот результат?
4. Почему мягкая отмена безопаснее физического удаления для этого сценария?
5. Какой инвариант проверяет каждый запрос из `checks.sql`?

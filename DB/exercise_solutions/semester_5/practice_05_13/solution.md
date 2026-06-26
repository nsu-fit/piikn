# Решение 5.13. Транзакционные эксперименты

## Сценарий 1. Lost update

Один корректный учебный timeline:

```sql
-- A1
BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT balance FROM course_lab.account_balances WHERE account_id = 1; -- 1000

-- B1
BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT balance FROM course_lab.account_balances WHERE account_id = 1; -- 1000

-- A2
UPDATE course_lab.account_balances SET balance = 900 WHERE account_id = 1;
COMMIT;

-- B2
UPDATE course_lab.account_balances SET balance = 950 WHERE account_id = 1;
COMMIT;
```

Итоговый баланс `950`, хотя суммарное списание `100 + 50` должно было дать `850`. Это lost update на уровне приложения: обе сессии записали значение, вычисленное из устаревшего чтения.

Безопаснее:

```sql
UPDATE course_lab.account_balances
SET balance = balance - 50
WHERE account_id = 1;
```

или явная блокировка строки перед прикладным вычислением.

## Сценарий 2. Инвариант on-call

При `READ COMMITTED` обе транзакции могут увидеть двух дежурных и каждая снять "своего" врача. После двух commit инвариант "остался хотя бы один дежурный" нарушается.

Безопасные варианты:

- `SERIALIZABLE` с обработкой `serialization_failure` и retry;
- явная блокировка строк смены;
- материализация инварианта через отдельную строку/constraint-подход, если он подходит предметной области.

## Сценарий 3. Deadlock

Типовой deadlock:

```text
A: BEGIN; UPDATE account_balances SET balance = balance - 10 WHERE account_id = 1;
B: BEGIN; UPDATE account_balances SET balance = balance - 10 WHERE account_id = 2;
A: UPDATE account_balances SET balance = balance + 10 WHERE account_id = 2; -- waits
B: UPDATE account_balances SET balance = balance + 10 WHERE account_id = 1; -- deadlock
```

Реакция приложения: rollback текущей транзакции, retry всей операции, единый порядок блокировок по `account_id`.

## Граница объяснения

В 5-м семестре достаточно объяснять наблюдаемое поведение: ожидание, deadlock, serialization failure, retry. Детали tuple versions и внутреннего MVCC переносятся в 6-й семестр.

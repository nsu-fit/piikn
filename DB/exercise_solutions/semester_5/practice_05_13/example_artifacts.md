# Пример ожидаемых артефактов 5.13

```text
semester-5/practice-13-transactions/
  README.md
  setup.sql
  session_a.sql
  session_b.sql
  experiment_log.md
```

## `session_a.sql`

```sql
-- A1
BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT balance FROM course_lab.account_balances WHERE account_id = 1;

-- A2
UPDATE course_lab.account_balances
SET balance = 900
WHERE account_id = 1;
COMMIT;
```

## `session_b.sql`

```sql
-- B1
BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT balance FROM course_lab.account_balances WHERE account_id = 1;

-- B2
UPDATE course_lab.account_balances
SET balance = 950
WHERE account_id = 1;
COMMIT;
```

## `experiment_log.md`

```md
# Experiment log

## Scenario 1: lost update

Isolation level: READ COMMITTED.

Expected business result: 1000 - 100 - 50 = 850.
Actual result after both commits: 950.

Explanation: both sessions computed a new balance from the same old value. The second write overwrote the effect of the first.

Safe reaction: use atomic `balance = balance - :delta`, row lock before read-modify-write, or retry logic under stricter isolation.
```

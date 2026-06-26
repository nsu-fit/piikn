# Пример ожидаемых артефактов 6.6

```text
semester-6/practice-06-backup-restore/
  README.md
  runbook.md
  commands.ps1
  checks.sql
  recovery-notes.md
```

## `commands.ps1`

```powershell
New-Item -ItemType Directory -Force -Path .\backup
pg_dump -h localhost -U db_course_owner -d db_course -Fc -f .\backup\db_course.dump
createdb -h localhost -U db_course_owner db_course_restore
pg_restore -h localhost -U db_course_owner -d db_course_restore .\backup\db_course.dump
psql -h localhost -U db_course_readonly -d db_course_restore -f .\checks.sql
```

## `runbook.md`

```md
# Backup/restore runbook

Goal: restore `db_course` into separate database `db_course_restore`.

Steps:

1. Create custom-format dump.
2. Create restore database.
3. Restore dump.
4. Run smoke checks.

Do not restore into `db_course` during the exercise.
```

## `recovery-notes.md`

```md
# Recovery notes

This is a logical backup. It does not provide point-in-time recovery and does not capture all cluster-level settings.
Restore was verified by row counts and aggregate checks.
```

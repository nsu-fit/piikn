# Практика 6.7. Репликация и эксплуатационные риски

Вы описываете учебную primary/replica-топологию и фиксируете, какие запросы можно отправлять на реплику, а какие чувствительны к задержке.

## Что нужно сдать

```text
semester-6/practice-07-replication-topology/
  README.md
  topology.md
  risks.md
  lag_checks.sql
```

## Задания

1. В `topology.md` нарисуйте схему:
   - application;
   - primary;
   - read replica;
   - backup/restore target;
   - monitoring/health checks.
2. Разделите write path и read path.
3. В `lag_checks.sql` добавьте запросы или команды наблюдения lag:
   - на primary: текущий WAL LSN;
   - на replica: replay LSN и replay timestamp, если реплика доступна;
   - fallback: текстовое описание, если преподаватель дал демонстрационный лог вместо живой реплики.
4. В `risks.md` опишите минимум 6 рисков:
   - stale read;
   - failover split-brain;
   - потеря write availability;
   - чтение после записи;
   - backup, ошибочно принятый за реплику;
   - секреты и права подключения.
5. Для каждого риска укажите проверку или mitigation.

## Контрольные вопросы

1. Чем read replica отличается от backup?
2. Какие запросы нельзя безопасно читать с задержкой?
3. Как приложение должно вести себя при failover?
4. Почему lag является прикладным, а не только инфраструктурным риском?

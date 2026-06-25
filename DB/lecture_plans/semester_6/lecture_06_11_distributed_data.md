# Лекция 6.11. Распределенные данные

Место в курсе: лекция систематизирует решения, которые появляются при росте данных, нагрузки и числа сервисов.

## Цели

- Разобрать partitioning, sharding и replication как разные техники распределения данных.
- Объяснить CAP/PACELC, clocks, consensus и distributed transactions на прикладном уровне.
- Показать, как retention и партиционирование помогают audit/telemetry-сценариям.
- Подготовить студентов к проектированию partitioning/retention для audit/telemetry-данных.

## План лекции

1. Почему данные становятся распределенными: объем, география, отказоустойчивость, организационные границы.
2. Partitioning внутри одной СУБД: range, list, hash, partition pruning.
3. Sharding: распределение данных между узлами и проблема выбора shard key.
4. Replication: повторение данных для доступности и чтения.
5. CAP: consistency, availability, partition tolerance; ограничения интерпретации.
6. PACELC: что происходит не только при partition, но и в нормальном режиме.
7. Время и порядок событий: logical clocks, ordering, idempotency.
8. Consensus: зачем нужны Raft/Paxos-подобные алгоритмы на концептуальном уровне.
9. Distributed transactions: 2PC, саги, outbox, eventual consistency.
10. Audit/telemetry-данные: партиционирование по времени/tenant scope, retention, стоимость хранения.

## Ключевые понятия

Partitioning, sharding, replication, shard key, CAP, PACELC, logical clock, consensus, 2PC, saga, outbox, retention.

## Связь с практикой

Практика посвящена partitioning/retention для audit или telemetry: схема партиционирования по времени/tenant scope, запросы обслуживания и trade-off стоимости хранения.

## Контрольные вопросы: что вы должны были узнать за эту лекцию

1. Чем partitioning отличается от sharding?
2. Как выбрать shard key?
3. Что CAP говорит о распределенной системе?
4. Чем PACELC дополняет CAP?
5. Почему распределенные транзакции сложны?
6. Как партиционирование помогает audit/telemetry-таблицам?

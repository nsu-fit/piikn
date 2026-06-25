# Подробные планы практических занятий по дисциплине "Базы данных"

Этот каталог дополняет файлы `DB/practical_classes_plan.md`, `DB/practical_assessment_methodology.md`, `DB/practical_exercises_design.md` и `DB/updated_database_course_program.md`.

Конкретные выдаваемые задания, варианты и спецификации проверки находятся в `DB/exercises/`.

Общая сетка:

- 5-й семестр: 16 практических занятий, фокус на применении СУБД, чтении схем, SQL, нормализации, транзакциях и безопасности в учебной среде Taidon/sqlrs.
- 6-й семестр: 16 практических занятий, фокус на внутреннем устройстве, эксплуатации и архитектурных аспектах БД на базе локального или контейнерного PostgreSQL-контура.

Полностью зарезервированные контрольные недели:

- 5-й семестр: недели 4, 8, 15 - очные контрольные; неделя 16 - защита SQL-портфолио.
- 6-й семестр: неделя 5 - очный оптимизационный практикум; неделя 16 - финальная защита проектного артефакта.

Каждый файл содержит:

- место занятия в курсе;
- тип занятия;
- цели;
- входные условия;
- план пары;
- задание или регламент контроля;
- артефакт сдачи;
- критерии зачета или оценки;
- контрольные вопросы в формате "что вы должны уметь после занятия".

## 5-й семестр

1. [Вход в Taidon/sqlrs и воспроизводимый SQL-сценарий](semester_5/practice_05_01_sqlrs_intro.md)
2. [Анализ учебного датасета](semester_5/practice_05_02_dataset_analysis.md)
3. [Восстановление ER-диаграммы](semester_5/practice_05_03_er_reconstruction.md)
4. [Контрольная 1: анализ схемы и предметной области](semester_5/practice_05_04_checkpoint_schema_analysis.md)
5. [Реляционная алгебра и SQL](semester_5/practice_05_05_relational_algebra_sql.md)
6. [DDL в изолированном снапшоте](semester_5/practice_05_06_ddl_snapshot.md)
7. [DML и базовый SELECT](semester_5/practice_05_07_dml_select.md)
8. [Контрольная 2: базовый SQL](semester_5/practice_05_08_checkpoint_basic_sql.md)
9. [CTE, рекурсивные запросы и оконные функции](semester_5/practice_05_09_cte_windows_recursive.md)
10. [Функциональные зависимости и аномалии](semester_5/practice_05_10_functional_dependencies.md)
11. [Нормализация учебной схемы](semester_5/practice_05_11_normalization.md)
12. [Представления и простые функции](semester_5/practice_05_12_views_functions.md)
13. [Транзакционные эксперименты](semester_5/practice_05_13_transactions.md)
14. [MVCC, конфликты и безопасный SQL](semester_5/practice_05_14_mvcc_sql_security.md)
15. [Контрольная 3: нормализация, транзакции и безопасность SQL](semester_5/practice_05_15_checkpoint_integrated.md)
16. [Защита SQL-портфолио](semester_5/practice_05_16_sql_portfolio_defense.md)

## 6-й семестр

1. [Локальное или контейнерное развертывание PostgreSQL](semester_6/practice_06_01_postgres_local_setup.md)
2. [Устройство PostgreSQL-кластера](semester_6/practice_06_02_cluster_internals.md)
3. [Физическое хранение и первичные индексы](semester_6/practice_06_03_physical_storage_indexes.md)
4. [Специализированные индексы и JSONB](semester_6/practice_06_04_advanced_indexes_jsonb.md)
5. [Оптимизационный практикум](semester_6/practice_06_05_optimization_practicum.md)
6. [WAL, checkpoint и backup/restore учебного PostgreSQL-контура](semester_6/practice_06_06_backup_restore.md)
7. [Репликация в контейнерах](semester_6/practice_06_07_replication_topology.md)
8. [Эксплуатационный чеклист](semester_6/practice_06_08_operations_checklist.md)
9. [Интеграция PostgreSQL с приложением](semester_6/practice_06_09_application_integration.md)
10. [Миграции схемы](semester_6/practice_06_10_schema_migration.md)
11. [Partitioning и retention](semester_6/practice_06_11_partitioning_retention.md)
12. [Реляционное хранение и альтернативы внутри PostgreSQL](semester_6/practice_06_12_storage_alternatives.md)
13. [Графоподобные данные в PostgreSQL и architecture trade-off review](semester_6/practice_06_13_graph_tradeoff.md)
14. [Аналитическая витрина на PostgreSQL](semester_6/practice_06_14_analytics_mart.md)
15. [Поиск и AI-сценарии](semester_6/practice_06_15_search_ai_data.md)
16. [Финальная защита проектного артефакта по PostgreSQL-инженерии](semester_6/practice_06_16_project_defense.md)

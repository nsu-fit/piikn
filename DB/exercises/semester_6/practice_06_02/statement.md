# Практика 6.2. Устройство PostgreSQL-кластера и storage/MVCC-наблюдения

Вы составляете карту учебного PostgreSQL-кластера и связываете логические объекты с системными каталогами и файлами хранения.

## Что нужно сдать

```text
semester-6/practice-02-cluster-internals/
  README.md
  catalog_queries.sql
  cluster-map.md
  mvcc-observation.md
```

## Задания

1. В `catalog_queries.sql` добавьте запросы:
   - `q01_database_and_settings`: текущая база, пользователь, `server_version`, `data_directory`;
   - `q02_course_schemas`: схемы учебной базы;
   - `q03_app_relations`: таблицы и индексы схемы `app`;
   - `q04_relation_files`: `pg_relation_filepath` для `app.events`, `app.orders`, `app.documents`;
   - `q05_activity`: текущие соединения из `pg_stat_activity`;
   - `q06_relation_sizes`: размер таблиц и общий размер relations.
2. В `cluster-map.md` опишите, как запущен кластер, где data directory, какие базы/схемы/роли используются.
3. В `mvcc-observation.md` проведите безопасное наблюдение:
   - измерьте размер `app.orders`;
   - выполните 100-200 `UPDATE` в транзакции и `COMMIT`;
   - снова измерьте размер или статистику;
   - выполните `VACUUM app.orders`;
   - опишите наблюдение без ручного изменения файлов.

## Запрещено

- вручную менять файлы data directory;
- запускать destructive cleanup без отдельной команды и предупреждения;
- выдавать скриншот вместо SQL и текстового наблюдения.

## Контрольные вопросы

1. Чем cluster отличается от database?
2. Как связать таблицу с relation file?
3. Что показывает `pg_stat_activity`?
4. Почему `UPDATE` может увеличить физический след таблицы?

# Практика 6.12. Реляционное хранение, JSONB и access policies

Вы сравниваете варианты хранения для одного класса данных и набрасываете access policy.

## Что нужно сдать

```text
semester-6/practice-12-storage-alternatives/
  README.md
  storage-tradeoff.md
  access-policy-sketch.md
  adr-draft.md
  model-example.sql или model-example.json
```

## Выберите один класс данных

- пользовательские настройки;
- event metadata;
- document attributes;
- large artifact reference;
- audit payload.

## Сравните минимум три варианта

1. Нормализованная реляционная схема.
2. JSONB в PostgreSQL.
3. Key-value pattern в PostgreSQL.
4. Object storage reference.
5. Внешнее специализированное хранилище.

## `storage-tradeoff.md`

Заполните таблицу:

- write pattern;
- read/query pattern;
- consistency;
- size/growth;
- retention;
- search needs;
- migration cost;
- backup/restore implications;
- operational burden.

## `access-policy-sketch.md`

Опишите:

- роли;
- tenant/user boundary;
- какие строки можно читать;
- какие строки можно менять;
- нужен ли RLS или достаточно application-layer authorization;
- один пример SQL policy или псевдокод проверки.

## Контрольные вопросы

1. Что является authoritative source?
2. Когда JSONB оправдан в PostgreSQL?
3. Когда object storage лучше таблицы?
4. Как access pattern влияет на выбор модели?

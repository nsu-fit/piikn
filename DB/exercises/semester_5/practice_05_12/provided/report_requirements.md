# Требования к отчетам

## Route revenue

Отчет нужен аналитику продаж. Он отвечает на вопрос: какие маршруты дают наибольшую выручку по проданным сегментам.

Минимальные поля:

- route number;
- departure airport;
- arrival airport;
- segment count;
- total revenue.

## Booking quality

Отчет нужен для проверки целостности демоданных. Он отвечает на вопрос: совпадает ли сумма бронирования с суммой всех сегментов билетов внутри бронирования.

Минимальные поля:

- booking reference;
- stored booking total;
- calculated total;
- delta.

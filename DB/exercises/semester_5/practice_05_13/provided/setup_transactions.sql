CREATE SCHEMA IF NOT EXISTS course_lab;

DROP TABLE IF EXISTS course_lab.on_call;
DROP TABLE IF EXISTS course_lab.account_balances;

CREATE TABLE course_lab.account_balances (
    account_id integer PRIMARY KEY,
    balance integer NOT NULL CHECK (balance >= 0)
);

CREATE TABLE course_lab.on_call (
    doctor_id integer NOT NULL,
    shift_date date NOT NULL,
    is_on_call boolean NOT NULL,
    PRIMARY KEY (doctor_id, shift_date)
);

INSERT INTO course_lab.account_balances (account_id, balance)
VALUES
    (1, 1000),
    (2, 1000);

INSERT INTO course_lab.on_call (doctor_id, shift_date, is_on_call)
VALUES
    (1, date '2026-03-01', true),
    (2, date '2026-03-01', true);

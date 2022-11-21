DROP TABLE IF EXISTS fine;
DROP TABLE IF EXISTS traffic_violation;
DROP TABLE IF EXISTS payment;

CREATE TABLE fine(
       fine_id        SERIAL PRIMARY KEY,
       name           VARCHAR(30),
       number_plate   VARCHAR(6),
       violation      VARCHAR(50),
       sum_fine       DECIMAL(8, 2),
       date_violation DATE,
       date_payment   DATE
);

INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES ('Баранов П.Е.',  'Р523ВТ', 'Превышение скорости(от 40 до 60)',    NULL, '2020-02-14 ',        NULL),
       ('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал',        NULL, '2020-02-23',         NULL),
       ('Яковлев Г.Р.',  'Т330ТТ', 'Проезд на запрещающий сигнал',        NULL, '2020-03-03',         NULL),
       ('Баранов П.Е.',  'Р523ВТ', 'Превышение скорости(от 40 до 60)',  500.00, '2020-01-12', '2020-01-17'),
       ('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал',     1000.00, '2020-01-14', '2020-02-27');

CREATE TABLE traffic_violation(
       violation_id SERIAL PRIMARY KEY,
       violation    VARCHAR(50),
       sum_fine     DECIMAL(8, 2)
);

INSERT INTO traffic_violation (violation, sum_fine)
VALUES ('Превышение скорости(от 20 до 40)', 500),
       ('Превышение скорости(от 40 до 60)', 1000),
       ('Проезд на запрещающий сигнал', 1000);

CREATE TABLE payment(
       payment_id     SERIAL PRIMARY KEY,
       name           VARCHAR(30),
       number_plate   VARCHAR(6),
       violation      VARCHAR(50),
       date_violation DATE,
       date_payment   DATE
);

INSERT INTO payment(name, number_plate, violation, date_violation, date_payment)
VALUES ('Яковлев Г.Р.', 'М701АА', 'Превышение скорости (от 20 до 40)', '2020-01-12', '2020-01-22'),
       ('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости (от 40 до 60)', '2020-02-14', '2020-03-06'),
       ('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал',      '2020-03-03', '2020-03-23'); 
/* Создать таблицу fine следующей структуры:
   fine_id         ключевой столбец целого типа с автоматическим увеличением значения ключа на 1
   name            строка длиной 30
   number_plate    строка длиной 6
   violation       строка длиной 50
   sum_fine        вещественное число, максимальная длина 8, количество знаков после запятой 2
   date_violation  дата
   date_payment    дата */
CREATE TABLE fine (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30),
    number_plate VARCHAR(6),
    violation VARCHAR(50),
    sum_fine DECIMAL(8,2),
    date_violation DATE,
    date_payment DATE
    );

/* В таблицу fine первые 5 строк уже занесены. Добавить в таблицу записи 6, 7, 8.
   +---------------+--------------+----------------------------------+----------+------------------+--------------+
   | name          | number_plate | violation                        | sum_fine | date_violation   | date_payment |
   +---------------+--------------+----------------------------------+----------+------------------+--------------+
   | Баранов П.Е.  | Р523ВТ       | Превышение скорости(от 40 до 60) | 500.00   | 2020-01-12       | 2020-01-17   |
   | Абрамова К.А. | О111АВ       | Проезд на запрещающий сигнал     | 1000.00  | 2020-01-14       | 2020-02-27   |
   | Яковлев Г.Р.  | Т330ТТ       | Превышение скорости(от 20 до 40) | 500.00   | 2020-01-23       | 2020-02-23   |
   | Яковлев Г.Р.  | М701АА       | Превышение скорости(от 20 до 40) | None     | 2020-01-12       | None         |
   | Колесов С.П.  | К892АХ       | Превышение скорости(от 20 до 40) | None     | 2020-02-01       | None         |
   | Баранов П.Е.  | Р523ВТ       | Превышение скорости(от 40 до 60) | None     | 2020-02-14       | None         |
   | Абрамова К.А. | О111АВ       | Проезд на запрещающий сигнал     | None     | 2020-02-23       | None         |
   | Яковлев Г.Р.  | Т330ТТ       | Проезд на запрещающий сигнал     | None     | 2020-03-03       | None         |
   +---------------+--------------+----------------------------------+----------+------------------+--------------+
   Affected rows: 3 */
INSERT INTO fine(name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES ('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', NULL, '2020-02-14', NULL),
       ('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', NULL, '2020-02-23', NULL),
       ('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал', NULL, '2020-03-03', NULL);
   
/* Занести в таблицу fine суммы штрафов, которые должен оплатить водитель, в соответствии с данными из таблицы traffic_violation. 
   При этом суммы заносить только в пустые поля столбца sum_fine. */
UPDATE fine f, traffic_violation tv SET f.sum_fine = tv.sum_fine
WHERE f.violation = tv.violation AND f.sum_fine IS NULL;

/* Вывести фамилию, номер машины и нарушение только для тех водителей, которые на одной машине нарушили одно и то же правило два и более раз. 
   При этом учитывать все нарушения, независимо от того оплачены они или нет. Информацию отсортировать в алфавитном порядке, сначала по фамилии водителя, 
   потом по номеру машины и, наконец, по нарушению. */
SELECT `name`, number_plate, violation -- COUNT(*)
FROM fine
GROUP BY `name`, number_plate, violation
HAVING COUNT(*) >= 2
ORDER BY `name`, number_plate, violation;

-- В таблице fine увеличить в два раза сумму неоплаченных штрафов для отобранных на предыдущем шаге записей.
UPDATE fine, 
   (SELECT name, number_plate, violation
    FROM fine
    GROUP BY name, number_plate, violation
    HAVING COUNT(violation) >= 2
    ORDER BY name, number_plate, violation) AS qin
SET fine.sum_fine = fine.sum_fine * 2
WHERE fine.name = qin.name
AND fine.number_plate = qin.number_plate
AND fine.violation = qin.violation
AND fine.date_payment IS NULL;

/* В таблицу fine занести дату оплаты соответствующего штрафа из таблицы payment; Уменьшить начисленный штраф в таблице fine в два раза
   (только для тех штрафов, информация о которых занесена в таблицу payment) , если оплата произведена не позднее 20 дней со дня нарушения. */
UPDATE fine f, payment p
SET f.date_payment = p.date_payment,
    f.sum_fine = IF((DATEDIFF(p.date_payment, f.date_violation)) <= 20, f.sum_fine / 2, f.sum_fine)
WHERE f.name = p.name
  AND f.number_plate = p.number_plate
  AND f.violation = p.violation
  AND f.date_payment IS NULL;

/* Создать новую таблицу back_payment, куда внести информацию о неоплаченных штрафах 
   (Фамилию и инициалы водителя, номер машины, нарушение, сумму штрафа и дату нарушения) из таблицы fine. */
-- 1 variant
CREATE TABLE back_payment AS
    (SELECT name, number_plate, violation, sum_fine, date_violation
     FROM fine
     WHERE date_payment IS NULL);
-- SELECT * FROM back_payment;
-- 2 variant
CREATE TABLE back_payment(SELECT * FROM fine WHERE ISNULL(date_payment));
ALTER TABLE back_payment DROP fine_id, DROP date_payment;

/* Удалить из таблицы fine информацию о нарушениях, совершенных раньше 1 февраля 2020 года. */
DELETE FROM fine
WHERE DATEDIFF(date_violation, '2020-02-01') < 0;
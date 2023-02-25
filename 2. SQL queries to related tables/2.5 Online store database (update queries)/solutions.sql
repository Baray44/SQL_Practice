/* Включить нового человека в таблицу с клиентами. Его имя Попов Илья, его email popov@test, проживает он в Москве.*/
-- 1
INSERT INTO client (name_client, city_id, email)
SELECT 'Попов Илья', city_id, 'popov@test'
FROM city
WHERE name_city = 'Москва';
-- 2
INSERT INTO client (name_client, city_id, email)
VALUES ('Попов Илья', 
        (SELECT city_id FROM city WHERE name_city = 'Москва'),
        'popov@test');

/* Создать новый заказ для Попова Ильи. Его комментарий для заказа: «Связаться со мной по вопросу доставки».*/
INSERT INTO buy (buy_description, client_id)
SELECT 'Связаться со мной по вопросу доставки', client_id
FROM client
WHERE name_client = 'Попов Илья';

/* В таблицу buy_book добавить заказ с номером 5. Этот заказ должен содержать книгу Пастернака «Лирика»
в количестве двух экземпляров и книгу Булгакова «Белая гвардия» в одном экземпляре.*/
INSERT INTO buy_book (buy_id, book_id, amount)
SELECT 5, book_id, 2
FROM book
JOIN author USING (author_id)
WHERE name_author LIKE 'Пастернак %' AND title = 'Лирика';

INSERT INTO buy_book (buy_id, book_id, amount)
SELECT 5, book_id, 1
FROM book
JOIN author USING (author_id)
WHERE name_author LIKE 'Булгаков %' AND title = 'Белая гвардия';

/* Уменьшить количество тех книг на складе, которые были включены в заказ с номером 5.*/
UPDATE book b JOIN buy_book bb USING (book_id)
SET b.amount = b.amount - bb.amount
WHERE buy_id = 5;

/* Создать счет (таблицу buy_pay) на оплату заказа с номером 5, в который включить название книг, 
   их автора, цену, количество заказанных книг и  стоимость. Последний столбец назвать Стоимость. 
   Информацию в таблицу занести в отсортированном по названиям книг виде.*/
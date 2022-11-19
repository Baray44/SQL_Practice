/* Вывести все заказы Баранова Павла (id заказа, какие книги, по какой цене и в каком количестве он заказал)
   в отсортированном по номеру заказа и названиям книг виде. */
SELECT buy.buy_id, book.title, book.price, buy_book.amount
FROM buy
JOIN client USING (client_id)
JOIN buy_book USING (buy_id)
JOIN book USING (book_id)
WHERE client.name_client = 'Баранов Павел'
ORDER BY buy.buy_id, book.title;

/* Посчитать, сколько раз была заказана каждая книга, для книги вывести ее автора (нужно посчитать, в каком количестве заказов фигурирует каждая книга).  
   Вывести фамилию и инициалы автора, название книги, последний столбец назвать Количество. 
   Результат отсортировать сначала  по фамилиям авторов, а потом по названиям книг. */
SELECT name_author, title, COUNT(buy_book.book_id) AS 'Количество'
FROM book
JOIN author USING (author_id)
LEFT JOIN buy_book USING (book_id)
GROUP BY book.book_id
ORDER BY name_author, title;

/* Вывести города, в которых живут клиенты, оформлявшие заказы в интернет-магазине.
   Указать количество заказов в каждый город, этот столбец назвать Количество.
   Информацию вывести по убыванию количества заказов, а затем в алфавитном порядке по названию городов. */
SELECT name_city, COUNT(client_id) AS 'Количество'
FROM city
JOIN client USING (city_id)
JOIN buy USING (client_id)
GROUP BY name_city
ORDER BY 'Количество' DESC, name_city;

/* Вывести номера всех оплаченных заказов и даты, когда они были оплачены. */
SELECT buy_id, date_step_end
FROM step
JOIN buy_step USING (step_id)
WHERE name_step LIKE 'Оплата' AND date_step_end IS NOT NULL;

/* Вывести информацию о каждом заказе: его номер, кто его сформировал (фамилия пользователя) 
   и его стоимость (сумма произведений количества заказанных книг и их цены), в отсортированном 
   по номеру заказа виде. Последний столбец назвать Стоимость. */
SELECT buy_id, name_client, SUM(price * buy_book.amount) AS 'Стоимость'
FROM book
JOIN buy_book USING (book_id)
JOIN buy USING (buy_id)
JOIN `client` USING (client_id)
GROUP BY buy_id, name_client
ORDER BY buy_id;
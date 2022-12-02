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

/* Вывести номера заказов (buy_id) и названия этапов, на которых они в данный момент находятся. 
   Если заказ доставлен –  информацию о нем не выводить. Информацию отсортировать по возрастанию buy_id. */
SELECT buy_id, name_step
FROM buy_step
JOIN step USING (step_id)
WHERE date_step_beg IS NOT NULL AND date_step_end IS NULL
ORDER BY buy_id;

/* В таблице city для каждого города указано количество дней, за которые заказ может быть доставлен в этот город 
   (рассматривается только этап "Транспортировка"). Для тех заказов, которые прошли этап транспортировки, 
   вывести количество дней за которое заказ реально доставлен в город. А также, если заказ доставлен с опозданием, 
   указать количество дней задержки, в противном случае вывести 0. В результат включить номер заказа (buy_id), 
   а также вычисляемые столбцы Количество_дней и Опоздание. Информацию вывести в отсортированном по номеру заказа виде. */
-- 1 variant (GREATEST)
SELECT buy_id, DATEDIFF(date_step_end, date_step_beg) AS Количество_дней, GREATEST((DATEDIFF(date_step_end, date_step_beg) - days_delivery), 0) AS Опоздание
FROM buy_step
JOIN step USING (step_id)
JOIN buy USING (buy_id)
JOIN client USING (client_id)
JOIN city USING (city_id)
WHERE name_step = 'Транспортировка'
AND date_step_beg IS NOT NULL
AND date_step_end IS NOT NULL
ORDER BY buy_id;
-- 2 variant (IF)
SELECT buy_id, DATEDIFF(date_step_end, date_step_beg) AS Количество_дней, IF (days_delivery < DATEDIFF(date_step_end, date_step_beg), DATEDIFF(date_step_end, date_step_beg) - days_delivery, 0) AS Опоздание
FROM city INNER JOIN client USING (city_id)
INNER JOIN buy USING(client_id)
INNER JOIN buy_step USING(buy_id)
INNER JOIN step USING(step_id)
WHERE date_step_end IS NOT NULL and name_step = 'Транспортировка'
ORDER BY buy_id;

/* Выбрать всех клиентов, которые заказывали книги Достоевского, информацию вывести в отсортированном по алфавиту виде. */
SELECT DISTINCT name_client
FROM client
JOIN buy USING (client_id)
JOIN buy_book USING (buy_id)
JOIN book USING (book_id)
JOIN author USING (author_id)
WHERE name_author = 'Достоевский Ф.М.'
ORDER BY name_client;

/* Вывести жанр (или жанры), в котором было заказано больше всего экземпляров книг, указать это количество. Последний столбец назвать Количество. */
SELECT genre.name_genre, SUM(buy_book.amount) as Количество
FROM genre
    JOIN book USING(genre_id)
    JOIN buy_book USING(book_id)
GROUP BY genre.name_genre
HAVING SUM(buy_book.amount) =
    (/* вычисляем максимальный жанр из общего количества каждого заказа */
        SELECT MAX(sum_amount) AS max_sum_amount
        FROM 
            (/* считаем количество жанров каждого заказа */
            SELECT genre.genre_id, SUM(buy_book.amount) AS sum_amount 
            FROM genre
            JOIN book USING(genre_id)
            JOIN buy_book USING(book_id)
            GROUP BY genre.genre_id
            ) query_in
    );
    
/* Сравнить ежемесячную выручку от продажи книг за текущий и предыдущий годы.
   Для этого вывести год, месяц, сумму выручки в отсортированном сначала по возрастанию месяцев, затем по возрастанию лет виде.
   Название столбцов: Год, Месяц, Сумма. */
SELECT YEAR(date_payment) AS Год, MONTHNAME(date_payment) AS Месяц, SUM(price * amount) AS Сумма
FROM buy_archive
GROUP BY Год, Месяц

UNION ALL

SELECT YEAR(date_step_end) AS Год, MONTHNAME(date_step_end) AS Месяц, SUM(book.price * buy_book.amount) AS Сумма
FROM buy_step
JOIN buy_book USING (buy_id)
JOIN book USING (book_id)
WHERE date_step_end IS NOT NULL AND step_id = 1
GROUP BY Год, Месяц
ORDER BY Месяц, Год;

/* Для каждой отдельной книги необходимо вывести информацию о количестве проданных экземпляров и их стоимости за текущий и предыдущий год.
   Вычисляемые столбцы назвать Количество и Сумма. Информацию отсортировать по убыванию стоимости. */
SELECT title, SUM(Количество) AS Количество, SUM(Сумма) AS Сумма
FROM
    (SELECT title, SUM(buy_book.amount) AS Количество, SUM(book.price * buy_book.amount) AS Сумма
    FROM buy_book 
    JOIN buy USING (buy_id)
    JOIN buy_step USING (buy_id)
    JOIN step USING (step_id)
    JOIN book USING (book_id)
    WHERE name_step = 'Оплата' AND not isNull(date_step_end)
    GROUP BY title
     
    UNION
     
    SELECT title, SUM(buy_archive.amount) AS amount, SUM(buy_archive.price * buy_archive.amount) AS total
    FROM buy_archive
    JOIN book ON buy_archive.book_id = book.book_id
    GROUP BY title ) AS query
GROUP BY title
ORDER BY Сумма DESC;

/* Вывести названия книг, которые ни разу не были заказаны, отсортировав в алфавитном порядке. */
SELECT title_b.title
FROM 
	(SELECT book.title , title_buy.title AS t2
	 FROM book
     LEFT JOIN (SELECT title, book_id
			    FROM buy_book
			    JOIN book USING(book_id)
			    GROUP BY title, book_id) AS title_buy USING (book_id)) AS title_b
WHERE title_b.t2 IS NULL;
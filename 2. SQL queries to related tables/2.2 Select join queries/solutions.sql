/* Вывести название, жанр и цену тех книг, 
   количество которых больше 8, 
   в отсортированном по убыванию цены виде.
   +-----------------------+------------+--------+
   | title                 | name_genre | price  |
   +-----------------------+------------+--------+
   | Стихотворения и поэмы | Поэзия     | 650.00 |
   | Игрок                 | Роман      | 480.50 |
   | Идиот                 | Роман      | 460.00 |
   +-----------------------+------------+--------+ */
SELECT b.title, g.name_genre, b.price
FROM genre g
JOIN book b ON g.genre_id = b.genre_id
WHERE b.amount > 8
ORDER BY b.price DESC;

/* Вывести все жанры, которые не представлены в книгах на складе. */
-- 1 variant
SELECT g.name_genre
FROM genre g
LEFT JOIN book b ON g.genre_id = b.genre_id
WHERE b.genre_id IS NULL;

-- 2 variant
SELECT name_genre
FROM book
RIGHT JOIN genre ON book.genre_id = genre.genre_id
WHERE isNull(book.genre_id);

/* Необходимо в каждом городе провести выставку книг каждого автора в течение 2020 года. Дату проведения выставки выбрать случайным образом. 
   Создать запрос, который выведет город, автора и дату проведения выставки. Последний столбец назвать Дата.
   Информацию вывести, отсортировав сначала в алфавитном порядке по названиям городов, а потом по убыванию дат проведения выставок. */
SELECT c.name_city, a.name_author, DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND()*365) DAY) AS Дата
FROM city c, author a
ORDER BY name_city, Дата DESC;

/* Вывести информацию о книгах (жанр, книга, автор), относящихся к жанру, включающему слово «роман» в отсортированном по названиям книг виде. */
SELECT g.name_genre, b.title, a.name_author
FROM book b
JOIN author a USING(author_id)
JOIN genre g USING(genre_id)
WHERE g.name_genre = 'Роман'
ORDER BY b.title;
/*
SELECT g.name_genre, b.title, a.name_author
FROM book b
JOIN author a ON b.author_id = a.author_id
JOIN genre g ON b.genre_id = g.genre_id
WHERE g.name_genre = 'Роман'
ORDER BY b.title;
*/

/* Посчитать количество экземпляров  книг каждого автора из таблицы author.  
   Вывести тех авторов,  количество книг которых меньше 10, 
   в отсортированном по возрастанию количества виде. Последний столбец назвать Количество.*/
SELECT a.name_author, SUM(b.amount) AS 'Количество'
FROM book b
RIGHT JOIN author a ON b.author_id = a.author_id
GROUP BY a.name_author
HAVING SUM(b.amount) < 10 OR SUM(b.amount) IS NULL
ORDER BY 'Количество';

/*  Вывести в алфавитном порядке всех авторов, которые пишут только в одном жанре. 
    Поскольку у нас в таблицах так занесены данные, что у каждого автора книги только в одном жанре,  для этого запроса внесем изменения в таблицу book. 
    Пусть у нас  книга Есенина «Черный человек» относится к жанру «Роман», а книга Булгакова «Белая гвардия» к «Приключениям» (эти изменения в таблицы уже внесены).
   +------------------+
   | name_author      |
   +------------------+
   | Достоевский Ф.М. |
   | Пастернак Б.Л.   |
   +------------------+ */
-- 1 variant
SELECT name_author
FROM (SELECT name_author, genre_id
      FROM book
      JOIN author ON book.author_id = author.author_id
      GROUP BY book.author_id, book.genre_id) in_query
GROUP BY name_author
HAVING COUNT(genre_id) = 1
ORDER BY name_author;
-- 2 variant
SELECT name_author FROM author 
WHERE author_id IN(SELECT DISTINCT author_id
				   FROM book
				   GROUP BY author_id
				   HAVING COUNT(DISTINCT genre_id) = 1);

/* Вывести информацию о книгах (название книги, фамилию и инициалы автора, название 
   жанра, цену и количество экземпляров книг), написанных в самых популярных жанрах, 
   в отсортированном в алфавитном порядке по названию книг виде. Самым популярным 
   считать жанр, общее количество экземпляров книг которого на складе максимально.
   +-----------------------+------------------+------------+--------+--------+
   | title                 | name_author      | name_genre | price  | amount |
   +-----------------------+------------------+------------+--------+--------+
   | Белая гвардия         | Булгаков М.А.    | Роман      | 540.50 | 5      |
   | Братья Карамазовы     | Достоевский Ф.М. | Роман      | 799.01 | 3      |
   | Игрок                 | Достоевский Ф.М. | Роман      | 480.50 | 10     |
   | Идиот                 | Достоевский Ф.М. | Роман      | 460.00 | 10     |
   | Лирика                | Пастернак Б.Л.   | Поэзия     | 518.99 | 10     |
   | Мастер и Маргарита    | Булгаков М.А.    | Роман      | 670.99 | 3      |
   | Стихотворения и поэмы | Есенин С.А.      | Поэзия     | 650.00 | 15     |
   | Черный человек        | Есенин С.А.      | Поэзия     | 570.20 | 6      |
   +-----------------------+------------------+------------+--------+--------+ */
-- 1 variant
SELECT title, name_author, name_genre, price, amount
FROM book
JOIN author ON book.author_id = author.author_id
JOIN genre ON book.genre_id = genre.genre_id
WHERE book.genre_id IN (SELECT genre_id FROM 
    (SELECT genre_id, SUM(amount) AS sum_amount
     FROM book
     GROUP BY genre_id) AS query1
WHERE sum_amount = (SELECT MAX(sum_amount)
     FROM
    (SELECT genre_id, SUM(amount) AS sum_amount
     FROM book
     GROUP BY genre_id) AS query2))
ORDER BY title;
-- 2 variant
SELECT title, name_author, name_genre, price, amount
FROM author
INNER JOIN book 
ON author.author_id = book.author_id
INNER JOIN genre 
ON book.genre_id = genre.genre_id
WHERE book.genre_id IN 
    (SELECT genre_id
     FROM book
     GROUP BY genre_id
     HAVING SUM(amount) >= ALL(SELECT SUM(amount) FROM book GROUP BY genre_id)
     )
ORDER BY title;

/* Если в таблицах supply и book есть одинаковые книги, которые имеют равную цену, вывести их название и автора, а также посчитать общее 
   количество экземпляров книг в таблицах supply и book, столбцы назвать Название, Автор и Количество. */
SELECT b.title AS Название, s.author AS Автор, (b.amount + s.amount) AS Количество
FROM book b
JOIN author a USING(author_id)
JOIN supply s ON a.name_author = s.author
WHERE b.title = s.title AND b.price = s.price;

/* Произвольное задание.
Разослать литературу в любое количество городов (не только три). Остаток от деления книг между городами уезжает в Москву.
Для столицы устанавливаются цены на 10% выше первоначальных, с округлением вверх до ближайшего кратного 50 рублям и вычетом одной копейки.
Сортировка по названию города, автору и названию книги (по алфавиту): */
SELECT
    name_city AS Город,
    name_author AS Автор,
    title AS Название,
    name_genre AS Жанр,
    IF(name_city = 'Москва',
       ROUND(CEIL(price * 1.1 / 50) * 50, 2) - 0.01,
       PRICE) AS Цена,
    IF(name_city = 'Москва',
       amount DIV(SELECT COUNT(*) FROM city) + amount % (SELECT COUNT(*) FROM city),
       amount DIV(SELECT COUNT(*) FROM city)) AS Количество
FROM book
JOIN author USING (author_id)
JOIN genre USING (genre_id)
CROSS JOIN city
WHERE IF(name_city = 'Москва',
         amount DIV(SELECT COUNT(*) FROM city) + amount % (SELECT COUNT(*) FROM city),
         amount DIV(SELECT COUNT(*) FROM city)) > 0
ORDER BY Город, Автор, Название;
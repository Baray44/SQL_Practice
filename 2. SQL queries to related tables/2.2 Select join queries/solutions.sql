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

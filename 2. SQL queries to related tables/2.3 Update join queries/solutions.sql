/* Для книг, которые уже есть на складе (в таблице book), но по другой цене, чем в поставке (supply),  
   необходимо в таблице book увеличить количество на значение, указанное в поставке,  и пересчитать цену. 
   А в таблице  supply обнулить количество этих книг. Формула для пересчета цены:
   
   price= (book_price * book_amount + supply_price * supply_amount) \ (book_amount + supply_amount) */
UPDATE book b
JOIN author a ON a.author_id = b.author_id
JOIN supply s ON a.name_author = s.author AND b.title = s.title

SET b.amount = b.amount + s.amount,
    s.amount = 0,
    b.price = (b.price * b.amount + s.price * s.amount) / (b.amount + s.amount)
WHERE b.price <> s.price;

/* Включить новых авторов в таблицу author с помощью запроса на добавление, а затем вывести все данные из таблицы author.  
   Новыми считаются авторы, которые есть в таблице supply, но нет в таблице author. */
-- 1 variant
INSERT INTO author (name_author)
SELECT s.author
FROM author a
RIGHT JOIN supply s ON a.name_author = s.author
WHERE a.name_author IS NULL;
-- 2 variant
INSERT INTO author (name_author)
SELECT author
FROM supply
WHERE author NOT IN (SELECT name_author FROM author);

/* Добавить новые книги из таблицы supply в таблицу book. Затем вывести для просмотра таблицу book.
См. запросы в лекциях. */
INSERT INTO book(title, author_id, price, amount)
SELECT title, author_id, price, amount
FROM author a
JOIN supply s ON a.name_author = s.author
WHERE s.amount <> 0;

/*  Занести для книги «Стихотворения и поэмы» Лермонтова жанр «Поэзия», а для книги «Остров сокровищ» Стивенсона - «Приключения».
	(Использовать два запроса). */
UPDATE book
SET genre_id = 
    (
     SELECT genre_id
     FROM genre
     WHERE name_genre = 'Поэзия'
    )
WHERE title = 'Стихотворения и поэмы';

UPDATE book
SET genre_id = 
    (
     SELECT genre_id
     FROM genre
     WHERE name_genre = 'Приключения'
    )
WHERE title = 'Остров сокровищ';

/* Удалить всех авторов и все их книги, общее количество книг которых меньше 20. */
DELETE FROM author
WHERE author_id IN (
    SELECT author_id
    FROM book
    GROUP BY author_id
    HAVING SUM(amount) < 20
    );
    
/*  Удалить все жанры, к которым относится меньше 4-х книг. В таблице book для этих жанров установить значение Null. */
DELETE FROM genre
WHERE genre_id IN (
    SELECT genre_id
    FROM book
    GROUP BY genre_id
    HAVING COUNT(title) < 4
    );
/*  Удалить все жанры, к которым относится меньше 4-х книг. 
    В таблице book для этих жанров установить значение Null. */
-- 1 variant    
DELETE FROM author
USING author
JOIN book b ON author.author_id = b.author_id
JOIN genre g ON b.genre_id = g.genre_id
WHERE g.name_genre = 'Поэзия';
-- 2 variant
DELETE FROM author 
USING author JOIN book USING(author_id)
             JOIN genre USING(genre_id)
WHERE name_genre='Поэзия';

/* Произвольное задание.
Нас взломали хакеры. В жанр добавлена новая запись "Страшилки". Теперь этот жанр присвоен всем книгам Достоевского и Булгакова,
книги писателей в таблице supply увеличены на 100 единиц у каждого из указанных авторов. Задание - замоделировать такие изменения в базу данных. */
SELECT * FROM genre;
INSERT INTO genre (name_genre) VALUES ('Страшилка');
SELECT * FROM genre;
SELECT * FROM book;

UPDATE book
SET genre_id = (
    SELECT genre_id
    FROM genre
    WHERE name_genre = 'Страшилка')
WHERE author_id IN (
    SELECT author_id
    FROM author
    WHERE name_author IN ('Достоевский Ф.М.', 'Булгаков М.А.'));
    
SELECT * FROM book;
SELECT * FROM supply;

UPDATE supply
SET amount = supply.amount + 100
WHERE author IN ('Достоевский Ф.М.', 'Булгаков М.А.');

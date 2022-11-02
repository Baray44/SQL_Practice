/* Вывести информацию (автора, название и цену) о  книгах, цены которых меньше или равны 
   средней цене книг на складе. Информацию вывести в отсортированном по убыванию цены виде. 
   Среднее вычислить как среднее по цене книги. */
SELECT author, title, price
FROM book
WHERE price <= (
    SELECT AVG(price)
    FROM book
    )
ORDER BY price DESC;

/* Вывести информацию (автора, название и цену) о тех книгах, цены которых превышают минимальную 
   цену книги на складе не более чем на 150 рублей в отсортированном по возрастанию цены виде. */
SELECT author, title, price
FROM book
WHERE (price - (SELECT MIN(price) FROM book)) <= 150.00
ORDER BY price;

/* Вывести информацию (автора, книгу и количество) о тех книгах, 
   количество экземпляров которых в таблице book не дублируется. */
SELECT author, title, amount
FROM book
WHERE amount IN (
    SELECT amount
    FROM book
    GROUP BY amount
    HAVING COUNT(amount) = 1 );

SELECT author, title, amount
FROM book AS b1
WHERE ( 
    SELECT COUNT(amount)
    FROM book AS b2
    WHERE b2.amount = b1.amount ) = 1;

/* Вывести информацию о книгах(автор, название, цена), цена которых меньше 
   самой большой из минимальных цен, вычисленных для каждого автора. */
SELECT author, title, price
FROM book
WHERE price < ANY (
    SELECT MIN(price)
    FROM book
    GROUP BY author
    );
    
/* Посчитать сколько и каких экземпляров книг нужно заказать поставщикам, чтобы на складе стало 
   одинаковое количество экземпляров каждой книги, равное значению самого большего количества экземпляров 
   одной книги на складе. Вывести название книги, ее автора, текущее количество экземпляров на складе 
   и количество заказываемых экземпляров книг. Последнему столбцу присвоить имя Заказ. */
-- 1 variant 
SELECT title, author, amount,
    ((SELECT MAX(amount) FROM book) - amount) AS 'Заказ'
FROM book
WHERE ((SELECT MAX(amount) FROM book) - amount) <> 0;

-- 2 variant 
   WITH cte AS (SELECT MAX(amount) max_count FROM book)
SELECT
  title, author, amount, 
  cte.max_count - amount  AS 'Заказ'
FROM
  cte,
  book
WHERE cte.max_count - amount > 0;

-- Придумайте один или несколько запросов к нашей таблице book, используя вложенные запросы. 
INSERT INTO book(title, author, price, amount) 
     VALUES ('Записки для чайникофф', 'Дроздов Никита', 310.00, 8);

SELECT title, author, price, amount
FROM book
WHERE author IN (SELECT author
                 FROM book
                 GROUP BY author
                 HAVING COUNT(amount) - COUNT(DISTINCT amount) = 0
                 )
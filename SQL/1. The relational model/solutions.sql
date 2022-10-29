/* Task_1 MySQL 
CREATE TABLE book(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title   VARCHAR(50),
    author  VARCHAR(30),
    price   DECIMAL(8, 2),
    amount  INT
);
*/

/* Task_1 Postgres */
CREATE TABLE book(
    book_id SERIAL PRIMARY KEY,
    title   VARCHAR(50),
    author  VARCHAR(30),
    price   DECIMAL(8, 2),
    amount  INT
);

/* Task_2 */
INSERT INTO book(title, author, price, amount) 
VALUES ("Мастер и Маргарита", "Булгаков М.А.", 670.99, 3);

/* Task_3 */
INSERT INTO book(title, author, price, amount)
VALUES ("Белая гвардия", "Булгаков М.А.", 540.50, 5),
       ("Идиот", "Достоевский Ф.М.", 460.00, 10),
       ("Братья Карамазовы", "Достоевский Ф.М.", 799.01, 2)
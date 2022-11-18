DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS author;

CREATE TABLE genre(
    genre_id   SERIAL PRIMARY KEY,
    name_genre VARCHAR(30)
);

CREATE TABLE author(
    author_id   SERIAL PRIMARY KEY,
    name_author VARCHAR(50)
);

CREATE TABLE book (
    book_id   SERIAL PRIMARY KEY, 
    title     VARCHAR(50), 
    author_id INT NOT NULL, 
    genre_id  INT,
    price     DECIMAL(8,2), 
    amount    INT, 
    FOREIGN KEY (author_id)  REFERENCES author (author_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id)   REFERENCES genre  (genre_id)  ON DELETE SET NULL
);

INSERT INTO author (name_author)
VALUES ('Булгаков М.А.'),
       ('Достоевский Ф.М.'),
       ('Есенин С.А.'),
       ('Пастернак Б.Л.');

INSERT INTO genre (name_genre)
VALUES ('Роман'),
       ('Поэзия');

INSERT INTO book(title, author_id, genre_id, price, amount) 
VALUES ('Мастер и Маргарита',    1,  1,  670.99,   3),
       ('Белая гвардия',         1,  1,  540.50,   5),
       ('Идиот',                 2,  1,  460.00,  10),
       ('Братья Карамазовы',     2,  1,  799.01,   3),
       ('Игрок',                 2,  1,  480.50,  10);
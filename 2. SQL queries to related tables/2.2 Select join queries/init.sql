DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS author;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS supply;

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

CREATE TABLE city(
    city_id   SERIAL PRIMARY KEY,
    name_city VARCHAR(50)
);

CREATE TABLE supply(
    supply_id SERIAL PRIMARY KEY,
    title     VARCHAR(50),
    author    VARCHAR(50),
    price     DECIMAL(8, 2),
    amount    INT
);

INSERT INTO author (name_author)
VALUES ('Булгаков М.А.'),
       ('Достоевский Ф.М.'),
       ('Есенин С.А.'),
       ('Пастернак Б.Л.'),
       ('Лермонтов М.Ю.');

INSERT INTO genre (name_genre)
VALUES ('Роман'),
       ('Поэзия'),
       ('Приключения');

INSERT INTO book(title, author_id, genre_id, price, amount) 
VALUES ('Мастер и Маргарита',    1,  1,  670.99,   3),
       ('Белая гвардия',         1,  1,  540.50,   5),
       ('Идиот',                 2,  1,  460.00,  10),
       ('Братья Карамазовы',     2,  1,  799.01,   3),
       ('Игрок',                 2,  1,  480.50,  10),
       ('Стихотворения и поэмы', 3,  2,  650.00,  15),
       ('Черный человек',        3,  2,  570.20,   6),
       ('Лирика',                4,  2,  518.99,   2);

INSERT INTO city(name_city)
VALUES ('Москва'),
       ('Санкт-Петербург'),
       ('Владивосток');

INSERT INTO supply(title, author, price, amount)
VALUES ('Доктор Живаго',  'Пастернак Б.Л',    618.99, 3),
       ('Черный человек', 'Есенин С.А.',      570.20, 6),
       ('Евгений Онегин', 'Пушкин А.С.',      440.80, 5),
       ('Идиот',          'Достоевский Ф.М.', 360.80, 3);
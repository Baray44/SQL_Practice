/*Создаем схему*/
DROP SCHEMA IF EXISTS stepik CASCADE;
CREATE SCHEMA IF NOT EXISTS stepik;

---AUTHOR
DROP TABLE IF EXISTS stepik.author CASCADE;
CREATE TABLE IF NOT EXISTS stepik.author (
		author_id   BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
		name_author TEXT
);

INSERT INTO stepik.author(name_author)
VALUES ('Булгаков М.А.'),
       ('Достоевский Ф.М.'),
       ('Есенин С.А.'),
       ('Пастернак Б.Л.'),
       ('Лермонтов М.Ю.');

---GENRE
DROP TABLE IF EXISTS stepik.genre CASCADE;
CREATE TABLE IF NOT EXISTS stepik.genre (
		genre_id   BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
		name_genre TEXT
);

INSERT INTO stepik.genre(name_genre)
VALUES ('Роман'),
       ('Поэзия'),
       ('Приключения');

---BOOK
DROP TABLE IF EXISTS stepik.book CASCADE;
CREATE TABLE IF NOT EXISTS stepik.book (
		book_id   BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
		title     TEXT,
		author_id BIGINT NOT NULL,
		genre_id  BIGINT,
		price     DECIMAL(8, 2),
		amount    INT,
		CONSTRAINT "FK_book_author"
				FOREIGN KEY (author_id) REFERENCES stepik.author (author_id) ON DELETE CASCADE,
		CONSTRAINT "FK_book_genre"
				FOREIGN KEY (genre_id) REFERENCES stepik.genre (genre_id) ON DELETE SET NULL
);

INSERT INTO stepik.book(title, author_id, genre_id, price, amount)
VALUES ('Мастер и Маргарита',    1, 1, 670.99, 3),
       ('Белая гвардия',         1, 1, 540.50, 5),
       ('Идиот',                 2, 1, 460.00, 10),
       ('Братья Карамазовы',     2, 1, 799.01, 2),
       ('Игрок',                 2, 1, 480.50, 10),
       ('Стихотворения и поэмы', 3, 2, 650.00, 15),
       ('Черный человек',        3, 2, 570.20, 6),
       ('Лирика',                4, 2, 518.99, 2);

---CITY
DROP TABLE IF EXISTS stepik.city CASCADE;
CREATE TABLE IF NOT EXISTS stepik.city (
		city_id       BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
		name_city     TEXT,
		days_delivery INT
);

INSERT INTO stepik.city(name_city, days_delivery)
VALUES ('Москва',           5),
       ('Санкт-Петербург',  3),
       ('Владивосток',     12);

---CLIENT
CREATE EXTENSION IF NOT EXISTS citext;
DROP DOMAIN IF EXISTS email;
CREATE DOMAIN email AS citext
		CHECK ( value ~
		        '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' );

DROP TABLE IF EXISTS stepik.client CASCADE;
CREATE TABLE IF NOT EXISTS stepik.client
(
		client_id   BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
		name_client TEXT,
		city_id     BIGINT,
		email       email,
		CONSTRAINT "FK_client_city"
				FOREIGN KEY (city_id) REFERENCES stepik.city (city_id)
);

INSERT INTO stepik.client(name_client, city_id, email)
VALUES ('Баранов Павел',   3, 'baranov@test'),
       ('Абрамова Катя',   1, 'abramova@test'),
       ('Семенонов Иван',  2, 'semenov@test'),
       ('Яковлева Галина', 1, 'yakovleva@test');

---BUY
DROP TABLE IF EXISTS stepik.buy CASCADE;
CREATE TABLE IF NOT EXISTS stepik.buy
(
		buy_id          BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
		buy_description TEXT,
		client_id       BIGINT DEFAULT (NULL),
		CONSTRAINT "FK_buy_client"
				FOREIGN KEY (client_id) REFERENCES stepik.client (client_id)
);

INSERT INTO stepik.buy (buy_description, client_id)
VALUES ('Доставка только вечером', 1),
       (NULL, 3),
       ('Упаковать каждую книгу по отдельности', 2),
       (NULL, 1);


---BUY_BOOK
DROP TABLE IF EXISTS stepik.buy_book CASCADE;
CREATE TABLE IF NOT EXISTS stepik.buy_book (
		buy_book_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
		buy_id      BIGINT,
		book_id     BIGINT,
		amount      INT,
		CONSTRAINT "FK_buy_book_buy"
				FOREIGN KEY (buy_id) REFERENCES stepik.buy (buy_id),
		CONSTRAINT "FK_buy_book_book"
				FOREIGN KEY (book_id) REFERENCES stepik.book (book_id)
);

INSERT INTO stepik.buy_book(buy_id, book_id, amount)
VALUES (1, 1, 1),
       (1, 7, 2),
       (2, 8, 2),
       (3, 3, 2),
       (3, 2, 1),
       (3, 1, 1),
       (4, 5, 1);


---STEP
DROP TABLE IF EXISTS stepik.step CASCADE;
CREATE TABLE IF NOT EXISTS stepik.step (
		step_id   BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
		name_step TEXT
);

INSERT INTO stepik.step(name_step)
VALUES ('Оплата'),
       ('Упаковка'),
       ('Транспортировка'),
       ('Доставка');

---BUY_STEP
DROP TABLE IF EXISTS stepik.buy_step CASCADE;
CREATE TABLE IF NOT EXISTS stepik.buy_step (
		buy_step_id   BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
		buy_id        INT,
		step_id       INT,
		date_step_beg DATE,
		date_step_end DATE,
		CONSTRAINT "FK_buy_step_buy"
				FOREIGN KEY (buy_id) REFERENCES stepik.buy (buy_id),
		CONSTRAINT "FK_buy_step_step"
				FOREIGN KEY (step_id) REFERENCES stepik.step (step_id)
);

INSERT INTO stepik.buy_step(buy_id, step_id, date_step_beg, date_step_end)
VALUES (1, 1, '2020-02-20', '2020-02-20'),
       (1, 2, '2020-02-20', '2020-02-21'),
       (1, 3, '2020-02-22', '2020-03-07'),
       (1, 4, '2020-03-08', '2020-03-08'),
       (2, 1, '2020-02-28', '2020-02-28'),
       (2, 2, '2020-02-29', '2020-03-01'),
       (2, 3, '2020-03-02', NULL),
       (2, 4, NULL, NULL),
       (3, 1, '2020-03-05', '2020-03-05'),
       (3, 2, '2020-03-05', '2020-03-06'),
       (3, 3, '2020-03-06', '2020-03-10'),
       (3, 4, '2020-03-11', NULL),
       (4, 1, '2020-03-20', NULL),
       (4, 2, NULL, NULL),
       (4, 3, NULL, NULL),
       (4, 4, NULL, NULL);

---BUY_ARCHIVE
DROP TABLE IF EXISTS stepik.buy_archive CASCADE;
CREATE TABLE IF NOT EXISTS stepik.buy_archive (
		buy_archive_id   BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
		buy_id           INT,
		client_id        INT,
		book_id          INT,
		date_payment     DATE,
		price            DECIMAL,
		amount           INT,
		CONSTRAINT "FK_buy_archive_client"
		        FOREIGN KEY (client_id) REFERENCES stepik.client (client_id),
		CONSTRAINT "FK_buy_archive_book"
				FOREIGN KEY (book_id)   REFERENCES stepik.book   (book_id)
);

INSERT INTO stepik.buy_archive(buy_id, client_id, book_id, date_payment, price, amount)
VALUES (2, 1, 1, '2019-02-21', 670.60, 2),
       (2, 1, 3, '2019-02-21', 450.90, 1),
       (1, 2, 2, '2019-02-10', 520.30, 2),
       (1, 2, 4, '2019-02-10', 780.90, 3),
       (1, 2, 3, '2019-02-10', 450.90, 1),
       (3, 4, 4, '2019-03-05', 780.90, 4),
       (3, 4, 5, '2019-03-05', 480.90, 2),
       (4, 1, 6, '2019-03-12', 650.00, 1),
       (5, 2, 1, '2020-03-18', 670.60, 2),
       (5, 2, 4, '2020-03-18', 780.90, 1);
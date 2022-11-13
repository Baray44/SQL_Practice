/* Создать таблицу author следующей структуры:
   author_id INT PRIMARY KEY AUTO_INCREMENT
   name_author VARCHAR(50) */
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author	VARCHAR(50)
    );
    
/* Заполнить таблицу author. В нее включить следующих авторов:
   Булгаков М.А.
   Достоевский Ф.М.
   Есенин С.А.
   Пастернак Б.Л. */
INSERT INTO author (name_author)
VALUES ('Булгаков М.А.'),
       ('Достоевский Ф.М.'),
       ('Есенин С.А.'),
       ('Пастернак Б.Л.');
      
/* Перепишите запрос на создание таблицы book , чтобы ее структура соответствовала структуре, 
   показанной на логической схеме (таблица genre уже создана, порядок следования столбцов - 
   как на логической схеме в таблице book, genre_id  - внешний ключ) . Для genre_id ограничение 
   о недопустимости пустых значений не задавать. В качестве главной таблицы для описания поля 
   genre_id использовать таблицу genre. */      
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author_id INT NOT NULL,
    genre_id INT,
    price DECIMAL(8,2),
    amount INT,
    FOREIGN KEY (author_id) REFERENCES author (author_id),
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id)
);
    
/* Перепишите запрос на создание таблицы book , чтобы ее структура соответствовала структуре, 
   показанной на логической схеме (таблица genre уже создана, порядок следования столбцов - 
   как на логической схеме в таблице book, genre_id  - внешний ключ) . Для genre_id ограничение 
   о недопустимости пустых значений не задавать. В качестве главной таблицы для описания поля 
   genre_id использовать таблицу genre. */
CREATE TABLE book (
    book_id   INT PRIMARY KEY AUTO_INCREMENT, 
    title     VARCHAR(50), 
    author_id INT NOT NULL, 
    genre_id  INT,
    price     DECIMAL(8,2), 
    amount    INT, 
    FOREIGN KEY (author_id)  REFERENCES author (author_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id)   REFERENCES genre  (genre_id)  ON DELETE SET NULL
);

/* Перепишите запрос на создание таблицы book , чтобы ее структура соответствовала структуре, 
   показанной на логической схеме (таблица genre уже создана, порядок следования столбцов - 
   как на логической схеме в таблице book, genre_id  - внешний ключ) . Для genre_id ограничение 
   о недопустимости пустых значений не задавать. В качестве главной таблицы для описания поля 
   genre_id использовать таблицу genre. */
INSERT INTO book(title, author_id, genre_id, price, amount)
VALUES ('Стихотворения и поэмы',3,2,650.00,15),
       ('Черный человек',3,2,570.20,6),
       ('Лирика',4,2,518.99,2);
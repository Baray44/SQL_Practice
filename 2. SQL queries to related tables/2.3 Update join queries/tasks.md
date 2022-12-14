### Задание 1.
Для книг, которые уже есть на складе (в таблице book), но по другой цене, чем в поставке (supply),  необходимо в таблице book увеличить количество на значение, указанное в поставке,  и пересчитать цену. А в таблице  supply обнулить количество этих книг. Формула для пересчета цены:
```
    price = (book_price * book_amount + supply_price * supply_amount) \ (book_amount + supply_amount)
```

Результат:
```
Affected rows: 2

Query result:
+---------+-----------------------+-----------+----------+--------+--------+
| book_id | title                 | author_id | genre_id | price  | amount |
+---------+-----------------------+-----------+----------+--------+--------+
| 1       | Мастер и Маргарита    | 1         | 1        | 670.99 | 3      |
| 2       | Белая гвардия         | 1         | 1        | 540.50 | 5      |
| 3       | Идиот                 | 2         | 1        | 437.11 | 13     |
| 4       | Братья Карамазовы     | 2         | 1        | 799.01 | 3      |
| 5       | Игрок                 | 2         | 1        | 480.50 | 10     |
| 6       | Стихотворения и поэмы | 3         | 2        | 650.00 | 15     |
| 7       | Черный человек        | 3         | 2        | 570.20 | 6      |
| 8       | Лирика                | 4         | 2        | 518.99 | 2      |
+---------+-----------------------+-----------+----------+--------+--------+
Affected rows: 8

Query result:
+-----------+-----------------------+------------------+--------+--------+
| supply_id | title                 | author           | price  | amount |
+-----------+-----------------------+------------------+--------+--------+
| 1         | Доктор Живаго         | Пастернак Б.Л.   | 380.80 | 4      |
| 2         | Черный человек        | Есенин С.А.      | 570.20 | 6      |
| 3         | Белая гвардия         | Булгаков М.А.    | 540.50 | 7      |
| 4         | Идиот                 | Достоевский Ф.М. | 360.80 | 0      |
| 5         | Стихотворения и поэмы | Лермонтов М.Ю.   | 255.90 | 4      |
| 6         | Остров сокровищ       | Стивенсон Р.Л.   | 599.99 | 5      |
+-----------+-----------------------+------------------+--------+--------+
Affected rows: 6
```

### Задание 2. 
Включить новых авторов в таблицу author с помощью запроса на добавление, а затем вывести все данные из таблицы author.  Новыми считаются авторы, которые есть в таблице supply, но нет в таблице author.

Результат:
```
Affected rows: 1

Query result:
+-----------+------------------+
| author_id | name_author      |
+-----------+------------------+
| 1         | Булгаков М.А.    |
| 2         | Достоевский Ф.М. |
| 3         | Есенин С.А.      |
| 4         | Пастернак Б.Л.   |
| 5         | Лермонтов М.Ю.   |
| 6         | Стивенсон Р.Л.   |
+-----------+------------------+
```

Структура и наполнение таблиц:
```
Таблица book
+---------+-----------------------+-----------+----------+--------+--------+
| book_id | title                 | author_id | genre_id | price  | amount |
+---------+-----------------------+-----------+----------+--------+--------+
| 1       | Мастер и Маргарита    | 1         | 1        | 670.99 | 3      |
| 2       | Белая гвардия         | 1         | 1        | 540.50 | 12     |
| 3       | Идиот                 | 2         | 1        | 460.00 | 10     |
| 4       | Братья Карамазовы     | 2         | 1        | 799.01 | 3      |
| 5       | Игрок                 | 2         | 1        | 480.50 | 10     |
| 6       | Стихотворения и поэмы | 3         | 2        | 650.00 | 15     |
| 7       | Черный человек        | 3         | 2        | 570.20 | 6      |
| 8       | Лирика                | 4         | 2        | 518.99 | 2      |
+---------+-----------------------+-----------+----------+--------+--------+
Таблица supply
+-----------+-----------------------+------------------+--------+--------+
| supply_id | title                 | author           | price  | amount |
+-----------+-----------------------+------------------+--------+--------+
| 1         | Доктор Живаго         | Пастернак Б.Л.   | 380.80 | 4      |
| 2         | Черный человек        | Есенин С.А.      | 570.20 | 12     |
| 3         | Белая гвардия         | Булгаков М.А.    | 540.50 | 7      |
| 4         | Идиот                 | Достоевский Ф.М. | 360.80 | 3      |
| 5         | Стихотворения и поэмы | Лермонтов М.Ю.   | 255.90 | 4      |
| 6         | Остров сокровищ       | Стивенсон Р.Л.   | 599.99 | 5      |
+-----------+-----------------------+------------------+--------+--------+
Таблица author                          Таблица genre
+-----------+------------------+    +----------+-------------+          
| author_id | name_author      |    | genre_id | name_genre  |          
+-----------+------------------+    +----------+-------------+          
| 1         | Булгаков М.А.    |    | 1        | Роман       |          
| 2         | Достоевский Ф.М. |    | 2        | Поэзия      |          
| 3         | Есенин С.А.      |    | 3        | Приключения |          
| 4         | Пастернак Б.Л.   |    +----------+-------------+          
| 5         | Лермонтов М.Ю.   |                            
+-----------+------------------+
```

### Задание 3.
Добавить новые книги из таблицы supply в таблицу book на основе сформированного выше запроса. Затем вывести для просмотра таблицу book.

Результат:
```
Affected rows: 3

Query result:
+---------+-----------------------+-----------+----------+--------+--------+
| book_id | title                 | author_id | genre_id | price  | amount |
+---------+-----------------------+-----------+----------+--------+--------+
| 1       | Мастер и Маргарита    | 1         | 1        | 670.99 | 3      |
| 2       | Белая гвардия         | 1         | 1        | 540.50 | 12     |
| 3       | Идиот                 | 2         | 1        | 437.11 | 13     |
| 4       | Братья Карамазовы     | 2         | 1        | 799.01 | 3      |
| 5       | Игрок                 | 2         | 1        | 480.50 | 10     |
| 6       | Стихотворения и поэмы | 3         | 2        | 650.00 | 15     |
| 7       | Черный человек        | 3         | 2        | 570.20 | 12     |
| 8       | Лирика                | 4         | 2        | 518.99 | 2      |
| 9       | Доктор Живаго         | 4         | None     | 380.80 | 4      |
| 10      | Стихотворения и поэмы | 5         | None     | 255.90 | 4      |
| 11      | Остров сокровищ       | 6         | None     | 599.99 | 5      |
+---------+-----------------------+-----------+----------+--------+--------+
```
Структура и наполнение таблиц
```
Таблица book
+---------+-----------------------+-----------+----------+--------+--------+
| book_id | title                 | author_id | genre_id | price  | amount |
+---------+-----------------------+-----------+----------+--------+--------+
| 1       | Мастер и Маргарита    | 1         | 1        | 670.99 | 3      |
| 2       | Белая гвардия         | 1         | 1        | 540.50 | 12     |
| 3       | Идиот                 | 2         | 1        | 437.11 | 13     |
| 4       | Братья Карамазовы     | 2         | 1        | 799.01 | 3      |
| 5       | Игрок                 | 2         | 1        | 480.50 | 10     |
| 6       | Стихотворения и поэмы | 3         | 2        | 650.00 | 15     |
| 7       | Черный человек        | 3         | 2        | 570.20 | 12     |
| 8       | Лирика                | 4         | 2        | 518.99 | 2      |
+---------+-----------------------+-----------+----------+--------+--------+
Таблица supply
+-----------+-----------------------+------------------+--------+--------+
| supply_id | title                 | author           | price  | amount |
+-----------+-----------------------+------------------+--------+--------+
| 1         | Доктор Живаго         | Пастернак Б.Л.   | 380.80 | 4      |
| 2         | Черный человек        | Есенин С.А.      | 570.20 | 0      |
| 3         | Белая гвардия         | Булгаков М.А.    | 540.50 | 0      |
| 4         | Идиот                 | Достоевский Ф.М. | 360.80 | 0      |
| 5         | Стихотворения и поэмы | Лермонтов М.Ю.   | 255.90 | 4      |
| 6         | Остров сокровищ       | Стивенсон Р.Л.   | 599.99 | 5      |
+-----------+-----------------------+------------------+--------+--------+
Таблица author                          Таблица genre
+-----------+------------------+    +----------+-------------+          
| author_id | name_author      |    | genre_id | name_genre  |          
+-----------+------------------+    +----------+-------------+          
| 1         | Булгаков М.А.    |    | 1        | Роман       |          
| 2         | Достоевский Ф.М. |    | 2        | Поэзия      |          
| 3         | Есенин С.А.      |    | 3        | Приключения |          
| 4         | Пастернак Б.Л.   |    +----------+-------------+          
| 5         | Лермонтов М.Ю.   |
| 6         | Стивенсон Р.Л.   |
+-----------+------------------+
```

### Задание 4. 
Занести для книги «Стихотворения и поэмы» Лермонтова жанр «Поэзия», а для книги «Остров сокровищ» Стивенсона - «Приключения». (Использовать два запроса).

Результат:
```
Affected rows: 2

Query result:
+---------+-----------------------+-----------+----------+--------+--------+
| book_id | title                 | author_id | genre_id | price  | amount |
+---------+-----------------------+-----------+----------+--------+--------+
| 1       | Мастер и Маргарита    | 1         | 1        | 670.99 | 3      |
| 2       | Белая гвардия         | 1         | 1        | 540.50 | 12     |
| 3       | Идиот                 | 2         | 1        | 437.11 | 13     |
| 4       | Братья Карамазовы     | 2         | 1        | 799.01 | 3      |
| 5       | Игрок                 | 2         | 1        | 480.50 | 10     |
| 6       | Стихотворения и поэмы | 3         | 2        | 650.00 | 15     |
| 7       | Черный человек        | 3         | 2        | 570.20 | 12     |
| 8       | Лирика                | 4         | 2        | 518.99 | 2      |
| 9       | Доктор Живаго         | 4         | 1        | 380.80 | 4      |
| 10      | Стихотворения и поэмы | 5         | 2        | 255.90 | 4      |
| 11      | Остров сокровищ       | 6         | 3        | 599.99 | 5      |
+---------+-----------------------+-----------+----------+--------+--------+
```

Структура и наполнение таблиц
```
Таблица book
+---------+-----------------------+-----------+----------+--------+--------+
| book_id | title                 | author_id | genre_id | price  | amount |
+---------+-----------------------+-----------+----------+--------+--------+
| 1       | Мастер и Маргарита    | 1         | 1        | 670.99 | 3      |
| 2       | Белая гвардия         | 1         | 1        | 540.50 | 12     |
| 3       | Идиот                 | 2         | 1        | 437.11 | 13     |
| 4       | Братья Карамазовы     | 2         | 1        | 799.01 | 3      |
| 5       | Игрок                 | 2         | 1        | 480.50 | 10     |
| 6       | Стихотворения и поэмы | 3         | 2        | 650.00 | 15     |
| 7       | Черный человек        | 3         | 2        | 570.20 | 12     |
| 8       | Лирика                | 4         | 2        | 518.99 | 2      |
| 9       | Доктор Живаго         | 4         | 1        | 380.80 | 4      |
| 10      | Стихотворения и поэмы | 5         | Null     | 255.90 | 4      |
| 11      | Остров сокровищ       | 6         | Null     | 599.99 | 5      |
+---------+-----------------------+-----------+----------+--------+--------+

Таблица author                          Таблица genre
+-----------+------------------+    +----------+-------------+          
| author_id | name_author      |    | genre_id | name_genre  |          
+-----------+------------------+    +----------+-------------+          
| 1         | Булгаков М.А.    |    | 1        | Роман       |          
| 2         | Достоевский Ф.М. |    | 2        | Поэзия      |          
| 3         | Есенин С.А.      |    | 3        | Приключения |          
| 4         | Пастернак Б.Л.   |    +----------+-------------+          
| 5         | Лермонтов М.Ю.   |
| 6         | Стивенсон Р.Л.   |
+-----------+------------------+
```

### Задание 5. 
Удалить всех авторов и все их книги, общее количество книг которых меньше 20.

Структура и наполнение таблиц:
```
Таблица book
+---------+-----------------------+-----------+----------+--------+--------+
| book_id | title                 | author_id | genre_id | price  | amount |
+---------+-----------------------+-----------+----------+--------+--------+
| 1       | Мастер и Маргарита    | 1         | 1        | 670.99 | 3      |
| 2       | Белая гвардия         | 1         | 1        | 540.50 | 12     |
| 3       | Идиот                 | 2         | 1        | 437.11 | 13     |
| 4       | Братья Карамазовы     | 2         | 1        | 799.01 | 3      |
| 5       | Игрок                 | 2         | 1        | 480.50 | 10     |
| 6       | Стихотворения и поэмы | 3         | 2        | 650.00 | 15     |
| 7       | Черный человек        | 3         | 2        | 570.20 | 12     |
| 8       | Лирика                | 4         | 2        | 518.99 | 2      |
| 9       | Доктор Живаго         | 4         | 1        | 380.80 | 4      |
| 10      | Стихотворения и поэмы | 5         | 2        | 255.90 | 4      |
| 11      | Остров сокровищ       | 6         | 3        | 599.99 | 5      |
+---------+-----------------------+-----------+----------+--------+--------+
Таблица supply
+-----------+-----------------------+------------------+--------+--------+
| supply_id | title                 | author           | price  | amount |
+-----------+-----------------------+------------------+--------+--------+
| 1         | Доктор Живаго         | Пастернак Б.Л.   | 380.80 | 4      |
| 2         | Черный человек        | Есенин С.А.      | 570.20 | 6      |
| 3         | Белая гвардия         | Булгаков М.А.    | 540.50 | 7      |
| 4         | Идиот                 | Достоевский Ф.М. | 360.80 | 3      |
| 5         | Стихотворения и поэмы | Лермонтов М.Ю.   | 255.90 | 4      |
| 6         | Остров сокровищ       | Стивенсон Р.Л.   | 599.99 | 5      |
+-----------+-----------------------+------------------+--------+--------+
Таблица author                          Таблица genre
+-----------+------------------+    +----------+-------------+          
| author_id | name_author      |    | genre_id | name_genre  |          
+-----------+------------------+    +----------+-------------+          
| 1         | Булгаков М.А.    |    | 1        | Роман       |          
| 2         | Достоевский Ф.М. |    | 2        | Поэзия      |          
| 3         | Есенин С.А.      |    | 3        | Приключения |          
| 4         | Пастернак Б.Л.   |    +----------+-------------+          
| 5         | Лермонтов М.Ю.   |
| 6         | Стивенсон Р.Л.   |
+-----------+------------------+
```

Результат:
```
Affected rows: 4

Query result:
+-----------+------------------+
| author_id | name_author      |
+-----------+------------------+
| 2         | Достоевский Ф.М. |
| 3         | Есенин С.А.      |
+-----------+------------------+
Affected rows: 2

Query result:
+---------+-----------------------+-----------+----------+--------+--------+
| book_id | title                 | author_id | genre_id | price  | amount |
+---------+-----------------------+-----------+----------+--------+--------+
| 3       | Идиот                 | 2         | 1        | 437.11 | 13     |
| 4       | Братья Карамазовы     | 2         | 1        | 799.01 | 3      |
| 5       | Игрок                 | 2         | 1        | 480.50 | 10     |
| 6       | Стихотворения и поэмы | 3         | 2        | 650.00 | 15     |
| 7       | Черный человек        | 3         | 2        | 570.20 | 12     |
+---------+-----------------------+-----------+----------+--------+--------+
Affected rows: 5
```

### Задание 6. 
Удалить все жанры, к которым относится меньше 4-х книг. В таблице book для этих жанров установить значение Null.

Структура и наполнение таблиц
```
Таблица book
+---------+-----------------------+-----------+----------+--------+--------+
| book_id | title                 | author_id | genre_id | price  | amount |
+---------+-----------------------+-----------+----------+--------+--------+
| 1       | Мастер и Маргарита    | 1         | 1        | 670.99 | 3      |
| 2       | Белая гвардия         | 1         | 1        | 540.50 | 12     |
| 3       | Идиот                 | 2         | 1        | 437.11 | 13     |
| 4       | Братья Карамазовы     | 2         | 1        | 799.01 | 3      |
| 5       | Игрок                 | 2         | 1        | 480.50 | 10     |
| 6       | Стихотворения и поэмы | 3         | 2        | 650.00 | 15     |
| 7       | Черный человек        | 3         | 2        | 570.20 | 12     |
| 8       | Лирика                | 4         | 2        | 518.99 | 2      |
| 9       | Доктор Живаго         | 4         | 1        | 380.80 | 4      |
| 10      | Стихотворения и поэмы | 5         | 2        | 255.90 | 4      |
| 11      | Остров сокровищ       | 6         | 3        | 599.99 | 5      |
+---------+-----------------------+-----------+----------+--------+--------+
Таблица supply
+-----------+-----------------------+------------------+--------+--------+
| supply_id | title                 | author           | price  | amount |
+-----------+-----------------------+------------------+--------+--------+
| 1         | Доктор Живаго         | Пастернак Б.Л.   | 380.80 | 4      |
| 2         | Черный человек        | Есенин С.А.      | 570.20 | 6      |
| 3         | Белая гвардия         | Булгаков М.А.    | 540.50 | 7      |
| 4         | Идиот                 | Достоевский Ф.М. | 360.80 | 3      |
| 5         | Стихотворения и поэмы | Лермонтов М.Ю.   | 255.90 | 4      |
| 6         | Остров сокровищ       | Стивенсон Р.Л.   | 599.99 | 5      |
+-----------+-----------------------+------------------+--------+--------+
Таблица author                          Таблица genre
+-----------+------------------+    +----------+-------------+          
| author_id | name_author      |    | genre_id | name_genre  |          
+-----------+------------------+    +----------+-------------+          
| 1         | Булгаков М.А.    |    | 1        | Роман       |          
| 2         | Достоевский Ф.М. |    | 2        | Поэзия      |          
| 3         | Есенин С.А.      |    | 3        | Приключения |          
| 4         | Пастернак Б.Л.   |    +----------+-------------+          
| 5         | Лермонтов М.Ю.   |
| 6         | Стивенсон Р.Л.   |
+-----------+------------------+
```

Результат:
```
Query result:
+----------+------------+
| genre_id | name_genre |
+----------+------------+
| 1        | Роман      |
| 2        | Поэзия     |
+----------+------------+
Affected rows: 2

Query result:
+---------+-----------------------+-----------+----------+--------+--------+
| book_id | title                 | author_id | genre_id | price  | amount |
+---------+-----------------------+-----------+----------+--------+--------+
| 1       | Мастер и Маргарита    | 1         | 1        | 670.99 | 3      |
| 2       | Белая гвардия         | 1         | 1        | 540.50 | 12     |
| 3       | Идиот                 | 2         | 1        | 437.11 | 13     |
| 4       | Братья Карамазовы     | 2         | 1        | 799.01 | 3      |
| 5       | Игрок                 | 2         | 1        | 480.50 | 10     |
| 6       | Стихотворения и поэмы | 3         | 2        | 650.00 | 15     |
| 7       | Черный человек        | 3         | 2        | 570.20 | 12     |
| 8       | Лирика                | 4         | 2        | 518.99 | 2      |
| 9       | Доктор Живаго         | 4         | 1        | 380.80 | 4      |
| 10      | Стихотворения и поэмы | 5         | 2        | 255.90 | 4      |
| 11      | Остров сокровищ       | 6         | None     | 599.99 | 5      |
+---------+-----------------------+-----------+----------+--------+--------+
Affected rows: 11
```

### Задание 7.
Удалить всех авторов, которые пишут в жанре "Поэзия". Из таблицы book удалить все книги этих авторов. В запросе для отбора авторов использовать полное название жанра, а не его id.

Структура и наполнение таблиц
```
Таблица book
+---------+-----------------------+-----------+----------+--------+--------+
| book_id | title                 | author_id | genre_id | price  | amount |
+---------+-----------------------+-----------+----------+--------+--------+
| 1       | Мастер и Маргарита    | 1         | 1        | 670.99 | 3      |
| 2       | Белая гвардия         | 1         | 1        | 540.50 | 12     |
| 3       | Идиот                 | 2         | 1        | 437.11 | 13     |
| 4       | Братья Карамазовы     | 2         | 1        | 799.01 | 3      |
| 5       | Игрок                 | 2         | 1        | 480.50 | 10     |
| 6       | Стихотворения и поэмы | 3         | 2        | 650.00 | 15     |
| 7       | Черный человек        | 3         | 2        | 570.20 | 12     |
| 8       | Лирика                | 4         | 2        | 518.99 | 2      |
| 9       | Доктор Живаго         | 4         | 1        | 380.80 | 4      |
| 10      | Стихотворения и поэмы | 5         | 2        | 255.90 | 4      |
| 11      | Остров сокровищ       | 6         | 3        | 599.99 | 5      |
+---------+-----------------------+-----------+----------+--------+--------+
Таблица supply
+-----------+-----------------------+------------------+--------+--------+
| supply_id | title                 | author           | price  | amount |
+-----------+-----------------------+------------------+--------+--------+
| 1         | Доктор Живаго         | Пастернак Б.Л.   | 380.80 | 4      |
| 2         | Черный человек        | Есенин С.А.      | 570.20 | 6      |
| 3         | Белая гвардия         | Булгаков М.А.    | 540.50 | 7      |
| 4         | Идиот                 | Достоевский Ф.М. | 360.80 | 3      |
| 5         | Стихотворения и поэмы | Лермонтов М.Ю.   | 255.90 | 4      |
| 6         | Остров сокровищ       | Стивенсон Р.Л.   | 599.99 | 5      |
+-----------+-----------------------+------------------+--------+--------+
Таблица author                          Таблица genre
+-----------+------------------+    +----------+-------------+          
| author_id | name_author      |    | genre_id | name_genre  |          
+-----------+------------------+    +----------+-------------+          
| 1         | Булгаков М.А.    |    | 1        | Роман       |          
| 2         | Достоевский Ф.М. |    | 2        | Поэзия      |          
| 3         | Есенин С.А.      |    | 3        | Приключения |          
| 4         | Пастернак Б.Л.   |    +----------+-------------+          
| 5         | Лермонтов М.Ю.   |
| 6         | Стивенсон Р.Л.   |
+-----------+------------------+
```

Результат:
```
Affected rows: 3

Query result:
+-----------+------------------+
| author_id | name_author      |
+-----------+------------------+
| 1         | Булгаков М.А.    |
| 2         | Достоевский Ф.М. |
| 6         | Стивенсон Р.Л.   |
+-----------+------------------+
Affected rows: 3

Query result:
+---------+--------------------+-----------+----------+--------+--------+
| book_id | title              | author_id | genre_id | price  | amount |
+---------+--------------------+-----------+----------+--------+--------+
| 1       | Мастер и Маргарита | 1         | 1        | 670.99 | 3      |
| 2       | Белая гвардия      | 1         | 1        | 540.50 | 12     |
| 3       | Идиот              | 2         | 1        | 437.11 | 13     |
| 4       | Братья Карамазовы  | 2         | 1        | 799.01 | 3      |
| 5       | Игрок              | 2         | 1        | 480.50 | 10     |
| 11      | Остров сокровищ    | 6         | 3        | 599.99 | 5      |
+---------+--------------------+-----------+----------+--------+--------+
```

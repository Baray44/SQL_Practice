## Выборка данных, групповые функции SUM и COUNT
При группировке над элементами столбца, входящими в группу можно выполнить различные действия, например, просуммировать их или найти количество элементов в группе.

**Пример 1.** Посчитать, сколько экземпляров книг каждого автора хранится на складе.
```sql
SELECT author, SUM(amount)
  FROM book
 GROUP BY author;
```
```
Результат:
+------------------+-------------+
| author           | SUM(amount) |
+------------------+-------------+
| Булгаков М.А.    | 8           |
| Достоевский Ф.М. | 23          |
| Есенин С.А.      | 15          |
+------------------+-------------+
```

**Пример 2.** Посчитать, сколько различных книг каждого автора хранится на складе.
```sql
/* чтобы проверить запрос, добавьте в таблицу строку */
INSERT INTO book (title, author, price, amount) 
VALUES ('Черный человек','Есенин С.А.', Null, Null);

SELECT author, COUNT(author), COUNT(amount), COUNT(*)
  FROM book
 GROUP BY author
 ```
 ```
 Результат:
 +------------------+---------------+---------------+----------+
| author           | COUNT(author) | COUNT(amount) | COUNT(*) |
+------------------+---------------+---------------+----------+
| Булгаков М.А.    | 2             | 2             | 2        |
| Достоевский Ф.М. | 3             | 3             | 3        |
| Есенин С.А.      | 2             | 1             | 2        |
+------------------+---------------+---------------+----------+
```

Из таблицы с результатами запроса видно, что функцию COUNT() можно применять к любому столбцу, в том числе можно использовать и '\*', если таблица не содержит пустых значений. Если же в столбцах есть значения null, (для группы по автору Есенин в нашем примере), то:

COUNT( \* ) —   подсчитывает все записи, относящиеся к группе, в том числе и со значением null;  
COUNT( имя_столбца ) —   возвращает количество записей конкретного столбца (только NOT null), относящихся к группе.
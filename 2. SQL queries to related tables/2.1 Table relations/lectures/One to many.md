## Связь «один ко многим»

Рассмотрим таблицу book(в ней столбец author переименован в name_author):
```
book_id      title              name_author       price  amount
 1       Мастер и Маргарита    Булгаков М.А.     670.99     3
 2       Белая гвардия         Булгаков М.А.     540.50     5
 3       Идиот                 Достоевский Ф.М.  460.00    10
 4       Братья Карамазовы     Достоевский Ф.М.  799.01     2
 5       Стихотворения и поэмы Есенин С.А.       650.00    15
```
В этой таблице фамилии авторов повторяются для нескольких книг. А что, если придется вместо инициалов для каждого автора хранить его полное имя и отчество? Тогда, если в таблице содержится информация о 50 книгах Достоевского, придется 50 раз исправлять «Ф.М.» на «Федор Михайлович». При этом, если в некоторых записях использовать «Фёдор Михайлович» (c буквой ё), то мы вообще получим двух разных авторов...  

Чтобы устранить эту проблему в реляционных базах данных создается новая таблица author,  в которой перечисляются все различные авторы, а затем эта таблица связывается с таблицей book. При этом такая связь называется «один ко многим», таблица author называется главной, таблица book – связанной или подчиненной. 

Связь «один ко многим» имеет место, когда одной записи главной таблицы соответствует несколько записей связанной таблицы, а каждой записи связанной таблицы соответствует только одна запись главной таблицы. 

### Этапы реализации связи «один ко многим» на следующем примере:

1. Создать таблицу author,  в которую включить уникальных авторов книг, хранящихся на складе.

    ![ ](https://ucarecdn.com/ebb2959d-32be-4d80-8855-abe8ce6ec4cb/)

2. Обе таблицы должны содержать первичный ключ, в таблице book он уже есть, в таблицу authorдобавим ключ author_id.

    ![ ](https://ucarecdn.com/88d82e42-3e5b-4e9a-b8e0-78f27f348b1b/)

3. Включить в таблицу book связанный столбец (внешний ключ, FOREIGN KEY), соответствующий по имени и типу ключевому столбцу главной таблицы (в нашем случае это столбец author_id). Для наглядности связь на схеме обозначается стрелкой от ключевого столбца главной таблицы к внешнему ключу связной таблицы.

    ![ ](https://ucarecdn.com/d504072b-bad1-4040-8f49-f5b7102fa1ca/)
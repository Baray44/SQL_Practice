# Вставка записи в таблицу
Для занесения новой записи в таблицу используется SQL запрос, в котором указывается в какую таблицу, в какие поля заносить новые значения. Структура запроса: 
- ключевые слова INSERT INTO (ключевое слово INTO можно пропустить);
- имя таблицы, в которую добавляется запись;
- список полей в круглых скобках через запятую, в которые следует занести новые данные;
- ключевое слово VALUES;
- список значений в круглых скобках через запятую, которые заносятся в соответствующие поля, при этом текстовые значения заключаются в кавычки, числовые значения записываются без кавычек, в качестве разделителя целой и дробной части используется точка;
---
**Пример.**  В таблицу, состоящую из двух столбцов добавим новую строку, при этом в поле1 заносится значение1,  в поле2 - значение2.
```sql
INSERT INTO таблица(поле1, поле2) 
VALUES (значение1, значение2);
```
В результате выполнения запроса новая запись заносится в конец обновляемой таблицы.
### Рекомендации по записи SQL запроса
При составлении списка полей и списка значений необходимо учитывать следующее:
- количество полей и количество значений в списках должны совпадать;  
- должно существовать прямое соответствие между позицией одного и того же элемента в обоих списках, поэтому первый элемент списка значений должен относиться к первому столбцу в списке столбцов, второй, соответственно, ко второму столбцу и т.д.;  
- типы данных элементов в списке значений должны быть совместимы с типами данных соответствующих столбцов таблицы (целое число можно занести в поле типа DECIMAL, обратная операция - недопустима);  
- новые значения нельзя добавлять в поля, описанные как PRIMARY KEY AUTO_INCREMENT;
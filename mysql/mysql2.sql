#Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
update users set created_at = coalesce(created_at, now()), updated_at = coalesce(updated_at, now());
#Таблица users была неудачно спроектирована. 
#Записи created_at и updated_at были заданы типом VARCHAR 
#и в них долгое время помещались значения в формате "20.10.2017 8:10". 
#Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
select str_to_date(`created_at`,'%d.%m.%Y %k:%i'), str_to_date(`updated_at`,'%d.%m.%Y %k:%i') from users;
#В таблице складских запасов storehouses_products в поле value 
#могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, 
#если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
#чтобы они выводились в порядке увеличения значения value. 
#Однако, нулевые запасы должны выводиться в конце, после всех записей.
select * from storehouses_products order by if(value > 0,0,1), value;


#Подсчитайте средний возраст пользователей в таблице users
select round(avg(timestampdiff(YEAR, birthday_at,NOW()))) from users;
#Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
#Следует учесть, что необходимы дни недели текущего года, а не года рождения.
select DAYNAME(concat(YEAR(NOW()), date_format(birthday_at, '-%m-%d'))) day_of_week, COUNT(*) from users 
group by DAYNAME(concat(YEAR(NOW()), date_format(birthday_at, '-%m-%d')))
order by DAYOFWEEK(concat(YEAR(NOW()), date_format(birthday_at, '-%m-%d')));
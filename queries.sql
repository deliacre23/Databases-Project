--inserts

insert into Destination values ('Morocco', 'Rabat', 'city break', 1300)
insert into Destination values ('Romania', 'Cluj',	'city break',	1300)
insert into Destination values	('Spain', 'Madrid', 'city break', 2000)
insert into Destination values	('Austria',	'Viena', 'city break',	1000)
insert into Destination values	('Portugal', 'Lisboa', 'city break', 1700)
insert into Destination values	('USA', '17 states', 'tour',	7000)
insert into Destination values	('Japan', 'Tokyo', 'city break', 4800)

insert into Passport values	('2019-12-25', '2030-01-15')
insert into Passport values	('2018-05-05', '2032-09-09')
insert into Passport values	('2017-06-20', '2026-04-03')

insert into Airline values ('American Airlines Group')
insert into Airline values ('Delta Air Lines')
insert into Airline values ('Air France–KLM')

select * from Destination
select * from Passport
select * from Airline


--updates

UPDATE Destination
SET country='România'
WHERE country LIKE 'Rom__%' AND price>=2000
--
UPDATE Destination
SET price=price-400
WHERE price BETWEEN 1500 AND 8000
--
UPDATE Attraction
SET description='a wonderful choice for families'
WHERE type='sightseeing' OR type='nature'
--
select * from Destination
select * from Attraction


--delete

DELETE Flight
WHERE  class in ('economy','business')
--
DELETE Attraction
WHERE description IS NOT NULL AND dest_id=5

select * from Flight
select * from Attraction


--group by

select d.country , AVG(d.price) as average_price, sum(d.price) as total
from Destination d 
GROUP BY d.country
order by average_price

select p.first_name,p.last_name,p.budget
from Person p 
group by  p.first_name,p.last_name,p.budget
having p.budget>2000
order by p.budget desc

select d.country,d.type, avg(r.stars) rating, count(r.dest_id)nb_reviews
from Destination d inner join Review r on d.dest_id=r.dest_id
group by  d.country,d.type
having avg(r.stars)>3.5
order by avg(r.stars) desc

select top 5 name,stars
from Hotel 

select distinct d.price
from Destination d


--exist

SELECT d.country, d.price
FROM  Destination d
WHERE d.price<3000 and d.dest_id IN (SELECT a.dest_id FROM Attraction a)

SELECT a.name, a.type
FROM  Attraction a
WHERE a.dest_id IN (SELECT a.dest_id FROM Destination d)

SELECT  a.name, a.type
FROM Attraction a
WHERE EXISTS (SELECT * FROM  Destination d
WHERE a.dest_id=d.dest_id)

SELECT  a.name, a.type
FROM Attraction a
WHERE EXISTS (SELECT * FROM  Destination d
WHERE a.type in ('nature', 'sightseeing', 'water'))


--join

select *
from Attraction, Destination
WHERE Attraction.dest_id=Destination.dest_id
-- equivalent
select *
from Attraction a INNER JOIN Destination d ON 
a.dest_id=d.dest_id
-- LEFT OUTER JOIN
select *
from Attraction a LEFT OUTER JOIN Destination d ON
a.dest_id=d.dest_id
-- RIGHT OUTER JOIN
select *
from Attraction a RIGHT OUTER JOIN Destination d ON
a.dest_id=d.dest_id
-- FULL OUTER JOIN
select *
from Attraction a FULL OUTER JOIN Destination d ON
a.dest_id=d.dest_id

--3 tables full inner join
SELECT *
FROM Person p 
INNER JOIN Passport pass ON p.p_id=pass.p_id 
INNER JOIN Booking b ON  b.p_id = p.p_id


--union

SELECT h1.name
FROM Hotel h1
WHERE stars=4 OR stars=5
UNION
SELECT h2.name
FROM Hotel h2
WHERE dest_id=1
--
SELECT *
FROM Attraction 
WHERE description IS NOT NULL
INTERSECT
SELECT *
FROM Attraction 
WHERE type in ('water','nature')
-- equivalent
SELECT *
FROM Airline
WHERE company_name like '%Air%'
EXCEPT 
SELECT *
FROM Airline
WHERE company_name like '%China%'


--intersect

SELECT h1.name
FROM Hotel h1
WHERE stars=4 OR stars=5
UNION
SELECT h2.name
FROM Hotel h2
WHERE dest_id=1
--
SELECT *
FROM Attraction 
WHERE description IS NOT NULL
INTERSECT
SELECT *
FROM Attraction 
WHERE type in ('water','nature')


--except

SELECT *
FROM Airline
WHERE company_name like '%Air%' 
-- equivalent
SELECT *
FROM Airline
WHERE company_name like '%Air%'
EXCEPT 
SELECT *
FROM Airline
WHERE company_name like '%China%'

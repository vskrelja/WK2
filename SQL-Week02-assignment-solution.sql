-- Week2Assignment.sql

SELECT distinct dest FROM flights
SELECT * FROM airports;
SELECT * from airlines;
SELECT * from planes;
SELECT distinct origin from weather LIMIT 24;


-- 1. What weather conditions are associated with New York City departure delays?

-- High temperature / low pressure conditions which are associated with higher wind speed/gust and lower visibility 
-- is mostly responsible for departure delays.

select 
f.dep_delay, 
w.*
from flights f 
join weather w on f.year=w.year and f.month=w.month and f.day=w.day and f.origin=w.origin 
and to_number(substring(to_char(f.dep_time, '0000') from 1 for 3),'99G999D9S')=w.hour 
where w.temp is not null
and w.dewp is not null
and w.humid is not null
and w.wind_dir is not null
and w.wind_speed is not null
and w.wind_gust is not null
and w.precip is not null
and w.pressure is not null
and w.visib is not null


-- 2. Are older planes more likely to be delayed?

-- A visual of a scatter plot of age vs. delays does not show any relationship.

select
dep_delay,
(2015-p.year) as age
from flights f
join planes p on f.tailnum=p.tailnum


-- 3. Ask (and if possible answer) a third question that also requires joining information from two or more tables in the flights database, 
--    and/or assumes that additional information can be collected in advance of answering your question.

-- Q: Which engine has the most departure delays on average?

-- A: 4 Cycle

select
engine,
count(*),
avg(dep_delay) avg_delay
from flights f
join planes p on f.tailnum=p.tailnum
where engine is not null
and dep_delay is not null
and dep_delay < 800
group by engine
order by avg(dep_delay) desc



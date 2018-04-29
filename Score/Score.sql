DROP DATABASE IF EXISTS Score;
CREATE DATABASE Score;
USE Score;

create table Score (
   id int primary key auto_increment,
   score int
);

insert into Score values
 (NULL, 30),  
 (NULL, 20),  
 (NULL, 25),  
 (NULL, 39), 
 (NULL, 40),  
 (NULL, 50),  
 (NULL, 52),  
 (NULL, 18),  
 (NULL, 8),  
 (NULL, 20),  
 (NULL, 30),  
 (NULL, 60);
 
 #find everyone whoes scores are 80% of the max
 
select (8/10)*max(score) from Score; 
 
select id, score from Score
where score > (select (8/10)*max(score) from Score);

select a.id, a.score 
from Score a left join Score b on a.id = b.id 
      and b.score < 48 
where b.score is null;



select a.id, a.score 
from Score a left join Score b on a.score <= (8/10)*b.score 
where b.score is null;






# all scores that have a 10 or greater point gap above them


SELECT id
FROM Score Sout
WHERE NOT EXISTS (select * FROM Score Sin WHERE Sout.score < Sin.score and Sout.score+10 > Sin.score)
ORDER BY id;

SELECT Sout.id
FROM Score Sout
LEFT JOIN Score Sin ON Sout.score < Sin.score and Sout.score+10 > Sin.score
WHERE Sin.id is null
Order by Sout.id;








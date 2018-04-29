DROP DATABASE IF EXISTS Worker1;
CREATE DATABASE Worker1;
USE Worker1;

create table Worker (
   id int auto_increment primary key,
   name varchar(60) not null,
   baseRate decimal(5,2) not null,
   timezone varchar(30),  # assume US/Pacific if null
   prefLang char(5) not null
);

create table WorkPeriod (
   id int auto_increment primary key,
   workerId int,
   utcClockIn datetime,      # Clock in time 
   utcClockOut datetime,     # Clock out time
   clockIn datetime,         # Timezone-local clock in
   clockOut datetime,        # Timezone-local clock out
   multiplier double,        # 1.0, 1.5 or 2
   pay DECIMAL(10,2),        # Pay owed for this WorkPeriod
   explanation varchar(255), # Explanation of pay
   constraint FKWorkPeriod_workerId
      foreign key(workerId) references Worker(id)
);

create table Explanation (
   prefLang char(5) primary key,
   content varchar(255) not null,
   otContent varchar(255) not null
);

insert into Explanation values
 ("en_US", "<first> <last>, you worked <time> for normal pay of <pay>",
 "<first> <last>, you worked <time> for overtime pay of <pay>.  We appreciate the effort, <first>."),
 ("es_ES", "[ES] <first> <last>: you worked <time> for normal pay of <pay>",
 "[ES] <first> <last>: you worked <time> for overtime pay of <pay>.  We appreciate the effort, Sr/Sra <last>.");

insert into Worker values
 (1, "Gonzalez, Jose", 52.0, "Europe/Madrid", "es_ES"),
 (2, " Smith,  John", 45.0, NULL, 'en_US'),
 (3, "Jones, Mary ", 55.0, "US/Eastern",  'en_US');

insert into WorkPeriod(workerId, utcClockIn, utcClockOut) values
 (1, "2013-11-1 20:01:04", "2013-11-2 2:03:45"),
 (1, "2013-11-2 20:02:04", "2013-11-3 2:23:45"),
 (2, "2013-11-4 14:05:04", "2013-11-4 18:03:45"),
 (2, "2013-11-4 20:02:04", "2013-11-4 20:12:45"),
 (2, "2013-11-4 20:30:04", "2013-11-5 1:23:45"),
 (3, "2013-11-4 14:02:04", "2013-11-5 2:23:45"),
 (3, "2013-11-2 03:02:04", "2013-11-2 8:20:00");
 
 
 -- Set the multiplier so that any time worked on Saturday gets time-and-a-half, and any time worked on Sunday gets double time. 
 -- Use local times. Set pay based on the duration worked, the worker's base rate, and the multiplier. 
 -- Use time totals to the nearest minute.
 
 -- Generate an explanation. 
 -- Use the Explanation row for the worker's preferred language, 
 -- filling in the content or otContent string with the indicated data from above.
 
UPDATE WorkPeriod 
SET clockIn = (SELECT 
      convert_tz(utcClockIn, 'UTC', IFNULL(timezone,'US/Pacific')) 
      FROM Worker W 
      WHERE W.id = workerId),
clockOut = (SELECT 
      convert_tz(utcClockOut, 'UTC', IFNULL(timezone,'US/Pacific')) 
      FROM Worker W 
      WHERE W.id = workerId);

INSERT INTO WorkPeriod 
      (workerId, utcClockIn, utcClockout, clockIn,
      clockOut, multiplier, pay, explanation) 
SELECT workerId, convert_tz(CONCAT(DATE(clockOut), ' 00:00:00'),
      timezone, 'UTC'), utcClockout,
            CONCAT(DATE(clockOut), ' 00:00:00'),
                  clockOut, multiplier, pay, explanation 
FROM WorkPeriod, Worker 
WHERE workerId = Worker.id 
&& DATEDIFF(clockOut, clockIn) > 0;


UPDATE WorkPeriod
SET clockOut = CONCAT(DATE(clockOut), ' 00:00:00'),
utcClockOut = (
      SELECT convert_tz(CONCAT(DATE(clockOut), ' 00:00:00'), 
            timezone, 'UTC') 
      FROM Worker 
      WHERE workerId = Worker.id)
WHERE DATEDIFF(clockOut, clockIn) > 0;

DELETE FROM WorkPeriod 
WHERE utcClockIn = utcClockOut;

UPDATE WorkPeriod 
SET multiplier = IF(DATE_FORMAT(clockIn, '%W') = 'Saturday', 1.5, 
      IF(DATE_FORMAT(clockIn, '%W') = 'Sunday', 2.0, 1.0)),
pay = (SELECT ROUND(((TIMESTAMPDIFF
            (MINUTE, clockIn, clockOut)*(baseRate/60)*multiplier)),2)
      FROM Worker W 
	  WHERE workerId = W.id),
explanation = (SELECT IF((DATE_FORMAT(clockIn, '%W') = 'Saturday' 
      || DATE_FORMAT(clockIn, '%W') = 'Sunday'), otContent , content) 
      FROM Worker W, Explanation E 
      WHERE workerId = W.id && E.prefLang = W.prefLang),
explanation = (SELECT REPLACE(REPLACE(REPLACE(REPLACE(explanation, 
      '<time>', TIME_FORMAT(TIMEDIFF(clockOut, clockIn), '%H:%i')),
            '<pay>', pay), 
                  '<first>', TRIM(RIGHT(name, LENGTH(name) - LOCATE(',', name)))),
                        '<last>', TRIM(SUBSTRING_INDEX(name, ',', 1))) 
      FROM Worker 
      WHERE workerId = Worker.id);

SELECT * FROM WorkPeriod;

SELECT REPLACE(REPLACE(REPLACE(REPLACE(explanation, '<time>', TIME_FORMAT(TIMEDIFF(clockOut, clockIn), '%H:%i')), '<pay>', pay), '<first>', TRIM(RIGHT(name, LENGTH(name) - LOCATE(',', name)))), '<last>', TRIM(SUBSTRING_INDEX(name, ',', 1))) FROM WorkPeriod, Worker WHERE workerId = Worker.id;
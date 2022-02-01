CREATE DATABASE IF NOT EXISTS POCTask;
USE POCTask;

create table author (
id int primary key,
name varchar(100)
);

create table post(
id int primary key,
name varchar(100),
createdts datetime,
authorid int, foreign key (authorid) references author(id)
);

create table user(
id int primary key,
name varchar(100)
);

create table comment (
id int primary key,
content varchar(1000),
postid int, foreign key (postid) references post(id) ,
createdts datetime,
userid int, foreign key (userid) references user(id) 
);

insert into author values
(100,"James Bond"),
(101,"Abitha"),
(102,"Kiran"),
(103,"Arun"),
(104,"Harini"),
(105,"Yashu");

select * from author;

insert into post values
(1,"POST1","2000-05-13",100),
(2,"POST2","2002-09-21",101),
(3,"POST3","1998-05-09",100),
(4,"POST4","2010-12-28",103),
(5,"POST5","2021-08-03",105);

select * from post;

insert user values
(501,"Ammu"),(502,"Kutti"),(503,"Kumar"),(504,"Karan"),(505,"Vijay"),
(506,"Kiram"),(507,"Saritha"),(508,"Anand"),(509,"Vinay"),(510,"Raghu"),
(511,"veena"),(512,"soundarya"),(513,"meghana"),(514,"sinchana"),(515,"prajwala"),
(516,"Mouna"),(517,"punya"),(518,"Kavya"),(519,"Megha"),(520,"Bharath");

select * from user;

insert into comment values
(201,"Comment1",5,"2020-04-04",501),
(202,"Comment2",3,"2020-05-04",501),
(203,"Comment3",3,"2020-05-09",505),
(204,"Comment4",1,"2021-01-01",504),
(205,"Comment5",1,"2021-02-01",502),
(206,"Comment6",2,"2021-02-03",507),
(207,"Comment7",1,"2021-03-09",506),
(208,"Comment8",4,"2021-03-12",503),
(209,"Comment9",3,"2021-04-09",504),
(210,"Comment10",3,"2021-05-11",508),
(211,"Comment11",1,"2021-05-12",509),
(212,"Comment12",1,"2021-06-10",510),
(213,"Comment13",3,"2021-06-24",507),
(214,"Comment14",1,"2021-07-12",512),
(215,"Comment15",1,"2021-08-20",514),
(216,"Comment16",2,"2021-08-23",514),
(217,"Comment17",5,"2021-08-24",516),
(218,"Comment18",1,"2021-08-24",515),
(219,"Comment19",3,"2021-09-10",518),
(220,"Comment20",1,"2021-09-10",517),
(221,"Comment21",3,"2021-09-15",519),
(222,"Comment22",1,"2021-09-20",520),
(223,"Comment23",3,"2021-09-20",506),
(224,"Comment24",3,"2021-09-25",507),
(225,"Comment25",1,"2021-09-26",503);

-- Query to display the list of Posts with latest 10 comments of each post authored by 'James Bond'

select *
from  post p
left join comment c on 
    (p.id=c.postid)
    and 
    c.id >
    (select id from comment c
        where postid=p.id 
        ORDER BY c.createdts DESC LIMIT 10,1),author a
where a.id=p.authorid and authorid in(select id from author where name="James Bond");


use poctask;
SELECT * 
FROM (
	SELECT *, row_number() OVER (PARTITION BY postid ORDER BY createdts DESC) AS rn
    FROM comment
) c
JOIN post p 
ON p.id = c.postid
WHERE p.authorid = (SELECT id from AUTHOR WHERE NAME='JAMES BOND') AND rn <= 10
ORDER BY c.createdts DESC;



-- Query to display the list of Posts with latest 10 comments of post authored by 'James Bond'

use poctask;
select * 
from post p left join comment c on (p.id=c.postid) 
and 
authorid in(select id 
		  from author 
          where name="James Bond")
ORDER BY c.createdts DESC LIMIT 10;

create table stu(
no number,
name varchar2(5 char),
tel varchar2(13));

create table pp(
no number,
e_name varchar2(4),
e_point number(3));

insert into stu values (1,'hong', '1111');
insert into stu values (2,'kim', '2222');
insert into stu values (3,'lee', '3333');

insert into pp values(1, 'java',70);
insert into pp values(1, 'html',90);
insert into pp values(3, 'java',80);

desc stu;
select * from stu;
select * from pp;

drop table stu;
-- join : 1개 이상의 테이블을 논리적으로 합치는것
-- 종류 : full join : 두개의 테이블을 모두 합치는것
--      결과는 n*m의 수만큼 조인이 되어 튜플이 만들어 진다.
--        inner join : 조건을 제시한다. 조건에 참일 경우만 조인한다.
--              종류: 동등이너조인(==), 비동등이너조인(!=)
--        outer join : 이너조인 + 조인에 참여하지 않은 튜플까지 출력
--              종류: 테이블 조인의 위치에 따라
--              left outer join, right outer join
--      공부의 방향은 : 어떤 테이블을 조인할까? 어떤 조인을 사용할까??
--  먼저 full join해본다 .. 절대 현업에서는 하지 마세요. 속도가 너무 느려짐.
select *
from stu,pp;

 -- 테이블 삭제시: DROP TABLE stu CASCADE CONSTRAINTS;
 --풀 조인
select s.no, s.name, p.no, p.e_name, p.e_point
from stu s, pp p;

-- 동등 이너조인
select s.no, s.name, p.no, p.e_name, p.e_point
from stu s, pp p
where s.no=p.no;

-- 동등 이너조인은 다음과 같은 표기법도 있다.
select s.no, s.name, p.no, p.e_name, p.e_point
from stu s      
inner join pp p     
on s.no=p.no;

--left 아우터 조인
select s.no, s.name, p.no, p.e_name, p.e_point
from stu s      
left outer join pp p     --left outer join/ left table : stu
on s.no=p.no;

-- right 아우터 조인
select s.no, s.name, p.no, p.e_name, p.e_point
from stu s      
right outer join pp p     --left outer join/ left table : stu
on s.no=p.no;


--비동등 이너조인
select s.no, s.name, p.no, p.e_name, p.e_point
from stu s, pp p
where s.no!=p.no;

commit;

DROP TABLE stu CASCADE CONSTRAINTS;
DROP TABLE pp CASCADE CONSTRAINTS;

-- 시험을 본 학생들의 이름과 과목과 점수를 출력하시오.
-- 2개의 테이블을 합쳐야 하죠 // 조인 .. 그런데 같은 칼럼을 합치죠
                            -- 이너조인                            
select s.name, p.e_name, p.e_point
from stu s, pp p
where s.no = p.no;
--홍길동의 이름과 과목과 점수를 출력하시오. 이너조인
select s.name, p.e_name, p.e_point
from stu s, pp p
where s.no = p.no and s.name='hong';
--시험을 치루지 않은 학생들의 이름을 출력하시오
-- 이너조인에 참여하지 않은 튜플의 정보이므로 아우터 조인
-- 1. left outer join 해결
select s.name
from stu s
left outer join pp p
on s.no = p.no
where p.no is null;

// join 정의
// 조인의 종류
// 조인의 종류를 언제 사용하는지 ?? 샘플 ..



DROP TABLE users CASCADE CONSTRAINTS;


create table users(
id varchar2(8), 
name varchar2(10), 
addr varchar2(10));

create table carinfo(
c_num varchar2(4),   --자동차 번호
c_name varchar2(10),  -- 자동차 종류
 id varchar2(8));


insert into users values ('1111','kim','수원');
insert into users values ('2222','lee','서울');
insert into users values ('3333','park','대전');
insert into users values ('4444','choi','대전');

insert into carinfo values ('1234','중형','1111');
insert into carinfo values ('3344','소형','1111');
insert into carinfo values ('5566','중형','3333');
insert into carinfo values ('6677','중형','3333');
insert into carinfo values ('7788','중형','4444');
insert into carinfo values ('8888','중형','5555');

select * from carinfo;
select * from users;

-- 1. 회원의 이름과 주소를 출력하시오.
select u.name 이름, u.addr 주소
from users u;
--2. 회원의 이름과 소유한 자동차 번호를 출력하시오. - 이너조인
select u.name 이름, c.c_num 자동차번호
from users u,carinfo c
where u.id = c.id;
--3. 자동차 번호가 7788인 소유자의 이름과 주소를 출력하시오.

-- (1)조인을 해서 조건절로 7788인 자동차의 소유자의 정보를 출력 > 조인
select u.name 이름, u.addr 주소
from users u,carinfo c
where u.id = c.id and c.c_num = '7788';

-- (2)7788소유자의 회원아이디를 검색한 후 결과값을 본 쿼리의 조건 > 서브쿼리
select name 이름, addr 주소
from users
where id = (select id from carinfo where c_num='7788');


--4. 자동차를 소유하지 않은 사람의 이름과 주소를 출력하시오. left outer
--left outer join
select u.name 이름, u.addr 주소
from users u
left outer join carinfo c
on u.id = c.id
where c.id is null;
--left outer join(2) 다음과 같이 (+)기호로 표시할수 있다.
select u.name 이름, u.addr 주소
from users u, carinfo c
where u.id = c.id(+) and c.id is null;
--right outer join을 다음과 같이 (+)기호로 표시할수 있다.
select u.name 이름, u.addr 주소
from users u, carinfo c
where u.id(+) = c.id and c.id is null;

select u.*, c.*
from users u        --left table
left outer join carinfo c
on u.id = c.id;

--5. 회원별 등록한 자동차 수를 출력하시오.
select u.name 이름, count(*) 등록한_자동차_수
from users u,carinfo c
where u.id = c.id
group by u.name;


--++동명이인일 경우도 있으니 .. u.id로 그룹화하자.
--(1)이렇게 하면 에러가난다. select u.name은 다중행이다.
select u.name 이름, count(*) 등록한_자동차_수
from users u,carinfo c
where u.id = c.id
group by u.id;

--(2)그룹바이 복합속성으로
select u.name 이름, count(*) 등록한_자동차_수
from users u,carinfo c
where u.id = c.id
group by (u.name,u.id); --group by 복합속성으로 정의하자



--6. 2대 이상을 소유한 회원의 이름과 소유한 자동차 수를 출력하시오.
select u.name 이름, count(*) 등록한_자동차_수
from users u,carinfo c
where u.id = c.id 
group by u.name having count(*) >= 2;

--group by 복합속성으로 최종 해결.
select u.name 이름, count(*) 등록한_자동차_수
from users u,carinfo c
where u.id = c.id
group by (u.name,u.id) having count(*) >= 2; --group by 복합속성으로 정의하자



--7. 자동차는 등록되어 있는데 소유자가 없는 자동차 번호를 출력하시오. *right outer
--*먼저 보는 테이블은 carinfo, 두번째는 users
--이너조인에 참여하지 못하는 튜플을 원한다.. 아우터 조인
--아우터 조인일때는 어떤 테이블을 left로 볼 것인가?? 

--right에 있는 carinfo를 먼저봄. (from users right outer --> join carinfo)
select c.c_num as 소유자가_없는_자동차번호
from users u
right outer join carinfo c
on u.id = c.id
where u.id is null;

-- left에 있는 carinfo를 먼저봄 ( carinfo <--left outer join user)
select c.c_num as 소유자가_없는_자동차번호
from carinfo c
left outer join users u
on u.id = c.id
where u.id is null;

--
select c.c_num 소유자가_없는_자동차번호
from carinfo c, users u
where c.id = u.id(+) and u.id is null;


select *
from users u
left outer join carinfo c
on u.id= c.id;

select * from users u right outer join carinfo c on u.id = c.id;

select * from users; --1111 2222 3333 4444
select * from carinfo; -- 1111 3333 4444 5555 (id 5555,cnum:8888) 자동차는 등록, 소유자 없음

--
create table companycar(     -- 자동차 정보
c_num varchar2(4),   -- 차번호
c_com varchar2(30),  -- 제조사
c_name varchar2(10),  -- 차이름
c_price number);  -- 차 가격

insert into companycar values ('1234','현다','소나타',1000);
insert into companycar values ('3344','기와','축제',2000);
insert into companycar values ('7788','기와','레2',800);
insert into companycar values ('9900','현다','그랭저',2100);

--8. 배정 자동차의 차번호, 제조사, 자동차명, 가격을 출력하시오.
--carinfo 배정 자동차의 정보로 가정.. 차번호는 carinfo 해결 가능
--제조사와 자동차 명과 가격은 companycar테이블에 있다.  ..  이너조인
select c_num, c_com, c_name, c_price
from companycar;

select * from companycar; --1234 3344 7788 9900 
select * from carinfo; -- 1234 3344 7788 ;; 5566 6677 8888 

select c.c_num 차번호, c.c_com 제조사, c.c_name 자동차명, c.c_price 가격
from carinfo a, companycar c
where a.c_num = c.c_num;
-- 9. 회사에서구매는 하였지만 배정되지 않은 자동차의 차번호, 제조자, 자동차 이름을 출력  
-- company에는 있는데 carinfo에는 없는 자동차

--순서
--테이블을 보는 순서를 정해보자.
--companycar 테이블에 보유한 자동차 정보를 확인, 이 자동차 배정되었는지
--확인하기 위해서 carinfo테이블 확인 .. 배정된 자동차를 이너조인
--배정이 안된 자동차는 아우터 조인 .. 이때 companycar를 left(먼저봄)
--(2) 최종
select c.c_num 차번호, c.c_com 제조회사, c.c_name 자동차이름
from carinfo a
right outer join companycar c
on a.c_num = c.c_num
where a.c_num is null;

--(1)
select *
from carinfo a
right outer join companycar c
on a.c_num = c.c_num;

--10. 자동차 가격이 1000만원 이상인 자동차의 자동차 번호를 출력하시오.
--한개의 테이블에 필요한 정보가 다 있음.
select c.c_num 자동차번호
from companycar c
where c.c_price>=1000;

select *
from companycar c
where c.c_price>=1000;

--11. 배정된 자동차 중에 회사에서 구매한 자동차가 아닌 자동차 번호를 출력하시오.
-- carinfo에는 있는데 company에는 없는 자동차의정보
-- carinfo를 left로 보겠다

select a.c_num 자동차번호
from carinfo a
left outer join companycar c
on a.c_num = c.c_num
where c.c_num is null;

select *
from carinfo a
left outer join companycar c
on a.c_num = c.c_num;

--12. 모든 사람의 정보를 출력하시오. 이름, 배정받은 자동차번호, 자동차이름
--테이블 3개 조인 필요. 이대는 순서를 정하고 순서대로 2개씩 조인하고
-- 그 결과의 논리테이블과 다음 테이블을 조인 .. 진행
 
--순서(0) 
 select *
from users u
left outer join carinfo c
on u.id=c.id
;   
--- 순서 (1)    
select *
from users u
left outer join carinfo c
on u.id=c.id
left outer join companycar cc
on c.c_num= cc.c_num;
-- 순서 (2) , nvl로 '널'을 '없음' 처리
select u.name 이름, nvl(c.c_num,'없음') 배정받은_자동차번호, nvl(cc.c_name,'없음') 자동차이름
from users u
left outer join carinfo c
on u.id=c.id
left outer join companycar cc
on c.c_num= cc.c_num;

/*
*고찰*
테이블은 데이터 중복을 최소화 하기 위해 정규화 되어야 한다.
정규화는 테이블을 분리하는 의미가 있다.
그런데, 이 서비스를 이용하는 고객 입장에서는 2개 이상의 테이블이 조인이 되어야 하는 경우가 있다.
그래서 정규화는 설계자의 입장이고, 조인은 서비스를 제공하는 입장의 기술이다.
그런데 , 2개 이상의 테이블이 조인되어야 하는 서비스는
서비스가 이용될때마다 db는 조인 연산을 계속해야 한다. 쿼리도 복잡하다
간단하게 할 방법은 없을까
해결 책은 물리적인 테이블은 유지하되, 조인 결과를 합친 논리적인 테이블을 만드는 것이다.
논리적인 테이블은 물리적인 테이블의 데이터로 만들어져 있다.
이런 논리적인 테이블을 뷰라고 한다.
*/

--12번의 서비스를 제공하기 위해 view를 만들어 보자.;'
--컬럼명을 지정해줘어야 에러가 안난다.

--view를 통해서 insert update가 이론적으로 가능하지만 table 무결성의 제약조건에 위배가 되지 않아야 한다.
--이런점에서 view는 조회 목적으로 많이 사용한다.

create view all_users as (
select u.name 이름, nvl(c.c_num,'없음') 배정받은_자동차번호, nvl(cc.c_name,'없음') 자동차이름
from users u
left outer join carinfo c
on u.id=c.id
left outer join companycar cc
on c.c_num= cc.c_num);

select * from all_users; -- view이름으로 조회가 가능하다.

select 이름,배정받은_자동차번호,자동차이름
from all_users;



commit;
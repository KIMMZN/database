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
-- join : 1�� �̻��� ���̺��� �������� ��ġ�°�
-- ���� : full join : �ΰ��� ���̺��� ��� ��ġ�°�
--      ����� n*m�� ����ŭ ������ �Ǿ� Ʃ���� ����� ����.
--        inner join : ������ �����Ѵ�. ���ǿ� ���� ��츸 �����Ѵ�.
--              ����: �����̳�����(==), �񵿵��̳�����(!=)
--        outer join : �̳����� + ���ο� �������� ���� Ʃ�ñ��� ���
--              ����: ���̺� ������ ��ġ�� ����
--              left outer join, right outer join
--      ������ ������ : � ���̺��� �����ұ�? � ������ ����ұ�??
--  ���� full join�غ��� .. ���� ���������� ���� ������. �ӵ��� �ʹ� ������.
select *
from stu,pp;

 -- ���̺� ������: DROP TABLE stu CASCADE CONSTRAINTS;
 --Ǯ ����
select s.no, s.name, p.no, p.e_name, p.e_point
from stu s, pp p;

-- ���� �̳�����
select s.no, s.name, p.no, p.e_name, p.e_point
from stu s, pp p
where s.no=p.no;

-- ���� �̳������� ������ ���� ǥ����� �ִ�.
select s.no, s.name, p.no, p.e_name, p.e_point
from stu s      
inner join pp p     
on s.no=p.no;

--left �ƿ��� ����
select s.no, s.name, p.no, p.e_name, p.e_point
from stu s      
left outer join pp p     --left outer join/ left table : stu
on s.no=p.no;

-- right �ƿ��� ����
select s.no, s.name, p.no, p.e_name, p.e_point
from stu s      
right outer join pp p     --left outer join/ left table : stu
on s.no=p.no;


--�񵿵� �̳�����
select s.no, s.name, p.no, p.e_name, p.e_point
from stu s, pp p
where s.no!=p.no;

commit;

DROP TABLE stu CASCADE CONSTRAINTS;
DROP TABLE pp CASCADE CONSTRAINTS;

-- ������ �� �л����� �̸��� ����� ������ ����Ͻÿ�.
-- 2���� ���̺��� ���ľ� ���� // ���� .. �׷��� ���� Į���� ��ġ��
                            -- �̳�����                            
select s.name, p.e_name, p.e_point
from stu s, pp p
where s.no = p.no;
--ȫ�浿�� �̸��� ����� ������ ����Ͻÿ�. �̳�����
select s.name, p.e_name, p.e_point
from stu s, pp p
where s.no = p.no and s.name='hong';
--������ ġ���� ���� �л����� �̸��� ����Ͻÿ�
-- �̳����ο� �������� ���� Ʃ���� �����̹Ƿ� �ƿ��� ����
-- 1. left outer join �ذ�
select s.name
from stu s
left outer join pp p
on s.no = p.no
where p.no is null;

// join ����
// ������ ����
// ������ ������ ���� ����ϴ��� ?? ���� ..



DROP TABLE users CASCADE CONSTRAINTS;


create table users(
id varchar2(8), 
name varchar2(10), 
addr varchar2(10));

create table carinfo(
c_num varchar2(4),   --�ڵ��� ��ȣ
c_name varchar2(10),  -- �ڵ��� ����
 id varchar2(8));


insert into users values ('1111','kim','����');
insert into users values ('2222','lee','����');
insert into users values ('3333','park','����');
insert into users values ('4444','choi','����');

insert into carinfo values ('1234','����','1111');
insert into carinfo values ('3344','����','1111');
insert into carinfo values ('5566','����','3333');
insert into carinfo values ('6677','����','3333');
insert into carinfo values ('7788','����','4444');
insert into carinfo values ('8888','����','5555');

select * from carinfo;
select * from users;

-- 1. ȸ���� �̸��� �ּҸ� ����Ͻÿ�.
select u.name �̸�, u.addr �ּ�
from users u;
--2. ȸ���� �̸��� ������ �ڵ��� ��ȣ�� ����Ͻÿ�. - �̳�����
select u.name �̸�, c.c_num �ڵ�����ȣ
from users u,carinfo c
where u.id = c.id;
--3. �ڵ��� ��ȣ�� 7788�� �������� �̸��� �ּҸ� ����Ͻÿ�.

-- (1)������ �ؼ� �������� 7788�� �ڵ����� �������� ������ ��� > ����
select u.name �̸�, u.addr �ּ�
from users u,carinfo c
where u.id = c.id and c.c_num = '7788';

-- (2)7788�������� ȸ�����̵� �˻��� �� ������� �� ������ ���� > ��������
select name �̸�, addr �ּ�
from users
where id = (select id from carinfo where c_num='7788');


--4. �ڵ����� �������� ���� ����� �̸��� �ּҸ� ����Ͻÿ�. left outer
--left outer join
select u.name �̸�, u.addr �ּ�
from users u
left outer join carinfo c
on u.id = c.id
where c.id is null;
--left outer join(2) ������ ���� (+)��ȣ�� ǥ���Ҽ� �ִ�.
select u.name �̸�, u.addr �ּ�
from users u, carinfo c
where u.id = c.id(+) and c.id is null;
--right outer join�� ������ ���� (+)��ȣ�� ǥ���Ҽ� �ִ�.
select u.name �̸�, u.addr �ּ�
from users u, carinfo c
where u.id(+) = c.id and c.id is null;

select u.*, c.*
from users u        --left table
left outer join carinfo c
on u.id = c.id;

--5. ȸ���� ����� �ڵ��� ���� ����Ͻÿ�.
select u.name �̸�, count(*) �����_�ڵ���_��
from users u,carinfo c
where u.id = c.id
group by u.name;


--++���������� ��쵵 ������ .. u.id�� �׷�ȭ����.
--(1)�̷��� �ϸ� ����������. select u.name�� �������̴�.
select u.name �̸�, count(*) �����_�ڵ���_��
from users u,carinfo c
where u.id = c.id
group by u.id;

--(2)�׷���� ���ռӼ�����
select u.name �̸�, count(*) �����_�ڵ���_��
from users u,carinfo c
where u.id = c.id
group by (u.name,u.id); --group by ���ռӼ����� ��������



--6. 2�� �̻��� ������ ȸ���� �̸��� ������ �ڵ��� ���� ����Ͻÿ�.
select u.name �̸�, count(*) �����_�ڵ���_��
from users u,carinfo c
where u.id = c.id 
group by u.name having count(*) >= 2;

--group by ���ռӼ����� ���� �ذ�.
select u.name �̸�, count(*) �����_�ڵ���_��
from users u,carinfo c
where u.id = c.id
group by (u.name,u.id) having count(*) >= 2; --group by ���ռӼ����� ��������



--7. �ڵ����� ��ϵǾ� �ִµ� �����ڰ� ���� �ڵ��� ��ȣ�� ����Ͻÿ�. *right outer
--*���� ���� ���̺��� carinfo, �ι�°�� users
--�̳����ο� �������� ���ϴ� Ʃ���� ���Ѵ�.. �ƿ��� ����
--�ƿ��� �����϶��� � ���̺��� left�� �� ���ΰ�?? 

--right�� �ִ� carinfo�� ������. (from users right outer --> join carinfo)
select c.c_num as �����ڰ�_����_�ڵ�����ȣ
from users u
right outer join carinfo c
on u.id = c.id
where u.id is null;

-- left�� �ִ� carinfo�� ������ ( carinfo <--left outer join user)
select c.c_num as �����ڰ�_����_�ڵ�����ȣ
from carinfo c
left outer join users u
on u.id = c.id
where u.id is null;

--
select c.c_num �����ڰ�_����_�ڵ�����ȣ
from carinfo c, users u
where c.id = u.id(+) and u.id is null;


select *
from users u
left outer join carinfo c
on u.id= c.id;

select * from users u right outer join carinfo c on u.id = c.id;

select * from users; --1111 2222 3333 4444
select * from carinfo; -- 1111 3333 4444 5555 (id 5555,cnum:8888) �ڵ����� ���, ������ ����

--
create table companycar(     -- �ڵ��� ����
c_num varchar2(4),   -- ����ȣ
c_com varchar2(30),  -- ������
c_name varchar2(10),  -- ���̸�
c_price number);  -- �� ����

insert into companycar values ('1234','����','�ҳ�Ÿ',1000);
insert into companycar values ('3344','���','����',2000);
insert into companycar values ('7788','���','��2',800);
insert into companycar values ('9900','����','�׷���',2100);

--8. ���� �ڵ����� ����ȣ, ������, �ڵ�����, ������ ����Ͻÿ�.
--carinfo ���� �ڵ����� ������ ����.. ����ȣ�� carinfo �ذ� ����
--������� �ڵ��� ��� ������ companycar���̺� �ִ�.  ..  �̳�����
select c_num, c_com, c_name, c_price
from companycar;

select * from companycar; --1234 3344 7788 9900 
select * from carinfo; -- 1234 3344 7788 ;; 5566 6677 8888 

select c.c_num ����ȣ, c.c_com ������, c.c_name �ڵ�����, c.c_price ����
from carinfo a, companycar c
where a.c_num = c.c_num;
-- 9. ȸ�翡�����Ŵ� �Ͽ����� �������� ���� �ڵ����� ����ȣ, ������, �ڵ��� �̸��� ���  
-- company���� �ִµ� carinfo���� ���� �ڵ���

--����
--���̺��� ���� ������ ���غ���.
--companycar ���̺� ������ �ڵ��� ������ Ȯ��, �� �ڵ��� �����Ǿ�����
--Ȯ���ϱ� ���ؼ� carinfo���̺� Ȯ�� .. ������ �ڵ����� �̳�����
--������ �ȵ� �ڵ����� �ƿ��� ���� .. �̶� companycar�� left(������)
--(2) ����
select c.c_num ����ȣ, c.c_com ����ȸ��, c.c_name �ڵ����̸�
from carinfo a
right outer join companycar c
on a.c_num = c.c_num
where a.c_num is null;

--(1)
select *
from carinfo a
right outer join companycar c
on a.c_num = c.c_num;

--10. �ڵ��� ������ 1000���� �̻��� �ڵ����� �ڵ��� ��ȣ�� ����Ͻÿ�.
--�Ѱ��� ���̺� �ʿ��� ������ �� ����.
select c.c_num �ڵ�����ȣ
from companycar c
where c.c_price>=1000;

select *
from companycar c
where c.c_price>=1000;

--11. ������ �ڵ��� �߿� ȸ�翡�� ������ �ڵ����� �ƴ� �ڵ��� ��ȣ�� ����Ͻÿ�.
-- carinfo���� �ִµ� company���� ���� �ڵ���������
-- carinfo�� left�� ���ڴ�

select a.c_num �ڵ�����ȣ
from carinfo a
left outer join companycar c
on a.c_num = c.c_num
where c.c_num is null;

select *
from carinfo a
left outer join companycar c
on a.c_num = c.c_num;

--12. ��� ����� ������ ����Ͻÿ�. �̸�, �������� �ڵ�����ȣ, �ڵ����̸�
--���̺� 3�� ���� �ʿ�. �̴�� ������ ���ϰ� ������� 2���� �����ϰ�
-- �� ����� �����̺�� ���� ���̺��� ���� .. ����
 
--����(0) 
 select *
from users u
left outer join carinfo c
on u.id=c.id
;   
--- ���� (1)    
select *
from users u
left outer join carinfo c
on u.id=c.id
left outer join companycar cc
on c.c_num= cc.c_num;
-- ���� (2) , nvl�� '��'�� '����' ó��
select u.name �̸�, nvl(c.c_num,'����') ��������_�ڵ�����ȣ, nvl(cc.c_name,'����') �ڵ����̸�
from users u
left outer join carinfo c
on u.id=c.id
left outer join companycar cc
on c.c_num= cc.c_num;

/*
*����*
���̺��� ������ �ߺ��� �ּ�ȭ �ϱ� ���� ����ȭ �Ǿ�� �Ѵ�.
����ȭ�� ���̺��� �и��ϴ� �ǹ̰� �ִ�.
�׷���, �� ���񽺸� �̿��ϴ� �� ���忡���� 2�� �̻��� ���̺��� ������ �Ǿ�� �ϴ� ��찡 �ִ�.
�׷��� ����ȭ�� �������� �����̰�, ������ ���񽺸� �����ϴ� ������ ����̴�.
�׷��� , 2�� �̻��� ���̺��� ���εǾ�� �ϴ� ���񽺴�
���񽺰� �̿�ɶ����� db�� ���� ������ ����ؾ� �Ѵ�. ������ �����ϴ�
�����ϰ� �� ����� ������
�ذ� å�� �������� ���̺��� �����ϵ�, ���� ����� ��ģ ������ ���̺��� ����� ���̴�.
������ ���̺��� �������� ���̺��� �����ͷ� ������� �ִ�.
�̷� ������ ���̺��� ���� �Ѵ�.
*/

--12���� ���񽺸� �����ϱ� ���� view�� ����� ����.;'
--�÷����� ���������� ������ �ȳ���.

--view�� ���ؼ� insert update�� �̷������� ���������� table ���Ἲ�� �������ǿ� ���谡 ���� �ʾƾ� �Ѵ�.
--�̷������� view�� ��ȸ �������� ���� ����Ѵ�.

create view all_users as (
select u.name �̸�, nvl(c.c_num,'����') ��������_�ڵ�����ȣ, nvl(cc.c_name,'����') �ڵ����̸�
from users u
left outer join carinfo c
on u.id=c.id
left outer join companycar cc
on c.c_num= cc.c_num);

select * from all_users; -- view�̸����� ��ȸ�� �����ϴ�.

select �̸�,��������_�ڵ�����ȣ,�ڵ����̸�
from all_users;



commit;
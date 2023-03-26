/*
    ex08_aggregation_function.sql 
    
�Լ�   > �������� ���� ����Ŭ�� OOP�� �ƴϴ� �׷��� �Լ���� ���� ����.
�޼ҵ� > ��ü�� ������ �Լ� �ڹٴ� OOP��
    �Լ�, Function 
    1. ������ �Լ�(Built-in Function)
    2. ����� ���� �Լ�(User Function)  > ANSI-SQL(X) , PL/SQL(O) 
    
    �����Լ�, Aggreegation Function
    1. count()
    2. sum()
    3. avg()
    4. max()
    5. min()
    
    1. count() : ������ ���ش�. 
    - ��� ���̺��� ���ڵ� ���� ��ȯ�Ѵ�. 
    - number count(�÷���) 
    - null ���ڵ�� ����(***) > count(Į����)
                              count(*) null ����
*/

select name from tblCountry; -- �� ����� > ���ڵ� ������ ���� �ʹ�.
select count(name) from tblCountry; -- �� ����� > ���ڵ� ������ ���� �ʹ�. > ��ȯ���� ���ڵ� ���� - 14 > �̰͵� ���̺��̴�.
-- 1�� 1��¥�� ��� ���̺��̴�.

-- 'AS'�� ���� ���� ����? > �� 4���� ���� �ֽ��ϴ�. 
select count(name) from tblCountry where continent = 'AS';

select capital from tblCountry;            
select count(capital) from tblCountry;      

select population from tblCountry;         
select count(population) from tblCountry;      

-- tblCountry�� ���� �� �? 14
select count(name) from tblCountry;
select count(capital) from tblCountry;
select count(population) from tblCountry;

select * from tblAddressBook; -- �����Ͱ� �̳� ������ ����ִ°� �˾Ƴ��� ��ƴ�. 

select count(*) from tblCountry;  --null�� ������� ���̺��� �� ���� ��Ȯ�ϰ� �ľ�~ 
select * from tblCountry;         


-- ��� ������? 
-- ����ó�� �ִ� ������?
-- ����ó�� ���� ������?
select count(*) from tblInsa;      -- ��� ������?
select count(tel) from tblInsa; -- null ���� ���� ������ ����. ����ó�� �ִ� ������?
select count(*) - count(tel) from tblInsa; -- �����ͻ��� ������ null�� ������ ���´�. ����ó�� ���� ������?

select count(*) from tblInsa where tel is not null; -- 57��
select count(*) from tblInsa where tel is null;     -- 3��

-- tblInsa. � �μ����� �ֳ���?
select distinct buseo from tblInsa; -- 7���� �μ��� �ִ�.

-- tblInsa. �μ��� � �ֳ���?
select count(distinct buseo) from tblInsa; -- �ߺ����� ������ ���� ���� ��


-- tblComedian. ���ڼ�?, ���ڼ�?
select * from tblComedian;

select count(*) from tblComedian where gender = 'm';
select count(*) from tblComedian where gender = 'f';

-- *** ���� ���Ǵ� ����
select 
    case
        when gender = 'm' then 'A' -- �� ������ �������ؼ� �ƹ��� ��ã���� null�� ��ȯ�Ѵ�.
    end -- �� ��ü�� Į��
from tblComedian;

select 
    count(case
        when gender = 'm' then 'A' -- �� ������ �������ؼ� �ƹ��� ��ã���� null�� ��ȯ�Ѵ�.
    end) -- �� ��ü�� Į��
from tblComedian;

 -- �� ��ü�� Į��
 -- �� ������ �������ؼ� �ƹ��� ��ã���� null�� ��ȯ�Ѵ�.
select 
    count(*) as ��ü�ο���,
    count(case
        when gender = 'm' then 'A' 
    end) as �����ο���,
    count(case 
        when gender ='f' then 'B'
    end)  as �����ο��� -- null�� ���ַ��� ���������� �ϴ� ���̴�.   
from tblComedian;

-- tblInsa. �μ��� �ο��� 

-- ��ȹ�� ���? �ѹ��� ���? ���ߺ� ���? 
select count(*) from tblInsa where buseo = '��ȹ��'; -- 7
select count(*) from tblInsa where buseo = '�ѹ���'; -- 7
select count(*) from tblInsa where buseo = '���ߺ�'; -- 14


--select 
--    case
--        when buseo = '��ȹ��' then 1
--        when buseo = '�ѹ���' then 1 > ���� �����....
--    end
--from tblInsa; �̰� ���͸���. 

select   -- ���� ���� �����̴�.
    count(case
        when buseo = '��ȹ��' then 1
    end) as ��ȹ��,
    count(case
        when buseo = '�ѹ���' then 1
    end) as �ѹ���,
    count(case
        when buseo = '���ߺ�' then 1
    end) as ���ߺ� 
from tblInsa;

-- �����÷� or *
select count(name, buseo) from tblInsa; 

/*
    2. sum()
    - �ش� Į���� ���� ���Ѵ�.
    - number sum(�÷���)
    - �������� ���� ���� 
        
*/

select * from tblComedian;
select sum(height), sum(weight) from tblComedian;
-- select sum(first) from tblComedian; -- ���ڰ� �ƴѰ� ������ ��������. 
-- ORA-01722: invalid number
-- 01722. 00000 -  "invalid number"

select 
    sum(basicpay) as "���� �޿� ��",
    sum(sudang) as "���� ���� ��",
    sum(basicpay) + sum(sudang) as "�� ����",
    sum(basicpay + sudang) as "�� ����" -- Į�� ���Ѱŵ� �� ������ �� �� �ִ�. 
from tblInsa;

/*
    3. avg()
    -  �ش� �÷��� ��հ��� ���Ѵ�.
    - number avg(�÷���)
    - �������� ���� ���� 
*/


select sum(basicpay) / 60 from tblInsa;       -- 1556526
select sum(basicpay) / count(*) from tblInsa; -- 1556526

select avg(basicpay) from tblInsa;       -- 1556526

-- ������ ����Ʈ 
-- ��� �α���?
select 
    avg(population),         -- null ����x�и� ����                 - 15588
    sum(population)/count(*), -- null ���� �и� ������ ����          - 14475
    sum(population)/count(population) -- null ���� �и� ������ ����  - 15588
from tblCountry;
-- avg�� null Į�� ���ܵȴ�.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

select 
    count(*),           -- 14
    count(population)   -- 13
from tblCountry;

-- ȸ�� > ������ ���� > ������ ��ó > 1�� ����~
-- 1. �յ� ����: ���ڱ޾� / ��� ������ = sum() / count(*) 
-- 2. ���� ����: �����޾� / ���� ������ = sum() / count(�����ο���) = avg()
-- ���� vs ����

/*
    4. max()
    - object max(Į����)
    - �ִ� ��ȯ
    
    5. min()
    - object min(Į����)
    - �ּڰ� ��ȯ
    
    - ������, ������, ��¥�� ��� ���� 

*/

select max(height),min(height) from tblComedian; -- ������
select max(name), min(name) from tblInsa;         -- ������
select max(ibsadate), min(ibsadate) from tblInsa; --��¥��

select
    count(*) as "������",
    sum(basicpay) as "�ѱ޿� ��",
    avg(basicpay) as "��ձ޿�",
    max(basicpay) as "�ְ� �޿�",
    min(basicpay) as "���� �޿�"
from tblInsa;


-- ���� �Լ� ��� ������!!!!

-- �����Լ� > sum(), avg(), max(), min()

-- �����Լ� > count()


-- 1. tblCountry. �ƽþ�(AS)�� ����(EU)�� ���� ������ ����?? -> 7��
select * from tblCountry ;

select count(NAME) 
from tblCountry
where continent = 'AS' or continent = 'EU';

-- 2. �α����� 7000 ~ 20000 ������ ������ ����?? -> 2��
select count(NAME) 
from tblCountry
where population between 7000 and 20000;


-- 3. hr.employees. job_id > 'IT_PROG' �߿��� �޿��� 5000���� �Ѵ� ������ ���? -> 2��
select * from employees;

select count(employee_id) 
from employees
where job_id = 'IT_PROG' and salary > 5000;


-- 4. tblInsa. tel. 010�� �Ⱦ��� ����� ���?(����ó�� ���� ����� ����) -> 42��
select count(*)
from tblInsa
where tel NOT LIKE '010-%' and tel is not null;

select count(*), count(tel), count(*) - count(tel)
from tblInsa;


select * from tblInsa;
-- 5. city. ����, ���, ��õ -> �� ���� ���� �ο���? -> 18��
select count(city)
from tblInsa
where city NOT IN('����', '���', '��õ') and city is not null; -- �׷��� Ȥ�� �𸣴ϱ� ���� �Լ� ��� �� �� and Į���� is not null�� �ٿ��� �ϴ� �ɱ�?
-- 6. �����»�(7~9��) + ���� ���� �� ���? -> 7��
select count(NAME)
from tblInsa
where SUBSTR(ssn,4,1) IN ('7','8','9') and ssn LIKE '%-2%';
select SUBSTR('1234567',4,1) 
from dual;

-- 7. ���ߺ� + ������ �ο���? -> ���� ?��, ���� ?��, �븮 ?��, ��� ?��
select 
    count(
    case 
        when jikwi = '����' then 1
    end) as "����",
    count(
    case 
        when jikwi = '����' then 1
    end) as "����",
    count(
    case 
        when jikwi = '�븮' then 1
    end) as "�븮",
    count(
    case 
        when jikwi = '����' then 1
    end) as "���"
from tblInsa
where  buseo ='���ߺ�';


--sum()
--1. ������ ������ī�� ���� ������ �α� �� ��? tblCountry > 14,198
select sum(POPULATION)
from  tblCountry
where continent='EU' or continent='AF';


--2. �Ŵ���(108)�� �����ϰ� �ִ� �������� �޿� ����? hr.employees > 39,600
select sum(salary)
from   employees
where  manager_id = 108;

--3. ����(ST_CLERK, SH_CLERK)�� ������ �������� �޿� ��? hr.employees > 120,000
select sum(salary)
from employees
where job_id = 'ST_CLERK' or job_id = 'SH_CLERK' ; -- or�� ���Ĺ����� �Ǳ���

--4. ���￡ �ִ� �������� �޿� ��(�޿� + ����)? tblInsa > 33,812,400
select sum(basicpay + sudang)
from tblInsa
where city ='����';


select * from tblInsa;

--5. ���(����+����)���� �޿� ��? tblInsa > 36,289,000 > ������ ���� or�� Ȱ��
select sum(basicpay)
from tblInsa
where jikwi = '����' or jikwi = '����';

--avg()
--1. �ƽþƿ� ���� ������ ��� �α���? tblCountry > 39,165
select 
avg(population)
from tblCountry
where continent='AS';

--2. �̸�(first_name)�� 'AN'�� ���Ե� �������� ��� �޿�?(��ҹ��� ���о���) hr.employees > 6,270.4
select avg(salary)
from employees
where upper(first_name) LIKE '%AN%';

-- select upper(first_name), lower(first_name) from employees; -- upper�� lower��

--3. ���(����+����)�� ��� �޿�? tblInsa > 2,419,266.66
select avg(basicpay)
from  tblInsa
where jikwi='����' or jikwi='����';


--4. �����(�븮+���)�� ��� �޿�? tblInsa > 1,268,946.66 > �տ��� ���� ���ϱ� ������ or�̴�. 
select avg(basicpay)
from  tblInsa
where jikwi='�븮' or jikwi='���';


--5. ���(����,����)�� ��� �޿��� �����(�븮,���)�� ��� �޿��� ����? tblInsa > 1,150,320 ��
select -- Į�� Į���� case end ��� ���� ���ڰ� 
    avg(
    CASE
        when jikwi IN ('����', '����') then basicpay
    end)
    -
    avg(
    CASE
        when jikwi IN ('�븮', '���') then basicpay
    end) as ����
    from tblInsa;
-- �̰� 


--max(),min()
--1. ������ ���� ���� ������ ������? tblCountry > 959
select max(AREA)
from tblCountry;


--2. �޿�(�޿�+����)�� ���� ���� ������ �� �󸶸� �ް� �ִ°�? tblInsa > 988,000
select min(basicpay+sudang)
from tblInsa;



select TO_DATE('201501','YYYYMM') from dual;
select extract (day from to_date('2020/10/21'))
from dual;

-- ���� �Լ� ��� ������
select count(*) from tblInsa;
select name from tblInsa; 

select name, count(*) from tblInsa;
select name from tblInsa;
-- ORA-00937: not a single-group group function 
-- �÷� ����Ʈ�� �����Լ��� �Ϲ� �÷��� ���ÿ� ����� �� ����. > �ȵ�
-- ���� �Լ� ��� ������ 


select to_char(to_date('2015.01.01 10','YYYY.MM.DD HH24') + 1/24/(60/10), 'YYYY.MM.DD HH24:MI:SS') from dual;


-- �䱸 ����] ��� �޿����� �� ���� ���� ������ �������ÿ� 
select avg(basicpay) from tblInsa; 

select * from tblInsa where basicpay >= avg(basicpay); -- where������ �����Լ� �Ұ���
select * from tblInsa where basicpay >= (select avg(basicpay) from tblInsa); -- �̰� ���� > �������� > �� ��Į��



select *                         --3.
from tblInsa                     --1.
where basicpay >= avg(basicpay); --2. > where���� �ڹٷ� ġ�� �ݺ����̴�. �̰� ������ ����Ŭ�� 
                                 --   from�� ���̺��� ������ ���� �����͸� �ϳ��� �����ؼ� �� ������ �����. 
                                 --   where���� ������ �ǵ帮�� �����̴�.
                                 --   �������� �ٷ�� ������ where���̴ϱ� �������� ������ �ٷ� �� ���̳��� ���̴�. 




/* 
SQL > ����(sequel) ������ �̷��� �θ��⵵ ������ 
�װ��� ��ȣ��� ���Ƽ� sql�̶�� �ٲ� 
ex18_subquery.sql 

Main Query
- ���±����� SQL
- �Ϲ����� SQL 
- �ϳ��� ����ȿ� �ϳ��� select(insert, update, delete)�� ������ ������ ����������� �Ѵ�.

Sub Query 
- �ϳ��� ����(select, insert, update, delete)�ȿ� �� �ٸ� ����(select)�� ����ִ� ����
- �ϳ��� select���ȿ� ����ִ� �� �ٸ� select��
- ���� ��ġ > ���� ��ټ��� ��(select��, from��, where��,,<- ���� ����. ::: ���� �Ⱦ���. -> having��, order by��) 

*/

select * from tblCountry;

select max(population) from tblCountry;

-- ����
-- 1. 2���� sql> 1���� sql�� �����. 
-- 2. ��ȭ�� ���ϴ�.( �α��� ����) > ������ ���Ǽ� ��� 
select name from tblCountry where population in (select max(population) from tblCountry) ;

select name from tblCountry where population in (select avg(population) from tblCountry) ;

select max(weight) from tblComedian;
select * from tblInsa where basicpay = 2650000;

select * from tblInsa where basicpay = (select max(basicpay) from tblInsa);

-- tblInsa. ��������? ������ 05/09/26
select * from tblInsa where ibsadate = (select max(ibsadate) from tblInsa);

-- tblInsa. �հ���? ���μ� 95/02/23 
select * from tblInsa where ibsadate = (select min(ibsadate) from tblInsa);

-- ��� �޿����� �� ���� �޴� ����
select avg(basicpay) from tblInsa;
select * from tblInsa where basicpay >= (select avg(basicpay) from tblInsa);

-- tblInsa. 'ȫ�浿'���� �޿��� ���� ����?
select basicpay from tblInsa where name = 'ȫ�浿';

select * from tblInsa
    where basicpay >= (select basicpay from tblInsa where name ='ȫ�浿') and name <> 'ȫ�浿';


-- �������� ���� ��ġ

-- 1. ������
-- 2. �÷�����Ʈ
-- 3. from�� 

-- 1. ������
-- : �� ���(�񱳰�) ���� > ��
-- : where��, having��, case��

-- a. ��ȯ���� 1�� 1�� > ���ϰ� ��ȯ > �� 1���� ���
-- b. ��ȯ���� N�� 1�� > ���߰�(���� ������ �������� ������) ��ȯ > �� N���� ��� > ������ ��� > in 
-- c. ��ȯ���� 1�� N�� > ���߰�(���� �ٸ� ������ �������� ������) ��ȯ >
-- d. ��ȯ���� N�� N�� > ���߰� ��ȯ

-- a. ��ȯ���� 1�� 1�� > ���ϰ� ��ȯ > �� 1���� ���
select * from tblInsa 
    where basicpay >= (select avg(basicpay) from tblInsa);

-- b. ��ȯ���� N�� 1�� > ���߰�(���� ������ �������� ������) ��ȯ > �� N���� ���

-- �޿��� 260���� �̻� �޴� ������ �ٹ��ϴ� �μ� ���� ����� �������ÿ�. > ��ȹ�� + �ѹ��� 
-- select * from tblInsa
    -- where buseo = (select buseo from tblInsa where basicpay >= 2600000); > �ȵȴ� �񱳰� �߸��� > 1�� 2�� �񱳰� �ȵȴ�.
    -- where �μ� = ��ȹ��/�ѹ���
    -- ORA-01427: single-row subquery returns more than one row
    -- ���ڵ带 �ϳ��� ��ȯ�ϴ� �������� ��ġ�� 1�� �̻��� row�� ��ȯ�ߴ�. 

select * from tblInsa
    -- where buseo = '��ȹ��' or buseo ='�ѹ���';
    -- where buseo in ('��ȹ��', '�ѹ���'); -- ���� ������ N���� ������ > ������
    where buseo IN (select buseo from tblInsa where basicpay >= 2600000);

-- 'ȫ�浿'�� ���� ���� + ���� ���� > �Ҽ� �μ� ���� ���
select * from tblInsa where name = 'ȫ�浿'; -- ����, ���� 
select * from tblInsa where city = '����' and jikwi = '����';


select * from tblInsa -- Į���� �ٸ� ��� �̷��� ���� ���������� ���� �� 
    where city =(select city from tblInsa where name ='ȫ�浿') 
        and jikwi = (select jikwi from tblInsa where name = 'ȫ�浿')
            and name <> 'ȫ�浿';

select * from tblInsa
    where buseo in ('��ȹ��', '������'); -- city�� jikwi�� Į���� �޶� �ѹ��� in���� ��ĥ���� ����.
    
-- sub query�� ��ø�� ��ø�� ��ø�� �Ǵ� ��쵵 �ִ�.

select * from tblInsa 
    where buseo in (select buseo from tblInsa -- Į���� �ٸ� ��� �̷��� ���� ���������� ���� �� 
        where city = (select city from tblInsa where name ='ȫ�浿') 
            and jikwi = (select jikwi from tblInsa where name = 'ȫ�浿')
                and name <> 'ȫ�浿');
-- sub_query�� ��� ��� ��� �غ���

-- ���� ��ø ��ø ��ø ��ø ��ø �Ǵ� ��찡 ����. 




-- c. ��ȯ���� 1�� N�� > ���߰�(���� �ٸ� ������ �������� ������) ��ȯ >
-- 'ȫ�浿'�� ���� ���� + ���� ���� > � ������? 
select city from tblInsa where name = 'ȫ�浿';
select jikwi from tblInsa where name = 'ȫ�浿';

select * from tblInsa where city ='����' and jikwi = '����';

select * from tblInsa 
    where city = (select city from tblInsa where name = 'ȫ�浿')
        and jikwi = (select jikwi from tblInsa where name = 'ȫ�浿');
        -- �̷��� �Ǹ� �ϳ��� 1���� �ٸ� �÷��� 2���� ���� �� �ִ�.
        
select * from tblInsa
    where (city, jikwi) = (select city, jikwi from tblInsa where name ='ȫ�浿');
    -- 2��2 ���ε� ����� �������� Į������ ���缭 ���ؾ� �Ѵ�.
    
select * from tblAddressBook; --�⿹��(����, ����, ����, Ű)
select * from tblAddressBook
    where (gender ,age, job, height) = (select gender, age, job, height
                                        from tblAddressBook where name = '�⿹��');
                                        -- ������������ �ѹ� ������ ��������
                                        -- ���Ŀ� ��ü ������ ��������. 

select * from tblAddressBook;

select * from tblAddressBook
    where (gender ,hometown, job) = (select gender, hometown, job
                                        from tblAddressBook where name = '������');
                                -- n�������� ��ȯ���� 1���ϱ� �̷��� = ���� ����. 

-- d. ��ȯ���� N�� N�� > ���߰� ��ȯ
-- �޿��� 260�� �̻� �޴� ������ > ���� �μ� + ���� �������� ��� ����?
select * from tblInsa where basicpay >=2600000;

-- ���� + ��ȹ�� && �泲 + �ѹ��� 

-- ���ڵ嵵 2�� �÷ҵ� 2�� 
select city, buseo from tblInsa where basicpay >=2600000;


--select * from tblInsa
--    where (city, buseo) in (��������);
                         -- ���ڵ嵵 �������� �� in���� ����.     
    
select * from tblInsa
    where (city, buseo) in (select city, buseo from tblInsa where basicpay >= 2600000);
 

select 
    buseo,
    avg(basicpay)
from tblInsa
    group by buseo                       
        having avg(basicpay) >= 1500000; -- ��� ���� ��ſ� ���������� ����. 
                                         -- ��� ���� ���� ���������� ����. 
                                         
select 
    buseo,
    avg(basicpay)
from tblInsa
    group by buseo                       
        having avg(basicpay) >= (select avg(basicpay) from tblInsa where buseo = '���ߺ�');                                         
        
select 
    buseo,
    avg(basicpay)
from tblInsa
    group by buseo                       
        having avg(basicpay) >= (select avg(basicpay) from tblInsa where buseo = '�ѹ���');        
        

-- 2. �÷�����Ʈ
-- : ���� ������(��) > ���ڰ� > ������ �����ͺ��̽� > ǥ > �Ӽ�(�÷�)�� ���� ���ڰ��̾�� �Ѵ�.
-- a. �÷���
-- b. ���
-- c. ����
-- d. �Լ� 


-- �÷�����Ʈ���� ���������� ����ϱ�
-- -. ���������� ������� �ݵ�� 1�� 1���̾�� �Ѵ�. > ��Į�� ���� 
-- -  �������� > ��� �࿡ ������ ���� ��ȯ���ִ� �� > ���󵵰� ����. 
-- - ���� ���������� �� �Ⱦ������� 
-- �����������(��ȣ��������)��  ���� ����. >>> ���� ����.


select 
    name as "�÷�",
    100 as "���", -- �ϳ��ϳ��ϳ�
    basicpay + 100 as "����",
    length(name) as "�Լ�"
from tblInsa;          -- 50��
select * from tblInsa; -- 50��

select 
    name,
    (select sysdate from dual),
    sysdate
from tblInsa;

select 
    name,
    (select basicpay from tblInsa where name ='ȫ�浿') -- �������� 261������ �ݺ��ȴ�. > �ϳ�
from tblInsa;

select  -- ����!!!
    name, buseo, basicpay,
    avg(basicpay) -- ���ÿ� �÷����� ������. �ֳĸ� ��׵��� ������ �ٸ���. 
from tblInsa;

-- �ǰ� �Ϸ��� ���������� ���ȭ�� ��Ų��.     

select  -- �̷��� ������ �ȳ���.
    name, buseo, basicpay,
    (select round(avg(basicpay)) from tblInsa) as "��ձ޿�"-- �ϳ��� ���� ���ڸ� �������� ������ �ȵȴ�.
from tblInsa;
-- -  �������� > ��� �࿡ ������ ���� ��ȯ���ִ� �� > ���󵵰� ����. 


-- �ٵ� �� ������ �����Ͷ� ������ �����͸� �ϳ��� ���ڵ�� �־�??  >> ������. 

select avg(basicpay) from tblInsa;

select  -- �̷��� ������ �ȳ���.
    name, buseo, basicpay,                       -- ? �� �׳� buseo��� �ϸ� ������ ���Ѵ�. �׷��� ������ ���δ�. 
    (select round(avg(basicpay)) from tblInsa where buseo = ? ) as "�Ҽ� �μ� ��� �޿�"-- ������ �� �������� �ǹ̷� �ٲ۴�. 
from tblInsa ;  -- �ٱ��� ���������� �÷��� �������� �ҷ��� �� �־ '���� ���谡 �ִ� ������' ����ؼ� �������������. ��� �ϴ� �� 



-- �� ���ξ� ����Ұǵ� �̰� �Ѷ��ξ��� a.�÷���
select  -- �̷��� ������ �ȳ���.
    name, buseo, basicpay,                       -- ? �� �׳� buseo��� �ϸ� ������ ���Ѵ�. �׷��� ������ ���δ�. 
    (select round(avg(basicpay)) from tblInsa b where a.buseo = b.buseo ) as "�Ҽ� �μ� ��� �޿�"-- ������ �� �������� �ǹ̷� �ٲ۴�. 
from tblInsa a;                        -- �μ� �̸��� �����ֵ��� �Ҽ� �μ� ����� �����ϴ�.
-- ����Ŭ�� as�� �ٿ��� ���̺� alias�� ���Ѵ�. > ��ǻ� ���̺��� �ΰ��̰� �������� �ΰ��� ���̺��� ����� ���̴�. 

    
-- �ĺ��� ����
select * from tblInsa;

select * from hr.tblInsa; -- ������(��Ű��).���̺�� > �̷��� ���°� fm�̴�. 

select tblInsa.name, tblInsa.buseo, tblInsa.jikwi from hr.tblInsa;

select hr.tblInsa.name, hr.tblInsa.buseo, hr.tblInsa.jikwi from hr.tblInsa; 
-- ���� �̰� �� ��� 
-- ������.���̹ɸ�.Į����

select *, sysdate from tblInsa; -- ���ϵ� ī��� �Ϲ� �÷�ǥ���� ���ÿ� ���´�.
select *, name from tblInsa;    -- ���ϵ� ī��� �Ϲ� �÷�ǥ���� ���ÿ� ���´�.
-- �÷��� �� �������� ����ð��� �������� �ʹ�. > �̰� �ȵȴ�. 

select tblInsa.*, sysdate from tblInsa; --�� ���ϵ�ī�� �տ� ���̺� �̸��� ��������� ������ �ȴ�.
-- ���ϵ�ī��(*)�� �ٸ� Į���� ���ÿ� �������� ��� > ���̺��.* 

-- �÷��� ��Ī > ��ȿ�� �̸��� ����� ���ؼ� + �ǹ��ְ� ���´�. 
-- ���̺� ��Ī > �ִ��� �ٿ��� > ���� ���ĺ� 1���ڷ� ���´�. > �÷� ��Ī�� �ٸ� �����̴�. 

-- �� SQL�� ��Ī(ALIAS) > ����(X), ����(O)�̴�. > �̸��� ��� ��ġ�� ���̴�. 

-- ������ ����. ȣ����� ������ �׷���. 
select tblInsa.*, sysdate  -- 2. �� �ܰ迡���� tblInsa �ν��� ���Ѵ�. > ��� i�� ���� 
from tblInsa i;            -- 1. > �� �� tblInsa�� ������ i�� ���� �ٲܰž�! 

-- �� ������ �ƴ϶� �����̴�. �Ʒ��� �����ϴ�. 
select i.*, sysdate      
from tblInsa i;          

select 
    name, buseo, basicpay,    -- ���� ?�� �� ����� �̽� �׷��� �ٱ��� from table�� �μ��� �����ٰ� ���´�.
    (select round(avg(basicpay)) from tblInsa where buseo=  ? ) as "�Ҽ� �μ� ��� �޿�"
from tblInsa;

select  -- �̰� ������������� ���̰� ���󵵴� ����. 
    name, buseo, basicpay,  
    (select round(avg(basicpay)) from tblInsa where buseo= i.buseo ) as "�Ҽ� �μ� ��� �޿�"
from tblInsa i; -- �ٵ� �̰� ���̺��� �״�ξ���? �ƴϴ�. �� �׷��� i�� ���̰� �� �ٱ��� ���̺��� �����ٰ� ����. 

select * from tblMen;
select * from tblWomen;

drop table tblMen;
drop table tblWomen;

CREATE TABLE tblmen
(
   name varchar2(30) primary key,
   age number not null,
   height number null,
   weight number null,
   couple varchar2(30) null
);

CREATE TABLE tblwomen
(
   name varchar2(30) primary key,
   age number not null,
   height number null,
   weight number null,
   couple varchar2(30) null
);

INSERT INTO tblmen VALUES ('ȫ�浿', 25, 180, 70, '�嵵��');
INSERT INTO tblmen VALUES ('�ƹ���', 22, 175, NULL, '�̼���');
INSERT INTO tblmen VALUES ('������', 27, NULL, 80, NULL);
INSERT INTO tblmen VALUES ('����', 21, 177, 72, NULL);
INSERT INTO tblmen VALUES ('���缮', 29, NULL, NULL, '���');
INSERT INTO tblmen VALUES ('�ڸ��', 30, 170, NULL, '������');
INSERT INTO tblmen VALUES ('������', 31, 183, NULL, '�ź���');
INSERT INTO tblmen VALUES ('������', 28, NULL, 92, NULL);
INSERT INTO tblmen VALUES ('�缼��', 22, 166, 55, '��ΰ�');
INSERT INTO tblmen VALUES ('����ȣ', 24, 165, 58, '������');

INSERT INTO tblwomen VALUES ('�ڳ���', 23, 150, 55, NULL);
INSERT INTO tblwomen VALUES ('�嵵��', 28, 177, 65, 'ȫ�浿');
INSERT INTO tblwomen VALUES ('������', 30, 160, NULL, '�ڸ��');
INSERT INTO tblwomen VALUES ('���', 34, 158, NULL, '���缮');
INSERT INTO tblwomen VALUES ('������', 27, NULL, NULL, '����ȣ');
INSERT INTO tblwomen VALUES ('��ΰ�', 22, 169, 88, '�缼��');
INSERT INTO tblwomen VALUES ('ȫ����', 20, 158, 75, NULL);
INSERT INTO tblwomen VALUES ('�ź���', 26, 170, 60, '������');
INSERT INTO tblwomen VALUES ('�̼���', 28, 163, NULL, '�ƹ���');
INSERT INTO tblwomen VALUES ('�ź���', 27, 162, NULL, NULL);

COMMIT;

-- tblMen <- (����) -> tblwomen;
select * from tblmen;
select * from tblwomen;

-- ���� ���(�̸�, ����) ��� > ����ģ���� ������ ����ģ��(�̸�, ����)�� ���� ����Ͻÿ�.
select 
    name, age, couple -- ���� couple�̶�� �÷����� �ֱ⿡... 
from tblMen;

--> �����������!! 
select  -- ������������� �̷��� �̿��Ѵ�. "�ٱ��� ���� ���̺��� ���� ���̺��� �����´�."
    name, age, couple,
    (select age from tblwomen where name = tblmen.couple)
from tblmen; 

-- 3. from��
-- : ���������� ������� �ϳ��� ���̺��̶�� �����ϰ�, �� �ٸ� select�� ����~ 
-- : ������ �ܼ�ȭ�ϱ� ���ؼ� ����Ѵ�.
select 
*
from ( select * from tblInsa ); 
-- 1. ������ �ϳ� ������ ��� ���̺��� ���´�. -> �� ���̺��� �����̶� ������ �� 

select 
    * -- ��� �÷�(name, buseo, jikwi)
from (select name, buseo, jikwi from tblInsa); -- �� �̳��� �÷��� �����Ѵ�. �̰���������.

select -- ����!!!!
    name, ssn
from ( select name, buseo, jikwi from tblInsa); -- �ζ��κ� ������������ ssn�� �Ȳ����� ������ ����. 

select   -- ����!!!
    name --���� select������ ��Ī�� �ٿ��µ� ��Ī�� �̸��� �ٲٴ� ���̴�. ����!! 
from ( select name as �̸�, buseo, jikwi from tblInsa); -- ��Ī ������ �̰ŵ� ������.

select  
    �̸� -- alias������ ����ؾ� �Ѵ�!  
from ( select name as �̸�, buseo, jikwi from tblInsa); -- ��Ī ������ �̰ŵ� ������.

select 
    name, length(name) -- length�� �ι� ȣ��ȴ�. ���� ������ ������ ��ȿ�����̱⵵ �ϴ�.
from(select name, length(name) as len from tblInsa);

select 
    name, len         -- ��! �׷� ��Ī�� �ٷ� �����ٰ� ����. 
from(select name, length(name) as len from tblInsa);

select 
    *
from ( select name, age, couple 
     ,(select age from tblwomen where name = tblmen.couple ) as age2
from tblMen) ; -- ORA-00918: column ambiguously defined : �÷��� ��ȣ�ϰ� ���ǵǾ� �ִ�.> ������ �÷����� �ΰ��� �ִ�. 
-- ���������� join�� ���� ���� ������ �̸��� �÷��� ����� �����ϰ� �̷� ������ ����. �׷��� �Ӽ����� �ٲٸ� �ȴ�.
-- join�� ���� �� 
-- ��κ��� ���� �̸��� �Ȱ��� ������൵ �� �Ȱ��� ǥ�⸦ �ϴµ� developer�� �ٸ��� �ؼ� �����ش�. 
-- ������������� ����� �� �̰� ��������.
    
-- employees. 'Munich'�� ��ġ�� �μ��� �Ҽӵ� ���� ���? 
select * from employees;   -- department_id �Ҽ� �μ� 
select * from departments; -- location_id   ��ġ ����  
select * from locations;    

-- ��� ��ġ�� ��ġ ���̵�
select location_id from locations
    where city = 'Munich';
 
-- �μ������� ��ġ ���̵� ��ġ�������� �����̶� ������ 
select * from departments
    where location_id = (select location_id from locations where city = 'Munich');


-- ���� department_id�� �μ��� �ÿ�Ʋ�� �ִ� ��ġ ���̵�� ���� �μ� 
select * from employees
    where department_id in (select department_id from departments 
                            where location_id = (select location_id from locations
                                                  where city = 'Seattle'));


-- �� with���� �� ������� with�������� ���� ������ �����ϴ�. 
-- �� with table1 as () select ~ �̷������� ¥�� �ȴ�. 
-- �� with table1 as () , table2 as () select ~ �̷������� ¥�� �ȴ�. 

--WITH TEST AS (SELECT a.deptno AS deptno1 , b.emptno FORM a, b) ,
--     TEST2 AS (SELECT a.deptno AS deptno2, a.salaray , c.voc , c.label FROM a,c)
--SELECT * FROM TEST, TEST2 WHERE TEST.deptno1 = TEST2.deptno2;




-- �� �÷��� �����Լ�, �Ϲ� �÷��̶� ���� ������. 
-- �� ���� ū �� ���̺� ���ǿ� �´� �ɷ� ã�� ����, �׸��� �̰� from���� �ִ� �ζ��κ�� ����� �̰� ���̺�� �����ؼ� > rownum=1�� �����´�.

select * from employees;

select * from departments;

-- tblMen. tblWomen. ���� ¦�� �ִ� ��� �� / ���ڿ� ������ ������ ��� �������ÿ�. > select��
--    [����]        [����Ű]   [���ڸ�����]     [����]    [����Ű]   [���ڸ�����]
--    ȫ�浿         180       70              �嵵��     177        65
--    �ƹ���         175       null            �̼���     163        null
--    ..
select * from tblmen;

select  -- ��Į�� �� �������� ���� ����� �ֱ��ѵ�... �ʹ� ��ȿ�����̴�. 
    m.name "[����]", m.height "[����Ű]", m.weight "[���ڸ�����]", w.name "[����]", w.height  "[����Ű]", w.weight "[���ڸ�����]"
from tblmen m, tblwomen w
where m.couple = w.name;


-- tblAddressBook. ���� ���� ������� ������ �ִ� ������ / �ַ� ��� ���� �»�(hometown)�ΰ�? > where��
--                           1. ������ ã��                     �� �������� hometown�� �� group by�ؼ� 

-- 1��-- ���⿡ count(*)�� max�� �ɸ� job�� ������.   -- 332��� ���ڸ� ã�Ҵ�. 
select max(count(*))  
from tblAddressBook 
group by job 
order by count(*); 


-- ���⿡ count(*)�� max�� �ɸ� job�� ������. 
select job 
from tblAddressBook group by job having count(*) = ( select max(count(*)) from tblAddressBook group by job);

select hometown, count(*) from tblAddressBook where job = (select job 
from tblAddressBook group by job having count(*) = ( select max(count(*)) from tblAddressBook group by job)) group by hometown;

-- tblAddressBook. �̸��� �����ε� �� / ��� ���̵� ���̰� / ���� ��  / �̸��� ����Ʈ�� �������� �����ΰ�? > group by + having
with test as (
select 
-- substr(email, instr(email, '@') + 1) as "������",
max(avg(length(substr(email, 1, instr(email, '@') - 1)))) as maxlen -- ��վ��̵� ���� > length > avg > max�� ���ϰ� �̱�
from tblAddressBook
group by substr(email, instr(email, '@') + 1) )

select substr(email, instr(email, '@') + 1) "������" -- , avg(length(substr(email, 1, instr(email, '@') - 1)))
from tblAddressBook
group by substr(email, instr(email, '@') + 1)  -- �̰� ������ 
having avg(length(substr(email, 1, instr(email, '@') - 1))) = ( select maxlen from test );


-- tblAddressBook. ��� ���̰� ���� ���� ���(hometown)���� ������ �ִ� ���� �� ���� ���� ������? > where + group by + having
-- with������ ���� ������ �����ϴ�. 
with test as ( -- ���� ���� ��ճ��� ����
select max(avg(age)) as maxAge
from tblAddressBook
group by hometown
), 

test2 as ( -- ���� ���� ��ճ��� hometown ����
select hometown 
from tblAddressBook
group by hometown
having avg(age) = ( select maxAge from test )
)
select job
from ( -- ������������ ���ֿ��� �������� ����
select job, count(*)
from tblAddressBook
where hometown = (select hometown from test2)
group by job
order by count(*) desc -- ������������ �����ϰ� �̰� from�� ������ ó�� 
)
where rownum =1; -- �������� rownum=1 ó���� �Ѵ�. 

-- tblAddressBook. ���� ��� ���̺��� ���̰� ���� ���� �»� + ������ ������ �ִ� ������� �������ÿ�. > where��
select distinct job
from tblAddressBook where job ='����غ��';

select *
from tblAddressBook 
where age > ( select avg(age) from tblAddressBook where gender = 'm' ) and hometown = '����' and job not in ('����غ��','���');

-- tblAddressBook. gmail.com�� ����ϴ� ������� ���� > ���뺰(10,20,30,40��) �ο����� �������ÿ�. > where�� > ������? 
select * from
tblAddressBook ;
-- 1 �ܰ� 
select substr(email, instr(email, '@')+1) from 
tblAddressBook ;


with test as (
select 
case
when gender ='f' then '����' else '����'
end as genderstr,
case
when age between 10 and 19 then '10��'
when age between 20 and 29 then '20��'
when age between 30 and 39 then '30��'
when age between 40 and 49 then '40��'
end as ���̴�
from tblAddressBook 
where substr(email, instr(email, '@')+1) = 'gmail.com'
)
select genderstr as "����", ���̴�, count(*) from test
group by genderstr, ���̴�
order by genderstr;

select *
from tblAddressBook where substr(email, instr(email, '@')+1) = 'gmail.com';








-- tblAddressBook. ���� ���̰� �����鼭 ���� �����԰� ���� ������ ����� / ���� ������ ������ ������� �������ÿ�. > where��
select *
from tblAddressBook 
where age = (select max(age) from tblAddressBook); -- �������̳� 
select max(age) from tblAddressBook;


with findJob as  (
select job
from tblAddressBook 
where age = (select max(age) from tblAddressBook) and weight = (select max(weight) from tblAddressBook)
)

select * 
from tblAddressBook
where job = (select job from findJob);

-- tblAddressBook.  ���������� ������ �ֽ��ϴ�. �� �� ���� �ο����� ���� ��������(��� �̵���)�� ����� �������ÿ�. > where��
with test as (
select name 
from (
select name, count(*)
from tblAddressBook
group by name
order by count(*) desc
)
where rownum = 1
)
select * from tblAddressBook
where name = ( select name from test );

-- tblAddressBook. ���� ����� ���� ������(332��) ���뺰 ������ ���Ͻÿ�.> where + group by + having
--    [10��]       [20��]       [30��]       [40��]
--    8.7%        30.7%        28.3%        32.2%

with test as (select job
from
(
select job, count(*)
from tblAddressBook
group by job
order by count(*) desc
)
where rownum=1)

,test2 as (
select 
case
when age between 10 and 19 then '10��'
end a, 
case 
when age between 20 and 29 then '20��'
end b, 
case
when age between 30 and 39 then '30��'
end c, 
case
when age between 40 and 49 then '40��'
end d
from tblAddressBook 
where job = (select job from test)
)
select round(count(a)/count(*)*100, 1) || '%' "[10��]",
       round(count(b)/count(*)*100, 1) || '%' "[20��]",
       round(count(c)/count(*)*100, 1) || '%' "[30��]",
       round(count(d)/count(*)*100, 1) || '%' "[40��]"
       from test2;





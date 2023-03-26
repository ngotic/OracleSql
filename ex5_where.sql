/*


    ex5_where.sql
    
                                                  - select��
    [ WITH <Sub Query> ]                          - with�� 
    SELECT column_list                            - select��    // : �� �ΰ����� ����
    FROM table_name                               - from��
    [ WHERE search_condition]                     - where��
    [ GROUP BY group_by_expression]               - group by��
    { HAVING search_condition]                    - having��
    [ ORDER BY order_expression [ASC | DESC] ]    - order by��
    
    select Į������Ʈ         --3. �÷� ����
    from ���̺�               --1. ���̺� ���� 
    where ����;              --2. ���� ����
    
    where ��
    - ���ڵ带 �˻��Ѵ�. 
    - ���ϴ� �ุ �����ϴ� ���� > ����� ��ȯ 
    
*/

-- �÷�(5), ���ڵ�(14)
select *
    from tblCountry
        where name = '���ѹα�'; -- ���ѹα��� ������ ����;
        -- �̷��� ��� row�� ���ؼ� ����� yes or no�ε� no�� �˴� ������. 
        
select *                        -- ���� �ɷ��ش�.
    from tblCountry             -- 1.
        where continent = 'AS'; -- ������ > ���� �ɷ��ش�.
    
    
select * 
    from tblInsa
    where basicpay > 2000000;  -- 19��
    
    
select * 
    from tblInsa
    where basicpay <= 2000000;  -- 41��
        
        
select *                        -- 14��
    from tblInsa
        where buseo = '���ߺ�'; 
        
select *                        -- 46��
    from tblInsa
        where buseo <> '���ߺ�'; -- ���ߺ� ���� ������ �༮��
        
select *                        
    from tblInsa
        where buseo = '���ߺ�' and jikwi = '����'; --&& �� ���� ������
        -- where buseo = '���ߺ�' && jikwi = '����'; --&& �� ���� ������

select * 
    from tblInsa 
        where city = '����' or city = '���';
        
select * 
    from tblInsa 
        where not buseo = '���ߺ�';              -- ���ߺΰ� �ƴϴ�. 
            
-- tblComedian
-- 1. �����԰� 60kg �̻��̰�, Ű�� 170cm �̸��� ����� �������ÿ�. 3��
desc tblComedian;
select * 
from tblComedian
where HEIGHT < 170 and WEIGHT >= 60;
--select 
-- 2. �����԰� 70kg ������ ���ڸ� ����������. 1�� 
select *
from tblComedian
where WEIGHT <= 70 and GENDER ='f';     -- sql�� ��ҹ��ڸ� ������ ������ �����ʹ� ��ҹ��ڸ� ������.`

-- tblInsa
-- 3. �μ��� '���ߺ�'�̰�, �޿��� 150���� �̻� �޴� ������ �������ÿ�. 4��
desc tblInsa;
select * from tblInsa;
select *
from tblInsa
where BUSEO='���ߺ�' and BASICPAY >= 1500000;

-- 4. �޿�(basicpay) + ����(sudang)�� ���� �ݾ��� 200���� �̻� �޴� ������ �������ÿ�. 26��      
select *
from  tblInsa
where  BASICPAY+SUDANG >= 2000000; -- �̰��� Į���� ������ ��, -- �����Լ��� >>> row ���̵鿡���� ���̴�. 


/*
    between 
    - where ������ ��� > �������� ���
    - �÷��� between �ּڰ� and �ִ�
    - ���� ���� 
    - ������(***)
    - �ּڰ�, �ִ� > ���� 
*/

-- �̰� �� �� �ִ°� between �̴�. 
select * from tblComedian
    where height >= 170 and height <= 180;
    
-- �� ��, �Ʒ� �� ������ �����ϴ�. > ������ ������ ����. 

select * from tblComedian
    where height between 170 and 180;

select * from tblComedian
    where 180 >= height and 170 <= height;

select * from tblComedian 
    where height between 172 and 178;
    
-- �񱳿��� 
-- 1. ������
select * from tblInsa where basicpay >= 1500000 and basicpay <= 2000000;
select * from tblInsa where basicpay between 1500000 and 2000000;

-- 2. ������
select * from tblInsa where name >= '��'; -- sql�� �̷��� �����ڵ� �񱳰� �ٷ� �ȴ�. �ʹ��� ���ϴ�.
select * from tblInsa where name >= '��' and name <= '��';
select * from tblInsa where name between '��' and '��';

-- 3. ��¥�ð���
desc tblIns;

select * from tblInsa where ibsadate >= '2000-01-01';   -- �̷��� ���� �񱳰� �����ϴ�.
-- 2000�� ���Ŀ� �Ի��� ������ 
select * from tblInsa where ibsadate >= '2001-01-01' and ibsadate <='2005-12-31';

select * from tblInsa where ibsadate between '2000-01-01' and '2000-12-31';

/*

    in
    - where ������ ��� > ������ �ǻ��
    - ������ ����
    - �÷��� in ( ��, ��, ��..)
    - ������ 
    
*/

-- ȫ���� or ���ߺ�
select * from tblInsa where buseo = 'ȫ����' or buseo = '���ߺ�' or buseo = '�ѹ���'; -- 
select * from tblInsa where buseo in ('ȫ����', '���ߺ�', '�ѹ���');

select * from tblInsa
    where jikwi in ('����','����') and city in ('����', '��õ')
    and basicpay between 2500000 and 3000000;

-- between, in > ������ ���Ѵ� ��ü��, �ٵ� �������� ���� ����. �����ϰ� �Ǵ��ؾ��ϴ� ��Ȳ�� �ִµ� �ڱ� �������� �Ǵ� x 
-- �������ҿ� ��� �Ѵ�. 
/*
    like
    - where������ ��� > �������� ���
    - ���� �� 
    - �÷��� like '���� ���ڿ�'
    - ���� ǥ���� �ʰ��� ���� 
    
    ���� ���ڿ� ������� 
    1. _: ������ ���� 1�� (.)
    2. %: ������ ���� N�� 0~���Ѵ� (.*)
    
*/

select name from tblInsa;

-- ��OO
select name from tblInsa where name like '��__';  -- �� ã�´�. 
select name from tblInsa where name like '��_';   -- ����ٸ� �ϳ��� ���� ��ã�´�. 
select name from tblInsa where name like '__��';   -- ����ٸ� �ϳ��� ���� ��ã�´�. 
select name from tblInsa where name like '_��_';   -- ����ٸ� �ϳ��� ���� ��ã�´�. 

select name from tblInsa where name like '��%';

select * from tblAddressBook;

select * from tblAddressBook
where address like '����Ư����%';

select * from tblAddressBook
where address like '%���빮��%';


select * from tblAddressBook where name like '��%';
select * from tblAddressBook where name like '%��';
select * from tblAddressBook where name like '%��%'; -- �̶�� ���ڰ� ������ �Ǿ� ������ �� ã�´�. 

-- 771212-1022432 > SSN�� �ֹι�ȣ��. 
-- ��������
select * from tblInsa; 
select * from tblInsa where ssn like '______-2______';
select * from tblInsa where ssn like '%-2%'; -- �̷��� �ص� ������ �Ѵ�.

/*
    RDBMS������ null 
    - �ڹ��� null ����
    - �÷���(��)�� ����ִ� ���� 
    - null ��� ����
    - ��κ��� ���� null�� ������ ����� �� �� ����.(***********)
    < � ���� null==null �̷��� �Ǳ��� >
    
    10 + 20 = 30
    10 + null = ? ����� ����. > ����� null
    
    null ���� 
    - where������ ���
    
    
*/

-- �α����� �̱���� ����? 
select * from tblCountry; -- null�� �ǻ��� �ƹ��͵� ����. > ���������� ���� �ȳ־ �Ǵ� ��쿡�� ���Է� �����ε� �� �� null�� ��ü�� �ִ´�. 


select * from tblCountry where population = null;  -- X
select * from tblCountry where population is null; 


select * from tblCountry where population <> null; -- X
select * from tblCountry where population is null;
select * from tblCountry where population is not null; -- ��ȣ�� ����(������) 


select * from tblTodo;

select * from tblTodo where completedate is null; -- ��ȣ�� ����(������)

-- ������ > �뿩 ���̺�(�Ӽ�: �뿩��¥, �ݳ���¥ )
-- ���� �ݳ��� ���� �����?

-- ���� �ݳ��� ���� �����?
select * from �����뿩 where �ݳ���¥ is null;

-- �ݳ��� �Ϸ�� �����?
select * from �����뿩 where �ݳ���¥ is not null;



-- �䱸����.001.tblCountry
-- ��� ��� ��� �÷��� �������ÿ�.
select * from tblCountry;


-- �䱸����.002.tblCountry
-- ������� �������� �������ÿ�.
desc tblCountry;
select name, capital from tblCountry;


-- �䱸����.003.tblCountry
-- �Ʒ��� ���� �������ÿ�
-- [������]    [������]   [�α���]   [����]    [���] <- �÷���
-- ���ѹα�   ����        4403       101       AS     <- ������
-- �� ������ �ǵ��� Alias�� ���̶�� ����. ������ ���� �̸��� �� column �̸��� �� ���� name�̴�. 
select name "������", 
       capital "������",
       population "�α���",
       area "����",
       continent "���"
from tblCountry;



--�䱸����.004.tblCountry
--�Ʒ��� ���� �������ÿ�
-- [��������]                                  <- �÷���
-- ������: ���ѹα�, ������: ����, �α���: 4403   <- ������ : �ϳ��� ���ڿ��̴�. �÷��÷��÷��÷��� ���ϱ� �غ���� �̾߱�. || 
select '������: ' || name || ', ������: ' || capital|| ', �α���: ' || population as "��������"  
from tblCountry;

--�䱸����.005
--�Ʒ��� ���� �������ÿ�.employees
-- [�̸�]                [�̸���]            [����ó]          [�޿�]
-- Steven King           SKING@gmail.com   515.123.4567      $24000
desc employees;

-- �� '����' >>>>>> ���
-- "�̰�" alias���� �鰨

select * from employees;
select first_name || last_name as "�̸�",  EMAIL "�̸���", PHONE_NUMBER "����ó", '$'||SALARY "�޿�"
from employees;


--�䱸����.006.tblCountry
--����(area)�� 100������ ������ �̸��� ������ �������ÿ�.
select name "������", area "����"
from tblCountry
where area <= 100; -- 9��


--�䱸����.007.tblCountry
--�ƽþƿ� ���� ����� ���� ���� �������ÿ�.
-- select 
desc tblCountry;
select * from tblCountry;
--
--CAPITAL             VARCHAR2(30) 
--POPULATION          NUMBER       
--CONTINENT           VARCHAR2(2)  
--AREA                NUMBER  
select name
from tblCountry
where CONTINENT='AS' or CONTINENT='EU'; -- 7�� 


--�䱸����.008.employees
--����(job_id)�� ���α׷���(it_prog)�� ������ �̸�(Ǯ����)�� ����ó �������ÿ�.
select * from employees;

select first_name || ' ' || last_name "�̸�", phone_number "����ó"
from employees
where job_id='IT_PROG';


--�䱸����.009.employees > 2��
--last_name�� 'Grant'�� ������ �̸�, ����ó, ��볯¥�� �������ÿ�.
select first_name || ' ' || last_name "�̸�", phone_number "����ó", hire_date "��볯¥"
from employees
where last_name = 'Grant';

--�䱸����.010.employees > 8��
--Ư�� �Ŵ���(manager_id: 120)�� �����ϴ� ������ �̸�, �޿�, ����ó�� �������ÿ�.
select first_name || ' ' || last_name "�̸�",  '$' || SALARY "�޿�" , phone_number "����ó"
from employees
where manager_id = 120;


--�䱸����.011.employees > 45��
--Ư�� �μ�(60, 80, 100)�� ���� �������� �̸�, ����ó, �̸���, �μ�ID �������ÿ�.
select  first_name || ' ' || last_name "�̸�", phone_number "����ó", email "�̸���", DEPARTMENT_ID "�μ�ID"
from employees
where department_id IN ( 60, 80, 100) ;


select *
from tblInsa;

--�䱸����.012.tblInsa > 7��
--��ȹ�� ������ �������ÿ�.
select * 
from tblInsa
where buseo='��ȹ��';

--�䱸����.013.tblInsa
--���￡ �ִ� ������ �� ������ ������ ����� �̸�, ����, ��ȭ��ȣ �������ÿ�.
select name "�̸�", jikwi "����", tel "��ȭ��ȣ"
from tblInsa
where city ='����' and jikwi='����' ;

--�䱸����.014.tblInsa > 9
--�⺻�޿� + ���� ���ļ� 150���� �̻��� ���� �� ���￡ ������ �������ÿ�.
select *
from  tblInsa
where (basicpay + sudang) >= 1500000 and city ='����' ;

--�䱸����.015.tblInsa > 28
--������ 15���� ������ ���� �� ������ ���, �븮�� �������ÿ�.
select *
from tblInsa
where sudang <= 150000 and jikwi IN ( '���', '�븮' );

--�䱸����.016.tblInsa > 3
--������ ������ �⺻ ������ 2õ���� �̻�, ����, ���� ����(����)�� �������ÿ�.
select *
from tblInsa
where basicpay*12 >= 20000000 and city ='����' and jikwi IN ('����','����') ;


--�䱸����.017.tblCountry > 4
--������ 'O��'�� ���� �������ÿ�.
select * 
from tblCountry
where name Like '%��';


--�䱸����.018.employees
--����ó�� 515�� �����ϴ� ������ �������ÿ�.
select * 
from employees
where PHONE_NUMBER Like '515%';
    

--�䱸����.019.employees > 35
--���� ID�� SA�� �����ϴ� ������ �������ÿ�.
select * 
from employees
where JOB_ID Like 'SA%';

    

--�䱸����.020.employees
--first_name�� 'de'�� �� ������ �������ÿ�.
select * 
from employees
where FIRST_NAME Like '%de%';


--�䱸����.021.tblInsa
--���� ������ �������ÿ�.
select * 
from tblInsa
where SSN LIKE '%-1%';

-- �䱸����.022.tblInsa
--���� ������ �������ÿ�.   
select * 
from tblInsa
where SSN LIKE '%-2%';


--�䱸����.023.tblInsa
--������(7,8,9��) �¾ ������ �������ÿ�.
select * 
from  tblInsa
where SUBSTR(SSN,3,2) IN ('07','08','09');



--�䱸����.024.tblInsa
--����, ��õ�� ��� �达�� �������ÿ�.    
select * 
from  tblInsa
where city IN ('��õ', '����') and name LIKE '��%';


--�䱸����.025.tblInsa
--������/�ѹ���/���ߺ� ���� �� �����(���/�븮) �߿� 010�� ����ϴ� �������� �������ÿ�.
select * 
from  tblInsa
where buseo IN ('������', '�ѹ���', '���ߺ�') and jikwi IN ('���', '�븮') and tel LIKE '010-%';


--�䱸����.026.tblInsa
--����/��õ/��⿡ ��� �Ի����� 1998~2000�� ������ �������� �������ÿ�.
select * 
from  tblInsa
where ibsadate >= '1998-01-01' and ibsadate <='2000-12-31' and city IN ('��õ', '����', '���');
 
--�䱸����.027.employees > 1
--�μ��� ���� ���� �ȵ� �������� �������ÿ�. (department_id�� ���� ����)
select * 
from  employees
where department_id is null;



-- �䱸����.001.tblCountry
-- ��� ��� ��� �÷��� �������ÿ�.
select * from tblCountry;

-- �䱸����.002.tblCountry
-- ������� �������� �������ÿ�.
select name, capital from tblCountry;

-- �䱸����.003.tblCountry
-- �Ʒ��� ���� �������ÿ�. ��� ����
-- [������]    [������]   [�α���]   [����]    [���]   <- �÷���
-- ���ѹα�   ����        4403       101       AS     <- ������
select
    name as "[������]",
    capital as "[������]",
    population as "[�α���]",
    area as "[����]",
    continent as "[���]"
from tblCountry;

--�䱸����.004.tblCountry
--�Ʒ��� ���� �������ÿ�
-- [��������]                                   <- �÷���
-- ������: ���ѹα�, ������: ����, �α���: 4403   <- ������
select
    '������: ' || name || ', ������: ' || capital || ', �α���: ' || population as "[��������]"
from tblCountry;


--�䱸����.005
--�Ʒ��� ���� �������ÿ�.employees
-- [�̸�]               [�̸���]                 [����ó]            [�޿�]
-- Steven King           SKING@gmail.com           515.123.4567         $24000
select 
    first_name || ' ' || last_name as "[�̸�]",
    email || '@gmail.com' as "[�̸���]",
    phone_number as "[����ó]",
    '$' || salary as "[�޿�]"
from employees;


--�䱸����.006.tblCountry
--����(area)�� 100������ ������ �̸��� ������ �������ÿ�.
select name, area from tblCountry where area <= 100;

--�䱸����.007.tblCountry
--�ƽþƿ� ���� ����� ���� ���� �������ÿ�.
select * from tblCountry where continent in ('AS', 'EU');


--�䱸����.008.employees
--����(job_id)�� ���α׷���(it_prog)�� ������ �̸�(Ǯ����)�� ����ó �������ÿ�.
select first_name || ' ' || last_name as name, phone_number from employees where job_id = 'IT_PROG';


--�䱸����.009.employees
--last_name�� 'Grant'�� ������ �̸�, ����ó, ��볯¥�� �������ÿ�.
select first_name, last_name, phone_number, hire_date from employees where last_name = 'Grant';



--�䱸����.010.employees
--Ư�� �Ŵ���(manager_id: 120)�� �����ϴ� ������ �̸�, �޿�, ����ó�� �������ÿ�.
select first_name, last_name, salary, phone_number from employees where manager_id = 120;


--�䱸����.011.employees
--Ư�� �μ�(60, 80, 100)�� ���� �������� �̸�, ����ó, �̸���, �μ�ID �������ÿ�.
select first_name, last_name, phone_number, email, department_id from employees where department_id in (60, 80, 100);


--�䱸����.012.tblInsa
--��ȹ�� ������ �������ÿ�.
select * from tblInsa where buseo = '��ȹ��';


--�䱸����.013.tblInsa
--���￡ �ִ� ������ �� ������ ������ ����� �̸�, ����, ��ȭ��ȣ �������ÿ�.
select name, jikwi, tel from tblInsa where jikwi = '����' and city='����';


--�䱸����.014.tblInsa
--�⺻�޿� + ���� ���ļ� 150���� �̻��� ���� �� ���￡ ������ �������ÿ�.
select * from tblInsa where basicpay + sudang >= 1500000 and city = '����';


--�䱸����.015.tblInsa
--������ 15���� ������ ���� �� ������ ���, �븮�� �������ÿ�.
select * from tblInsa where sudang <= 150000 and jikwi in ('���', '�븮');



--�䱸����.016.tblInsa
--������ ������ �⺻ ������ 2õ���� �̻�, ����, ���� ����(����)�� �������ÿ�.
select * from tblInsa where basicpay * 12 >= 20000000 and city = '����' and jikwi in ('����', '����');



--�䱸����.017.tblCountry
--������ 'O��'�� ���� �������ÿ�.
select * from tblCountry where name like '_��';



--�䱸����.018.employees
--����ó�� 515�� �����ϴ� ������ �������ÿ�.
select * from employees where phone_number like '515%';

    

--�䱸����.019.employees
--���� ID�� SA�� �����ϴ� ������ �������ÿ�.
select * from employees where job_id like 'SA%';

    

--�䱸����.020.employees
--first_name�� 'de'�� �� ������ �������ÿ�.
select * from employees where first_name like '%de%';


--�䱸����.021.tblInsa
--���� ������ �������ÿ�.
select * from tblInsa where ssn like '%-1%';


-- �䱸����.022.tblInsa
--���� ������ �������ÿ�.   
select * from tblInsa where ssn like '%-2%';


--�䱸����.023.tblInsa
--������(7,8,9��) �¾ ������ �������ÿ�.
select * from tblInsa where ssn like '__07%' or  ssn like '__08%' or  ssn like '__09%'; 


--�䱸����.024.tblInsa
--����, ��õ�� ��� �达�� �������ÿ�.    
select * from tblInsa where city in ('����', '��õ') and name like '��%';


--�䱸����.025.tblInsa
--������/�ѹ���/���ߺ� ���� �� �����(���/�븮) �߿� 010�� ����ϴ� �������� �������ÿ�.
select * from tblInsa where buseo in ('������', '�ѹ���', '���ߺ�') and jikwi in ('���', '�븮') and tel like '010%';



--�䱸����.026.tblInsa
--����/��õ/��⿡ ��� �Ի����� 1998~2000�� ������ �������� �������ÿ�.
select * from tblInsa where city in ('����', '��õ', '���') and ibsadate between '1998-01-01' and '2000-12-31'; -- ��¥�� between�� �ȴ�. 


--�䱸����.027.employees
--�μ��� ���� ���� �ȵ� �������� �������ÿ�. (department_id�� ���� ����)
select * from employees where department_id is null;

-- ex03_select.sql 

/*

    SQL, Query(����) > SELECT 
    
    SELECT��
    - DML, DQL
    - ������ ���� �� ������ �۾��� ������ ��ɾ� 
    - ��� ���̺�κ��� ���ϴ� ���� �����ϴ� �۾� > ����Ŭ �������� �������� �ּ��� ~ ��û ��ɾ� 
    - �б� 
    
                                                  - select��
    [ WITH <Sub Query> ]                          - with�� 
    SELECT column_list                            - select��    // : �� �ΰ����� ����
    FROM table_name                               - from��
    [ WHERE search_condition]                     - where��
    [ GROUP BY group_by_expression]               - group by��
    { HAVING search_condition]                    - having��
    [ ORDER BY order_expression [ASC | DESC] ]    - order by��
    
    ********** ���� ��������� ������ �ִ�.
    
*/ 

select �÷�����Ʈ     --2. ���ϴ� �÷��� �����ϴ� ���� > �� �����ü��� ���ϴ°��� ������ ���� 

from ���̺��;        --1. �����ͼҽ��� ����(��� ���̺�� ���� �����͸� ��������)
-- ���̺��� ���� �����ϰ� ���̺� �ִ� ���ϴ� �÷��� ���� �´�. 

-- ó�� ���� ���̺��� ����(��Ű��, Schema) Ȯ��
-- 1. �� > �޸��� ������ �߳�? 
-- 2. ��ɾ�(SQL Developer, SQL PLUS ������ ���ư���.

DESC employees; -- SQL�� �ƴѴ�. Ư�� �� ��ɾ�ϱ� �̰� �ٸ� ���� ���� ���� �𸥴ٰ� ��������. 

select * 
from employees; 

select first_name from employees;
select email from employees;

-- ���� �÷�
select first_name, last_name from employees;

select first_name, last_name, email, salary, phone_number from employees; -- �������� ���� ��������. 

select first_name, last_name, email, salary, phone_number 
from employees; -- �������� ���� ��������. 


-- �÷����� ��� ��� �̰� �� ������. ���ϵ� ī�庸�� 
select 
    first_name, last_name, email, salary, phone_number 
from 
    employees; -- �������� ���� ��������. 

-- �÷����� ��� ��� > ������ �̰� �̵��� �Ǵ� �κ��� ����. 
select first_name, last_name, email, salary, phone_number -- 
    from employees;

-- ���ϵ� ī�� ���     
select * -- ���ϵ� ī��(*) > ��� Į�� > Į���� �پ��� �͵� ���� �� �ִ�. 
    from employees;

-- Į������Ʈ�� Į�������� ���� ���̺��� �÷������� �����ϴ�. �ʿ��ϸ� ����� ���ġ�ض� 
select last_name, first_name from employees; 

select first_name, first_name, first_name from employees;  -- ������ Į���� ������ ������ ������ ����.

select first_name, length(first_name) from employees; -- 





select * from zipcode;        -- 
select * from tblAddressBook; -- �ּҷ�
select * from tblComedian;    -- �ڸ޵��
select * from tblCountry; 
select * from tblDiary;       
select * from tblHousekeeping; -- ���Ժ� 
select * from tblInsa;         -- ��������
select * from tblMen;          -- �����Ͱ� �ȵ��� > ����
select * from tblWomen;        -- ����
select * from tblTodo;         -- �� �� > ���� �Ϸᰡ �Ǿ�����
select * from tblZoo;          -- ����  > 

-- ������ �� �� �� 

-- select ��  --> 2. �÷� ����
-- from �� ;  --> 1. ���̺� ���� 


select name from tblInsa; 

select name, buseo, jikwi
    from tblInsa;
    
-- �׻� select���� ����� ���̺��̴�. > �޸𸮿� �����ϴ� �ӽ� ���̺� > �������� ���� �̾ƿ� ������̴�.
-- ��� ���� ������ ���̺��̶� ��������. select ���� ����� ������̺� or ������̶� �Ѵ�. 

select name, length(name)
    from tblInsa;

select * 
    from tblIns; -- ���� ���̺� �̸� > ���̺��� �������� �ʴ´�. 
--    ORA-00942: table or view does not exist
-- 00942. 00000 -  "table or view does not exist"
    
select nama
    from tblInsa; 
-- �������� �ʴ� �ĺ���
--    ORA-00904: "NAMA": invalid identifier
--    00904. 00000 -  "%s: invalid identifier" 


    
    
    
    
    
    
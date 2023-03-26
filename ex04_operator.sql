/*
������, Operator

    1. ��� ������
    - +, -, *, /
    - %(����) > �Լ��� ����(mod())
    
    2. ���ڿ� ������
    - +(X) > ||(O) : || �̰� ���ϱ� �����ڴ� ���ڿ��� �ش�
    
    3. �� ������
    - >, >=, <, <= 
    - =(==), <>(!=)
    - ���� ��ȯ > ��������� ǥ�� �Ұ����� �ڷ��� > ������ �ʿ��� ��Ȳ������ ���
    - �÷� ����Ʈ���� ��� �Ұ�
    - ���������� ��밡��
    
    4. �� ������ 
    - and(&&), or(||), not(!)
    - �÷� ����Ʈ���� ��� �Ұ���
    - ���������� ��� ����
    
    5. ���� ������ 
    - = 
    - �÷� = �� (> �̷� �� ����. : �÷����ٰ� ���� �ִµ� ����. )
    - update������ �� ǥ���� ���´�. �ű� ����� ������ ����.
    
    6. 3�� ������ 
    - ���� 
    - ��� ����
    
    7. ���� ������ 
    - ���� 
    
    8. SQL ������
    - �ڹ�: instanceof, typeof ��.. 
    - in, between, like, is �� ..(������, ������) �̶�� �θ��⵵ �Ѵ�.  
    
    
    
*/

select * from tblCountry;

drop table tblType;

create table tblType(
    num1 number,
    num2 varchar2(50)
);

insert into tblType(num1, num2) values(123,'123');

select * from tblType;

desc tblCountry;
select * from tblCountry;


select population, area, population + area 
from tblCountry;

--select name + capital   -- �̰� ������ �ȵȴ�. ������ ����. invalid number
--from tblCountry; 

select name || capital   -- �̰� ������ �ȵȴ�. ������ ����. invalid number
from tblCountry;         -- �̷��� �ٿ��� �Ѵ�. 

drop table tblType;

-- �񱳿����ڰ� ���� �ʴ´�. 
-- select population > area from tblCountry;  -- �÷� ����Ʈ���� ����� �Ұ�

select * from tblCountry where population > area; 

-- �÷���
select name, name || '��'  -- �̷��� �ϸ� ������ ����� ����. ���߿� �츮�� �̰�� ���̺��� ������ �������� �ĺ��ؾ��� �� ������. 
    from tblInsa;
    
-- �÷��� > ������ �÷��� > �ùٸ� �̸����� ���� > �÷��� �ٲٱ� > ��Ī(Alias) 
-- �ĺ��� > "name" || "��"

-- select name, "name" || "��"     >> ������. > �ĺ��ڷ� �ùٸ��� ǥ���� ���� �ʴ´�. invalid identifier
--    from tblInsa;    
    

-- �ùٸ� �ֵ� �̻��� �ֵ� ������ ���� �� �ִ�. 
select name as name1 , name || '��' as name2
from tblInsa;
select name as "���� �̸�"  -- ��� ������ �ְ� �ʹ�.
from tblInsa;              -- �ĺ��ڿ��� ������ ���� �� ����. 
--> �� �� ���� ���� �� ����ǥ��. > ���� �ȵǴ� �̸��� �����ϰ� ��� 
    
    
select name as "select" -- ������ ������ ����. > �����Ϸ��� ������ ���Ѵ�. 
from tblInsa; -- �ֵ���ǥ�� ���̸� �Ǳ��ϴµ� �������� ... 
    
    
    
    
    
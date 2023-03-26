/*
ex07_order.sql
    
                                                  - select��
    [ WITH <Sub Query> ]                          - with�� 
    SELECT column_list                            - select��    // : �� �ΰ����� ����
    FROM table_name                               - from��
    [ WHERE search_condition]                     - where��
    [ GROUP BY group_by_expression]               - group by��
    { HAVING search_condition]                    - having��
    [ ORDER BY order_expression [ASC | DESC] ]    - order by��
    
    select Į������Ʈ                --3. ���ϴ� Į������ �����ͼ�
    from ���̺�                     --1. ���̺�κ���
    where ����                      --2. ���ϴ� ����� 
    order by ���ı���;               --4. ������� ���Ѵ�. > order by�� ����� �߿� �����.

    order by ��
    - ������� ����(O)
    - ���� ���̺��� ����(����ڰ� ���� �Ұ����ϴ� > ����Ŭ )
    - order by '�����÷�' [asc|desc]                     > ���� �����÷��� �´�. �����ϸ� ���������̴�. 
*/


select * from tblCountry;  -- �̷� ���̺��� �ְ� �� ���̺��� ��������! ������ ��û�Ѵ�. 

select * from tblCountry order by name asc;

select * from tblCountry order by population desc; -- �α����� ���� ����� �������ּ���. 
               -- null �÷��� ������� ���� ~ ! ū������ ������ �Ǽ� ���ĵȴ�. > �׷��� null�� ���� �ȴ�.
select * from tblCountry where population is not null order by population desc; -- �̻��¿��� �ɳĸ� ����. 

select * from tblInsa order by name asc; -- ���ڿ� + �������� 
select * from tblInsa order by basicpay; -- ���� + ��������  > �޿��� ���� ������� ���������ġ 
select * from tblInsa order by ibsadate; -- ��¥ + �������� 


select * from tblInsa order by buseo asc; -- ���ı����� �ߺ��� �Ͼ��. ���ߺΰ� ������.

-- ���� ���� 

select * from tblInsa order by buseo asc, city asc; -- ���ߺΰ� �������ϱ� �� ���̿����� ��Ƽ�������� ���� 

select * from tblInsa order by buseo asc, city asc, name asc; -- ���� ������ �ϰ������ ����Ŭ������ �ڹٿ����� �ؼ� ��ģ��.
-- �̰� db���� ���� �ƴϸ� �ڹٴܿ��� ���� ��εȴ�. 

select 
    name, buseo, jikwi
from tblInsa
    order by buseo, jikwi, name;  -- ������ �������� ���� 
    
    
    ------ ��
    
    
select 
    name, buseo, jikwi
from tblInsa
    order by 2, 3, 1; -- �÷������� ��ȣ��. > ���� x �������� ����. > ���������� ����ϴ�. 


-- ������ ���� > where ���� ������ó��
-- ������ ���� > order by �����ٰ� �� �� �ִ�.

select * from tblInsa order by basicpay desc; -- ���� ȫ�浿
select * from tblInsa order by basicpay + sudang desc; -- ���� ȫ�浿 > ������ �ٲ��. 
-- �̷������� ������ ���� order by�� ���� �� �ִ�. 

-- ���������� ����: ���� > ���� > �븮 > ��� > �ڹٴ� ��׵��� ������ �����ϴ� ���ڷ� ���������.
select 
    name, jikwi
from tblInsa
    order by jikwi desc;
    
-- ��,��,��,�縦 �츮�� ���ϴ� ���ڷ� �ϰ� �ʹ�. 

select 
    name, jikwi,
    case
        when jikwi = '����' then 1
        when jikwi = '����' then 2
        when jikwi = '�븮' then 3
        when jikwi = '���' then 4
    end as ���� -- alias�� �Ⱥ��̸� order by ���� ���ϰ͵� ����.
    
from tblInsa
    order by ���� asc; -- ���� ���ϴ� ���������� ��µǾ���. 
    -- ���ο� Į���� ���� �ױ����� �����Ѵ�. 
    





select 
    name, jikwi,
    case
        when jikwi = '����' then 1
        when jikwi = '����' then 2
        when jikwi = '�븮' then 3
        when jikwi = '���' then 4
    end as ���� -- alias�� �Ⱥ��̸� order by ���� ���ϰ͵� ����. > ���⼱ case ~ end�� Į���̴�. 
    
from tblInsa
    order by 3 asc; -- �̷��� 3���� �ص� �ȴ�.
    -- ���ο� Į���� ���� �ױ����� �����Ѵ�. 

select name, jikwi
from tblInsa 
order by 
(case
        when jikwi = '����' then 1
        when jikwi = '����' then 2
        when jikwi = '�븮' then 3
        when jikwi = '���' then 4
end) asc; -- alias�� �Ⱥ��̸� order by ���� ���ϰ͵� ����.
--> ���⼱ case ~ end�� Į���̾����Ƿ� ©�� ���� ���̴�.
--> �䷸�� �ϸ� ���� �κ��� Į���� ���� �� �ִ�.
-- case end�� select ������ ���� order by���� ����.
-- case���� where������ ����. 

select name, jikwi
from tblInsa 
where case  -- where ������ ���� �� �÷��̶� �����ض�
    when jikwi = '����' then 1
    when jikwi = '����' then 2
    when jikwi = '�븮' then 3
    when jikwi = '���' then 4
    end = 1
order by case 
    when jikwi = '����' then 1
    when jikwi = '����' then 2
    when jikwi = '�븮' then 3
    when jikwi = '���' then 4
    end asc;
    
-- ���������� ���� : ���� > ����     
-- 771212 - 1022432    
select * from tblInsa;

select * from tblInsa
    order by ���� asc;

-- case end������ ���� Į���� ���� �����. 
select 
    case 
        when ssn like '%-1%' then '����'
        when ssn like '%-2%' then '����'
    end as ����-- �̰� �ϳ��� �÷��̴�. ���� �����ؼ� ���� �÷��̴�. 
from tblInsa;
    
-- ���� ���̺� �ִ� Į���̴� �÷��̵� �����ϴ�. 

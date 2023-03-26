/*

    ex11_date_time_function.sql
    
    ��¥ �ð� �Լ� 
    
    1. sysdate
    - ���� �ý����� �ð��� ��ȯ
    - Calendar.getInstance()
    - date sysdate     > �Ұ�ȣ�� �����Ǿ���.
    
*/

-- YYYY-MM-DD HH24:MI:SS > �� ���ڿ��� �������. 

select sysdate from dual;  -- 23/03/16 > ������ �ٲ� ���ִµ� ���� �ɼ��� �ǵ���� �Ǳ��ϴµ� ���� x

/*
    ��¥ ����
    +, -
    1. �ð� - �ð� = �ð�
    2. �ð� + �ð� = �ð�
    3. �ð� - �ð� = 
    
*/

-- 1. �ð� - �ð� = �ð�(��)

select
    name,
    ibsadate,
    round(sysdate - ibsadate) as "�ٹ��ϼ�",
    round((sysdate - ibsadate) / 365) as "�ٹ����", -- ������ > 1�⿡ 365�� �ƴҼ� �־ ���������� �����. 
    round((sysdate - ibsadate)* 24) as "�ٹ��ü�",
    round((sysdate - ibsadate)* 24*60) as "�ٹ��м�",
    round((sysdate - ibsadate)* 24*60*60) as "�ٹ��ʼ�"
from tblInsa;
-- 1���� 365�� �ƴϴ�.

select 
    title,
    adddate,
    completedate,
    completedate - adddate,
    round((completedate - adddate) * 24, 1) as "�����ϱ�����ɸ��ð�",
    completedate - adddate as "�����ϱ�����ɸ��ð�" -- �̰Ŵ� �ȴ�. 
    -- completedate - adddate as "�����ϱ���� �ɸ� �ð�" -- ������ ����. �ĺ��ڰ� �ʹ� ���. 
    -- ORA-00972: identifier is too long �̰� �ѱ��̶� 30����Ʈ�� ���� utf-8�̴ϱ� �ѱ��ڴ� 3����Ʈ��. 
from tblTodo
    --where  round((completedate - adddate) * 24, 1) <= 1;
    order by round((completedate - adddate) * 24, 1) desc;
-- as "�ĺ���"

-- 2. �ð� + �ð�(��) = �ð�
-- 3. �ð� - �ð�(��) = �ð�
select 
    sysdate,
    sysdate + 100 as "100�ϵ�",
    sysdate - 100 as "100����", -- �ڹٺ��� ���ϴ�. 
    sysdate + ( 3 / 24 ) as "3�ð���",
    sysdate - ( 5 / 24 ) as "5�ð���",
    sysdate + ( 30 / 60 / 24 ) as "30�е�"
from dual;

/*

    �ð� - �ð� = �ð�(��)
    
    months_between()
    - number months_between(date, date)
    - �ð� - �ð� = �ð�(��) 
    
    add_months() > �ð����ٰ� �ð��� ���Ѵ�. 
    - number add_months(date, �ð�) 
    - �ð� + �ð�(��) = �ð� 
*/
select 
    name, 
    round(sysdate - ibsadate) as "�ٹ��ϼ�",
    round((sysdate - ibsadate)/365) as "�ٹ��ϼ�", -- �ŷ� X
    round(months_between(sysdate, ibsadate)) as "�ٹ�����", -- �ŷ� O
    months_between(sysdate, ibsadate) as �����,
    round(months_between(sysdate, ibsadate)/12) as "�ٹ����"
from tblInsa;
-- �̰� ����� ������ ����� �������� ǥ��?? 
-- ���� �ѹ����δ� ��� ���� ������ ��Ȯ�ϰ� ǥ���ϱ�� �����. 

select
    sysdate,
    sysdate + 10,          -- 10�� ��    23/03/26
    sysdate + 30,          -- �Ѵ� ��??  23/04/15
    add_months(sysdate, 1), -- �Ѵ� ��??
    add_months(sysdate, -3), -- 3���� �� 
    add_months(sysdate, 3*12) -- 3�� �� 
from dual;

/*
    �ð� - �ð�
    1. ��, ��, ��, �� > ������(-) 
    2. ��, �� > months_between() 

    �ð� +- �ð�
    1. ��, ��, ��, �� > ������(+,-)
    2. ��, �� > add_months()

*/

-- employees

-- 1. ��ü �̸�(first_name + last_name)�� ���� �� -> ª�� ��� ������ �����ؼ� ��������
--    > �÷� ����Ʈ > fullname(first_name + last_name), length(fullname)
select first_name || last_name as �̸�, length(first_name || last_name) as ����
from employees
order by length(first_name || last_name) desc;

-- 2. ��ü �̸�(first_name + last_name)�� ���� �� ����� �����? ���� ª�� ����� �����? ��� �����?
--    > �÷� ����Ʈ > ���� 3�� �÷�
select max(length(first_name || last_name)) as �ִ�, min(length(first_name || last_name)) as �ּ�, trunc(avg(length(first_name || last_name))) as ���
from employees;

-- 3. last_name�� 4���� ������� first_name�� ��������
--    > �÷� ����Ʈ > first_name, last_name
--    > ����(first_name, ��������)
select first_name, last_name
from employees
where length(last_name)=4
order by first_name;

-- decode( �� case end ) 

-- 4. tblInsa. ���� ���? ���� ���? �븮 ���? ��� ���?

select 
    count(decode(jikwi, '����', 1)) as ����,
    count(decode(jikwi, '����', 1)) as ����,
    count(decode(jikwi, '�븮', 1)) as �븮,
    count(decode(jikwi, '���', 1)) as ���
from tblInsa;

-- 5. tblInsa. ����(����, ����) ���? ���(�븮, ���) ���?
select 
    count(decode(jikwi, '����', 1, '����', 1)) as "����(����, ����)",
    count(decode(jikwi, '�븮', 1, '���', 1)) as "���(�븮, ���)"
from tblInsa;

-- 6. tblInsa. ��ȹ��, ������, �ѹ���, ���ߺ��� ���� ��� �޿�?
select 
    avg(decode(buseo, '��ȹ��', basicpay)) as "��ȹ��",
    avg(decode(buseo, '������', basicpay)) as "������",
    avg(decode(buseo, '�ѹ���', basicpay)) as "�ѹ���",
    avg(decode(buseo, '���ߺ�', basicpay)) as "���ߺ�"
from tblInsa;

select * from tblInsa;

-- 7. tblInsa. ���� ���� ���� ���̰� ���� ����� ��⵵ �»�? ���� ���� ���� ���̰� � ����� ��⵵ �»�?

select max(substr(ssn,1,2))
from tblInsa
where ssn LIKE '%-2%';

select min(substr(ssn,1,2))
from tblInsa
where ssn LIKE '%-1%';


select 
    decode(ssn, ssn LIKE '%-1%', 1)
from tblInsa;

select * from tblInsa;
-- 7. tblInsa. ���� ���� ���� ���̰� ���� ����� ��⵵ �»�? ���� ���� ���� ���̰� � ����� ��⵵ �»�?
select 
    min(decode(substr(ssn,8, 1 ), '2', substr(ssn, 0 ,2))) as ���ڳ��̸���,
    max(decode(substr(ssn,8, 1 ), '1', substr(ssn, 0 ,2))) as ���ڳ�������
from tblInsa;


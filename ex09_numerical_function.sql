/*
    ex09_numerical_function.sql
    
    ���� �Լ� ( = ���� �Լ�)
    - Math.random()
    
    round()
    - �ݿø� �Լ�
    - number round(�÷���) : ���� ��ȯ
    - number round(�÷���, �Ҽ����� �ڸ���) : �Ǽ� ��ȯ   
*/

select height/ weight, -- �ʹ� �Ҽ��� ���.
       round(height/ weight),    -- ����.
       round(height/ weight, 0), -- ����.
       round(height/ weight, 1),
       round(height/ weight, 2),
       round(height/ weight, 3)
from tblComedian;

-- ��� �޿�
select round(avg(basicpay)) from tblInsa;

/*

    floor(), trunc()
    - ���� �Լ� 
    - ������ ���� �Լ�
    - number floor(�÷���) : ������ ���� ��ȯ
    - number trunc(�÷��� [, �Ҽ����� �ڸ���]) : ���� or �Ǽ� ��ȯ

*/

select trunc('1.23456',3) -- ������ �ڸ��ų��� ���ڰ� �ʿ��ִ�. 
from dual;

select floor('1.23456')   -- ���ڰ� �� �ʿ䰡 ���� 
from dual;

select 
    height / weight,
    round(height / weight),
    floor(height / weight),
    trunc(height / weight),
    trunc(height / weight, 1),
    trunc(height / weight, 2)
from tblComedian;
    
/*
    ceil()
    - ������ �ø� �Լ�(õ��)
    - number ceil(�÷���) 
        
    mod()
    - ������ �Լ�
    - number mod(������, ����)
    
*/

select 
    height /weight, 
    round(height / weight),
    floor(height/weight),
    ceil(height/weight)
from tblComedian;

select chr(13)
from dual;

-- dual ���̺�  > ���ڵ� 1��¥�� ���̺�
select * from tblCountry;
select * from dual;
select sysdate from tblCountry; -- ���� ��¥�ε� where���Ⱥٿ��� �� ���̺� �ִ� ���ڵ� ������ŭ ���´�. 

select replace('oracle db hey ',' ') as result1,
replace('oracle db hey ','db','hello') as result2
from dual;

select 
    10/3,
    mod(10,3) as "������",
    floor(10/3) as "��"
from dual;

-- dual�� ����Ŭ���� �ִ�.

select 10/3
from dual;

select 
    abs(10),
    abs(-10),
    power(2,2),
    power(2,3),
    power(2,4),
    sqrt(4),
    sqrt(9),
    sqrt(16)
from dual





/*
ex24_rank.sql

�����Լ�
- rownum�� ����� �������� �뵵�� �����س��� �Լ�

** over �ȿ� order by�� �ʼ�,,,, 

1. rank() over()
    - rank() over(order by �÷��� [asc|desc])
    - ���� �ο���, �ߺ����� �߻��ϸ� ������ ������ �ο��ϰ�, �ߺ����� ������ŭ �ǳʶٱ� �Ѵ�.
    
2. dense_rank() over()
    - dense_rank() over(order by �÷��� [asc|desc])
    - ���� �ο���, �ߺ����� �߻��ϸ� ������ ������ �ο��ϰ�, �� ���� ������ �ǳʶٱ� ���ϰ� ���������� �ο��Ѵ�.
    
3. row_number() over()
    - row_number() over(order by �÷��� [asc|desc])
    - ���� �ο���, �ߺ����� ������� ���������� �ο�
    - ���� rownum�� ����� ����� ���� 
*/

select a.*, rownum from (select name, buseo, basicpay from tblInsa order by basicpay desc) a;

select name, buseo, basicpay, rank() over(order by basicpay desc) as  rnum from tblInsa;

select name, buseo, basicpay, dense_rank() over(order by basicpay desc) as  rnum from tblInsa;

select name, buseo, basicpay, row_number() over(order by basicpay desc) as  rnum from tblInsa;

-- �޿� 5�� 
select name, buseo, basicpay,
       row_number() over(order by basicpay desc) as  rnum 
from tblInsa
    where rnum = 5; -- alias�� �Ƚ�����.... !? > ������� ������ from . where ���ε� rnum�� ������ �Ȼ������� where������ ������. 
    

select name, buseo, basicpay,
       row_number() over(order by basicpay desc) as  rnum 
from tblInsa
    where (row_number() over(order by basicpay desc)) = 5; 
    
-- alias�� �Ƚ�����.... !? > ������� ������ from . where ���ε� rnum�� ������ �Ȼ������� where������ ������.  
-- ����!! ���� �Լ��� where���� �����´�.
-- ����� �굵 ���������� ������ �Ѵ�.  > ������ �����Ϸ��� ��� ���������� �ʼ���. 

-- rownum�� �������°ź��� �Ѵܰ� ���������� �־ ������ �پ���. 
select * from ( select 
                    name, buseo, basicpay,
                    row_number() over(order by basicpay desc) as rnum 
                from tblInsa )
                        where rnum = 5;
                        
-- �� ����� �ణ�� ȣ��ȣ�� ������. �����Լ� �� ���� �����Լ��� ���� ~ 
    

select * from (select
                    name, buseo, basicpay,
                    dense_rank() over(order by basicpay desc ) as rnum
               from tblinsa)
                    where rnum = 8; -- �������� ���� �� �ִ�. 
    
select * from (select
                    name, buseo, basicpay,
                    rank() over(order by basicpay desc ) as rnum
               from tblinsa)
                    where rnum = 9; -- rank_over���� �ǳʶٱ� ���ϸ� ã�� ���Ѵ�.



select name, buseo, basicpay, rank() over(order by basicpay desc, name asc) as  rnum from tblInsa;
-- 2�������� ������ �� ������ �þ�� �ȴ�. 1�� ���Ŀ��� �������� �� ������ �ް������� �ִ�.

update tblInsa set sudang = 200000 where name = '�̹���';

select name, buseo, basicpay, sudang, rank() over(order by basicpay desc, sudang desc) as  rnum from tblInsa;

-- ���� ���ĵ� ������ �Ǽ� ����� ������ ��ģ��. 

/*
    �׷캰 ���� ���ϱ� 
    - ���� �Լ� + group by 
    
*/

-- �޿� + ���� 
select 
    name, buseo, basicpay
from tblInsa;

select -- �޿������� ������ �ű� �� 
    name, buseo, basicpay,
    dense_rank() over( order by basicpay desc) as rnum
from tblInsa;

-- �μ���( �޿� + ���� ) > ���������� �Ǵ�. 
select 
    name, buseo, basicpay,
    dense_rank() over(partition by buseo order by basicpay desc) as rnum 
from tblInsa;
-- group by buseo; �Ƚ�����. > �ٵ� �̰� rank ���� ���� �Լ��� �׷��� 
-- order by�� �� ����� �ϳ�? 

select 
    name, buseo, basicpay,
    rank() over(partition by buseo order by basicpay desc) as rnum 
from tblInsa;

select 
    name, buseo, basicpay,
    row_number() over(partition by buseo order by basicpay desc) as rnum 
from tblInsa;

/*
    ex23_pseudo.sql
    
    �ǻ��÷�, Pseudo Column
    - ���� �÷��� �ƴѵ� �÷�ó�� �ൿ�ϴ� ���
    
    rownum 
    - ����Ŭ ����
    - row num > ���ȣ > ���ڵ��� �Ϸù�ȣ
    - from���� ����� �� �� ���ڵ忡 �Ϸù�ȣ�� �Ҵ��Ѵ�.(****)
    - where���� ������ ������ �Ϸù�ȣ�� �ٽ� �����Ѵ�.(reindexing) (****) > �Ϸù�ȣ ��ȭ!!!
    - rownum�� ��� > ���� ������ ���� ����Ѵ�.
*/

select
    name, buseo,     -- �÷�(�Ӽ�)   > output > ��ü�� Ư���� ���� �ٸ� ���� ������.(���� ������)
    sysdate,         -- �Լ�        > output > ��� ���ڵ尡 ������ ���� ������.(���� ������)
    substr(name, 2), -- �Լ�        > input + output > ��ü���� �ٸ� ���� ������. 
    '���',            -- ���        > output > ��� ���ڵ尡 ������ ���� ������. ( ���� ������ )
    rownum           -- �ǻ� Į�� > output > ��ü�� Ư���� ���� �ٸ� ���� ������.(���� ������ )
from tblInsa;

-- ���ڵ��� �ָ��� ���´�. �װ� �Ϸù�ȣ ���� ���´�.

-- �Խ��� > ����¡ : ������ ����� �� �� rownum�� ����. 
-- 1������ > rownum between 1 and 20 
-- 2������ > rownum between 21 and 40 
-- 3������ > rownum between 41 and 60 

select name, buseo, rownum from tblInsa;
select name, buseo, rownum from tblInsa where rownum = 1;  -- ��� �ȴ�!!!! �ε��� ���ľ��� ù������ �ٷ� ã�Ƽ�
select name, buseo, rownum from tblInsa where rownum <= 5; -- �굵 ��ġ�� �Ǵϱ� �ε��� ������ �ʿ䰡 ����

select name, buseo, rownum from tblInsa where rownum = 10; -- �ȵʾȵ�!!
select name, buseo, rownum from tblInsa where rownum = 2;  -- �̷��Ŵ� �ȵȴ�.
-- �̷��Ŵ� �ȵȴ�. �� 1���� ū �� �ϳ� �� ������ �ȵ� > ������ �����ϴ� ������ ����. 

select name, buseo, rownum from tblInsa where rownum > 5; -- �̰͵� �ȵȴ�. 



select 
    name, buseo, rownum
from tblInsa; --1. *** �� ������ �����͸� ������ rownum�� �̹� �Ҵ�Ǿ� �ִ�. 


select 
    name, buseo, rownum
from tblInsa          -- from���� ������ �������߿� ù��° ��� ã�´�. 
    where rownum = 1; --2. ����, rownum�� 1�� �����??
    
select 
    name, buseo, rownum
from tblInsa
    where rownum = 3;   -- �̰� �� �ȵɱ�? rownum=3�� �и��� �ִµ�...?
    -- Ż���� �ǹ����� ������Ŵ�.
    -- rownum�� �������� ��� > �ݵ�� 1~���� ���� > ���ǿ� ����



-- order by ���� ���Ⱑ �ָ��ϴ�. rownum�� ���� �����ĵȴ�.  
select 
    name, buseo, rownum
from tblInsa         -- 1. ����(+rownum)
    order by name;  
    

select 
    name, buseo, basicpay, rownum
from tblInsa
    order by basicpay desc;

-- rownum�� from���� �Ҵ�� �� ����ȴ�. �ٵ� order by�� �������� ����ȴ�.
-- �̰Ͷ����� ... ������!! ���������� ����� ���ϴ� ��� ���� �ʴ´�.
-- rownum�� order by���� �Ű��� ���̶� order by���������� �ڼ��̴� ���̴�.

-- �̷��ϱ� ����. 
select name, buseo, basicpay, rownum  -- �ζ��κ����� rownum�� ���� rownum�� ���� �ٸ���. 
-- �� ������ rownum���� ������� �ʴ´�.
from (select 
          name, buseo, basicpay, rownum 
      from tblInsa
          order by basicpay desc);


select name, buseo, basicpay, rownum, rnum  -- �ٵ� alias�� �ζ��κ��� rownum�� ��������??
-- �� ������ rownum���� ������� �ʴ´�.
from (select 
          name, buseo, basicpay, rownum as rnum 
      from tblInsa
          order by basicpay desc)
          where rownum <= 5;
          

-- �α����� ���� ���� ���� 1~3�� 
select * from tblCountry;

-- 1. ���ϴ� ������ �����ؾ� �Ѵ�.
select * from tblCountry where population is not null order by population desc;
select rownum from tblCountry where population is not null order by population desc;

-- 2. ���� ������� ������ �ѹ��� rownum�� ����� > from �� ���� 
select * from (select * from tblCountry where population is not null order by population desc)
    where rownum <= 3;



-- tblInsa. �޿��� 3�� 
select * from tblInsa; 
-- ���� �����̴�. > 1+1 �����̴�.

-- 1. �޿� ������ ����
select * from tblInsa order by basicpay desc;

select rownum from tblInsa order by basicpay desc;

-- 2. ���ϴ� ������� ���� �����> from�� ���� > rownum �ٽ� �ű��.
select a.*, rownum from(select * from tblInsa order by basicpay desc) a where rownum = 1;
select a.*, rownum from(select * from tblInsa order by basicpay desc) a where rownum <= 5;
select a.*, rownum from(select * from tblInsa order by basicpay desc) a where rownum = 3;

-- �� rownum�� = 1 �� �ƴ� ������ �� ��Դ� ��� 
--------------------- ������ ������ �ǹ��� ���� �ٱ����� where �� �˻��ص� �ȴ�. ---------------------
select * from (select a.*, rownum as rnum from(select * from tblInsa order by basicpay desc) a)
    where rnum = 3; -- �̷��� ��indexing�� �ȴ�. 
-- ���� �ٱ� rownum�� �ִµ� �Ⱦ���.

---- �� select�� ���� ��� select���� ���� rownum�� ����ϴ� ��� �� ---- ���� ������ ���ı��� ����
select * from (select  a.*, rownum as rnum from(select * from tblInsa order by basicpay desc) a)
    where rnum = 3;
-- ���ȣ�� ���õ� �Լ��鵵 �ִ�. 

-- tblComedian. 5��° �׶��� ���?

select * from tblComedian;
-- �� ����ó�� �ܿ��� �ϴ� �κ� ��
-- 1. ������ �Ѵ�. ���ı��ص� ����
select * from tblComedian order by weight desc;

-- 2. �������� > rownum ��Ī�� ���
select a.*, rownum as rnum from (select * from tblComedian order by weight desc) a;

-- 3. �������� ó�����Ѽ� rownum ��Ī�� ������������ �����ٰ� ����Ѵ�.
select * from (select a.*, rownum as rnum from (select * from tblComedian order by weight desc) a)
where rnum = 5;

-- 1. tblInsa. ���� �޿�(�⺻��+����)�� (��������)������� �������ÿ�. (�̸�, �μ�, ����, �޿�, ���� ���)
select name, buseo, jikwi, basicpay+sudang as �޿� from tblInsa order by �޿� desc; -- 1. ���� �� > '�ʿ��� Į�� ����'

select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang as �޿� from tblInsa order by �޿� desc) a;

-- rank, dense_rank, row_number()
select * from (select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang as �޿� from tblInsa order by �޿� desc) a);

-- 2. tblInsa. ���� �޿�(�⺻��+����)�� (��������)������� �������ÿ�. (�̸�, �μ�, ����, �޿�, ���� ���)
-- 1. ����, Į�� ����
select name, buseo, jikwi, basicpay+sudang as �޿� from tblInsa where substr(ssn,8, 1) ='2' order by �޿�;
select * from tblInsa;
-- > �� 
select a.*,rownum as rnum from ( select name, buseo, jikwi, basicpay+sudang as �޿� from tblInsa where substr(ssn,8, 1) ='2' order by �޿� ) a;



-- 3. tblInsa. ���� �ο����� (���� ���� �μ� �� �ο���) �������ÿ�.
--1
select buseo, count(*) from tblInsa where substr(ssn,8, 1) ='2' group by buseo order by count(*) desc;

select a.*, rownum as rnum from (select buseo, count(*) from tblInsa where substr(ssn,8, 1) ='2' group by buseo order by count(*) desc) a;

select * from (select a.*, rownum as rnum from (select buseo, count(*) from tblInsa where substr(ssn,8, 1) ='2' group by buseo order by count(*) desc) a) where rnum =1;

-- 4. tblInsa. ������ �ο��� (��������)������ �������ÿ�.(city, �ο���)

select * from tblInsa;

select city, count(*) from tblInsa group by city order by count(*) desc;

select a.*, rownum from (select city, count(*) from tblInsa group by city order by count(*) desc) a;

-- 5. tblInsa. �μ��� �ο����� ���� ���� �μ� �׿��� ���.
select buseo, count(*) as cnt from tblInsa group by buseo order by count(*) desc;

select  buseo, cnt, rownum as rnum from (select buseo, count(*) as cnt from tblInsa group by buseo order by count(*) desc) a;

-- from �� �ζ��κ並 ���������� ���
select buseo, cnt from (select  a.*, rownum as rnum from (select buseo, count(*) as cnt from tblInsa group by buseo order by count(*) desc) a) where rnum = 1;

-- 6. tblInsa. ���� �޿�(�⺻��+����)�� (��������) 3~5����� �������ÿ�. (�̸�, �μ�, ����, �޿�, ���� ���)
-- 1. 
select name, buseo, jikwi, basicpay+sudang from tblInsa where substr(ssn,8,1) = '1' order by basicpay+sudang desc;

select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang from tblInsa where substr(ssn,8,1) = '1' order by basicpay+sudang desc) a ;

select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang from tblInsa where substr(ssn,8,1) = '1' order by basicpay+sudang desc) a where rownum <=5
minus
select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang from tblInsa where substr(ssn,8,1) = '1' order by basicpay+sudang desc) a where rownum <=2;

-- ��
select * from (select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang from tblInsa where substr(ssn,8,1) = '1' order by basicpay+sudang desc) a ) where rnum >=  3 and rnum <=5;

-- 7. tblInsa. �Ի����� ���� ������ 5���������� �������ÿ�.
select * from tblInsa order by ibsadate;

--> ��
select a.*, rownum from (select * from tblInsa order by ibsadate) a where rownum <=5;


-- 8. tblhousekeeping. ���� ����(���� * ����) �� ���� ���� �ݾ��� ������ ���� 3������ �������ÿ�.
select t.*, price*qty from tblhousekeeping t order by price*qty desc;

-- ��
select a.*, rownum from (select t.*, price*qty from tblhousekeeping t order by price*qty desc) a where rownum <= 3;

-- 9. tblinsa. ��� �޿� 2���� �μ��� ���� �������� �������ÿ�.
select buseo, round(avg(basicpay + sudang)) as �޿� from tblinsa group by buseo order by �޿� desc;

select buseo, rownum as rnum from (select buseo, round(avg(basicpay + sudang)) as �޿� from tblinsa group by buseo order by �޿� desc) ;

-- ��
select *
from tblinsa
where buseo = (select buseo from (select buseo, rownum as rnum from (select buseo, round(avg(basicpay + sudang)) as �޿� from tblinsa group by buseo order by �޿� desc)) where rnum = 2 );

-- 10. tbltodo. ��� �� ���� ������ �Ϸ��� ������ ������� 5�� �������ÿ�.

select * from tbltodo;
-- completedate�� null �� �ƴ� �� üũ 
select * from tbltodo where completedate is not null order by adddate;

-- �ð��� �ʴ����� ����ֳ� ? 
select a.*, completedate - adddate as test from (select * from tbltodo where completedate is not null order by adddate) a order by test ;

select a.*, rownum as rnum from (select a.*, completedate - adddate as test from (select * from tbltodo where completedate is not null order by adddate) a order by test) a;

select * from (select a.*, rownum as rnum from (select * from (select * from tbltodo where completedate is not null order by adddate) order by completedate - adddate) a) where rnum <= 5;


-- 11. tblinsa. ���� ���� �߿��� �޿��� 3��°�� ���� �޴� ������ 9��°�� ���� �޴� ������ �޿� ������ ���ΰ�?
-- ��
with thirdPay as (
select �޿� from (select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang as �޿� from tblInsa where substr(ssn,8,1) = '1' order by basicpay+sudang desc) a ) where rnum =  3),
ninethPay as (
select �޿� from (select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang as �޿� from tblInsa where substr(ssn,8,1) = '1' order by basicpay+sudang desc) a ) where rnum =  9)
select (select �޿� from thirdPay)
- (select �޿� from ninethPay ) as ����
from dual;

-------------------------------------------------------------------------------------------------


-- 1. tblInsa. ���� �޿�(�⺻��+����)�� (��������)������� �������ÿ�. (�̸�, �μ�, ����, �޿�, ���� ���)
select a.*, rownum from (select name, buseo, jikwi, (basicpay + sudang) as salary 
                                    from tblInsa
                                       where substr(ssn, 8, 1) = '1'
                                          order by (basicpay + sudang) desc) a;

-- 2. tblInsa. ���� �޿�(�⺻��+����)�� (��������)������� �������ÿ�. (�̸�, �μ�, ����, �޿�, ���� ���)
select a.*, rownum from (select name, buseo, jikwi, (basicpay + sudang) as salary 
                                    from tblInsa
                                       where substr(ssn, 8, 1) = '2'
                                          order by (basicpay + sudang) asc) a;

-- 3. tblInsa. ���� �ο����� (���� ���� �μ� �� �ο���) �������ÿ�.
select * from (select buseo, count(*) as cnt from tblinsa where substr(ssn, 8, 1) = '2'
   group by buseo order by count(*) desc) where rownum = 1;


-- 4. tblInsa. ������ �ο��� (��������)������ �������ÿ�.(city, �ο���)
select city, count(*) as cnt from tblinsa
   group by city order by count(*) desc;

-- 5. tblInsa. �μ��� �ο����� ���� ���� �μ� �׿��� ���.
select * from (select buseo, count(*) as cnt from tblinsa
   group by buseo order by count(*) desc) where rownum = 1;

-- 6. tblInsa. ���� �޿�(�⺻��+����)�� (��������) 3~5����� �������ÿ�. (�̸�, �μ�, ����, �޿�, ���� ���)
select * from (select a.*, rownum as rnum from (select name, buseo, jikwi, (basicpay + sudang) as salary from tblinsa    order by (basicpay + sudang) desc) a) where rnum between 3 and 5;

-- 7. tblInsa. �Ի����� ���� ������ 5���������� �������ÿ�.
select * from (select * from tblinsa order by ibsadate asc) where rownum <= 5;

-- 8. tblhousekeeping. ���� ����(���� * ����) �� ���� ���� �ݾ��� ������ ���� 3������ �������ÿ�.
select * from (select * from tblhousekeeping
   order by (price * qty) desc) where rownum <= 3;

-- 9. tblinsa. ��� �޿� 2���� �μ��� ���� �������� �������ÿ�.
select * from (select a.*, rownum as rnum from (select buseo, avg(basicpay) from tblinsa
   group by buseo
      order by avg(basicpay) desc) a) where rnum = 2;

-- 10. tbltodo. ��� �� ���� ������ �Ϸ��� ������ ������� 5�� �������ÿ�.
select a.*, round((completedate - adddate) * 24 * 60) || '��' from (select * from tbltodo
   order by (completedate - adddate) asc) a where rownum <= 5;

-- 11. tblinsa. ���� ���� �߿��� �޿��� 3��°�� ���� �޴� ������ 9��°�� ���� �޴� ������ �޿� ������ ���ΰ�?
select () - () from dual;

select 
   (select basicpay from (select basicpay, rownum as rnum from (select basicpay from tblinsa where substr(ssn, 8, 1) = '1' order by basicpay desc)) where rnum = 3)
   -
   (select basicpay from (select basicpay, rownum as rnum from (select basicpay from tblinsa where substr(ssn, 8, 1) = '1' order by basicpay desc)) where rnum = 9) as "�޿� ����"
from dual;   




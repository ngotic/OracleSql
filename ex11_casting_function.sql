/*
ex11_casting_function.sql

1. to_char(����)   : ���� > ����
2. to_char(��¥)   : ��¥ > ���� *************
3. to_number(����) : ���� > ����
4. to_date(����)   : ���� > ��¥ ****

*/

/*

1. to_char(����, ���Ĺ��ڿ�)

���Ĺ��ڿ� �������
a. 9: ���� 1���� ���� 1���� �ٲٴ� ����. ���ڸ��� �����̽��� ġȯ . %5d
b. 0: ���� 1���� ���� 1���� �ٲٴ� ����. ���ڸ��� 0���� ġȯ.      %05d
c. $: ��ȭ ��ȣ ǥ�� 
d. L: ��ȭ ��ȣ ǥ�� > �Ѵ� �ݾ��� ��Ÿ���� ������ ���� �� ����. 
e. .: �Ҽ���
f. ,: ù����


2. to_char(��¥)   : ��¥ > ���� *************

���Ĺ��ڿ�

a. yyyy
b. yy
c. month
d. mon
e. mm
f. day
g. dy
h. ddd
i. dd
j. d
k. hh
l. hh24
m. mi
n. ss
o. am(pm)
*/

select 
    weight,          -- ��������(����)  
    to_char(weight)  -- ��������(����)
from tblComedian;

-- *** Java�� ������ ��� > ������ Į���� �ؼ� > �ڷ���
-- *** SQL�� ������ ��� > ������ ������ �ؼ� > �ڷ��� > �Ͻ��� ����ȯ ���� 

select 
    weight,          -- ��������(����)  
    to_char(weight),  -- ��������(����)
    length(weight),    -- length() ���ڿ� > weight ���� 
    length(to_char(weight))  -- �̰� ���������� ȣ���� �� ���̴�. > ���ڰ� �ִ��� ������ ����ȯ�� �ڵ����� �ȴ�. 
from tblComedian;

select 
    weight,
    to_char(weight),
    '@' || to_char(weight) || '@',
    to_char(weight, '99999'),-- ���ڸ��� ä��� �������� ���Ƽ� �����̽��� ä���. 
    '@' || to_char(weight, '99999'),
    '@' || to_char(weight, '00000')  || '@', -- ��ȣ�� ���� �ڸ� ��ĭ�� ����д�. 
    '@' || to_char(-weight, '00000') || '@' -- ���̳ʽ��� �־����� ����. 
from tblComedian;

select 
    100,
     to_char(100, '999'),
     to_char(100, '999') || '�޷�' ,
     to_char(100, '999') || '��' ,
     to_char(100, '$999'),
     to_char(100, 'L999') -- ��100 �̷��� ���´�.
    -- to_char(100, '999�޷�') �̰� �ȵȴ�. ������ to_char �ι�° ���ڿ��� ���Ĺ����̴�. �ƹ��� ������ ����� �ֵ鸸 ���´�. 
from dual;

select 
    1234567.89,
    to_char(1234567.89, '9,999,999') -- �ڹٴ� %,d ����. 
from dual;

select sysdate from dual; -- ������ �Ȱ���. 
select to_char(sysdate) from dual; -- �̰ų� 
select to_char(sysdate,'yyyy') from dual;

select to_char(sysdate) from dual; 
select to_char(sysdate, 'yyyy') from dual;  -- 2023 ( 4�ڸ� ) 
select to_char(sysdate, 'yy') from dual;    -- 23��(2�ڸ�) 
select to_char(sysdate, 'month') from dual; -- 3��(Ǯ����)
select to_char(sysdate, 'mon') from dual;   -- ��(���)
select to_char(sysdate, 'mm') from dual;    -- ��(2�ڸ�)
select to_char(sysdate, 'day') from dual;   -- ����(Ǯ����)
select to_char(sysdate, 'dy') from dual;    -- ����(���)
select to_char(sysdate, 'ddd') from dual;   -- ��(������ ��ĥ)
select to_char(sysdate, 'dd') from dual;    -- ��(�̹����� ��ĥ)
select to_char(sysdate, 'd') from dual;     -- ��(�̹����� ��ĥ)
select to_char(sysdate, 'hh') from dual;    -- ��(12�ð�)
select to_char(sysdate, 'hh24') from dual;  -- ��(24�ð�)
select to_char(sysdate, 'mi') from dual;    -- ��
select to_char(sysdate, 'ss') from dual;    -- ��
select to_char(sysdate, 'am') from dual;    -- ����/����
select to_char(sysdate, 'pm') from dual;    -- ����/����

-- �ϱ�
select 
    sysdate,
    to_char(sysdate, 'yyyy-mm-dd'), -- 2023-03-16
    to_char(sysdate, 'hh24:mi:ss'), -- 14:46:54
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), -- 2023-03-16 14:46:54
    to_char(sysdate, 'day am hh:mi:ss')        -- ����� ���� 02:46:54
from dual;

-- ȫ�浿	98/10/11	1998-10-11

select * from tblInsa;

select 
name,
ibsadate,
to_char(ibsadate, 'yyyy-mm-dd') as hire_date,
to_char(ibsadate, 'day') as day,
case
    when to_char(ibsadate, 'd') in ('1','7') then '�����Ի�'
    else '�����Ի�' -- else���� then �Ⱦ���. 
end
from tblInsa;

select * from tblInsa;

desc tblInsa;

-- ��¥ ��� 
-- �Ի糯¥ > 2000�� ����
select * from tblInsa
    where ibsadate >= '2000-01-01';  -- �갡 ������� �Ѵ�. �ٵ� �̰� ���ڿ��̴�. 
    -- �ڲٸ� �̳���� ����ȯ�Ѵ�...

-- �Ի糯¥ > 2000�⿡ ...
select * from tblInsa 
    where ibsadate >= '2000-01-01' and ibsadate < '2001-01-01'; -- �̷��� ��� �Ѵ�. > �� ǥ���� ���� �������̴�. 
    -- where ibsadate >= '2000-01-01' and ibsadate <= '2000-12-31'; -- ���� > �������� ���� ����� ������ ���� �ʴ´�.
                                          -- 2000-12-31 00��0��0���̶� ���������� ������ �ȵȴ�. > ��������!!
                     -- ����� �ú����ε� 
                     -- ��¥ ��� > �ڵ����� 00:00:00 > �������� ���õȴ�.(�׳�¥�� �����̵Ǵ� ������ �ȴ�.)
                     
-- �����ϵ� �ڵ����� ����ȯ�� �Ǵµ� ����ȯ�� �Ǹ� �ú��ʴ� 00:00:00�̴�.
select * from tblInsa
    where to_char(ibsadate, 'yyyy') = '2000';
    
    
select * from tblInsa
    where ibsadate >= '2000-01-01 00:00:00' and ibsadate <= '2000-12-31 23:59:59'; -- ����ȯ�� �ȵȴ�. ����ϱ��� ����.
    
select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') from dual;



-- 3. to_number(����) 
select 
   123,
   '123',            -- ���ڿ� ������ ����
   to_number('1234') -- ���� ���� ���ĵȴ�.
from dual;

select 123 * 2,
       to_number('123') * 2,
       '123'*2               -- ����ȯ�� ���ص� �׳ɵ� �ȴ�. > �Ͻ��� ����ȯ
from dual;

-- 4. to_date()
select 
    sysdate,     -- 23/03/16
    '2023-03-16', -- '2023-03-16'> ���ڿ�!!!, ��¥ �ƴϴ� > ���⼱ ����ȯ �߻� ���ߴ�. 
    to_date('2023-03-16') + 1,
    to_date('2023-03-16', 'yyyy-mm-dd' ),
    to_date('20230316'),  -- 23/03/16
    to_date('20230316','yyyymmdd'),
    to_date('2023/03/16','yyyy/mm/dd'),
    to_date('2023-03-16 15:28:25', 'yyyy-mm-dd hh24:mi:ss') -- �ú��ʰ� ���ԵǸ�... �̻��ϰ� �ȴ�. 
from dual; -- ' '���� �����ϱ� ��¥ ����� �ʿ䰡 �����ϱ� '2023-03-16' + 1 �� �ȵȴ�. 

select * from tblInsa;
desc tblInsa;

select * from tblInsa 
    where ibsadate >= to_date('2000-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss') and ibsadate <= to_date('2000-12-31 23:59:59', 'yyyy-mm-dd hh24:mi:ss');
    

-- to_date�� �ú��ʱ��� ������ ���� �ٲٱ� ���ؼ� ����.
-- to_date�� �ú��ʱ��� �����ų �� �ִ�. > ������ ���̺� ������ �ȿ����� �ú��ʰ� �Ⱥ��δ�. > to_char�� ��������Ѵ�.


select 
    to_date('2023-03-16 15:28:25', 'yyyy-mm-dd hh24:mi:ss'),   -- �ú��ʱ��� ���  --23/03/16
    to_char(to_date('2023-03-16 15:28', 'yyyy-mm-dd hh24:mi'), 'yyyy-mm-dd hh24:mi:ss'),      -- �ú��ʸ� ���������� �̷��� -- default�� 00���� ä������
    to_char(to_date('2023-03-16 15:28:25', 'yyyy-mm-dd hh24:mi:ss'), 'yyyy-mm-dd hh24:mi:ss')  -- �ú��ʸ� ���������� �̷��� 
from dual;

select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') from dual;  
-- ���϶� ����ϱ��� ����� �ú��ʱ��� �����, �ú��ʱ��� ���������� to_char�� ������





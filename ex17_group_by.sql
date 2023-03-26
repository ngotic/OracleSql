/* ex17_group_by.sql 

    [ with <sub query> ]
    select column_list
    from table_name
    [where search_condition]
    [group by group_by_expression]
    [having search_condition]
    [order by order_expression [asc|desc]];
    
    
    // _> �߰� *** 
    
    select �÷� ����Ʈ 
    
    group by �� 
    - ���ڵ带 ������� �׷��� ������ ����
    - Ư�� Į���� ������� ���� ���� ������ ���ڵ�鳢�� �׷��� ���� ����
    - �׷��� �� ��������? > ������ ������ �׷��� ��� > �����Լ��� �����ϱ� ���ؼ�!!!!
    

*/

select * from tblComedian;

-- tblInsa. �μ��� ��� �޿�? 

select * from tblInsa; 

select avg(basicpay) from tblInsa; -- 155����, 60��

select distinct buseo from tblInsa; -- 7��

select round(avg(basicpay)) from tblInsa where buseo = '�ѹ���'; -- 171
select round(avg(basicpay)) from tblInsa where buseo = '���ߺ�'; -- 138
select round(avg(basicpay)) from tblInsa where buseo = '������'; -- 160
select round(avg(basicpay)) from tblInsa where buseo = '��ȹ��'; -- 185
select round(avg(basicpay)) from tblInsa where buseo = '�λ��'; -- 153
select round(avg(basicpay)) from tblInsa where buseo = '�����'; -- 141
select round(avg(basicpay)) from tblInsa where buseo = 'ȫ����'; -- 145
-- �� �۾��� ���̷��� groupby�� �Ѵ�.

select * from tblInsa group by buseo; -- �̴�δ� ������ �ȵȴ�. ������ ����. 
-- �÷�����Ʈ �����̴�. group by�� �÷�����Ʈ�� �ƹ��ų� ���� �� ����. ������ �ִ�. 
-- 1. �����Լ�
-- 2. group by �� ���� �÷�

select 
buseo, avg(basicpay)
from tblInsa
    group by buseo;

-- ���� ���? ���� ���? > ���ະ ���� �������? 
-- ���� �׷�, ���� �׷��� ī��Ʈ�� ���� �Ѵ�. 
select * from tblComedian;

select count(*), gender from  -- ���� ������ �𸣴ϱ� ������ ���ش�.
tblComedian 
    group by gender;
    
-- ����� ������ ? 
select 
count(*), continent
from tblCountry
group by continent;

select 
    buseo, 
    count(*) as "�μ��� �ο���",
    sum(basicpay) as "�μ��� �޿� ��",
    avg(basicpay) as "�μ��� ��� �޿�",
    max(ibsadate) as "�μ��� ������ �Ի���",
    min(ibsadate) as "�μ��� ������ �Ի���"
from tblInsa
    group by buseo;
    
select 
gender,
round(avg(height)) as "���ະ ��� Ű" ,
round(avg(weight), 1) as "���ະ ��� ������" ,
max(height) as "Ű�� ���� ū���",
min(height) as "Ű�� ���� �������"
from tblComedian
    group by gender ;
    
-- ������ �ο���? > ���� > ���� ������ ��踦 ���Ѵ�. 
select 
job,
count(*)
from tblAddressBook
group by job
-- order by count(*) desc;
order by job; 

-- ���� �̸������ε� ����

--select 
--    round(avg(basicpay)), --OK
--    buseo,     -- OK
--    name               -- �̰Ͷ����� ������ ����. 
--from tblInsa
--    group by buseo;

-- 1�� �׷�(�μ�) > 2�� �׷�(����)

select -- 1���׷� 
buseo as "�μ���",
count(*) as "�ο���"
from tblInsa 
    group by buseo;
        
select -- 2���׷� >> �����ϰ� ��������. 
buseo as "�μ���",
jikwi as "������",
count(*) as "�ο���"
from tblInsa 
    group by buseo, jikwi
        order by buseo, jikwi;

-- ���� �ο���?
select 
count(*), 
substr(ssn,8,1) as ����
from tblInsa
group by substr(ssn,8,1); --?? �׷��� �������� ��� ������ ������ ���� ������ �ʿ��ϴ�. 
-- group by�� ���ǵ� �÷� ����ü�� �ƴ϶� ������ �������� group by�� ���� �� �ִ�. 
-- group by���� alias�� ������.

-- instr > indexOf�̴�. 
select instr('hellow','w') -- w�� ��ġ�� 6
from dual;


-- ������ �ο��� ? 
-- ����Ư���� ������ ������13�� 5 ~ 42
-- ���ֱ����� ~
-- ��⵵ ~ 
-- �̰� �׷����� ������ �պκ��� ©�󳻾��Ѵ�. 
select 
substr(address, 1, instr(address,' ') -1 ) -- ' '������ ������ �� �� �κ��� �׷��� ������ŭ ¥���ϱ� -1
from tblAddressBook
    group by substr(address, 1, instr(address,' ') -1 ); 
    
-- ������ ������ group by�ϴ� ����


-- �̸��� ����Ʈ�� �ο���
-- prevent@gmail.com
-- international_dog@duam.net
-- small@gmail.com
-- daughter@daum.net 

select 
    substr(email, instr(email, '@')+1), -- 1�������� �����غ��� 
    count(*)
from tblAddressBook
    group by substr(email, instr(email, '@')+1)
        order by count(*) desc;
        
        
-- �޿��� �׷� > �ο���?
 -- 100���� ����
 -- 100���� ~ 200���� �̻�
 -- 200���� �̻�
select 
    basicpay,
    floor(basicpay / 1000000)
    from tblInsa;

select 
    (floor(basicpay / 1000000)+1) *100 || '���� ����' as "�޿���",
    count(*)
    from tblInsa
        group by floor(basicpay / 1000000)
            order by floor(basicpay / 1000000) asc;

-- floor�� �Ẹ�� 

-- ����? ������? ���� �? completedate�� ���� ������ ���� �޶�����. 
select 
completedate,
count(*) from tblTodo
group by completedate;
 

select 
    case 
        when completedate is null then '������' 
        when completedate is not null then '����'
    end
    from tblTodo
        group by case 
        when completedate is null then '������'  
        when completedate is not null then '����' 
    end;

-- select * from traffic_accident;
-- traffic_accident. �� ���� ���� ��(����ö, ö��, �װ���, ����, �ڵ���) �߻��� �� ���� ��� �߻� ��, �� ����� ��, ��� �� ��� ����� ���� �������ÿ�.
-- �̰� ���̺��� ����.

-- tblZoo. ����(family)�� ��� �ٸ��� ������ �������ÿ�.
select * from tblZoo;
select floor(avg(leg)) "��մٸ� ����" from tblZoo group by family;

-- tblZoo. ������� �������� �׷��� ������ �� �׷��� ������ �������ÿ�.
select sizeof "������", family "����", count(*) "�� �׷찳��" from tblZoo group by sizeof, family;

-- tblAddressBook. �̸����� ������ũ �������� ������� ����� �߿��� �����̸�, 20���̸�, Ű�� 150~160cm ���̸�, ������ ���� �Ǵ� ��õ�� ����鸸 �������ÿ�.
select *
from tblAddressBook;

select *
from tblAddressBook
where email like '%a_%' escape 'a' and
      gender ='f' and
      age >= 20 and age <30 and
      height >150 and height < 160 and
      hometown in ('����', '��õ') ; 

/*
 group by ��
 - ���ڵ带 ������� �׷��� ������ ����
 - Ư�� Į���� ������� ���� ���� ������ ���ڵ�鳢�� �׷��� ���� ����
 - �׷��� �� �����°���? > ������ ������ �׷��� ��� > ���� �Լ��� �����ϱ� ���ؼ� !!!(***************)
 
select �÷�����Ʈ  --5. �÷��� ����
from ���̺�       --1. ���̺�κ���
where ����        --2. ���ϴ� ���ڵ带 
group by ����     --3. �׷��� ������
having��          --4. �׷쿡 ���� ����
order by ����     --6. �����Ѵ�.

-- from, where, group by, having, select, order by
 
 select��(***)
 1. ������ ����
 2. ������ �������
 
 ** where�� vs having�� 
 
 having�� > group���� �з��� �ϳ��� ī�װ��� ���� �����̴�. 
 - ������
 - group by���κ��� ���� �¿� ���� ����(���� ����: group by > having)
 - ���տ� ���� ���� > ���� �Լ����� �������� ��� 
 
 where��  > from���� �������̺��� �����ο� ���� ������ �Ǵ�.
 - ������
 - from���κ��� ���� �¿� ���� ����(���� ���� : from > where)
 - ���ο� ���� ����(��) > �÷����� �������� ���
 
 
*/

select 
count(*), buseo --3.
from tblInsa    --1.
group by buseo; --2.


select 
    count(*), buseo           --4.
from tblInsa                  --1.
    where city = '����'        --2.
        group by buseo;       --3.

select 
    count(*), buseo            -- 4.
from tblInsa                   -- 1. 
    where basicpay >= 2500000  -- 2. 
        group by buseo;        -- 3. �ɷ��� ���¿��� group by�� �ȴ�. 

select max(basicpay) from tblInsa group by buseo;

select name, buseo, jikwi, city, basicpay
from tblInsa
    where basicpay>=2500000;

select name, buseo, jikwi, city, basicpay
from tblInsa
    where basicpay>=2500000
        order by buseo;


select 
    buseo, 
    round(avg(basicpay))    --3. �������� �׷캰�� �����Լ��� ���� ���Ѵ�. 
from tblInsa                --1. 60���� �����͸� �����´�. 
    group by buseo;         --2. 60���� ������� > �μ��� �׷��� ������. 


select 
    buseo,
    round(avg(basicpay))
from tblInsa
    where basicpay >= 1500000  -- 1. 60���� �����͸� �����´�.
        group by buseo;        -- 2. 60���� ����� ���ǿ� �´� ������ �����.
                               -- 3. where���� ������ �������� ������� �׷��� ������. 

select 
    buseo,
    round(avg(basicpay))
from tblInsa                                 --1. 60���� �����͸� �����´�.
        group by buseo                       --2. 60���� ������� > �μ��� �׷��� ������. 
            having avg(basicpay) >= 1500000; --3. �׷캰 �����Լ����� �������� ���͸� 

-- having�� ���ڵ带 ������� ���� �ʴ´�. �׷�� ���� �ϳ��� ī�װ��� ���� ���͸��� �Ѵ�.
-- �μ��߿� ������ �����ϴ� �μ��� �ɷ����� ������ �Ѵ�. 
-- ex) ���࿡ ȫ���ΰ� avg(basicpay) >= 1500000; ���ǿ� ���� ������ ���͸��� �ȴ�. 

select 
    buseo, 
    round(avg(basicpay))                     -- 5.
from tblInsa                                 -- 1. 
    where basicpay >= 1500000                -- 2.
        group by buseo                       -- 3.
            having avg(basicpay) >= 2200000  -- 4. having���� ��ձ޿��� 220���� �̻��� �ֵ鸸 �ɷ��� 
                order by avg(basicpay) desc; -- 6.

select name, buseo, jikwi from tblInsa where basicpay >= 1500000 order by buseo;

-- tblZoo. ü���� ������ ���� �� �ư��� ȣ��� �� ȣ���� �ϴ� ������ ������ �������ÿ�.
select breath, count(*) "����"
from tblZoo
where thermo = 'variable' 
group by breath;


-- tblAddressBook. �������� �Ǽ��� ��� ������� �̸��� �ּҰ� �ߺ��Ǿ���. �ߺ��� �̸��� �ּҸ� �������ÿ�.
select email --, count(*)
from tblAddressBook
group by email
having count(*) >= 2;

-- tblAddressBook. ������ �ο����� 100�� �̻� �Ǵ� �������� �������ÿ�.
select * from tblAddressBook;

select substr(name,1,1) -- , count(*)
from tblAddressBook
group by substr(name,1,1)
having  count(*) >= 100;


-- tblAddressBook. '�ǹ���'�� '�ǹ���������'���� �������� ����� ������ ������ ��� �Ǵ���?
select job, count(*) "��",

sum(case 
    when instr(address,'����') <> 0 then 1 else 0
end) "���﷯",
sum(case 
    when instr(address,'����') = 0 then 1 else 0
end) "���淯",
round( sum(case 
    when instr(address,'����') <> 0 then 1 else 0
end)/count(address),2)*100 ||'%' "������ ���� ",

round( sum(case 
    when instr(address,'����') <> 0 then 0 else 1
end)/count(address),2)*100 ||'%' "������ ���� "

from
tblADdressBook
group by job
having job='�ǹ���' or job='�ǹ���������';



select instr(address,'����')
from tblAddressBook;

select count(address) "���﷯" from tblAddressBook where job='�ǹ���' and instr(address,'����')<>0 ;
select count(address) "���淯 "from tblAddressBook where job='�ǹ���' and instr(address,'����') = 0 ;
select count(address) "���﷯" from tblAddressBook where job='�ǹ���������' and instr(address,'����')<>0 ;
select count(address) "���淯 "from tblAddressBook where job='�ǹ���������' and instr(address,'����') = 0 ;
select count(address) from tblAddressBook where job='�ǹ���������';


/*

cube()

rollup()
    -group by ��ȯ ������� �ڼ��ϰ� ǥ��
    

*/

select 
    buseo,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by buseo;
    
select
    buseo,
    jikwi,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by rollup(buseo, jikwi);
 
select
    buseo,
    jikwi,
    city,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by buseo, jikwi, city;
  
select
    buseo,
    jikwi,
    city,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by rollup(buseo, jikwi, city);

 
-- �߽������ ���� ����� ����.  > �̷��� �����ָ� ������ ������ ������ �Ѵ�. 
-- �̰Ϳ� ���� ���꼺�� �����ش�. 
-- �ٵ� format ���°� �̷� ���¶� �Ⱦ��� ��쵵 ���� 


/*
     cube()
     - group by ������� ���� ����� �� �ڼ��ϰ� ��ȯ
     - rollup() ���� �� �� �ڼ��ϰ� ǥ�� 
     - rollup() �� ���� �� �� �پ��� �������� �߰� ���� �߰� 
*/


select 
    buseo,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by cube(buseo);
    
-- 1�� �׷��� rollup�� cube�� ����. ������ ����.

select 
    buseo,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by rollup(buseo);


select 
    buseo,
    jikwi,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by cube(buseo, jikwi);


select 
    buseo,
    jikwi,
    city,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by cube(buseo, jikwi, city);
    
-- ������ ���������� cube�� ���.. �躸�� ����� ???     
    

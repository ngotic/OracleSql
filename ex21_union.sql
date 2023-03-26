/*

    ex21_union.sql
    
    ���� ��� ����
    1. ������ > select where
    2. �������� > select column
    3. ���� > a join b
    4. ������, �����Ϻ� ������
    
    union 
    - ������
    
    intersect 
    - ������
    
    minus 
    - ������
    
*/  

-- ����: �÷� + �÷�
-- ���Ͽ� : ���ڵ� + ���ڵ�
-- select * from tblMen + select * from tblWomen; ������� ��ġ�� ���̴�.

select * from tblMen    -- ������ �鿩���⸦ �Ѵ�.
union 
select * from tblWomen; -- ���� 10��, ���� 10���� �Ѳ����� ���� �ִ�.

--- ȸ�� �μ��� > �Խ��� ------------------
-- ������ ~
select * from �Խ���; -- 4õ����

-- ������ ~
select * from �����ΰԽ���; -- õ����
select * from �ѹ��ΰԽ���; -- 2õ����
select * from ���ߺΰԽ���; -- õ����

--- ����� > ��� �μ��� �Խ��� > �ѹ��� ����
-- �ѹ��� ~
select * from �����ΰԽ���
union
select * from �ѹ��ΰԽ���
union
select * from ���ߺΰԽ���;
-----------------------------------------

-- SNS > �Խù� > �⵵����~ > ���̿���
select * from �Խ���2020;
select * from �Խ���2021;
select * from �Խ���2022;
select * from �Խ���2023;

select * from �Խ���2023 where �˻�; 
-- ������ ������ ������ �̷��� ���̺��� ���������� ���� �ְ� 
-- ������ ������ �˻��� �����ϰ� ���ϱ� ... 

select * from �Խ���2020
union
select * from �Խ���2021
union
select * from �Խ���2022
union
select * from �Խ���2023
where �˻�;

-- ��ҿ� ������ �����ߴٰ� ���߿� ��ü �˻��� �ϱ����� ���ļ� �˻�

-- �� ���� > ��Ű��(�÷��� ������ ����, �ڷ���)�� �����ؾ� �Ѵ�.
-- �� ����> �������� ������ �����ؾ� �Ѵ�.
select * from tblCountry -- 5�� Į��
union
select * from tblInsa;   -- 10�� Į��

select name, capital, population from tblCountry  -- ������ ������ �ʴ�.
union 
select name, buseo, basicpay from tblInsa;        -- ������ ������ �ʴ�.


create table tblUnionA ( 
    name varchar2(30) not null
);

create table tblUnionB ( 
    name varchar2(30) not null
);

insert into tblUnionA values ('������');
insert into tblUnionA values ('�����');
insert into tblUnionA values ('�䳢');
insert into tblUnionA values ('�ź���');
insert into tblUnionA values ('���Ƹ�');

insert into tblUnionB values ('ȣ����');
insert into tblUnionB values ('����');
insert into tblUnionB values ('������');
insert into tblUnionB values ('�ڳ���');
insert into tblUnionB values ('�����');

select * from tblUnionA;
select * from tblUnionB;

--[ union > ���� ������ ���� > ������ > �ߺ��� ���X ]
select * from tblUnionA
union 
select * from tblUnionB;

-- union all > �ߺ��� ��� O
select * from tblUnionA
union ALL
select * from tblUnionB;

-- intersect > ������
select * from tblUnionA
intersect
select * from tblUnionB;

-- minus > ������
select * from tblUnionA
minus 
select * from tblUnionB;

select * from tblUnionB
minus 
select * from tblUnionA;




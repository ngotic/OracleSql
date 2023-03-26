/*

    ex19_join.sql
    
    ������ �����ͺ��̽� �ý���(RDBMS, Oracle)�� �����ϴ� �͵� ....
    1. ���̺� �⺻Ű(PK)�� ���� ���� > ������ ���� ��� 
    2. null�� ���� ������ ���̺��� �ص��� �Ⱦ��Ѵ�.... > ������ ���� + ���� ���� 
    3. �����Ͱ� �ߺ��Ǵ� ���� > ������ ���� ��� + ���� ����
    4. �ϳ��� �Ӽ����� ���ڰ��� �ƴ� ���� 
   
*/


create table tblTest (
    name varchar2(30) not null,
    age number(3) not null,
    address varchar2(300) not null
);

drop table tblTest;

select * from tblTest;

insert into tblTest(name, age, address) values('ȫ�浿', 20, '�����');
insert into tblTest(name, age, address) values('�ƹ���', 25, '��õ��');
insert into tblTest(name, age, address) values('ȣȣȣ', 20, '�λ��');
insert into tblTest(name, age, address) values('ȫ�浿', 20, '�����');

select * from tblTest;

update tblTest set address='������' where name = 'ȫ�浿'; 

drop table tblTest;

create table tblTest (
    name varchar2(30) not null,
    age number(3) not null,
    address varchar2(300) not null,
    hobby varchar2(300) null
);

insert into tblTest(name, age, address, hobby) values('ȫ�浿', 20 ,'�����', '����');
insert into tblTest(name, age, address, hobby) values('�ƹ���', 25 ,'��õ��', null);
insert into tblTest(name, age, address, hobby) values('ȣȣȣ', 27 ,'�λ��', '����, ����, �, ����');
insert into tblTest(name, age, address, hobby) values('������', 29 ,'�λ��', '���Ʃ�꺸��');

select * from tblTest;

-- ������ �����?
select * from tblTest where hobby = '����';

-- ��� ���? 
select * from tblTest where hobby = '�'; -- �̷��Զ� ã���� �Ǳ� ��
select * from tblTest where hobby like '%�%'; -- �̷��Զ� ã���� �Ǳ� ��

-- � > ��ü�ܷ� 
-- ����, ����, �, ����> ����, ����, ��ü�ܷ�, ����
-- ���ڰ��� ������ �ٵ� �̷��� �ϸ� ����� �Ѵ�. 
-- �ǵ������� ���ؾ� �Ѵ�. 

drop table tblTest;

create table tblTest (
    name varchar2(30) not null,
    age number(3) not null,
    address varchar2(300) not null,
    hobby1 varchar2(300) null,
    hobby2 varchar2(300) null,
    hobby3 varchar2(300) null
);

-- �׷� Į���� ������ �����?
-- ȣȣȣ, 27, �λ��, �, null, null, null, null, null, null > �̷������� ���� ���� 
-- ������, 29, �����, A, B, C, D, E, F, J > �̷��� �پ��� ������µ�

-- �������� 
-- ����(��ȣ(PK), �̸�, �޿�, ������, ���������Ʈ)
--create table tblStaff (
--    seq number primary key,         -- ��ȣ(PK) 
--    name varchar2(30) not null,     -- �̸�
--    salary number not null,         -- �޿�
--    address varchar2(300) not null, -- ������
--    project varchar2(300) null      -- ��� ������Ʈ --> ����� ��������. 
--); -- old


insert into tblStaff(seq, name, salary, address, project) values (1, 'ȫ�浿', 300, '�����', 'ȫ�� ����');
insert into tblStaff(seq, name, salary, address, project) values (2, '�ƹ���', 250, '��õ��', 'TV ����');
insert into tblStaff(seq, name, salary, address, project) values (3, '������', 350, '�λ��', '���� �м�');
                
select * from tblStaff;

-- ���� + ���������Ʈ
-- 1���� ���� > �������� ������Ʈ ��� 
-- 'ȫ�浿'���� ��� ������Ʈ 1�� �߰� > '������' 
-- '�ƹ���'���� ��� ������Ʈ 1�� �߰� > '�Խ��� ����'
insert into tblStaff(seq, name, salary, address, project) 
values (4, 'ȫ�浿', 300, '�����', 'ȫ�� ����');
update tblStaff set project = project || ',�Խ��ǰ���' where name = '�ƹ���'; -- �ϳ��� Į���� �ΰ��� ������Ʈ�� ����??... ���� �ȵ� �̰� ���ĺ���
select * from tblStaff;

drop table tblStaff;

create table tblStaff (
    seq number primary key,         -- ��ȣ(PK) 
    name varchar2(30) not null,     -- �̸�
    salary number not null,         -- �޿�
    address varchar2(300) not null  -- ������
    
); -- ���� tblStaff�� �ִ� ������Ʈ�� �Ʒ� ���̺�� �и� 

create table tblProject (
    seq number primary key,           -- �������� �ʿ��ߴ� ���� �ƴѵ� �⺻Ű ������ ���ؼ� ���� Ű 
    project varchar2(300) not null,   -- ��� ������Ʈ
    staff_seq number not null         -- ������ȣ
);

insert into tblStaff(seq, name, salary, address) values (1, 'ȫ�浿', 300, '�����');
insert into tblStaff(seq, name, salary, address) values (2, '�ƹ���', 300, '��õ��');
insert into tblStaff(seq, name, salary, address) values (3, '������', 300, '�λ��');

-- >> ���� �̷� ������ �ߵ� 
insert into tblProject( seq, project, staff_seq) values ( 1, 'ȫ�� ����', 1 );  -- ȫ�浿
insert into tblProject( seq, project, staff_seq) values ( 2, 'TV ����',  2);   -- �ƹ���
insert into tblProject( seq, project, staff_seq) values ( 3, '���� �м�', 3);  -- ������
insert into tblProject( seq, project, staff_seq) values ( 4, '���� ����', 1 ); -- ȫ�浿
insert into tblProject( seq, project, staff_seq) values ( 5, '�븮�� �о�',2 ); -- �ƹ���

-- ���ڰ� ���� & �ߺ� �߻�X > ����ȭ : �� 1����ȭ�� �۾��� �� ���̴�. 
-- ���������� ������ �ִ� ���̺��� ����ε� ������ ���̺�� �ٲ� 
select * from tblStaff; 
select * from tblProject;

-- A. ���� ��� �Ի� > �ű� ������Ʈ ��� 
-- A.1 ���� ��� �߰� 
insert into tblStaff (seq, name, salary, address)  values (4, 'ȣȣȣ', 250, '�ϻ��');

-- A.2 �ű� ������Ʈ �߰� + ��� ���� 
insert into tblProject ( seq, project, staff_seq ) values (6, '���� ����', 4);

-- A.3 �ű� ������Ʈ �߰� > ���� �߻�!! > �������� �ʴ� ���� ��ȣ�� ���!!! 
insert into tblProject ( seq, project, staff_seq ) values (7, '�� ��ġ', 5); -- X �� �ȵ� : �� �Ǵµ�... 

-- �����!! > '�� ��ġ' �����!!!
select * from tblStaff
where seq = (select staff_seq from tblProject where project ='�� ��ġ'); -- �ƹ��͵� ���� 
-- ����ڰ� ����.... ���⼭ �̹� �߸����� ���̴�. 
-- �������� ������ �� ������. 

-- B.  'ȫ�浿' ���
-- B.1 'ȫ�浿' ���� 
delete from tblStaff where seq = 1;

select * from tblStaff;

-- �����!! > "ȫ�� ����" > ����� ������? > ����. �浿�̸� �������ϱ� �̷� ������.... 
select * from tblStaff
where seq = (select  staff_seq from tblProject where project ='ȫ�� ����');

-- �浿�̰� ����ڷ� �Ǿ� �ִ� ������Ʈ�� �����Կ��� �̷���. 

-- B.2 '�ƹ���' ��� > �μ� �ΰ�(����) > '������'
update tblProject set staff_seq = 3 where staff_seq = 2; 
-- �� ���� ������Ʈ�� �ð� �־ �ΰ��� ���� ������Ʈ �ȴ�.

update tblProject set staff_seq = (select seq from tblStaff where name='������') 
    where staff_seq = (select seq from tblStaff where name ='�ƹ���'); 


--B.3 '�ƹ���' ��� 
delete from tblStaff where seq= 2;

-- �����!! > 'TV ����'
select * from tblStaff 
    where seq = (select staff_seq from tblProject where project = 'TV ����');

-- �̷� ��������� fk�� �����Ѵ�. 
drop table tblStaff;
drop table tblProject;

-- �θ� ���̺�(�⺻ ���̺�)  
create table tblStaff (
    seq number primary key,         -- ��ȣ(PK) 
    name varchar2(30) not null,     -- �̸�
    salary number not null,         -- �޿�
    address varchar2(300) not null  -- ������
); -- ���� tblStaff�� �ִ� ������Ʈ�� �Ʒ� ���̺�� �и� 


-- �ڽ� ���̺�(�������̺�) 
create table tblProject (
    seq number primary key,                                 -- �������� �ʿ��ߴ� ���� �ƴѵ� �⺻Ű ������ ���ؼ� ���� Ű 
    project varchar2(300) not null,                         -- ��� ������Ʈ
    staff_seq number not null references tblStaff(seq)      -- ������ȣ(����Ű, �ܷ�Ű, FK) > �� Į�� ������ ������. 
); 
-- �������� �� �÷��� ���� �����ʹ� �ƹ��ų� ���� ���� ����. staff ���̺��� ������ �ִ� staff_seq�� �־�� �Ѵ�. 
-- tblProject ���̺� > �̰� ���� ����� ������ ����. 
-- tblStaff�̰� ������� �𸣴ϱ� ������ ����ִ� ���̴�.

-- ���� �� ���̺� ������ �����ض� fk������ ���߿� ����� �ֳĸ� �����ϴ� ���̺��� ���� ������ �ϱ� ������ 

-- ���� ���� Project table ���� ������ �Ѵ�.
-- �׷��� ���� tblStaff���̺� �����. 

-- �� �θ� ���̺���� ����� �ڽ����̺� ������ �Ѵ�.
-- �� ���� ���� �ڽ����̺� ���� ������ �Ѵ�. 

insert into tblStaff(seq, name, salary, address) values (1, 'ȫ�浿', 300, '�����');
insert into tblStaff(seq, name, salary, address) values (2, '�ƹ���', 300, '��õ��');
insert into tblStaff(seq, name, salary, address) values (3, '������', 300, '�λ��');

insert into tblProject( seq, project, staff_seq) values ( 1, 'ȫ�� ����', 1 );  -- ȫ�浿
insert into tblProject( seq, project, staff_seq) values ( 2, 'TV ����',  2);   -- �ƹ���
insert into tblProject( seq, project, staff_seq) values ( 3, '���� �м�', 3);  -- ������
insert into tblProject( seq, project, staff_seq) values ( 4, '���� ����', 1 ); -- ȫ�浿
insert into tblProject( seq, project, staff_seq) values ( 5, '�븮�� �о�',2 ); -- �ƹ���

-- A.1 ���� ��� �߰� 
insert into tblStaff (seq, name, salary, address)  values (4, 'ȣȣȣ', 250, '�ϻ��');

-- A.2 �ű� ������Ʈ �߰� + ��� ���� 
insert into tblProject ( seq, project, staff_seq ) values (6, '���� ����', 4);

-- A.3 �ű� ������Ʈ �߰� > ���� �߻�!! > �������� �ʴ� ���� ��ȣ�� ���!!! -- ���� ������ ����.
-- ORA-02291: integrity constraint (HR.SYS_C007334) violated - parent key not found
insert into tblProject ( seq, project, staff_seq ) values (7, '�� ��ġ', 5);
                                             -- 5���̶�� ��ȣ�� �������� �ʴ´�. 
-- ȫ�浿 ��� ������ �����. 
delete from tblStaff where seq = 1; 
-- ORA-02292: integrity constraint (HR.SYS_C007334) violated - child record found
-- �ڽ� ���̺��� �־ ��������. > ���� �����ϴ� �ְ� �־ ������.... child record

update tblProject set staff_seq = 3 where staff_seq = 2; -- ���� ���� 
select * from tblProject;      -- staff_seq = 2 �� �ش��ϴ� ģ���� ����
delete from tblStaff where seq= 2;  -- 2, '�ƹ���'�� ���� ���� ������ ��� ����
select * from tblStaff;

-- �� (���̺�) ������ �� > ���� �����ؾ��� ������ ������ > �θ� ���̺� 

-- �� ���̺� 
create table tblCustomer (
    seq number primary key,        -- ����ȣ(PK)
    name varchar2(30) not null,    -- ����
    tel varchar2(15) not null,     -- ����ó
    address varchar2(100) not null -- �ּ�
);

-- �Ǹų��� ���̺� 
create table tblSales(
    seq number primary key,
    item varchar2(50) not null,
    qty number not null,
    regdate date default sysdate not null,
    cseq number not null references tblCustomer(seq)
);  

select * from tblCustomer;
select * from tblSales;
-- �帣 ���̺�
create table tblGenre (         -- ���� ū ����
    seq number primary key ,    -- �帣��ȣ(PK)
    name varchar2(30) not null, -- �帣��
    price number not null,      -- 
    period number not null      -- 
);

-- ���� ���̺�
create table tblVideo (
    seq number primary key,        -- ���� ��ȣ(PK)
    name varchar2(100) not null,   -- ���� ����
    qty number not null,           -- ���� ����
    company varchar2(50) null,     -- ���ۻ�
    director varchar2(50) null,    -- ����
    major varchar2(50) null,       -- �ֿ���� 
    genre number not null references tblGenre(seq) -- �帣 ��ȣ(FK) 
);

-- ��� ���̺� 
create table tblMember (
    seq number primary key ,
    name varchar2(30) not null,
    grade number(1) not null,
    byear number(4) not null,
    tel varchar2(15) not null,   
    address varchar2(300) null,        -- �ּ� 
    money number not null              -- ��ġ��
);

-- �뿩 ���̺� 
create table tblRent ( -- ���� ������ �̷��� �ڽ�, �ƴϸ� ���⿡ �� ���� �޾� 
    seq number primary key,                                 -- �뿩��ȣ(PK)
    member number not null references tblMember(seq),       -- ȸ����ȣ(PK)
    video number not null references tblVideo(seq),         -- ������ȣ(FK)
    rentdate date default sysdate not null,                 -- �뿩��¥
    retdate date null,                                      -- �ݳ���¥
    remark varchar2(500) null                               -- ��� 
);
-- ���� > �帣 > ���� > ȸ�� > �뿩 ���̺� ���� 



-- �� ������
insert into tblcustomer (seq, name, tel, address)
      values (1, 'ȫ�浿', '010-1234-5678', '�����');
insert into tblcustomer (seq, name, tel, address)
      values (2, '�ƹ���', '010-3333-4444', '��õ��');
insert into tblcustomer (seq, name, tel, address)
      values (3, '������', '010-5555-6666', '�λ��');


-- �Ǹ� ������
insert into tblsales (seq, item, qty, cseq) values (1, '��ȭ��', 1, 1);
insert into tblsales (seq, item, qty, cseq) values (2, '���̾', 3, 2);
insert into tblsales (seq, item, qty, cseq) values (3, '��Ʈ', 10, 2);
insert into tblsales (seq, item, qty, cseq) values (4, '����', 20, 3);
insert into tblsales (seq, item, qty, cseq) values (5, '���찳', 15, 3);
insert into tblsales (seq, item, qty, cseq) values (6, '���콺', 5, 1);
insert into tblsales (seq, item, qty, cseq) values (7, 'Ű����', 2, 3);
insert into tblsales (seq, item, qty, cseq) values (8, '�����', 1, 2);
insert into tblsales (seq, item, qty, cseq) values (9, '��ǳ��', 2, 1);

commit;






-- �帣 ������
INSERT INTO tblGenre VALUES (1, '�׼�',1500,2);
INSERT INTO tblGenre VALUES (2, '����',1000,1);
INSERT INTO tblGenre VALUES (3, '���',1000,3);
INSERT INTO tblGenre VALUES (4, '�ڹ̵�',2000,2);
INSERT INTO tblGenre VALUES (5, '���',2000,1);
INSERT INTO tblGenre VALUES (6, '��Ÿ',1800,2);


-- ���� ������
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (1, '������ ��ĥ��',5,'�����ʸ�','�ɿ���','��ĥ��',3);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (2, '���ޱ���',5,'���� ���δ���','�谨��','�ڿ���',2);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (3, '�й̳�����',3,'�Ķ󸶿�Ʈ','James','John',1);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (4, '������',3,'�븸��ȭ��','ȫ����','����',4);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (5, '�ǻ��ұ��',6,'�ǻǻ�','�ڰ���','������',5);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (6, '������ ��ȥ',2,'�Ķ󸶿�Ʈ','James','Mike',5);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (7, '�ֶ�� ������',1,NULL,NULL,NULL,1);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (8, 'Ÿ�̰� ŷ',4,'Walt','Kebin','Tiger',3);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (9, '�ڹ� ���긮 ��',10,'�����ʸ�','������','������',5);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (10, '����',7,'�λ��ʸ�','�ڰ���','�嵿��',1);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (11, '�������ﱸ��',2,'�ǻǻ�','�ڰ���','�̺���',1);




-- ȸ�� ������
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (1, '������',1,1970,'123-4567','12-3���� 301ȣ',10000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (2, '������',1,1978,'111-1111','777-2���� 101ȣ',0);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (3, '������',1,1978,'222-2222','86-9����',20000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (4, '������',1,1982,'333-3333',NULL,15000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (5, '�ż���',1,1988,'444-4444','���� APT 1012ȣ',0);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (6, '���߱�',1,1981,'555-5555','���Ѻ��� 102ȣ',1000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (7, '������',1,1981,'666-6666','12-1����',0);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (8, '�̼���',1,1981,'777-7777',NULL,1500);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (9, '��ν�',1,1981,'888-8888','73-6����',-1000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (10, '������',1,1981,'999-9999','���� APT 902ȣ',1200);

-- �뿩 ������
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (1, 1,1,'2022-01-01',NULL);
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (2, 2,2,'2022-02-02','2022-02-03');
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (3, 3,3,'2022-02-03',NULL);
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (4, 4,3,'2022-02-04','2022-02-08');
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (5, 5,5,'2022-02-05',NULL);
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (6, 1,2,'2022-02-10',NULL);

commit;

select * from tblcustomer;
select * from tblsales;

select * from tblGenre;
select * from tblVideo;
select * from tblMember;
select * from tblRent;

/*
    ����, join
    - (���� ���踦 ����) 2��(1��) �̻��� ���̺��� ����ؼ�, 1���� ������� ����� ����
    - ���̺�A + ���̺�B = ���̺�C
    
    ������ ����
    1. �ܼ� ����, Cross join
    2. ���� ����, Inner join *** 
    3. �ܺ� ����, Outer join ***
    4. ���� ����, Self join
    5. ��ü �ܺ� ����, Full Outer Join
    
    1. �ܼ� ����, Cross Join
        - īƼ�ǰ�, ��ī��Ʈ��
        - A ���̺� ���ڵ� ���� x B ���̺� ���ڵ� ���� = ����� ���ڵ� ����
        - A ���̺� �÷� ���� + B ���̺� �÷� ���� = ������� �÷� �� 
        - �������. > ��ġ�� �ִ� ��� ��ġ�� ���� ���� �ڼ��� �ִ�. 
        - ���߿�, �׽�Ʈ�� > ��ȿ���� ������� �ٷ��� �����͸� ���� ��.... 
        
     * ������ ���̺�, �������� ���̺� 1��1�� ��Ī�ؼ� ������� �����. 
        
     2. ���� ����, Inner Join
     - �ܼ� ���ο��� ��ȿ�� ���ڵ常 �����ϴ� ����(����� ����)
     - select �÷�����Ʈ from ���̺�A inner join ���̺�B on ���̺�A.�÷� = ���̺�B.�÷�; -- ANSI-SQL
                                --> ���� ���̺��� �÷��� ������ ���̺��� �÷��� ������ ������ ������ �Ѵ�.
     - select �÷�����Ʈ from ���̺�A, ���̺�B where ���̺�A.�÷� = ���̺�B.�÷�;        -- Oracle ����ǥ���
                            -- �̰� where�� ���ο뵵���� �ƴϸ� �ٸ� �뵵���� �򰥸���. > ������ ��������. 
    
    select �÷�����Ʈ
    from tableA 
        inner join tableB
            on tableA.�÷� = tableB.�÷�;
            
select �÷�����Ʈ
from ���̺�A
    inner join ���̺� B
        on �θ����̺�.id = �ڽ����̺�.id
*/

select * from tblCustomer; -- 3��
select * from tblSales;    -- 9��

select * from tblCustomer cross join tblSales; 
-- ANSI-SQL > ���� 
-- ���ϱ� ������ �����̴�.
select * from tblCustomer; -- �굵 seq
select * from tblSales; -- �굵 seq�� �ִ�. 

select * from tblCustomer 
    inner join tblSales
        on seq = cseq; -- ORA-00918: column ambiguously defined
        -- ���� seq�� tblSales ������, tblCustomer������ �𸥴�.



select name, item, tblCustomer.seq, tblSales.seq 
from tblCustomer 
    inner join tblSales
        on tblCustomer.seq = tblSales.cseq; 
       
-- ������. �׷��� ��Ī�� ���δ�.... 

select 
    c.name, s.item, c.seq, s.seq -- �������� ��������. 
from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq;


select * from tblCustomer, tblSales; -- Oracle ���� > �� ���̺��� row�� ������ ���� ���� �������̴�.

-- ���� �Ʒ� 2���� ���̺��� 1���� ���̺��̾���.
select * from tblStaff; -- �ѻ���� 2���̻��� ������Ʈ�� �����ϴ� ������. 
select * from tblProject;

-- ���� 1���� ���̺� ������ 2���� ������. > ������ 2���� ������ �ٽ� 1���� ���ļ� ������ ������ �����. 
-- > �� �� ���� ���� Join�̴�. 

select 
*
from tblStaff s 
    inner join tblProject p 
        on s.seq = p.staff_seq;
        -- �ڽ� fk
        -- �θ����� pk
        
-- �ɰ����� �͵� �ٽ� ��ġ�� ���� join�̴�. 

-- 1. ���� ����� �������ÿ�.
select * from tblStaff;

-- 2. �������� ������Ʈ ����� �������ÿ�.
select * from tblProject;

-- 3. �������� ������Ʈ(tblProject)�� �ش� ��������� �̸�(tblStaff)�� �������ÿ�.
select 
*
from tblStaff s
    inner join tblProject p 
        on s.seq = p.staff_seq;

-- �������� �ִ� ������ �ϳ��� ���̺�� �����´�. 

select * from tblGenre;
select * from tblVideo;
-- ���� ����, �뿩 ������ ���� ���� �˰� �ʹ�.

select 
*
from tblVideo v
    inner join tblGenre g
        on v.genre = g.seq;
        
select 
    v.name,
    g.price
from tblGenre g
    inner join tblVideo v
        on v.genre = g.seq;

-- tblCustomer + tblSales
-- :> ���� or �������� 

-- ���� + ��ǰ��
-- 1. join > �갡 �ӵ��� ���� ������ �ϴ�.
select 
    c.name as "����",
    s.item as "��ǰ��"
from tblCustomer c
    inner join tblSales s 
        on c.seq = s.cseq;

-- 2.subquery > ���������� join�� ������ �ʴ�.
select 
    item as "��ǰ��",
    (select name from tblCustomer where seq = tblSales.cseq) as "����"
from tblSales;

select * from tblGenre;
select * from tblVideo;
select * from tblRent;


-- ������ ���踦 �ΰ� �ִ��� �� ����ض�... 
select 
    v.name as "����",
    r.rentdate as "����",
    g.period as "�뿩�Ⱓ",
    r.rentdate + g.period as "�ݳ���¥"
from tblGenre g
        inner join tblVideo v
            on g.seq = v.genre              -- tblGenre <-> tblVideo
                inner join tblRent r
                    on v.seq = r.video;     -- tblVideo <-> tblRent

select * from tblGenre;
select * from tblVideo;
select * from tblRent;
select * from tblMember;

select 
    m.name as "����?",
    v.name as "����?",
    r.rentdate as "������",
    m.money as "����?"
    
from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre --
            inner join tblRent r
                on v.seq = r.video --
                    inner join tblMember m
                        on m.seq = r.member;

select * from tblStaff;
select * from tblSales;


select  
* 
from tblStaff s1
    inner join tblSales s2
        on s1.seq = s2.cseq;
-- join�� �ݵ�� �θ� �ڽ����� ���� ���̺�� ���۵Ǵ°� �ƴϴ�.
-- �ٵ� ���谡 �־�� �Ѵ�. �ڽ� ���̺� �θ� ���̺� ���� ���踦 �̿��ؾ� �Ѵ�.!!!!
-- �ٵ� fk�� �Ȱɾ���� �����ͻ󿡵� ���踦 �ɾ���� ���̺��� �ִ�. > ����� �׷����� ���������� �ִ�. 

select * from employees;


-- hr > 7�� > �̷��� 5���� ���޾� 1���� �����Ѵ�.
select * from employees;
select * from departments;
select * from locations;
select * from countries;
select * from regions;

select * from jobs;

-- �������
select  
    *
from employees e
    inner join departments d 
        on d.department_id = e.department_id
            inner join locations l
                on l.location_id = d.location_id; -- pk�� fk �̸��� ���� ���ѳ���

select  
    *
from employees e
    inner join departments d 
        on d.department_id = e.department_id
            inner join locations l
                on l.location_id = d.location_id
                    inner join countries c 
                        on c.country_id = l.country_id; -- pk�� fk �̸��� ���� ���ѳ���

-- join���ϸ� *ǥ�� �����´� �ߺ��Ǵµ� ���޾� �پ ���´�. �׷��� �̰� �����. > ���ϴ� Į���� ��������
select  
    *
from employees e
    inner join departments d 
        on d.department_id = e.department_id
            inner join locations l
                on l.location_id = d.location_id
                    inner join countries c 
                        on c.country_id = l.country_id
                            inner join regions r
                                on r.region_id = c.region_id
                                    inner join jobs j
                                        on j.job_id = e.job_id; -- pk�� fk �̸��� ���� ���ѳ���
                                      

-- join���ϸ� *ǥ�� �����´� �ߺ��Ǵµ� ���޾� �پ ���´�. �׷��� �̰� �����. > ���ϴ� Į���� ��������
select  
    e.first_name || ' ' || e.last_name as "�̸�",
    d.department_name as "�μ�",
    l.city as "����",
    c.country_name as "����",
    r.region_name as "���",
    j.job_title as "����"
from employees e
    inner join departments d 
        on d.department_id = e.department_id
            inner join locations l
                on l.location_id = d.location_id
                    inner join countries c 
                        on c.country_id = l.country_id
                            inner join regions r
                                on r.region_id = c.region_id
                                    inner join jobs j
                                        on j.job_id = e.job_id; -- pk�� fk �̸��� ���� ���ѳ���
                                      
-- [ Ŭ���̾�Ʈ�� �䱸������ �����ϴ� ���� 1������. > �䱸������ ��Ȯ�ϰ� �ľ��ϴ� ���� ����. ]


/*
    3. �ܺ� ����, Outer join
    - ���� ���� ��� + ����¿� ���Ե��� ���� �θ� ���̺��� ������ ���ڵ�
    
    select 
        �÷�����Ʈ
    from ���̺�A
        inner join ���̺�A
            on ���̺�A.�÷� = ���̺�B.�÷�;
            
    select 
        �÷�����Ʈ
    from ���̺�A
        (left|right) outer join ���̺�B  -- ���ʿ��� ���̺��� �ְ� �����ʿ��� ���̺��� �ִµ� �� �߿� �ϳ��� �����Ѿ� �Ѵ�.
            on ���̺�A.�÷� = ���̺�B.�÷�;
            
            
*/

select * from tblCustomer; -- 3��
select * from tblSales;    -- 9��


insert into tblCustomer values (4, 'ȣȣȣ', '010-1234-4321', '�����' );

-- �ѹ��̶� ������ �̷� �ִ� ������ ������ ���� �̷��� �������ÿ�.
select 
*
from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq; 
        
-- ���� �̷°� ������� ��� �� ������ ��������, �� ���� �̷� ������ �װ͵� ���� �������ÿ�.
select -- inner join ���� ���̺� ���ÿ� �����ϴ� �͸� �������� ���� 
* 
from tblCustomer c
    left outer join tblSales s -- ���ʿ����� �� ������ ���̴�. 
        on c.seq = s.cseq;
-- �� ���̺� �ִ� ����ȣ�� ������ �� �̷��� �־���. 
-- �ٵ� ���� ���� �����ʹ� ������ �̷��� ����. 

-- inner join�� ����� outer join�� ������ �ִ�.

select *
from tblCustomer c
    right outer join tblSales s
        on c.seq = s.cseq;
        
select * from tblStaff;
select * from tblProject;

insert into tblStaff(seq, name, salary, address) values (2, '�ƹ���', 250, '��õ��');

-- ���� ��� + ��� ������Ʈ 
-- 1. inner join 
-- : '�ƹ���' ���� > ��� ������Ʈ�� ��� .. > �θ� ���ڵ尡 �ڽ� ���̺� �������� �ʾұ� ������ 
select 
    * 
from tblStaff s
    inner join tblProject p 
        on s.seq = p.staff_seq; 

-- 2. outer join 
-- : ��� �������װ� ���� ���������.. > ������ ���� �θ��ڵ���� �������ÿ�.
select 
    *
from tblStaff s
    left outer join tblProject p
        on s.seq = p.staff_seq;
        

-- tblVideo, tblRent
-- �뿩�� �ѹ��̶� �� ������ �� �뿩 ������ �������ÿ�. > inner join
select * 
    from tblVideo v
        inner join tblRent r
            on v.seq = r.video;
            
select name, count(*) 
    from tblVideo v
        inner join tblRent r
            on v.seq = r.video
                group by name
                    order by count(*) desc; -- �Ϻ� Į���� null�̶� ���ڵ� ��ü�� ����.
                    
                    
select name, count(rentdate)
    from tblVideo v
        left outer join tblRent r
            on v.seq = r.video
                group by name
                    order by count(rentdate) desc;
            
            
-- �뿩�� ������� ��� ������ �� �뿩 ������ �������ÿ�. > outer join
select * 
    from tblVideo v
        left outer join tblRent r
            on v.seq = r.video;  -- �뿩������ �ֵ� ���� �� ������
         
select * 
    from tblVideo v
        left outer join tblRent r
            on v.seq = r.video
                where rentdate is null; -- �Ǽ����


-- tblMember, tblRent 
-- [ �뿩�� 1ȸ �̻� > �� ���� + �뿩 ���� ]
select 
*
from tblMember m
    inner join tblRent r
        on m.seq = r.member;
        

select -- �뿩�� �ѹ��� ���� ���� ���鵵 �뿩�� �ߴ� ���̶� ���� ������� 
*
from tblMember m
    left outer join tblRent r
        on m.seq = r.member;


select -- �뿩�� �ѹ��� ���� ���� ���鵵 �뿩�� �ߴ� ���̶� ���� ������� 
*
from tblMember m
    left outer join tblRent r
        on m.seq = r.member
            where rentdate is null;

-- ������̺�, �뿩���̺� �뿩�� ����? �׷��� �뿩�� �ѹ��� ���� ���� �ִ�!?


select *  from tblStaff;
select *  from tblProject;


-- tblStaff, tblProject. ���� �������� ��� ������ �̸�, �ּ�, ����, ���������Ʈ���� �������ÿ�.
select distinct s.name, s.address, s.salary, p.project
    from tblStaff s inner join tblProject p
        on s.seq = p.staff_seq;
    

-- �� �뿩 ���� �帣
    
-- tblVideo, tblRent, tblMember. '�ǻ��ұ��' ��� ������ ������ ȸ���� �̸���?
select * from tblVideo; -- �ǻǴ� 5���̴�. 5���� ã�Ƽ� 
select * from tblRent; -- video 5������ member ã�� ����� 5���̴�.
select * from tblMember; -- 5�� ����� �̸��� �Ӿ�?


-- ��>
select name
from ( select *
from tblRent 
where video = ( select seq from tblVideo
where name ='�ǻ��ұ��')) sr inner join tblMember
on sr.member = tblMember.seq;

-- 2�� �����ϰ� �������� where������ �ᵵ �Ǳ���

    
select * 
from tblStaff;
select * 
from tblProject;
-- tblStaff, tblProject. 'TV ����'�� ����� ������ ������ ���ΰ�?
-- ��> 
select s.salary
from tblStaff s inner join tblProject p
on p.project = 'TV ����' and p.staff_seq = s.seq;

   
   
select * from tblVideo;
select * from tblRent;
select * from tblMember;
-- tblVideo, tblRent, tblMember. '�й̳�����' ������ �ѹ��̶� �������� ȸ������ �̸���?

-- > ��
select m.name
from tblMember m 
    inner join tblRent r
        on m.seq = r.member 
            inner join tblVideo v
                on v.seq = r.video and v.name ='�й̳�����';
          
select  * from tblStaff;
select  * from tblProject;
-- tblStaff, tblProject. ����ÿ� ��� ������ ������ ������ �������� �̸�, ����, ���������Ʈ���� �������ÿ�.
select s.name, s.salary, p. project
from tblStaff s inner join tblProject p
on s.seq = p.staff_seq and s.address <> '�����';


-- tblCustomer, tblSales. ��ǰ�� 2��(���ϻ�ǰ) �̻� ������ ȸ���� ����ó, �̸�, ���Ż�ǰ��, ������ �������ÿ�.
select * from tblCustomer;
select * from tblSales; -- �̰Ŵ� ���ű�� 

select c.tel, c.name, s.item, s.qty
from tblCustomer c  inner join tblSales s
    on c.seq = s.cseq
        where s.qty > 1
            ORDER BY c.name asc, s.item asc;


-- qty�� �����̾���?

SELECT c.name, c.tel, s.item, s.qty FROM tblcustomer c
    inner join tblsales s
        on c.seq = s.cseq
            where s.qty > 1
                ORDER BY c.name asc, s.item asc;

-- tblVideo, tblRent, tblGenre. ��� ���� ����, ��������, �뿩������ �������ÿ�.
select * from tblVideo; -- ������ ����, �������� 
select * from tblRent; -- 
select * from tblGenre; -- ����
select * from tblMember;

-- > �� 
select 
v.name, v.qty, g.price
from tblVideo v inner join tblGenre g
on v.genre =  g.seq;
                
-- tblVideo, tblRent, tblMember, tblGenre. 2022�� 2���� �뿩�� ���ų����� �������ÿ�. ȸ����, ������, ����, �뿩����


-- tblVideo > ������ 
-- tblGenre > ���� 
-- tblRent > ���� 
-- tblRent > ���ǰŸ���
-- tblMember > ȸ����


select m.name "ȸ����", v.name "������", r.rentdate "����", g.price "����"
from tblVideo v inner join tblGenre g
on v.genre = g.seq inner join tblRent r 
on r.video = v.seq and r.rentdate in (
select rentdate -- 2022 2���� ���� ������ ~ 
from tblRent
where rentdate between to_date('2022-02-01') and to_date('2022-12-31') 
) inner join tblMember m
on r.member = m.seq;

-- �����Բ� 
SELECT m.name, v.name, r.rentdate, g.price FROM tblmember m
    inner join tblrent r
     on m.seq = r.member
        inner join tblvideo v
            on r.video = v.seq
                inner join tblgenre g
                    on v.genre = g.seq
        where r.rentdate >= to_date('2022-02-01', 'yyyy-mm-dd');



-- tblVideo, tblRent, tblMember. ���� �ݳ��� ���� ȸ����� ������, �뿩��¥�� �������ÿ�.
-- tblRent�� retdate�� null�� ģ���� ã�ƶ� 
select m.name "ȸ����", v.name "������", r.rentdate "����"
from tblVideo v  inner join tblRent r 
on r.video = v.seq and r.rentdate in (
select rentdate 
from tblRent
where retdate is null 
) inner join tblMember m
on r.member = m.seq;
-- �� �����ϰ� �������� ���Ǵޱ�     
    
SELECT m.name, v.name, r.rentdate FROM tblmember m
    inner join tblrent r
        on m.seq = r.member
            inner join tblvideo v
                on r.video = v.seq
    where r.retdate is null;
    

-- employees, departments. ������� �̸�, �μ���ȣ, �μ����� �������ÿ�.
-- ��
select e.first_name || ' ' || e.last_name "�̸�", e.department_id "�μ���ȣ", d.department_name "�μ���"
from employees e inner join departments d
on e.department_id = d.department_id;
    
select * from departments; -- department_id
-- employees_id, department_id


-- employees, jobs. ������� ������ �������� �������ÿ�.
select * from employees;
select * from jobs;

select e.*,j.job_title
from employees e inner join ( -- Į�� ���̱�
                            select job_id, job_title 
                            from jobs) j
on e.job_id = j.job_id;


-- �ϴ� ����   
-- �� employees, jobs. ����(job_id)�� �ְ�޿�(max_salary) �޴� ��� ������ �������ÿ�.
--with test as (
--select e.job_id, max_salary
--from employees e inner join jobs j
--on e.job_id = j.job_id
--)



desc jobs;

select e1.*
from employees e1
where  (job_id, salary) in (select job_id, max_salary from jobs);

select * from jobs;

--SELECT * FROM HR.employees e
--    INNER JOIN ( SELECT j.job_id as job1,count(*),max(j.max_salary) as maxvalue FROM HR.employees e
--        inner join HR.jobs j
--            on e.job_id = j.job_id
--                group by j.job_id ) k
--    on e.job_id = k.job1
--        where e.salary = k.maxvalue;
--        
-- �� �̰� �ϳ��� ���߿� �ٽ� Ǯ��





-- departments, locations. ��� �μ��� �� �μ��� ��ġ�ϰ� �ִ� ������ �̸��� �������ÿ�.
select * from departments;
select * from  locations;

select department_name, city 
from departments d inner join locations l
on d.location_id = l.location_id;

        
-- locations, countries. location_id �� 2900�� ���ð� ���� ���� �̸��� �������ÿ�.

select * from countries; -- country_id
select * from locations;

-- > ��
select c.country_name
from countries c inner join locations l
on c.country_id = l.country_id and l.location_id = 2900;
            
-- departments 
select * from employees; -- department_id
select * from departments;


-- employees. �޿��� 12000 �̻� �޴� ����� ���� �μ����� / �ٹ��ϴ� ������� �̸�, �޿�, �μ���ȣ�� �������ÿ�.

-- 1. �޿��� 12000 �̻� �޴� ����� �ִ� �μ� ã��
--with test as (
--select distinct department_id 
--from employees
--where salary >= 12000 )
--
--select e.first_name || ' ' || e.last_name, e.salary, e.department_id
--from employees e
--where department_id in (select * from test) and salary >= 12000;

SELECT e.first_name||' '||e.last_name as name, e.salary, e.department_id FROM HR.employees e
    inner join (SELECT DISTINCT (job_id) FROM HR.employees where salary >= 12000) f
        on e.job_id = f.job_id;

-- �� inner join�ÿ� ���������� ������� ���ε� ����
        
-- employees, departments. locations.  'Seattle'����(LOC) �ٹ��ϴ� ����� �̸�, ����(job_id), �μ���ȣ, �μ��̸��� �������ÿ�.
--> ��
select e.first_name || ' ' || e.last_name, e.job_id, e.department_id, d.department_name
from employees e inner join departments d
on e.department_id = d.department_id inner join locations l
on d.location_id = l.location_id and l.city ='Seattle';

    
    
-- employees, departments. first_name�� 'Jonathon'�� ������ ���� �μ��� �ٹ��ϴ� ������ ������ �������ÿ�.
with test as (
select e.department_id
from employees e inner join departments d
on e.department_id = d.department_id and e.first_name = 'Jonathon')

select *
from employees
where department_id = (select * from test ) ;


    
-- employees, departments. ����̸��� �� ����� ���� �μ��� �μ���, �׸��� ������ ����ϴµ� ������ 3000�̻��� ����� �������ÿ�.
select e.first_name || ' ' || e.last_name, d.department_name, e.salary
from employees e inner join departments d
on e.department_id = d.department_id and e.salary>=3000;
            
            
-- employees, departments. �μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, ����̸�, ������ �������ÿ�.
select d.department_id,d.department_name, e.first_name || ' ' || e.last_name,  e.salary
from employees e inner join departments d
on e.department_id = d.department_id and e.department_id=10;
            

select * from 
job_history;
select * from 
departments;
select * from employees;
-- departments, job_history. ����� ����� �Ի���, �����, �ٹ��ߴ� �μ� �̸��� �������ÿ�.
-- > ��
select h.start_date, h.end_date, d.department_name
from departments d inner join job_history h
on h.department_id = d.department_id;
        
SELECT h.employee_id, h.start_date, h.end_date, d.department_name FROM HR.job_history h
    inner join HR.departments d
        on h.department_id = d.department_id;



        
-- employees. �����ȣ�� ����̸�, �׸��� �� ����� �����ϴ� �������� �����ȣ�� ����̸��� ����ϵ� ������ �÷����� '�����ȣ', '����̸�', '�����ڹ�ȣ', '�������̸�'���� �Ͽ� �������ÿ�.
select * from employees;
-- self join
select e.employee_id "�����ȣ", e.first_name || ' ' || e.last_name "����̸�", m.employee_id "�����ڹ�ȣ", m.first_name || ' ' || m.last_name "�������̸�"
from employees e inner join employees m
on e.manager_id = m.employee_id;
        
-- employees, jobs. ��å(Job Title)�� Sales Manager�� ������� �Ի�⵵�� �Ի�⵵(hire_date)�� ��� �޿��� �������ÿ�. �⵵�� �������� �������� ����.
select * from jobs;
with test as (
select to_char( hire_date, 'YYYY') as �Ի�⵵, salary
from employees e inner join jobs j
on e.job_id = j.job_id
where job_title = 'Sales Manager')
select �Ի�⵵, avg(salary)
from test 
group by �Ի�⵵
order by �Ի�⵵;

SELECT to_char(e.hire_date, 'yyyy')||'�⵵' as "�Ի�⵵", avg(e.salary) as "��� �޿�" FROM HR.employees e
    inner join HR.jobs j
        on e.job_id = j.job_id
            where j.job_title = 'Sales Manager'
                GROUP BY to_char(e.hire_date, 'yyyy')
                    ORDER BY to_char(e.hire_date, 'yyyy') asc;


select * from departments;
select * from departments;
-- employees, departments. locations. �� ����(city)�� �ִ� ��� �μ� ������� ��ձ޿��� ���� ���� ���ú��� ���ø�(city)�� ��տ���, �ش� ������ ������� �������ÿ�. ��, ���ÿ� �ٹ��ϴ� ����� 10�� �̻��� ���� �����ϰ� �������ÿ�.
select city, round(avg(e.salary)), count(e.employee_id)
from employees e inner join departments d
        on e.department_id = d.department_id 
    inner join locations l
        on d.location_id=l.location_id 
        group by city
        having count(e.employee_id) < 10
        order by avg(e.salary);

            
-- employees, jobs, job_history. 
-- ��Public  Accountant���� ��å(job_title)���� ���ſ� �ٹ��� ���� �ִ� ��� ����� ����� �̸��� �������ÿ�.
-- ���� ��Public Accountant���� ��å(job_title)���� �ٹ��ϴ� ����� ��� ���� ����.
select * from employees;
select * from jobs;
select * from job_history; -- Accountant ��ģ������ employee_id�� �̾Ƽ� �̸��� ã�� 

select e.employee_id "���", e.first_name || ' ' || e.last_name "����̸�"
from jobs j inner join job_history h -- ���⼭ ã�� 
on j.job_id = h.job_id and j.job_title = 'Public Accountant' inner join employees e
on h.employee_id = e.employee_id;


    
-- employees, departments, locations. Ŀ�̼��� �޴� ��� ������� first_name, last_name, �μ���, ���� id, ���ø��� �������ÿ�.
select * from employees;
select * from departments;

select e.first_name || ' ' || e.last_name "����̸�", d.department_name, l.location_id, l.city
from employees e inner join departments d 
on e.department_id = d.department_id and e.commission_pct is not null inner join locations l
on d.location_id = l.location_id;
    
-- �� ������ �ٰɾ������ where ������ �ִ��� �ڷ� ����     
    
-- employees. �ڽ��� �Ŵ������� ���� ���� ������� first_name, last_name, ������� �������ÿ�.
select e.first_name , e.last_name , e.hire_date "�����"
from employees e inner join employees m
on e.manager_id = m.employee_id and e.hire_date < m.hire_date ;

select * from employees where first_name ='Lex'; --01/01/13


select * from employees; --03/06/17




/*
    4. ��������, self join
    - 1���� ���̺��� ����ϴ� ����
    - ���̺� �����ΰ� �ڽŰ� ���踦 �δ� ��� 
*/

-- ���� ���̺�
create table tblSelf (
    seq number primary key,                    -- ������ȣ(PK)
    name varchar2(30) not null,                -- ������
    department varchar2(50) null,              -- �μ���
    super number null references tblSelf(seq)  -- ������ �Ȱ��� ���̴�. -- ����ȣ(FK)
);


insert into tblSelf values(1, 'ȫ����', null, null);
insert into tblSelf values(2, '�����', '������', 1); 
insert into tblSelf values(3, '�̰���', '������', 2); 
insert into tblSelf values(4, '���븮', '������', 3); 
insert into tblSelf values(5, '�ֻ��', '������', 4); 
insert into tblSelf values(6, '�ں���', '���ߺ�', 1); 
insert into tblSelf values(7, '�ں���', '���ߺ�', 6); 

select * from tblSelf;

-- ���� ����� �����ðǵ� ��絵 �����Ͷ�
--1. join
--2. subquery 
select
b.name as "������",
a.name as "����"
from tblSelf a
    inner join tblSelf b -- ����
        on a.seq = b.super;    
-- ���νÿ� �տ� �ִ� ������ ���������µ� 
-- �ٵ� ȫ�����̶�� �ִ� ����. 

select
b.name as "������",
a.name as "����"
from tblSelf a
    right outer join tblSelf b -- ���� >> right �̱��ѵ�
        on a.seq = b.super;    

select
a.*,
( select name from tblSelf where seq = a.super ) as "����"
from tblSelf a; -- ����
-- �������������� ����ϴ� ����ε� �̰� join���� ���ݴ� ������? 
-- �ڱⰡ �ڱ⸦ �����ϴ� ���� 


-- ������ + ����
select 
    e1.first_name as "������",
    e2.first_name as "�Ŵ�����"
from employees e1
    inner join employees e2
        on e1.manager_id = e2.employee_id;

-- �� select�� ���������� �������
select 
    e1.first_name as "������",
    (select first_name from employees where employee_id = e1.manager_id) as "�Ŵ�����"
from employees e1;

/*
    5. ��ü �ܺ� ����, Full Outer Join
    - ���� �����ϰ� �ִ� ���迡�� ���
*/
select * from tblmen;   -- couple > ���� ���̺� ����
select * from tblwomen; -- couple > ���� ���̺� ����

-- Ŀ��(���ڸ� + ���ڸ�) 
select
    w.name as "����",
    m.name as "����"
from tblmen m -- �ڽ�
    inner join tblwomen w -- �θ�
        -- on m.name = w.couple; 
        on w.couple =  m.name ; -- �̰ŵ� �����ϴ�. 
        
-- ������ �̸��� ������ �̸� 
-- �ڽ����̺��� �����ε� �װŸ����� ������ ���� �� ��� �θ����̺��� ������� ���̴�.

-- Ŀ��(���ڸ� + ���ڸ�) + �ַ�(����) 


select
    m.name as "����", -- ������ ���ʿ� left �������̺� ��°� ����
    w.name as "����"
from tblmen m -- �ڽ� --> ������ 
    left outer join tblwomen w -- �θ�
        on w.couple =  m.name ; -- �̰ŵ� �����ϴ�. 

select
    w.name as "����",
    m.name as "����" 
from tblmen m 
    full outer join tblwomen w 
        on w.couple =  m.name ; 












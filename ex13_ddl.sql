/*

    ex13_ddl.sql

    1. DDL 
        - Data Definition Language
        - ������ ���Ǿ�
        - ���̺�, ��, �����, �ε���, Ʈ���� ���� �����ͺ��̽� ������Ʈ�� ����/����/�����ϴ� ��ɾ�
        a. create: ����
        b. drop: ����
        c. alter: ����
        
     ���̺� �����ϱ�
     
     create table ���̺��
     (
        �÷� ����,
        �÷� ����,
        �÷� ����,
        �÷� ����,
        �÷� ����,
        �÷��� �ڷ���(����) NULL ������� [ ���� ���� ]
     );
    �������, Constraint
    - �ش� Į���� �� ������(��)�� ���� ����
        - ������ �����ϸ� > ����
        - ������ �Ҹ����ϸ� > �����߻�
    - ��ȿ�� �˻� ����
    - �����ͺ��̽� > ������ ���� > ������ ���Ἲ(***)�� �����ϴ� ����
    
    
    1. NOT NULL
    - �ش� �÷��� �ݵ�� ���� ������ �Ѵ�.
    - �ش� �÷��� ���� ������ �����߻�
    - �ʼ��� 
    
    2. PRIMARY KEY
    - �⺻Ű 
    - ���̺��� ��� ���� �����ϱ� ���� �����̴�. 
    - ���� �ĺ��ϴ� ��ǥ �÷��� �����ϴ� ���� 
    - ��� ���̺��� �ݵ�� 1���� Ű��Ű�� �����ؾ��Ѵ�.(*****************)
    - �ߺ����� ���� �� ����. > UNIQUE �� �׷���. �ٵ� UNIQUE�� null�� �ɼ� �ִ�.
    - ���� �ݵ�� ������. > not null
    - Not NULL + Unique > Primary Key 
    
    
    3. FOREIGN KEY 
    pass
    
    4. UNIQUE 
    - �����ϴ�. > ��鰣�� ������ ���� ���� �� ����.
    - NULL�� ���� �� �ִ�. 
    ex) ��ǰ
        - ��(��ȣ(PK), �̸�,  �ּ�,  ��÷(UQ)) 
                1.     ȫ�浿, ����,  1��
                2.     �ƹ���,  �λ� , null
                3.     ������,  ����,  2�� 
                4.     ȣȣȣ,  ��õ,  3�� 
    ex) �ʵ��б� ���� 
    - �л�(��ȣ(PK), �̸�, ��å(UQ))
        1. ȫ�浿, ���� 
        2. �ƹ���, �ι���
        3. ������, null
        4. ȣȣȣ, ü������
        
    -- pk�� ��ȣ�� �Ȱ����� ����               
    5. CHECK
        - ����� ���� ���� ����
        - where���� ������ ������ �÷��� �����Ѵ�. 
    
    6. DEFAULT 
        - �⺻�� �����̴�. 
        - insert/update �۾� �� ���� �������� ������, �̸� �غ��س��� �⺻���� ��� �ִ� ���� 
        
    
        
*/  

create table TAB1 (
    col1 varchar(10) ,
    col2 varchar(10) 
);

select * from TAB1;

insert  into TAB1 values('a', NULL);
insert  into TAB1 values('b', '');
insert  into TAB1 values('c', 3);
insert  into TAB1 values('d', 4);
insert  into TAB1 values('e', 3);
select col2  from TAB1 where col1='b';


select NVL(col2,'x') from TAB1 where col1='a';

create table tblMemo(
    seq number(3) null,
    name varchar2(30) null,
    memo varchar2(1000) null,   -- null���
    regdate date null
);

drop table tblMemo;


-- insert into ���̺�(�÷�����Ʈ) values(������Ʈ) ;

insert into tblMemo(seq, name, memo, regdate) 
            values(1, 'ȫ�浿', '�޸��Դϴ�.', sysdate);


insert into tblMemo(seq, name, memo, regdate) 
            values(2, '�ƹ���', null, sysdate); -- �޸𳻿� ����

insert into tblMemo(seq, name, memo, regdate) 
            values(3,  null,   null,  null); -- �޸𳻿� ����

insert into tblMemo(seq, name, memo, regdate) 
            values(null,  null,   null,  null); 
            
insert into tblMemo(seq, name, memo, regdate) 
            values(4,  'ȫ�浿',   '�޸��Դϴ�.',  '2023-03-15');    -- 2023-03-15 �ڵ� ����ȯ �ȴ�.          

insert into tblMemo(seq, name, memo, regdate) 
            values(4,  'ȫ�浿',   '�޸��Դϴ�.',  '2023-03-15 12:30:50');  -- �̰� ����ȯ �ȵȴ�.
            
insert into tblMemo(seq, name, memo, regdate) 
            values(4,  'ȫ�浿',   '�޸��Դϴ�.',  to_date('2023-03-15 12:30:50','yyyy-mm-dd hh24:mi:ss'));  -- to_date���� �� �尨           
            
-- ���� ���� ������. ���δ� null�̴�. �� � ������ �̷� ���·� �����͸� ������ �ʴ´�.  > ��� �÷��� null ����ϴ� ���� ����. 
            
select * from tblMemo;

drop table tblMemo;

-- null�� ����Ʈ��. 
create table tblMemo(
    seq number(3) not null,
    name varchar2(30) null,
    memo varchar2(1000) not null,   -- null��� > �ʼ������� not null
    regdate date null
);

insert into tblMemo(seq, name, memo, regdate) 
            values(1, 'ȫ�浿', '�޸��Դϴ�.', sysdate);


insert into tblMemo(seq, name, memo, regdate) 
            values(2, '�ƹ���', null, sysdate); -- �޸� not null�̶� �ȵ���. 
--ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."MEMO") -- hr�� �����ϴ� ~ tblmemo���� ���ִ´�. 


insert into tblMemo(seq, name, memo, regdate) 
            values(3, 'ȫ�浿', '', sysdate); -- ����('') > ����Ŭ�� null�� ����Ѵ�. ����Ŭ�� ���ڸ� null�� ����Ѵ�. 

select * from tblMemo;


-- PK�� ����� �� 

create table tblMemo(
    seq number(3) not null,
    name varchar2(30) null,
    memo varchar2(1000) not null,   -- null��� > �ʼ������� not null
    regdate date null
); -- ���̺��� �߸��������. 



insert into tblMemo(seq, name, memo, regdate) 
            values(1, 'ȫ�浿', '�޸��Դϴ�.', sysdate);
            
            
insert into tblMemo(seq, name, memo, regdate) 
            values(1, 'ȫ�浿', '�޸��Դϴ�.', sysdate);
            
-- ���ϰ��� �ΰ� ����. 



create table tblMemo(
    seq number(3) primary key, -- not null ��ſ� �̷��� ����. primary key  > ��ģ���� �����ϴ�. null�� �ȵȴ�. 
    name varchar2(30) null,
    memo varchar2(1000) not null,   -- null��� > �ʼ������� not null
    regdate date null
); 

drop table tblMemo;

insert into tblMemo(seq, name, memo, regdate) 
            values(1, 'ȫ�浿', '�޸��Դϴ�.', sysdate);
            
insert into tblMemo(seq, name, memo, regdate) 
            values(1, 'ȫ�浿', '�޸��Դϴ�.', sysdate);
            
-- ORA-00001: unique constraint (HR.SYS_C007236) violated > Unique ���� ������ �����ߴٰ� �ϴ� ���̴�. 
-- seq�� ���� ���� �ΰ��� ������ ���ϴµ� �װ� ������

insert into tblMemo(seq, name, memo, regdate) 
            values(2, 'ȫ�浿', '�޸��Դϴ�.', sysdate); -- �̰� �ߵ���.
                 
 insert into tblMemo(seq, name, memo, regdate) 
            values(null, 'ȫ�浿', '�޸��Դϴ�.', sysdate); -- �̰� �ߵ���.           
-- ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."SEQ")




select 0/300,
        300/0
from dual;

drop table tblMemo;

create table tblMemo(
    seq number(3) primary key, -- not null ��ſ� �̷��� ����. primary key  > ��ģ���� �����ϴ�. null�� �ȵȴ�. 
    name varchar2(30) unique,  -- �ۼ����̸��� ����ũ�ϴ�(unique) > �̸��� �ߺ��� �� ����. > 1����� �� 1���� ���ۼ� ����
    memo varchar2(1000) not null,   -- null��� > �ʼ������� not null
    regdate date null
); 

insert into tblMemo(seq, name, memo, regdate) 
            values(1, 'ȫ�浿', '�޸��Դϴ�.', sysdate);
            
insert into tblMemo(seq, name, memo, regdate) 
            values(2, 'ȫ�浿', '�޸��Դϴ�.', sysdate);
--ORA-00001: unique constraint (HR.SYS_C007238) violated

insert into tblMemo(seq, name, memo, regdate) 
            values(2, '�ƹ���', '�޸��Դϴ�.', sysdate); -- ������ �ȴ�. 
insert into tblMemo(seq, name, memo, regdate) 
            values(3, null, '�޸��Դϴ�.', sysdate); -- ������ �ȴ�. 
select * from tblMemo;
drop table tblMemo;

create table tblMemo(
    seq number(3) primary key,   -- �ݵ�� �ʿ� 
    name varchar2(30),           
    memo varchar2(1000),              
    regdate date,
    priority number check(priority between 1 and 3 )             -- 1(�߿�), 2(����), 3(���)
); 
--  check�� where��� Ű������ �����Ѵ�. ���� ���ϴ� ���̺��� ã�� �����̶� ���� 

select * from tblMemo where priority between 1 and 3 ; -- where�����ٰ� �� ������ �״�� check�ȿ��ٰ� �ִ´�. 



insert into tblMemo(seq, name, memo, regdate, priority) 
            values(1, 'ȫ�浿', '�޸��Դϴ�.', sysdate, 1);
            
insert into tblMemo(seq, name, memo, regdate, priority) 
            values(2, 'ȫ�浿', '�޸��Դϴ�.', sysdate, 10);
-- ORA-02290: check constraint (HR.SYS_C007240) violated üũ���࿡ ��߳�



drop table tblMemo;


create table tblMemo(
    seq number(3) primary key,   -- �ݵ�� �ʿ� 
    name varchar2(30),           
    memo varchar2(1000),              
    regdate date,
    priority number check(priority between 1 and 3 ) ,            -- 1(�߿�), 2(����), 3(���)
    category varchar2(30) check(category in ('����' ,'�庸��', '����'))
); 

insert into tblMemo(seq, name, memo, regdate, priority, category) 
            values(1, 'ȫ�浿', '�޸��Դϴ�.', sysdate, 1, '����');

select * from tblMemo;

insert into tblMemo(seq, name, memo, regdate, priority, category) 
            values(2, 'ȫ�浿', '�޸��Դϴ�.', sysdate, 1, '��Ÿ��');

select * from tblMemo;


drop table tblMemo;



-- check�ȿ� where�����ٰ� ���� ���� ��´�. 
create table tblMemo(
    seq number(3) primary key,   -- �ݵ�� �ʿ� 
    name varchar2(30) check(length(name) > 1), -- ���� Į�������� check ���ྲ�� �ּҰ��� ���������ϴ�.           
    memo varchar2(1000),              
    regdate date,
    priority number check(priority between 1 and 3 ) ,            -- 1(�߿�), 2(����), 3(���)
    category varchar2(30) check(category in ('����' ,'�庸��', '����'))
); 

insert into tblMemo(seq, name, memo, regdate, priority, category) 
            values(1, 'ȫ�浿', '�޸��Դϴ�.', sysdate, 1, '����');
            
            
insert into tblMemo(seq, name, memo, regdate, priority, category) 
            values(1, 'ȫ', '�޸��Դϴ�.', sysdate, 1, '����');
-- ORA-02290: check constraint (HR.SYS_C007249) violated

drop table tblMemo;

-- �޸� ���̺� 
create table tblMemo(
    seq number(3) primary key,   -- �ݵ�� �ʿ� 
    name varchar2(30) default '�͸�', -- ���� Į�������� check ���ྲ�� �ּҰ��� ���������ϴ�.           
    memo varchar2(1000),              
    regdate date default sysdate
); 

insert into tblMemo(seq, name, memo, regdate) 
            values(1, 'ȫ�浿', '�޸��Դϴ�.', sysdate); -- ���� �� �ָ� default�� �������� �ʴ´�. 

insert into tblMemo(seq, name, memo, regdate) 
            values(2, 'ȫ�浿', '�޸��Դϴ�.', '2023-01-01'); -- ���� �� �ָ� default�� �������� �ʴ´�. - - ��  > 23/01/01 ���� �尨

select * from tblMemo;

insert into tblMemo(seq, name, memo, regdate) 
            values(3, null, '�޸��Դϴ�.', sysdate); -- ���� �� �ָ� default�� �������� �ʴ´�. 
-- ���� ��������� null�� �尨 
select * from tblMemo;            
            
-- �ƿ� Į�� �̸��� Į�� ����Ʈ�� ����
insert into tblMemo(seq, memo, regdate) 
            values(4, '�޸��Դϴ�.', sysdate); -- �̷��� �͸��� ����. 
            
insert into tblMemo(seq, memo, regdate) 
            values(5, '�޸��Դϴ�.', default); -- default��� ����� �ִ�.  �ش� �÷��� ���� �� default�� �־�� 
            
select * from tblMemo;            


select buseo, count(*) 
from tblInsa
group by buseo
having buseo='�ѹ���'; -- having���� ����Į�� ���ǵ� �����ϴ�. 


/*

    ���� ������ ����� ���
    1. �÷� ���ؿ��� ����� ���
        - ���� ���� ����
        - �÷� ���� + ���� ���� > ���ÿ� ���� ! 
        
    2. ���̺� ���ؿ��� ����� ���
        - �÷� ����� ���� ������ �и��ؼ� ���� 
    
    3. �ܺο��� ����� ���  > �����ֿ� �ҵ�!? 
        - alter ��ɾ�
        - ���̺� ����� ���� ������ �и��ؼ� ����  > dba���� ���� ���µ� �����ɷ��� ������ ��õ���� �ʴ´�.
        
    �� �������� �Ȱ����� ������ �ڵ带 ���⿡ ���� ���⿡ ������ ���̴�.     
    
    
*/

drop table tblMemo;

-- �޸� ���̺� 
create table tblMemo( 
    -- seq number(3) primary key,    -- �÷� ������ ���ÿ�
    -- seq number(3) [ constraint ������׸�] ��������, -- �̰� ���� FM�̴�. �̹���� ��������̴�. 
    -- ������׵� object��. ��ü�� �츮�� ����� ��, �츮�� �̸��� �ٿ��� �� �ִ�. 
    seq number(3) constraint tblMemo_seq_pk primary key, -- �̰� ���� ����̴�. 
    
    name varchar2(30) default '�͸�', -- ���� Į�������� check ���ྲ�� �ּҰ��� ���������ϴ�.           
    member varchar2(1000),              
    regdate date default sysdate
); 
select * from tblMemo;
insert into tblMemo(seq, name, member ,regdate) values(1, 'ȫ�浿', '�޸�', sysdate);
-- ORA-00001: unique constraint (HR.TBLMEMO_SEQ_PK) violated 
-- �ѹ��� ȣ��� �������� ������ ������ ����. > TBLMEMO_SEQ_PK �� �̸��� ������ �����ؼ� ã�´�. 


drop table tblMemo;

-- �޸� ���̺� 
create table tblMemo( 
    seq number(3) primary key, 
    
    name varchar2(30) default '�͸�',        
    member varchar2(1000),              
    regdate date default sysdate
); 
select * from tblMemo;
insert into tblMemo(seq, name, member ,regdate) values(1, 'ȫ�浿', '�޸�', sysdate);
insert into tblMemo(seq, name, member ,regdate) values(1, 'ȫ�浿', '�޸�', sysdate);
-- ORA-00001: unique constraint (HR.SYS_C007256) violated �̷��� ���. ����Ŭ�� �츮�� �̸��� �������༭ �̷��� ���. 
-- ������ �ڵ������ ����ִµ� �츮�� �̸��� �ָ� ���κп��� ���� ������ �˷��ش�. ���̺��� �鰳�ϱ� �̰�... �����αװ� ������ ã�Ⱑ ���ٴ� �� 

drop table tblMemo;
create table tblMemo( 
    -- �÷�����Ʈ�� 
    seq number(3), 
    name varchar2(30) default '�͸�',        
    member varchar2(1000),              
    regdate date,
    -- ������׵�
    constraint tblmemo_seq_pk  primary key(seq), -- ��ſ� �̷��� �÷����� �־��ش�.
    constraint tblmemo_name_uq unique(name),
    constraint tblmemo_memo_ck check(length(member) >= 10) 
); 

-- constraint �̸� ��������(Į����)

insert into tblMemo(seq, name, member ,regdate) values(1, 'ȫ�浿', '�޸�', sysdate);
-- ORA-02290: check constraint (HR.TBLMEMO_MEMO_CK) violated > ��~ ���� �޸𳻿��� ª�� �Է��߱���~ 



-- �ƹ��� ������ ���� ����
create table tblMemo( 
    seq number(3) , 
    name varchar2(30), 
    member varchar2(1000),              
    regdate date 
); 

insert into tblMemo(seq, name, member ,regdate) values(1, 'ȫ�浿', '�޸�', sysdate);
insert into tblMemo(seq, name, member ,regdate) values(1, 'ȫ�浿', '�޸�', sysdate);

select * from tblMemo;

-- �ܺο��� pk�� ���°� db�� ��԰� ��� ������� ���� ���⵵ �Ѵ�.
alter table tblMemo -- �̹� �ߺ��� ������ �� �� ������ �ɸ� ������ ���. ORA-02437: cannot validate (HR.TBLMEMO_SEQ_PK) - primary key violated
    add constraint tblmemo_seq_pk primary key(seq);

drop table tblMemo;
-- �ٽ� ���̺� ����� ���� �ֱ����� ���� ������� �Ǵ�.
















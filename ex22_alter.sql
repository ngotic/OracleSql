/*

    ex22_alter.sql
    
    DDL
    - ��ü ����: create > �̻����� ddl�� create�� ������ �Ѵ�. 
    - ��ü ����: drop  > drop alter�� ���� ����...
    - ��ü ����: alter > �� ������ ���ϸ� ū�� ����.
    
    DML > Data(Record)
    - ������ ����: insert
    - ������ ����: delete
    - ������ ����: update
  
  ���̺� �����ϱ� 
  - ���̺� ���� ���� > �÷� ����> �÷��� or �ڷ���(����) or �������
  
  ���̺� �����ؾ� �ϴ� ��Ȳ �߻�!!
      1. ���̺� ����(drop) > ���̺� DDL(create) ����> ������ DDL�� ���Ӱ� ���̺� ����
        a. ���� ���̺� �����Ͱ� ������ ��� > �ƹ� ������ ����
        b. ���� ���̺� �����Ͱ� �־��� ��� > �̸� ������ ��� > ���̺� ���� > ���� �� ���� > ������ ����
            - �����Ҷ� ���
            - ���� �߿� ���
            - ���� � �� > ���� �Ұ���!!!
    
      2. alter ��ɾ� ��� > ���� ���̺� ����(�÷� ����) ����
        a. ���� ���̺� �����Ͱ� ������ ��� > �ƹ� ���� ����
        b. ���� ���̺� �����Ͱ� �־��� ��� > ��쿡 ���� �ٸ�
            - ������ �� ���
            - ���� �߿� ���
            - ���� � �� > �� ����� ��� > DB�� ���並 ������. > ���赵 ���� �� �� ������
            
*/

create table tblEdit (
    seq number primary key,
    data varchar2(20) not null
);

insert into tblEdit values(1, '���콺');
insert into tblEdit values(2, 'Ű����');
insert into tblEdit values(3, '�����');

select * from tblEdit;

-- 1. ���ο� Į�� �߰��ϱ�
-- ���� �÷� �߰��ϱ� > price, number
-- ORA-01758: table must be empty to add mandatory (NOT NULL) column > ���̺��� ����־�� �Ѵ�. > not null ������ �׷� �̰� Į�� �߸��߰��ع����� null�� ����
alter table tblEdit 
    add ( price number not null ); -- not null�� �߸��� ��´�.
    -- ���̰� ���ְٵ� ��²��. ���̺� �����Ͱ� ����� �� �÷��� �߰��Ѵ�.
    
    
delete from tblEdit;    

alter table tblEdit add ( price number not null ); -- ������ �̰� ������ �ȴ�. 

desc tblEdit;

drop table tblEdit;

create table tblEdit (
    seq number primary key,
    data varchar2(20) not null
);

insert into tblEdit values(1, '���콺');
insert into tblEdit values(2, 'Ű����');
insert into tblEdit values(3, '�����');

alter table tblEdit 
    add ( price number null ); -- not null�� �߸��� ��´�.
    
select * from tblEdit ;  --> �̰� �߰��� �ȴ�. null�� ���·� ���´�.


drop table tblEdit;

create table tblEdit (
    seq number primary key,
    data varchar2(20) not null
);

-- �ƿ� ����� �ٽ� ����� insert���� ���� ����� ���°� ����.

-- �����͸� ����ǵ� �� �����͸� �̸� �ٸ��� ������ �־�� �Ѵ�.


alter table tblEdit 
    add ( price number not null ); -- not null�� �߸��� ��´�.

alter table tblEdit 
    add (memo varchar2(100) not null);
    
    
insert into tblEdit values(1, '���콺', 10000, '������');
insert into tblEdit values(2, 'Ű����', 20000, 'MS');
insert into tblEdit values(3, '�����', 30000, 'Dell');    

select * from tblEdit;

--2. �÷� �����ϱ�
alter table tblEdit
    drop column memo; -- �ٵ� �����Ͱ� �̹� ����ִ�.  > �������ϸ� ������ �ȴ�.

select * from tblEdit; -- �÷��� �Բ� �����Ͱ� �������. �̰� ������ �ȵȴ�.

-- �����Ͱ� ����ִ� Į���� ����� ���� �����͵� ���󰣴�. �� ���󰣴�. �̰� �����ϱ� > �����ϰ� �̸� �����͸� ����ϰ� �ؾ��Ѵ�.

alter table tblEdit
    drop column seq; -- PK Į�� ����> ����� ����!!!!!!!!!!!!!! > PK�� ��������!??.....
    
drop table tblEdit;

create table tblEdit (
    seq number primary key,
    data varchar2(20) not null
);

insert into tblEdit values(1, '���콺');
insert into tblEdit values(2, 'Ű����');
insert into tblEdit values(3, '�����');

--3. �÷� ������;
insert into tblEdit values ( 4, '���� i7 13���� �ֽ��� ��Ʈ��'); -- varchar2(20) ���̰� �ȸ´´�. overflow�Ǽ� �߰��� �ȵȴ�.

--3.1 �÷��� ���̸� �����ϱ�(Ȯ��/���)
alter table tblEdit
    modify (data varchar2(100)); -- �״�� ���� 
-- �����Ŀ� �ٽ� ����    
insert into tblEdit values ( 4, '���� i7 13���� �ֽ��� ��Ʈ��'); -- ���� ���Եȴ�. 

select * from tblEdit; --

desc tblEdit; -- �ݿ��� �Ǿ���. 

--3.2 �÷��� ���� ���� �����ϱ�
alter table tblEdit
    modify (data varchar2(100) null);

desc tblEdit;

alter table tblEdit
    modify (data varchar2(100) not null); -- �÷��� ������� ���� �����̴�.
    
-- 3.3 �÷��� �ڷ��� �ٲٱ�
alter table tblEdit -- ������ �����Ͱ� ���ڿ��� �� �ִµ� ���ڷ� �ٲ۴ٰ�??? 
    modify ( data number); -- ORA-01439: column to be modified must be empty to change datatype 
                    -- �����Ϸ��ŵ� ������� 
                    
alter table tblEdit -- ������ �����Ͱ� ���ڿ��� �� �ִµ� ���ڷ� �ٲ۴ٰ�??? 
    modify ( seq varchar2(30));  -- �굵 �ȵȴ�.
    
    
delete from tblEdit;

select * from tblEdit; --

alter table tblEdit -- ������ �����Ͱ� ���ڿ��� �� �ִµ� ���ڷ� �ٲ۴ٰ�??? 
    modify ( data number); -- ORA-01439: column to be modified must be empty to change datatype 
                    -- �����Ϸ��ŵ� ������� 
                    
alter table tblEdit -- ������ �����Ͱ� ���ڿ��� �� �ִµ� ���ڷ� �ٲ۴ٰ�??? 
    modify ( seq varchar2(30));  -- �굵 �ȵȴ�.

desc tblEdit; -- ������ �� Ÿ���� �ٲپ���. 

drop table tblEdit;

create table tblEdit (
    seq number primary key,
    data varchar2(20) not null
);

insert into tblEdit values(1, '���콺');
insert into tblEdit values(2, 'Ű����');
insert into tblEdit values(3, '�����');

select * from tblEdit; --

alter table tblEdit add (price number default 0 not null);
--> �����Ͱ� �־��µ��� �߰��� �Ǵµ� �̰� price���� default�� �س��ұ⿡ ���� ���� ���� �־ �׷���.

-- ex13_ddl.sql ���� ������� �߰�~ 


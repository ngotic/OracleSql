/*

    ex15_insert.sql
    
    insert 
    - DML
    
    insert into ���̺� value(������)
    insert into ���̺�(�÷�����Ʈ) value(�÷�����Ʈ�� �ִ°� ������)
    
*/

drop table tblMemo;

create table tblMemo (
    seq number(3) primary key ,
    name varchar2(50),
    memo varchar2(1000) not null,
    regdate date default sysdate
);

drop sequence seqMemo;
create sequence seqMemo;


-- 1. ǥ�� 
-- :  ���� ���̺� ���ǵ� �÷� ������ ������� �÷�����Ʈ�� �����
-- ������Ʈ�� �����ϴ� ���(b)
-- : ���� 
insert into tblMemo(seq, name, memo, regdate) -- a
        values ( seqMemo.nextVal, 'ȫ�浿', '�޸��Դϴ�.' , sysdate); -- b

-- �����ϴ� ��������� �ڵ尡 ���. ���̴� ����鵵 ����.         
        
-- 2. �÷� ����Ʈ�� ������ ���� ���̺�� �������. 
-- : �÷� ������ ������ ������Ʈ�� ������ �ݵ�� ��ġ�ؾ��Ѵ�.
insert into tblMemo( name, memo, regdate, seq)
                values('ȫ�浿', '�޸��Դϴ�.', sysdate, seqMemo.nextVal);
                
select * from tblMemo;                

insert into tblMemo( memo, regdate, seq, name)
                values('ȫ�浿', '�޸��Դϴ�.', sysdate, seqMemo.nextVal); -- ������ �ٸ��� ������ ����. 
                
select * from tblMemo;                

insert into tblMemo( memo, name, regdate, seq)
                values('ȫ�浿', '�޸��Դϴ�.', sysdate, seqMemo.nextVal);      -- Į�� ������ ��߳���. 
        
select * from tblMemo;                        
        
-- 3.00947. 00000 -  "not enough values"
  insert into tblMemo( seq,  name, memo , regdate)  -- 4��
            values(seqMemo.nextVal, 'ȫ�浿', sysdate );      -- 3��

-- 4. ORA-00913: too many values
insert into tblMemo( seq,  name, memo )  -- 3��
            values(seqMemo.nextVal, 'ȫ�浿', '�޸��Դϴ�.' ,sysdate ); --4��
        

-- 5. null ���� > name�� �ȳְ� �ʹ�. > null ����
insert into tblMemo(seq, name, memo, regdate)
            values ( seqMemo.nextVal, null, '�޸��Դϴ�.', sysdate);
        
-- 5.2 �÷� ����> �Ͻ���
insert into tblMemo(seq, memo, regdate)
            values (seqMemo.nextVal, '�޸��Դϴ�.', sysdate); -- �÷��� ���������� null�� ������. 

select * from tblMemo;            
        
-- 6. default�� ����        
insert into tblMemo(seq, name, memo, regdate)
    values (seqMemo.nextVal, 'ȫ�浿', '�޸��Դϴ�.', default); 
        
-- 6.2 �÷� ���� 
insert into tblMemo(seq, name, memo)
    values (seqMemo.nextVal, 'ȫ�浿', '�޸��Դϴ�.'); -- �÷��� ���������� ���̺�������� default�� �����ؼ� default�� ����. 

select * from tblMemo; 

-- 6.3 null ����� ����ϸ� ������� ������ �������ش�. �׷��� default�� ������ ���Ѵ�. 
insert into tblMemo(seq, name, memo, regdate)
    values (seqMemo.nextVal, 'ȫ�浿', '�޸��Դϴ�.', null); 
    
-- 7. ���� ǥ��
-- : �÷� ����Ʈ�� ������ �� �ִ�. > ���� ���̺��� Į�� ������ �����ؼ� ���� 
insert into tblMemo  values(seqMemo.nextVal, 'ȫ�浿', '�޸��Դϴ�.', sysdate);
insert into tblMemo  values( 'ȫ�浿', '�޸��Դϴ�.', sysdate, seqMemo.nextVal); -- ����!! ����Ŭ�� �̰� �ٲ�ٴ� ����� �𸥴�. 

-- : null ����
insert into tblMemo values ( seqMemo.nextVal, null, '�޸��Դϴ�.', sysdate);
insert into tblMemo values ( seqMemo.nextVal, '�޸��Դϴ�.', sysdate);  -- ���� 

--: default ���� 
insert into tblMemo values ( seqMemo.nextVal, 'ȫ�浿', '�޸��Դϴ�.', default);
insert into tblMemo values ( seqMemo.nextVal, '�޸��Դϴ�.','�޸��Դϴ�.');  -- ���� 

-- 8.tblMemo ���̺� > (����) > tblMemoCopy ���̺� > �ǻ�� ���� ���߿� ���� > ���̺� ��ü�� ���� ��������� ���� ������ ����. 
create table tblMemoCopy(
    seq number(3) primary key,
    name varchar2(50),
    memo varchar2(1000) not null,
    regdate date default sysdate
);

-- �������� 
insert into tblMemoCopy select * from tblMemo; -- ���̺� ������ �� �̷��� ����. 

drop table tblMemoCopy;

select * from tblMemo;
select * from tblMemoCopy;

-- 9 .tblMemo ���̺� > (����) tblMemoCopy ���̺� > �ǻ��X , �׽�ƮO > ������� copy�� �����༭ ������ ���� ���� ������ ũ��. 

create table tblMemoCopy as select * from tblMemo;

select * from tblMemoCopy; -- ���̺�� �����Ͱ� ���簡 �Ǿ���. 

desc tblMemoCopy; -- �������� ����....
desc tblMemo;


insert into tblMemoCopy(seq, name, memo, regdate)
        values(1, 'ȫ�浿', '�޸��Դϴ�.', sysdate); -- �̰� �ִ�??  > ������ PK���� �κ��� ��������. 
        
        
        
-- 8���� ���̺��� ���� �������ǵ� �� ��������� �����͸� ����
-- 9���� ���߿����� ��뷮�� ���̰� �ʿ��� ��쿡 ����Ѵ�. 




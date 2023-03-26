/*
    ex14_sequence.sql
    
    �����ͺ��̽� ��ü
    1. ���̺�
    2. ����(hr)
    3. �������
    4. ������ 
    
    ������, Sequence
    - �����ͺ��̽� ��ü �� �ϳ� 
    - ����Ŭ ���� ��ü(�ٸ� DMBS���� ����) 
    - �Ϸù�ȣ�� �����ϴ� ��ü(**********) 
    - (�ַ�) �ĺ��ڸ� ����� �뵵�� ���� ����Ѵ�. > PK �÷��� �Ϸ� ��ȣ�� ���� �� ���� ����Ѵ�.
    
    mysql > auto increment��� �� ����  > �Ϸù�ȣ�� ����� ����� ��ü���� �����ϴµ� �̰� ǥ���� �ƴϴ�.
    ǥ���� �ƴ϶� ��ƿ��Ƽ�� ����̴�. db���� �ٸ� ���·� �����ϴ� ���ε� �������ϴ�. ����Ŭ�� sequence �� ���� �����ϴ�.   
    
    ������ ��ü �����ϱ�
    - create sequence �������� [�ɼ�];
    
    ������ ��ü �����ϱ�
    - drop sequence ��������;
    
    ������ ��ü ����ϱ�
    - ��������.nextVal > �ַ� ��� > ���� ����
    - ��������.currVal > ���� ��� > ���� ����
    �� ���� �̰Ŵ�...
*/

create sequence seqNum;
drop sequence seqNum;

select seqNum.nextVal from dual;
-- ������ �ݺ��ϸ� 1���� ���� �����ȴ�. �Ϸ� ��ȣ�� ����� �ִ�. 

create sequence seqTest;
select seqTest.nextVal from dual;
-- �������� ���� �������̰� ���� �ڱ��ȣ�� ����.! 

-- �̻��¿��� sql developer�� ����. > ������ ���δ�. services.msc 

select seqTest.nextVal from dual; -- ������ ���� �ٽ� �����ߴµ��� ���������� �����ִ� ����̶� �ټ� �ᵵ ����� ���´�. 

drop table tblMemo;

create table tblMemo (
    seq number(3) primary key,
    name varchar2(50),
    memo varchar2(1000),
    regdate date
);

create sequence seqMemo;

insert into tblMemo(seq, name, memo, regdate) 
    values (seqMemo.nextVal, 'ȫ�浿', '�޸��Դϴ�. �ȳ��ϼ���.', sysdate);
    
select *from tblMemo;

insert into tblMemo(seq, name, memo, regdate) values(seqMemo.nextVal, 'ȫ�浿', '�޸��Դϴ�. �ȳ��ϼ���.> ' || seqMemo.nextVal , sysdate);

-- currVal > ������ ��ü�� �������� ���� ���ڸ� �ǹ��Ѵ�. Ȯ���ϴ� �Լ��̴�. > ť, ���� peek() ���� 
select seqMemo.currVal from dual; 
-- �α����� �� ��(����) �ּ� 1ȸ �̻� nextVal�� ȣ���ϰ� ���ڿ��� currVal�� ȣ���� �� �ִ�. 
-- �ƹ��� ȣ���ص� ���ڰ� �������� �ʴ´�. �׷��� �̰� �� �����ϴ�. 

-- �Ϸù�ȣ > ���ڷθ� x
-- ���θ� ��ǰ��ȣ > ABC10010 > ����:ī�װ�, ����:������ ��ȣ

select seqNum.nextVal from dual;

select 'ABC' || seqNum.nextVal from dual;

select 'ABC' || to_char(seqNum.nextVal, '0000') from dual; -- �߰��� ������ �����. > ��ȣ�ڸ��� �⺻ 

select 'ABC' ||  ltrim(to_char(seqNum.nextVal, '0000')) from dual; -- ������ �������. 

select -seqNum.nextVal from dual;
select -seqNum.currVal from dual;  -- �ݵ�� nextVal�� �����ϰ� ���� ��� �Ѵ�. 


/*

    ������ ��ü �����ϱ�
    create sequence �������� ;    
    create sequence ��������
                    increment by n  -- ����ġ(**)
                    start with n    -- �ִ�
                    minvalue n      -- �ּڰ� 
                    cycle           -- ���� 
                    cache n;        -- ĳ�� 
*/

drop sequence seqNum;
create sequence seqNum;
-- �޸����� �ʱ�ȭ�ϸ� �̰� �����Ű�� �ٽ� �����.

insert into tblMemo(seq, name, memo, regdate) 
    values (seqNum.nextVal, 'ȫ�浿', '�޸��Դϴ�. �ȳ��ϼ���.', sysdate);
-- �������� ����� �ٽø��� �׸��� �ٽ� �����ϰ� ���� >>> ������ ���� �浹����. 
-- �� ������׿� ������ ����. ORA-00001: unique constraint (HR.SYS_C007260) violated
-- �̰� ���� �������� ���� 1���� �������ϱ� �׷���. �̷� ������ �ִ� �Խ��� �� ��ȣ�� �ٽ� �ǵ�������..
--> �Ժη� ������ ��ü�� ����� �ȵȴ�. �����ٰ� �ٽ� ����� ���� ����� ����
select seqNum.nextVal from dual;

select *from tblMemo;

-- �� �׷��� ��û���� ū ���� �����Ϸ��� start with�� �ٿ��ش�. 
drop sequence seqNum;
create sequence seqNum 
                start with 200;
                
select seqNum.nextVal from dual;                

-- �޸����� ������ ��ȣ�� ������ ����. 

select max(seq) from tblMemo;
drop sequence seqNum;

create sequence seqNum 
                start with 23;

-- create sequence seqNum start with select max(seq) from tblMemo;  -- ���������� ���� �� ����.

drop sequence seqNum;
create sequence seqNum 
                start with 2;
create sequence seqNum 
                increment by 2;


create sequence seqNum
                increment by 100;
select seqNum.nextVal from dual;                                
create sequence seqNum
                increment by -1;
                

create sequence seqNum
                start with 100
                increment by -1
                maxvalue 100; -- �� ���� ���� �� ������ �Ǵ°� ��ġ�� �������. 
                
select seqNum.nextVal from dual;       

drop sequence seqNum;

create sequence seqNum
                maxvalue 10; -- 10 �Ѿ�� ������. 

select seqNum.nextVal from dual;                   

--declare
--TEST_STR VARCHAR2(10);
--vNum number;
--
--IS
--vNum := 23;
--
--begin
--
--
--query := 'create sequence seqNum
--                start with ' || vNum ;
--end;
--                pl/sql�� �����غ��� 

drop sequence seqNum;

create sequence seqNum
                increment by 1
                start with 1
                maxvalue 10
                cycle    -- ���� 
                cache 5; -- 10���� ���� �� ��� �Ѵ�. 
                -- cache �� ������Ʈ �Ը� ���� �ٸ���. �߳����� ����Ʈ�� ���̸��� ū ���� ����. 
                
select seqNum.nextVal from dual; -- 10���� ���� �ٽ� 1�� �����Ѵ�.

-- �޸��ȣ > 1������ �ݵ�� 2??? �ƴϴ�. > ������ �ĺ��ڰ� �޸��ȣ��.

-- 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 

-- ���� > ������ ĳ�� ����
-- �Խ��� �۾��� > ������ 15��~ �ٽ� �۾��� �ؾ��� �ϴµ� ���ڱ� �۹�ȣ�� 21������ ������ �� �ִ�.
-- ������ ĳ�ð� ���󰣴�. �� 16������ ������ ������ ������������� 21������ �ٽý����ض� �װ� �Ϲ����� ���̴�.
-- ���� ��¥�� ������ ����� �ȵǴ� ��ȣ�� �ִ�. 

drop sequence seqMemo; -- �������� ������ �ٽ� �����.

create sequence seqMemo start with 16;
-- ������ ��ȣ�� Ƣ�µ� �̰� ĳ���� ������ ��� �׷��� ��ó�� �޲ٸ� �ȴ�.. �װ� �����ϴ� �ɼ��� ĳ����. 




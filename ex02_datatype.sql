/*

    ex02_datatype.sql
    
    Java > SQL
    
    �ڷ����� ���� ����� ������ ������. 
    
    ANSI-SQL �ڷ���
    - Oracle �ڷ���(***)
    
    1. ������
        - ����, �Ǽ�   
        a. number     
            - (��ȿ�ڸ�) 38�ڸ� ���ϱ��� ǥ���ϴ� �ڷ���
            - 12345678901234567890123456789012345678
            - 1x10^-130 ~ 9.9999x10^125
            - 5~22byte
            
            1. number 
                - ����, �Ǽ� 
                - 1x10^-130 - 9.9999x10^125
                
            2. number(precision)
                - ������ ����(�ݿø�)
                - precision : ���� ������ �ڸ��� 
                
            3. number(precision, scale)
                - ����, �Ǽ� 
                - precision: ���� ������ �ڸ���
                - scale : �Ҽ����� �ڸ���(%.1f)
                
    2. ������
        - ����, ���ڿ�
        - char + String   > String
        - char vs nchar   > n�� �ǹ�?
        - char vs varchar > var �ǹ�? 
        
        ----------------
        a. char        
            - ���� �ڸ��� ���ڿ� > �÷�(����)�� ũ�Ⱑ �Һ�
            - char(n) : n�ڸ� ���ڿ�, n(����Ʈ)
                - n �ּ�ũ�� : 1 ����Ʈ 
                - n �ִ�ũ�� : 2000 ����Ʈ
            - char(10) > 'ABC' > 'ABC         ' : ���� �κ��� �������� ä���.
            - �־��� ������ �����Ͱ� ä���� ���ϸ� ������ ������ �����̽��� ä���. ������ 10����Ʈ�� ����°� ������ Ǯ����.
                       > �ƹ� �������� ������ ä���.
        b. nchar       
            - n : national > ����Ŭ ���ڵ��� ������� �ش� Į���� UTF-16 �����ϰ� 
            - ���� �ڸ��� ���ڿ� > �÷�(����)�� ũ�Ⱑ �Һ�
            - nchar(n) : n�ڸ� ���ڿ�, n(���ڼ�) 
                - n �ּ�ũ�� : 1 ���� ~ 
                - n �ִ�ũ�� : 1000���� 
                
            
        ----------------------------------------------- �ֹι�ȣ char(����) /// �ּ� ������ varchar2�� ���µ� �ð��� ���� ��� ���� �ӵ����̰� �����
                                                        -- �׷��� �� ����� varchar2�� ��κ��� ����. > ���� ���� ���� �ֱ���â ����. 
        c. varchar2     > ����ϴ� ���鿡�� �갡 �̵��̴�. ������ ���� ���� �κ��� trim��Ű�� ������ �߰��� ����. char ���� ������.
            - ���� �ڸ��� ���ڿ� > �÷�(����)�� ũ�Ⱑ ����
            - char(n) : n�ڸ� ���ڿ�, n(����Ʈ)
                - n �ּ�ũ�� : 1 ����Ʈ  >> �ּ�ũ�� ��
                - n �ִ�ũ�� : 4000 ����Ʈ
            - varchar2(10) > 'ABC' > 'ABC' : ������ 7 ����Ʈ�� ������. ���� ������ ������� ������ �� ������ Ȯ���Ѵ�. 
            - �־��� ������ �����Ͱ� ä���� ���ϸ� ������ ������ ������. 
            - ��, �������� ũ�Ⱑ ������ ũ�Ⱑ �ȴ�. �ξ� �� ������ ȿ�������� �� �� �ִ�.            
            
        >> �� ����Ŭ ���������� varchar2�� �ַ� ����. 
        
        d. nvarchar2   
            - n : national > ����Ŭ ���ڵ��� ������� �ش� Į���� UTF-16 �����ϰ� 
            - ���� �ڸ� �� ���ڿ� > �÷�(����)�� ũ�Ⱑ ����
            - varchar2(n) : n�ڸ� ���ڿ�, n(���ڼ�)
                - n �ּ�ũ�� : 1 ����
                - n �ִ�ũ�� : 2000 ���� > �̰� �Ѿ��?? > �ڷ����� �� �ִ�.
        
        >> varchar2�� �� ���� ����. 
        ----------------
    
        e. clob, nclob
        character large object 
        n character large object 
        - ��뷮 �ؽ�Ʈ
        - 128TB
        - �� ��� ����, �������̴�. > �ӵ��� ������. ������ ������ ���ڸ� �� ����.
       
    3. ��¥�ð���
    
        a. date
            - '����Ͻú���'���� ������
            - ����� 4712�� 1�� 1�� ~ 9999�� 12�� 31�� 
                   
        b. timestamp 
            - ����Ͻú��� + �и��� + ������   
        
        c. interval 
            - �ð�
            - ƽ�� �����
        
    
    4. ���� ��������
        - �� �ؽ�Ʈ �����͸� ����ִ´�.
        - �̹���, ����, ���� ��... �����δ� �� �Ⱦ���. ���̴�. 
        - ex) �Խ���( ÷������ ), ȸ������( ���� ) > ���ڿ��� ����(���ϸ� ����) > hong.png > �����̸�
        - �������ٰ� ������ϱ� ���� �̸� ����ڸ� ��� > �� �̸��� db���� ������ �� �̸��� �ش��ϴ� ���ϸ� �����°� �� �ΰ� ������.
        a. blob 
            - �ִ� 128TB

����Ŭ 
1. ���� > number
2. ���� > varchar2(+char)
3. ��¥ > date
4. ���� > X : ���ǹ��� �ݺ����� ���ٺ��� true / false�� �ʿ� ���Ե� ���̴�. 

    
�ڹ�
1. ����   > int, long, double
2. ���ڿ� > String
3. ��¥   > Calendar
4. ���� > boolean 

      
    create table ���̺�� (
       '�÷��� �����Ѵ�.'
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        �÷��� �ڷ��� 
    );
    
    -- ���̺� ��ü�� �ƹ��͵� ����. 
*/
--  ���� �ڵ� ����� 
-- - ��ü ���� > ��ü ���ξ� ��� > �� ��ü�� ����? ��� ����Ų��.

-- ���̺� ����
create table tblType(
    num number 
);

-- ���̺� ���� 
drop table tblType; 

-- ���̺� ���� Ȯ��
-- 1. SQL > ��� ���� �����ϰ� �����Ѵ�. 
select * from tabs;

-- 2. ������ ����� �ٸ�

-- ����Ŭ�� ����ڰ� ���� ��� �ĺ��ڸ� �빮�ڷ� ��ȯ�ؼ� �����Ѵ�. 

create table tblType(
    
    -- num number(3) -- [ -999 ~ 999 ] ���� �����Ѵ�. 
    num number(4,2) -- �Ҽ����� 2�ڸ��� �������� Ȯ���� �ϰ� > ������ ���� �κ� 2�ڸ� 99.99, -99.99
    
); 
-- �� ����� �������ϱ� ���� �� �����Ѵ�.
-- �����͸� �߰��ϱ�

insert into tblType (num) values (100); -- ���� ������ > ������ ���ͷ� > �ڹٿ� ����.
insert into tblType (num) values (200); -- 
insert into tblType (num) values (300); -- 
insert into tblType (num) values (3.14); -- �Ǽ��� ���ͷ� 
insert into tblType (num) values (-100); -- ���� 

-- sql�� Ȯ���ϱ�
select * from tblType;

drop table tblType;

select * from tblType;

insert into tblType (num) values (1000); -- �����÷ο�

insert into tblType (num) values (9.9);  -- �ݿø� // double a = 3.99 // (int)a > 3�̴�.

insert into tblType (num) values (999);  -- �ݿø� // double a = 3.99 // (int)a > 3�̴�.

insert into tblType (num) values (-999);  -- �ݿø� // double a = 3.99 // (int)a > 3�̴�.

insert into tblType (num) values (-1000);  -- �� �̰� �ȵ�

create table tblType(
    num number(4,2) -- �Ҽ����� 2�ڸ��� �������� Ȯ���� �ϰ� > ������ ���� �κ� 2�ڸ� 99.99, -99.99
);  -- �Ҽ� ���� �Ѥ��ڸ�����
drop table tblType;
select * from tblType;

insert into tblType (num) values (100); -- ���� ������ > ������ ���ͷ� > �ڹٿ� ����.
insert into tblType (num) values (200); -- 
insert into tblType (num) values (300); -- 
insert into tblType (num) values (3.14); -- �Ǽ��� ���ͷ� 
insert into tblType (num) values (1000); -- �����÷ο�
insert into tblType (num) values (9.9);  -- �ݿø� // double a = 3.99 // (int)a > 3�̴�.
insert into tblType (num) values (999);  -- �ݿø� // double a = 3.99 // (int)a > 3�̴�.
insert into tblType (num) values (-999);  -- �ݿø� // double a = 3.99 // (int)a > 3�̴�.
insert into tblType (num) values (-1000);  -- �� �̰� �ȵ�
insert into tblType (num) values (-100); -- ���� ;
insert into tblType (num) values (3.142); -- �� �ݿø��ؼ� 3.14�� �ȴ�.
insert into tblType (num) values (3.149); -- �� �ݿø����ؼ� 3.15�� �ȴ�. > ��° �ڸ����� ������ ���̴�.
insert into tblType (num) values (33.14);
insert into tblType (num) values (333.14); -- ��ġ�� 5�ڸ��� �ȴ�. 
insert into tblType (num) values (99.99);
insert into tblType (num) values (-99.99);
insert into tblType (num) values (100);

drop table tblType;

create table tblType(
   txt1 char(10)
); 

insert into tblType (txt1) values('A'); -- ���ڿ� ���ͷ� 
insert into tblType (txt1) values("A"); -- ���ڿ� ���ͷ� �ֵ���ǥ�� ��������.!!!

-- 10 ����Ʈ > �� ����? > ����Ŭ ���ڵ�? > UTF-8 > ����(1), �ѱ�(3)
insert into tblType (txt1) values('ABCDEFGHIJ');  -- ���� �ȴ�. 
insert into tblType (txt1) values('ABCDEFGHIJK'); -- ���� ����.

-- ���� ���� -
-- ORA-12899: value too large for column "HR"."TBLTYPE"."TXT1" (actual: 11, maximum: 10) > �ִ� 10����Ʈ ���� �� �ִµ� 11����Ʈ �������� �ؼ� ���� ���Ŵ�. 
select * from tblType;

insert into tblType (txt1) values ('��');
insert into tblType (txt1) values ('������');
insert into tblType (txt1) values ('�����ٶ�');
insert into tblType (txt1) values ('������A');
select * from tblType;

drop table tblType;

create table tblType (

    txt1 char(10),
    txt2 varchar2(10)
    
); -- �÷��� �� �ƽø� 40~50�� > �ʹ� access�ÿ� �������� ��������. 

-- ���������� 10�� �̸����� 10�� ���� 
                                    --  char    varchar2
insert into tblType(txt1, txt2) values( 'ABC', 'ABC' );
-- ������ Ȯ��?
-- 1. 

select * from tblType;

select sysdate from dual; -- sysdate�� ȣ���ϰ� ������� ��ȯ ! -> 23/03/14



create table tblType (

    txt1 char(10),
    txt2 varchar2(10)
    
);
drop table tblType;



insert into tblType(txt1) values( 'ABC' );

select * from tblType;





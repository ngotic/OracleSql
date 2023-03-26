select * from tabs;

-- ���϶��� �ּ�

/*

���߶��� �ּ� 
    
*/

-- ex01.sql 

select * from tabs;


/*

   [ system ���� ]
    
    �Ϲ� ���� ����  
    1. ������ ����  
    2. �̹� �����Ǿ� �ִ� �Ϲ� ���� > ������( �׽�Ʈ�� ) > scott ����Ŭ ���� �̸�, hr(human resource) �̶�� ����
    
    hr ���� 
    - �Ϲ� ����
    - �׽�Ʈ�� ���� ������ ����
    - ��ġ ���� > ����ִ� ���� > ��� ����
    - ��ġ ���� > ��ȣ ����
    
*/


alter user hr account unlock; -- ���� Ǯ��
alter user hr account lock;   -- ���� ��ױ�


alter user hr identified by java1234; -- ��ȣ �ٲٱ� 


-- ���� ������ �����ϰ� �ִ� ���̺� ��� �������� 
select * from tabs;

select * from REGIONS;             -- �μ� ���� ���� ��� ���� 
select * from COUNTRIES;           -- �μ� ���� ���� ����
select * from LOCATIONS;           -- �μ� ���� ����
select * from DEPARTMENT;          -- �μ� ����
select * from JOBS;                -- ���� ���� ���� 
select * from EMPLOYEES;           -- ���� ���� 
select * from JOB_HISTORY;         -- ���� ���� �̷� ���� 


/*

    ����Ŭ 
    - �����ͺ��̽� + �����ͺ��̽����� �ý���
    
    SQL
    - Structured Query Language 
    - ����ȭ�� ���� ���
    - ��ȭ�� ��� 
    - ����Ŭ �����ͺ��̽� <-> (SQL) <-> Ŭ���̾�Ʈ(������) 
    
    ����Ŭ(SQL + ���� ���) ���� ����? 
    1. �����ͺ��̽� ������
        - DBA 
        - ��� ��� ����/����
        
    2. �����ͺ��̽� ������
        - > DBA�� �߿� ������ ��ŵ� ����. 
        - DB �� 
        - ���� ��ټ� ��� ����/����
        
    3. �������α׷� ������
        - ���� or [ �Ϻ� ��� ] > �ұԸ�ȸ����� ���� ���α׷� �����ڵ� DB�� �ϱ���
        
    �����ͺ��̽� ���� > ���� ��κ��� ������ �����ͺ��̽���. 
    1. Oracle
    2. MS-SQL
    3. MYSQL
    4. MariaDB
    5. PostreSQL
    6. DB2
    7. SQLite
    
    Ŭ���̾�Ʈ ���α׷� 
    1. SQL Developer > ���� ��ġ
    2. SQL Plus      > ����Ŭ�� ���� ��ġ�ȴ�.(�ܼ�) 
    3. DataGrip      > *** ( �б� �̸��� ) 
    4. DBeaver       > ���������. ***
    5. SQLGate
    6. Toad          > Ŭ���̾�Ʈ ���α׷� ���ǿ� 
    
    ������ �����ͺ��̽�
    - �����͸� ǥ�������� ����/�����Ѵ�.
    - SQL�� ����Ѵ�.
    
    [ SQL ]
    1. DBMS ���ۻ�� �������̴�. 
       - ��� ������ �����ͺ��̽����� ���������� �����ϱ� ���� ������� ���
       - DBMS ���ۻ翡�� SQL�� �� �ڽ��� ��ǰ�� ����
       
    2. ǥ�� SQL, ANSI-SQL 
       - ��� DBMS�� ���� ������ SQL 
       
    3. �� ���ۻ纰 SQL 
       - Oracle vs MS-SQL 
       - �ڱ�� ��ǰ������ �����ϴ� �߰� SQL 
       - Oracle(����Ŭ���� �����ϴ� ����� �ִ�.) 
         vs Maria DB(�����.)
       - Oracle > PL/SQL  > ù DB�� ����Ŭ�̸� ����.
       - MS-SQL > T-SQL   > 
       
    ����Ŭ ���� = ANSI-SQL(5~60%) + PL/SQL(2~30%) + ����, ��Ÿ(10%)
    ����Ŭ�� ��ü������ Ȯ���ؼ� ���� SQL�� PL/SQL�̴�. 
    
    ANSI-SQL(5~60%) + PL/SQL(20~30%) + ����,��Ÿ(10%)
    
    ANSI-SQL ����
    1. DDL 
        - Data Definition Language
        - ������ ���Ǿ�
        - ���̺�, ��, �����, �ε���, Ʈ���� ���� �����ͺ��̽� ������Ʈ�� ����/����/�����ϴ� ��ɾ�
        - ���� ����/�����ϴ� ��ɾ�
        - �ǹ� > ���ʰ���(��, �ٴ�..) 
        a. create : ����
        b. drop   : ����
        c. alter  : ����
        - �����ͺ��̽� ������ 
        - �����ͺ��̽� ����� 
        - ���α׷���(**)  
        
    2. DML 
        - Data Manipulation Language
        - ������ ���۾�
        - �����ͺ��̽��� �����͸� �߰�/����/����/��ȸ�ϴ� ��ɾ�(CRUD)
        - ��� �󵵰� ���� ����
        a. select ��ȸ(�б�) > R ***** �߿��ϴ�. �б��۾��� ������ �۾����� �е������� ����. 
                            > ���� §��. ��κ��� SELECT�� ¥�� ��
        b. insert �߰�(����) > C
        c. update ����       > U
        d. delete ����       > D
        - �����ͺ��̽� ������ 
        - �����ͺ��̽� ����� 
        - ���α׷���(*****)  
        
    3. DCL 
            - Data Control Language
            - ������ �����
            - ���� ���� ����, ���� ����, Ʈ������ ó�� ��...
            a. commit
            b. rollback
            c. grant
            d. revoke
            - �����ͺ��̽� ������ 
            - �����ͺ��̽� ����� 
            - ���α׷���(�Ϻ�)      
            
    4. DQL 
        - Data Query Language
        - DML �߿� select ���� ���� ȣĪ
            
    5. TCL
        - Transaction Control Language 
        - DCL �߿� commit, rollback �� ���� ȣĪ�Ѵ�.
        
    ����Ŭ ���ڵ� 
    - 1.0 ~ 8i: EUR-KR > �̶��� �ڹٿ� ���� �� �� �ѱ��� �� ��������...  [ i > ���ͳ�, g > �׸��� �ý���, c > cloud ] 
    - 9i, 10g, 11g, 12c, 18c, 19c, 21c �� �̷������� ������ �ö�´�. ..  >> ������ ����ϸ� �ȴ�. 
    - 9i, 10g, 11g, 12c, 18c, 19c, 21c .. : UTF-8 ����. ������ ���� ���� ����.
    
    ����Ŭ ��ǰ�� 
    - Oracle Enterprise       >  �����Ѱ� �� ��
    - Oracle Express Edition  > �����ϰų� ū �� ���Ѵ�. > �ٵ� �����.
    
    Oracle Express Edition
    - ����
    - ���ο� or �ұԸ� ȸ��
    - ��� �޸� �ִ� 1GB 
    - ������ Express Edition�� 11g�� 18c �ΰ��� �����ۿ� ����. �������� 18c���� 11g�� ���� ����.
    - 11g 
    - 18c  >  ����� ���鼭 �߰��� ������ ���� �ִ�. // �̰ɷ� �����ص� �Ǵµ� ������.
   
*/

-- hr �������� ���� �����Ѵ�. 
-- ��ҹ��� 
-- 1. SQL ��ɾ�� ��ҹ��ڸ� �������� �ʴ´�.
-- �Ķ��� > Ű����
-- ������ > �ĺ���
select * from tabs; -- �üҹ��� --> ������ ���δ� �ҹ��ڷ� �Ѵ�. ��Ÿ���� ������. 

SELECT * FROM TABS; -- �ô빮��

select * from TABS; -- ȥ��1

SELECT * FROM tabs; -- ȥ��2

-- �ʱ��ۼ��� �̷��� �ϴٰ� ���߿� �� �ٲ� �� �ִ� ����� �ִ�. 

-- �ڵ� ������ 



-- Ctrl + F7 �Է��ϸ� ������ �ȴ�. 
 
select * from tabs; -- 


-- ��� ������ �빮�ڷ� �ۼ��ϴ� ���� ���F�ۤ���.

-- �ĺ��� > 
create table aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa  ( -- 31���� �� 
    num number
);

--ORA-00972: identifier is too long
--00972. 00000 -  "identifier is too long"
--*Cause:    An identifier with more than 128 bytes was specified,
--           or a password identifier longer than 30 bytes was specified.
--*Action:   Specify at most 128 bytes for identifiers,
--           and at most 30 bytes for password identifiers.







select * from tabs;




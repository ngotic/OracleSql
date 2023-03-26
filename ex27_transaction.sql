/*

    ex27_transaction.sql
    
    Ʈ�����, Transaction
    - �����͸� �����ϴ� ������ �ð��� ����
    - �Ϸ��� ����� ����. ex) ���࿡�� ���� �����ϴ� �ൿ( 1~ 8�� �ൿ) 
    
    Ʈ����� ��ɾ�
    - DCL, TCL(Transaction Control Language) 
    1. commit
    2. rollback
    3. savePoint
    
*/

-- ���̺��� ����µ� ���� ���̺��� ���� > ������ ���纻 > ������ ī��
create table tblTran
as
select name, buseo, jikwi from tblInsa;


-- ************** � ��ɾ � ������� �����ߴ��� �ݵ�� ����ؾ� �Ѵ�. 
commit; -- ���� �̰� ���� > �� �ð����� ���ο� Ʈ������� ���۵ȴ�.!
-- > insert, update, delete�� Ʈ����ǿ� �����Ѵ�. �����Ϳ� ��ȭ�� �� �� �ִ� ��ɾ ���� 
-- ���� ���۽�Ų Ʈ������� delete �� ����ִ�. select�� �ȵ���ִ�. �̻��¿��� �Ǵٸ� commit�̴� rollback�̴� �Ѵ�. 


select * from tblTran where name='�ڹ���';

delete from tblTran where name ='�ڹ���';

-- �츮�� �ϴ� ��� insert, update, delete�� �����ͺ��̽��� ������� �ʴ´�.
--> �ӽ÷� �޸𸮿� ����ȴ�. ���� DB�� ������ �ȵȴ�. 

-- commit;   -- ���� Ʈ�����ǿ� ���� ��� ��ɾ �־��� �Ϸ� ������.
rollback; -- ���� Ʈ����ǿ� �ߴ� ��� ��ɾ ������ �Ϸ� ������. > �̼��� ���� commit�������� ���ư���. 
-- rollback ���� > ���� Ʈ����� �Ϸ�������� ����. > ���ο� Ʈ������� ���۵ȴ�. �׸��� �� ���ݺ����ϴ� ��� �ൿ���� ��ϵȴ�. 

-- Transaction ����!  > Tx1

select * from tblTran where name='�ڹ���'; 

delete from tblTran where name='ȫ�浿';  --  Tx1 
update tblTran set jikwi = '�븮' where name='�̼���'; -- Tx1
commit; -- ���� Ʈ������� ��� �۾��� ���� DB�� �ݿ� > ���� Ʈ����� �Ϸ�> ���� Ʈ����� ����~ 

select * from tblTran;
-- �� ... �浿�� ����� �ȉ��... !? ���� �ǵ����� ���Ѵ�.

rollback; -- �ٽ� �ѹ��� �ϴ��� 
select * from tblTran; -- �ǵ����� ���Ѵ�.

-- where�� �Ⱥ��̰� �ٷ� �˾��������� �ѹ��� �ٷ� �ϸ�Ǵµ�
-- �װ� ��԰� �شٰ� ���߿� �������� �̰� �������� ����. 



/*

    Ʈ������� ���� �����ϰ�? ���� ��������?
    
    ���ο� Ʈ������� �����ϴ� ���
    1. commit ���� �� ��
    2. rollback ���� �� ��
    3. Ŭ���̾�Ʈ ���� �� �� (�α���)
    
    ���� Ʈ������� ����Ǵ� ��� 
    1. commit ���� > ���� Ʈ������� DB�� �ݿ��� �Ѵ�. 
    2. rollback ���� > ���� Ʈ������� DB�� �ݿ����� �ʴ´�. 
    3. Ŭ���̾�Ʈ ���� ���� 
        a. ���� ����
            - ���� Ʈ����ǿ� ���� �ݿ� �ȵ� ����� ���������� ����ڿ��� ����? 
        b. ������ ���� > �۾������ڷ� ���� ����
            - Ŀ��������? �ѹ�������? 
            - ���� �Ȱ� �ƴ϶� �Ѵ� �ȵ� ���̴�. Tx�� �ൿ�� DB�� �ݿ��� �ȵǾ���.
            - �̼����� ���� DB���� �������� �ʾҴ�. 
    4. DDL ���� > DB Ư��!! ����Ŭ�� �ϴ� �̷���. 
        a. create, alter, drop, rename, ������������ > ���� > �� ��� commit ����!!!
            - ���� �P���� DB ���� ����> ������ ���� O > ������ �̸� ���� 
            
    
*/

delete from tblTran where name ='�̼���';

select * from tblTran where name='�̼���';

-- ��� �ڿ� commit or rollback ? > ���� 

-- ���̺� or ������ 
create sequence seqTest; -- >> �̰� �ǽɵȴ�. 

rollback;

select * from tblTran; -- �̼����� ���� ����.

-- start!!!!
select * from tblTran where name ='�̱���'; 
delete from tblTran where name ='�̱���';
rollback;
select * from tblTran where name ='�̱���'; 

-- �����۾��� transaction�� �ѳ��µ� ���۾��� ������ ���� ����.....
-- �׷��� ��Ȳ�� �°� �����϶�� �ڵ�Ŀ���� �ִ�. 


commit;

select * from tblTran;

delete from tblTran where jikwi = '���';

select count(*) from tblTran;



-- 3. savepoint > �Ĳ��� ������� �߾��°��� ��
-- rollback�ϴ� ������ ����ڰ� ������� �����Ѵ�. �̸� �׷��� savepoint
commit;



select * from tblTran;

-- ������
update tblTran set jikwi = '�̻�' where name ='������'; -- ��.
select * from tblTran where name = '������';
savepoint a;

-- �����
delete from tblTran where name = '����';             -- ��.
savepoint b;


insert into tblTran values('������', '��ȹ��', '���'); -- ��.

rollback to b;
select * from tblTran;
-- ������ ������ ������

--      ����  u     d       i     ���� 
--------|----|------|------|------|-----------------------
------------    ��       ��    ��

rollback to a; -- �����̰� ��ƿ�
select * from tblTran where name ='����'; 

commit;


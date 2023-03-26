/*

    ex16_update.sql
    
    update 
    - DML
    - ������ �����ϴ� ��ɾ�
    - ���ϴ� ���� ���ϴ� �÷����� �����ϴ� ��ɾ�
    
    ����
    - update ���̺�� set Į���� = ��;
    
    - update ���̺�� set �÷��� = ��, �÷��� = ��, �÷��� = ��;
    
    - update ���̺�� set �÷��� = �� where��;
    
    - update ���̺�� set �÷��� = �� [, �÷���=�� ] x N [where��] : �����Ұ� �÷���=�� ���� where���� �ظ��ϸ� ���̰� 
    
*/

commit;
rollback;

select * from tblCountry;

-- ���Ϲα�: ���� > ����
update tblCountry set capital = '����'; -- where���� �̷��� �ٲٴ� ��� �ȵȴ�. ū�ϳ���. -- ��� ���ڵ带 ������� �Ѵ�.
rollback;
update tblCountry set capital = '����' where name = '���ѹα�'; --1���� ������Ʈ ��
rollback;

update tblCountry set 
    name ='�ѱ�', capital ='����', continent='EU'
    where name ='���ѹα�';
    

-- ��� ������ �α� ����!! > �ϰ������� ���� > 10% ���� > 4405 > 4845.5
update tblCountry set population = population * 1.1;
-- null * 1.1 �ϸ� null�� ���´�. ������ ����� ���� ������ �ǿ����ڰ� �Ǹ� ����� null�� ���´�.

-------------------------------------------------------------------------------------



/*
    delete 
    - DML
    - ������ �����ϴ� ��ɾ�
    - ���� �����ϴ� ��ɾ�
    
    ���� 
    - delete [from] ���̺�� [where��]
    
*/
commit;
rollback;

select * from tblCountry;

delete from tblCountry where name = '�Ϻ�';

delete from tblCountry where continent = 'EU';

delete from tblCountry;


-- update, delete > �Ǽ�
-- 1. ���
-- 2. commit/rollback > Ʈ����� > ���� ���ǿ� ���ؼ���... �̹� ������ ����� �̾����� �ʴ´�. -- ������ ������ ���� ������ ������.
-- 3. ��ũ��Ʈ�� ������ �ִ� ���


desc tblCountry;
select MIN(name)
from tblInsa;


select name
from tblInsa
where buseo not in ('���ߺ�', null);


/* 


2. ����
3. �������
4. ������
5. ��

 ex20_view.sql 
 View, �� 
    - �����ͺ��̽� ��ü �� �ϳ�
    - ���� ���̺�, ��, ���̺� ��..
    - ���̺�ó�� ����Ѵ�.(*****)
    - ��� SQL�� ������ ��ü�̴�.
    - ��� ȣ��ɶ����� ����� SQL�� ����ȴ�.(�ǽð� ���� ���̺�)
    
    View ����(����)
    1. ������ �ܼ�ȭ�Ѵ�. > ������ ��� > �������� �ٿ������� �ű�ٰ� �̸��� ���̸� �������� ��������.
    2. �������� ���鿡�� �����Ѵ�.
    3. ���� > �ٸ� �����(hr ��)�� ����
    
    create view ���
    as 
    select ��;
    
    create [ or replace ] view ��� 
    as 
    select��;
*/

-- �̰� ������ �����ڸ� ���̺��� �ƴϴ�. 
create or replace view vwInsa -- tblInsa ���̺��� ���纻 > �����Ѱ�ó�� ���� 
as 
select * from tblInsa;

select * from vwInsa; -- tblInsa ó�� �ൿ 

-- ���̺��̳� �������� or replace�� ���� ���ؼ� �� �� ����. 
create or replace view vwInsa -- ���鷡!? �ƴϸ� �ٲܷ�!? 
as 
select name, jikwi, city, buseo from tblInsa where buseo = '������';
-- ���� ���� select���� ��� ����İ� �����̴�. 

select * from vwInsa; -- �� == ������ ���̺�

-- ������ ��� ��������(�÷�4��)
select name, jikwi, city, buseo from tblInsa where buseo= '������';
select * from vwInsa;

select * from tblVideo; -- �帣 

-- ���� �뿩�� ���� > ������ �ϴ� ������ �ִ�. 
create or replace view �뿩üũ
as -- �Ʒ�ó�� ���� �� ������ ��� �����. 
select 
    m.name as nname,
    v.name as vname,
    to_char(r.rentdate, 'yyyy-mm-dd') as rentdate,
    case
        when r.retdate is not null then '�ݳ��Ϸ�' else '�̹ݳ�'
    end as state,
    case 
        when r.retdate is null 
            then (sysdate-(r.rentdate + (select period from tblGenre where seq = v.genre)))
    end as ��ü�ϼ�
    ,case
        when r.retdate is null
            then round( (sysdate-(r.rentdate + (select period from tblGenre where seq = v.genre)))* g.price * 0.1 )
    end as ��ü�� -- �뿩����(10%) x ��ü��
--    r.rentdate as "�뿩��¥",
--    (select period from tblGenre where seq = v.genre) as "�뿩�Ⱓ(��)",
--    r.rentdate + (select period from tblGenre where seq = v.genre) as "�ݳ���¥",
--    sysdate-(r.rentdate + (select period from tblGenre where seq = v.genre)) as "��ü�Ⱓ(��)"
from tblRent r
    inner join tblVideo v
        on v.seq = r.video
            inner join tblMember m
                on m.seq = r.member
                    inner join tblGenre g 
                        on g.seq = v.genre
                           order by state asc;

-- �뿩��¥
-- �뿩�Ⱓ
-- ���糯¥
-- ���糯¥ - ( �뿩��¥ + �뿩�Ⱓ )
-- ���糯¥ - �ݳ���¥ 

select sysdate - ( r.rentdate + 3 ) from tblRent r; 
-- ��ü�� �ð��� �� 3 �̶�� �ð� ��� ����?? 
-- �̰� �帣���Ը��� �ִ�... �� �װſ���? 

select * from tblRent;
select * from tblGenre;
-- select sysdate - ( r.rentdate + (select priod from tblGenre where seq = ) ) from tblRent r; 

select * from �뿩üũ; 
-- ���� ���� ������� ������ �ؾ��� �׷��� �̰� �����ؼ� �����´�. 
-- �� ������ �ݺ������� ����� �� ©���ϰ� ��ȣ�� �����ϴ�. 

-- �並 �̿��ؼ��� ���� ���̺��� ������ ������ �Ұ����ϴ�.

-- �� ���� > select ������� ���纻  > ������ ������ ��ü(X)
-- �� ���� > select ���� ������ ��ü > SQL ������ ��ü(�޼ҵ�)

create or replace view vwComedian -- ��� ���� ��ü�� �״�� ������ 
as 
select * from tblComedian;  -- ���� ���̺� 

-- �����͸� ������ ���� �ƴϰ� select���� ������ ���̴�.


select * from vwComedian;                  -- �� ���̺� ������ �������� �Ѵ�.
select * from (select * from tblComedian); -- �ٵ� ��ǻ� from ���������� ����. 
                                           -- �ζ��κ� > 1ȸ��

update tblComedian set
    weight = 70 where first = '�缮';
    
select * from tblComedian;    

-- view�� ���� view�� ������ �������� ���� 

-- view�� ���� ��ü�� ����Ѵ�. 


-- ������ �並 ���� ���̺��� Ȯ��
select * from user_views;


-- ����(����)
select * from tblInsa;
-- ���Ի�� > ������ > ���� > ������ �����鿡�� �ϰ� ���� �޼��� ����
select * from tblInsa; -- ���Ի������ tblInsa ������ ����  > tblInsa ���� ���� > ���Ի������ ���� ����
-- �ƿ� ���ƹ����� view�� �����.

drop view ����ó;

create or replace view ����ó
as 
select name, tel from tblInsa where buseo ='������';

select * from ����ó; -- ���Ի������ ����ó ��ü�� ���� ���� ���Ѹ� �ο�, �̷��� ����ó��! �ٸ� ������ ���ϰ�! > ���Ȱ� ���õ� ���� ���� 



create or replace view vwTodo
as
select * from tblTodo; 

select * from vwTodo;
insert into vwTodo values (21, '����Ŭ �����ϱ�', sysdate, null); -- �̰� ��??

select * from tblTodo; 

update vwTodo set title = '����Ŭ �����ϱ�' where seq = 21;

delete from vwTodo where seq = 21;

-- �䰡 insert, update, delete �� �ȴ�. �並 ������� ��ɾ ��µ� ������ ������ �ٲ��. 

-- �� ���
-- �� ������ select �������� �Ѵ�.
-- 1. select > ���� O > ��� �б� �����̴�.(***) == �б� ���� ���̺� 
-- 2. insert > ���� O > ���� ��� ���� > �信�ٰ� �������� ���� ���̺� ������� �ض�
-- 3. update > ���� O > ���� ��� ���� > �信�ٰ� �������� ���� ���̺� ������� �ض�
-- 4. delete > ���� O > ���� ��� ���� > �信�ٰ� �������� ���� ���̺� ������� �ض�

select * from vwTodo; -- �ܼ��� > ���� select���� 1���� ���̺�� ����


select * from �뿩üũ; -- ���շ� > 2�� �̻��� ���̺��� �𿩼� select�� ���� > 
insert into �뿩üũ values('ȫ�浿', '������ ����',
                            sysdate, '�̹ݳ�', 0, 0); -- �̰� �ǰڳ�?? > ��׵��� �츮�� ����ؼ� ���� ���̴�.
                            
-- ���շ��� �� �����͸� ���� �� ���� �ֵ��� ��κ��̴�. �Ǵ� �ִ� ���� �ȵǴ� �ֵ��� �Ⱦ��µ� �ۿ��� ������ ����� ����.
-- ���� ����� �� �� �ִ�. > ������ ���� ��׵��� ���Ǹ� �鿩�� ���� ģ���鸸 ����. 

-- �׷��� insert, update, delete�� �ȵȴٰ� �����Ѵ�. �̰� ���� �ȵ� 




















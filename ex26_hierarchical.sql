/* 


    ex26_hierarchical.sql 
    
    ������ ����, Hierarchical Query 
    - ����Ŭ ���� > �ǰ� ���ؼ� �ٸ� db�� �־����� ���ڴ�. 
    - ���ڵ� ���谡 ���� ���� ���������� �� ���
    - ���� �ٸ� ���̺��� ���谡 ���� ������ �� ���
    - �ڱ� ������ �ϴ� ���̺��� ���
    - ex) ī�װ�, �亯�� �Խ���, ������... Ʈ�� ������ ��� 
    
    1. ���������� ������
    2. ���̺� ���� ���� ���
    
    ��ǻ��
        - ��ü
            - ���κ���
            - �׷��� ī��
            - CPU 
            - �޸�
        - �����
            - ����;�
            - ��ȣ�ʸ�
   
*/

-- Ʈ�������� DB�� ������ �� ������ �����ϴ�. 
-- ������ db�� �������� ǥ���ϱ� �����. > ǥ�� 2���� �迭 

create table tblComputer (
    seq number primary key,                      -- �ĺ���(PK)
    name varchar2(50) not null,                  -- ��ǰ�� 
    qty number not null,                         -- ����
    pseq number null references tblComputer(seq) -- �� �θ��ǰ(FK) 
);

insert into tblComputer values(1, '��ǻ��', 1, null); -- �θ� ���� �ֵ� ����
insert into tblComputer values(2, '��ü', 1, 1); 
insert into tblComputer values(3, '���κ���', 1, 2); 
insert into tblComputer values(4, '�׷���ī��', 1, 2); 
insert into tblComputer values(5, 'CPU', 1, 2); 
insert into tblComputer values(6, '�޸�', 2, 2); 

insert into tblComputer values(7, '�����', 1, 1); 
insert into tblComputer values(8, '����;�', 1, 7); 
insert into tblComputer values(9, '��ȣ�ʸ�', 1, 7); 


-- Case 2. > ������ ���´� �ڱ������϶� �� �̷��� ??? ���� 
create table tblCategoryBig (
    seq number primary key,                 --�ĺ���(PK)
    name varchar2(100) not null             --ī�װ���
);

create table tblCategoryMedium (
    seq number primary key,                             --�ĺ���(PK)
    name varchar2(100) not null,                        --ī�װ���
    pseq number not null references tblCategoryBig(seq) --�θ�ī�װ�(FK)
);

create table tblCategorySmall (
    seq number primary key,                                 --�ĺ���(PK)
    name varchar2(100) not null,                            --ī�װ���
    pseq number not null references tblCategoryMedium(seq)  --�θ�ī�װ�(FK)
);

insert into tblCategoryBig values (1, 'ī�װ�');

insert into tblCategoryMedium values (1, '��ǻ�Ϳ�ǰ', 1);
insert into tblCategoryMedium values (2, '���ǰ', 1);
insert into tblCategoryMedium values (3, '�԰Ÿ�', 1);

insert into tblCategorySmall values (1, '�ϵ����', 1);
insert into tblCategorySmall values (2, '����Ʈ����', 1);
insert into tblCategorySmall values (3, '�Ҹ�ǰ', 1);

insert into tblCategorySmall values (4, '�״Ͻ�', 2);
insert into tblCategorySmall values (5, '����', 2);
insert into tblCategorySmall values (6, '�޸���', 2);

insert into tblCategorySmall values (7, '��ŰƮ', 3);
insert into tblCategorySmall values (8, '����Ŀ��', 3);
insert into tblCategorySmall values (9, '���ö�', 3);


-- ������� ������ �����Ѵ�. �������� ����� �� ���� �� ����� �غ���
-- �߰� > �ֻ��� > ������ >


-- tblComputer > �ָ��ϴ�. Ʈ������ ���� ������ �ȵ��. 
-- 1. ����
select
    c1.name as "��ǰ��",
    c2.name as "�θ��ǰ��"
from tblComputer c1 -- �ڽĺ�ǰ > ������ �ؾ��Ѵ�. 
    inner join tblComputer c2 -- �θ��ǰ > ������ ���ϰ�
        on c2.seq = c1.pseq; 

-- 2. ������ ����
/*

    start with�� + connect by ��
    
    ������ ���� �ǻ� Į��
    a. prior > �ڱ�� ������ �θ� ���ڵ� ����
    b. level > �����(depth) > 1���ͽ���
    
*/

select 
*
from tblComputer
    start with seq = 1
        connect by prior seq = pseq;
        
-- �̷����ϸ� prior�� level�� �� �� �ִ�.        
        
        
        
-- lpad(ä���, �?)        

-- ���������� ������ ���´�.
select 
    seq, 
    lpad(' ', (level-1) * 5) || name,  -- level�� �̿��ؼ� �ð����� ȿ���� �ش�. > �鿩����ȿ��
    prior name,    -- �ڸ��� �����Ѵ�.
    level
from tblComputer
    start with seq = 1  -- �θ� ��ǰ������, �ڽĺ�ǰ ������
        connect by prior seq = pseq; -- ���� ���ڵ�� �θ� ���ڵ带 �����ϴ� ����(���� on ����)
        -- on c2.seq = c1.pseq;  �̷��Կ� �����ϴ�. 
        -- ���� ���̺��� �ϳ���? prior ������ �׷���.
        -- �ڱ�� �θ��� ������ prior ������ �׷���.
        -- pseq�� �ڱ� �ڽ��� ������? ��� �˷��ش�. 
        -- prior seq �� �θ��ҷμ��� �������� ã�� 

-- level�� 1����    

-- ������ �κ������� �̾ƿ´�. �ұ׷츸 ���� �ʹ�. 
select 
    seq, 
    lpad(' ', (level-1) * 5) || name,  
    prior name,    -- �ڸ��� �����Ѵ�.
    level
from tblComputer        -- ����͹�ȣ�� �ƴϱ� �װɷ� ���� 
    start with seq = 7  -- ���� ������� �ֵ鸸 ������ �� �ִ�. 
        connect by prior seq = pseq; 

select 
    seq, 
    lpad(' ', (level-1) * 5) || name,  
    prior name,    -- �ڸ��� �����Ѵ�.
    level
from tblComputer        -- ����͹�ȣ�� �ƴϱ� �װɷ� ���� 
    start with seq = (select seq from tblComputer where name ='��ü')
        connect by prior seq = pseq; 



select 
    seq, 
    lpad(' ', (level-1) * 5) || name,  
    prior name,    -- �ڸ��� �����Ѵ�.
    level
from tblComputer        
    start with pseq is null -- ��Ʈ�� �������� ���� �ֱ���
        connect by prior seq = pseq; 


select * from tblSelf;
select 
lpad(' ', (level-1)*2) || name as "������"
 from tblSelf 
    start with seq = 1
        connect by super = prior seq; -- �ڽ����̺��� seq���ٰ� prior
                 -- �θ����̺��� super
                 
select * from tblCategoryBig;
select * from tblCategoryMedium where pseq = 1;
select * from tblCategorySmall where pseq = 2;
                 
-- �긦 �Ѳ����� ����ʹ�!? join�� �ض� 


select * 
from tblCategoryBig b
    inner join tblCategoryMedium m 
        on b.seq = m.pseq
            inner join tblCategorySmall s
                on m.seq = s.pseq;
                
-- ���� ī�װ�, ���� ī�װ� �ѹ��� �������� �; join�� �ߴ�.
-- �׷��� ��׵��� �ݺ��ؼ� ���͵� �ݺ� �ȵǰ� �ϰ� �ʹ�.... 



/*

    1. SQL
    
    3. ����(�𵨸�)
    
    ---------------------------- ���� > ������ ���� ��
    
    2. PL/SQL
    
    -------------------------- ����(����) + ������Ʈ(����) > ������Ʈ(����) 
    
*/









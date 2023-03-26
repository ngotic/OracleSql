/*

    ex25_with.sql
    
    [with <sub query> ]  - with��
    select column_list
    from table_name
    [where search_condition]
    [group by group_by_expression]
    [having search_condition]
    [order by order_expression [asc|desc]];
    
    with��
    - �ζ��κ�(from�� ��������)�� �̸��� ���̴� ���
    
    with �ӽ����̺�� as (
        ����� select��
    )
    select ��; 
    
    with�� ���� ��� ]
    1. Materialize ��� > �ӽ� ���̺��� 2���̻� ���Ǹ� ���ο� �ӽ� ���̺� ���� + �ݺ� ���� > with�� ���� 
    -- ó�� ȣ��� �ӽ÷� �޸𸮿� ����� �װ��� �����Ѵ�. : ���� > �ӵ����� �̵��̴�. �߰����� �̵��� �� �� �ִ�. 
    
    2. Inline ��� > �ӽ� ���̺� �������� �Ź� �ζ��� ������ �ݺ� ���� > �Ϲ������� �������� ���� ����ǰ� �������� ���� ����
    
    -- [ �ѹ� �� ��ĵ�� �׸��� ���� ���̺��� ������ �ֳ� Ȯ���ؼ� ������ 1��, �ƴϸ� 2�� ]
        
*/

select * from (select name, buseo, jikwi from tblInsa where city = '����');

with seoul as (select name, buseo, jikwi from tblInsa where city ='����' )
select * from seoul; 
-- with�� �ܵ����� ������. select���� �����ִ� �� 
-- ������ with���� ���� ���´�. 
-- �̷� ���ؼ� ��� �̵� : ���������� ª������. 


select * 
    from (select name, age, couple from tblMen where weight < 90) a
            inner join (select name, age, couple from tblwomen where weight > 60 ) b 
                on a.couple = b.name;
                
-- �������� ��������....                
-- with�� ���Ը� �ӽ����̺��ε� �����δ� �ϵ忡 ���� x, ��������ٰ� ������ 
with a as (select name, age ,couple from tblmen where weight < 90),
     b as (select name, age ,couple from tblwomen where weight > 60) 
    select * from a inner join b on a.couple = b.name;
            
            
-- �����Լ� or rownum 

-- �޿� 5��

select
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa;

select * from (
select
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa
) where rnum = 5;


with insa as (
select
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa
)
select * from insa where rnum = 5;





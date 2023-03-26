/*

    ex10_string_function.sql
    
    ���ڿ� �Լ�
    
    upper(), lower(), initcap()
    - varchar2 upper(�÷�)
    - varchar2 lower(�÷�)
    - varchar2 initcap(�÷�)
    
*/

select 
    first_name,
    upper(first_name),
    lower(first_name)
from employees;

select 
    'abc', initcap('abc'), initcap('aBC')  -- ī�� ǥ���ó�� ù���ڸ� �빮�ڷ� �ٲ��ִ�.  > ī��ǥ������� �Ѵ�. ù���ڸ� �빮��, �������� �ҹ��ڷ� �ϰ� ��ȯ
from dual;


select first_name 
    from employees
        where lower(first_name) like '%an%';
        
/*

    substr()
    - ���ڿ� ���� �Լ�
    - varchar2 substr(�÷�, ������ġ, ������ ���� ����) 
    - varchar2 substr(�÷�, ������ġ)
    - *** SQL �ε��� > 1���� ����
*/

select
    title, 
    substr(title, 3, 4), -- 4���ڸ� ¥���µ� ���鵵 �����ؼ� �ڸ���.
    substr(title, 3)     -- 3��° ��ġ���� ������ ~ 
from tblTodo;



select 
    name, 
    substr(name, 1, 1) as "��",
    substr(name, 2) as "�̸�",
    ssn,
    substr(ssn, 1, 2) as "����",
    substr(ssn, 3, 2) as "����",
    substr(ssn, 5, 2) as "����",
    substr(ssn, 8, 1) as "����"
from tblInsa;


select 
    sum
    (case 
        when substr(name, 1, 1) = '��' then 1 else 0
    end) as "�达",
    count
    (case 
        when substr(name, 1, 1) = '��' then 1
    end) as "�̾�",
    count
    (case 
        when substr(name, 1, 1) = '��' then 1
    end) as "�ھ�",
    count
    (case 
        when substr(name, 1, 1) = '��' then 1
    end) as "�־�",
    count
    (case 
        when substr(name, 1, 1) = '��' then 1
    end) as "����",
    count(case 
        when substr(name, 1, 1) NOT IN ('��', '��', '��', '��', '��') then 1
    end) as "������"
from tblInsa; -- ���ǿ� substring�� �� ���̴�.


-- ���� ���̽��� ���� ���� ����


select * from tblInsa
    where ssn like '%-2%';
    
select * from tblInsa
    where substr(ssn ,8, 1) = '2';
    
-- or�� ���� �ƴϸ� ���� �ƴϸ� �̷��Ե� ���µ� IN���� or�� ���÷��� �ȴ�. 

-- ���� > ���� ~ ���ڼ����� ���� ����ϰ� ���ڼ����� ����Ѵ�. 
select * from tblInsa
    order by ssn;

select 
    name, 
    ssn,
    case
        when ssn like '%-1%' then 1
        when ssn like '%-2%' then 2
    end as gender 
from tblInsa
    order by gender;
    
select 
    name, 
    ssn
from tblInsa
    order by case
        when ssn like '%-1%' then 1
        when ssn like '%-2%' then 2
    end; -- case�� ���� Į���� order �������� ���´�.    
    
select 
    *
from tblInsa
    order by substr(ssn, 8, 1); -- ���� ������ �� ������ ���� ������ �� ���´�. 
    
    
/*

    length()
    - ���ڿ� ����
    - number length(Į��)
    
*/

-- �÷� ����Ʈ���� ���
select name, length(name) from tblCountry;

-- ���������� ��� 
select name, length(name) from tblCountry where length(name) > 3;
select name, length(name) from tblCountry where length(name) between 4 and 6;

-- ���Ŀ��� ���
select name, length(name) from tblCountry order by length(name) desc;

-- �Խ��� ���� > ��� > �߶� > ������ǥ(..) 
select 
    title,
    case 
        when length(title) >= 8 then substr(title, 1, 8) || '..'
        else title
    end
from tblTodo;

/*
    instr()
    - �˻��Լ�(indexOf)
    - �˻����� ��ġ�� ��ȯ
    - number instr(�÷�, �˻���) 
    - number instr(�÷�, �˻���, ������ġ) 
    - number instr(�÷�, �˻���, ������ġ, -1)  -- �̷��� �ϸ� lastIndex ������ �Ѵ�.
    
*/

select 
    '�ȳ��ϼ���. ȫ�浿��',
    instr('�ȳ��ϼ���. ȫ�浿��', 'ȫ�浿') as r1, -- �� 8��°���� 
    instr('�ȳ��ϼ���. ȫ�浿��', '�ƹ���') as r2, -- ���°� ã���� 
    instr('�ȳ��ϼ���. ȫ�浿��. ȫ�浿��', 'ȫ�浿') as r3,
    instr('�ȳ��ϼ���. ȫ�浿��. ȫ�浿��', 'ȫ�浿', 11) as r4,
    instr('�ȳ��ϼ���. ȫ�浿��. ȫ�浿��', 'ȫ�浿'
    , instr('�ȳ��ϼ���. ȫ�浿��. ȫ�浿��', 'ȫ�浿') + length('ȫ�浿')) as r5, -- ������ ã�´�. 
    instr('�ȳ��ϼ���. ȫ�浿��. ȫ�浿��', 'ȫ�浿', -1 ) as t6
from dual;



/*
    lpad(), rpad()
    - left padding, right padding
    - varchar2 lpad(�÷�, ����, ����)
    - varchar2 rpad(�÷�, ����, ����)
*/


-- ���� ��ŭ �ڸ� ������ ��� �� �� �������ٰ� �� ���ڷ� ä�� ���̴�.
select 
    'a',
    lpad('a', 5, 'b'), -- ���� ������ ä��� > �е� 
    'a',
    lpad('1', 3, '0'),
    lpad('12', 3, '0'),
    lpad('123', 3, '0'),
    lpad('1234', 3, '0'),
    rpad('1', 3, '0')
from dual;











/*

    trim(), ltrim(), rtrim()
    - varchar2 trim(�÷�)
    - varchar2 ltrim(�÷�)
    - varchar2 rtrim(�÷�)

*/


select 
    '    �ϳ�       ��        ��     ',
    trim('    �ϳ�       ��        ��     '), -- ���鸸 �����. �ٸ� ���� ���Ŵ� ����, ���ڰ� �ϳ��� ����. 
    ltrim('    �ϳ�       ��        ��     '), -- �ٸ� ���� ���ŵ� ����
    rtrim('    �ϳ�       ��        ��     '), -- �ٸ� ���� ���ŵ� ���� 
    rtrim('    �ϳ�       ��        ��     xx','x') -- �ٸ� ���� ���ŵ� ���� 
from dual;


/*
    replace()
    - ���ڿ� ġȯ
    - varchar2 replace(�÷�, ã�� ���ڿ�, �ٲ� ���ڿ�)
*/

select 
    replace('ȫ�浿', 'ȫ', '��'),
    replace('ȫ�浿', '��', '��'),
    replace('ȫ�浿', '��', '��')
from dual;

select 
    name,
    continent,
    case
        when continent='AS' then '�ƽþ�'
        when continent='EU' then '����'
        when continent='AF' then '������ī'
    end as c1,
    replace(continent, 'AS', '�ƽþ�'),
    replace(replace(replace(continent, 'AS', '�ƽþ�'),'EU','����'),'AF','������ī') -- ������ replace
from tblCountry;
    
-- case end�� ������ �������� ������ null�� ��ȯ�Ѵ�.
-- replace�� ��ã���� ������ �����ش�.

/*

    decode()
    - ���ڿ� ġȯ 
    - replace�� ���
    - varchar2 decode( �÷�, ã�� ���ڿ�, �ٲ� ���ڿ� [, ã�� ���ڿ�, �ٲ� ���ڿ�] x N )
    - ���ڿ� ���� > case�� ������ ���� 
    - ��ã���� null�� �����ش�. ( replace�� ��ã���� ������ �����ش�.)
    - >>> �׷��� case end�� ����ϴ�.
*/

select * from tblComedian;

select 
    gender,
    case 
        when gender = 'm' then '����'
        when gender = 'f' then '����'
    end as g1,
    replace(replace(gender, 'm', '����'), 'f' ,'����') as g2,
    decode(gender, 'm', '����') as g3, -- ������ ��ã���ϱ� null�� ���Դ�.
    decode(gender, 'm', '����', 'f','����') as g4
    
from tblComedian;
-- ���ڸ� ã�Ƽ� ������ �ٲ۴�.

-- ���� ���? ���� ���?

select
    -- A.
    count(case
        when gender = 'm' then 1
    end),
    count(case 
        when gender = 'f' then 1
    end),
    count(decode(gender,'m', 1)),
    count(decode(gender,'f', 1))
from tblComedian; -- �� �����Լ��� �Ǵϱ� ����!!! 

-- decode�� case�� ����ѵ� .... 


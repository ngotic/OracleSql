/*
    ex06_column
*/

-- �÷� ���
select name, buseo
    from tblInsa;
-- ���� 
select name, basicpay, basicpay * 2 as basicpay2
    from tblInsa;
-- ���
select name, 'ȫ�浿', 100  -- 'ȫ�浿', 100�� �����. 
    from tblInsa;




/*


    distinct 
    - �÷� ����Ʈ���� ���
    - �ߺ��� ���� 
    - distinct �÷��� > �ߺ����� �����Ϸ��� ��� ���̺� ��ü�� �ߺ�����θ� ���еǴ� ���� ����� �Ǿ�� �Ѵ�.
                    -> �ٸ� Į���� �ٸ� �� �پ� ������ �ȵȴ�. 
                    -> ���ڵ忡 ���� �ߺ����� �����Ѵ�. ���ڵ�� ���ڵ�� ���Ѵ�. > ���ڵ� ������ ��� �����ؾ� �ߺ������Ŵ�. 
                    
                    
*/

select * from tblCountry; 
select continent from tblCountry; -- �̰�� > �ߺ����鸸 ����

-- tblCountry���� � � ����� �ֳ���? > ����? > ���⿣ �ƽþ� ������ī ���� ��콺 ��������, au�� �־��
select distinct continent from tblCountry; --> �տ� ���̸� �ȴ�. > �ߺ��� �ֵ��� ������ �ȴ�.

-- tbalInsa. > �� ȸ�翡�� � �μ�����??
select buseo from tblInsa; 
select distinct buseo from tblInsa; 
select distinct buseo, name from tblInsa; 

-- tblInsa. > �� ȸ��� ������ ��͵��� �ֳ���?
select distinct jikwi from tblInsa;

-- ******************************** DB�� ���̺��� �������̶�°� ����. 
select distinct continent, name from tblCountry; -- �� ���� distinct�� �پ �ߺ� ���Ű� �ȵȴ�. 
             -- ����� �ƴ϶� ���� �̸��� �����ϱ� �׷���. > Ʃ�ñ������� �ο� �������� �ߺ����� ��� ���̴�. 
             
             
select age, height from tblAddressBook where age = 36;            -- 50��
select distinct age, height from tblAddressBook where age = 36;   -- 29�� > �� Į���� �Ϻ��ϰ� ��ġ�ϴ� �ֵ��� ����

/*
    case 
    - ��κ� ������ ���
    - ���ǹ� ���� > �÷��� ����
   
*/


select 
    last || first as name,
    gender,
    case      -- case, end ���̰� �����ƽ� ���̰�  >> Į��
        when gender = 'm' then '����'
        when gender = 'f' then '����'
    end as genderName --as�� �� ������... �ݵ�� ������ > when ��? then ����
from tblComedian;
-- if() { -> sql�� ��ȣ ǥ���� ����. 
-- }
                          
select 
    name,
    continent,
    case 
        when continent = 'AS' then '�ƽþ�'
        when continent = 'EU' then '����'
        when continent = 'AF' then '������ī'
        else '��Ÿ'
    end as continentName
from tblCountry;


select 
    name,
    continent,
    case continent -- continent = �� �������� �÷���� 
        when 'AS' then '�ƽþ�'
        when 'EU' then '����'
        when 'AF' then '������ī'
    end as continentName
from  tblCountry;

select 
    name,
    continent,
    case 
        when continent = 'AS' then '�ƽþ�'
        when continent = 'EU' then '����'
        when continent = 'AF' then '������ī'
        -- else '��Ÿ' > ������ ������ null�̴�. 
    end as continentName
from tblCountry;

select 
    name,
    continent,
    case 
        when continent = 'AS' then '�ƽþ�'
        when continent = 'EU' then '����'
        when continent = 'AF' then '������ī'
         else continent  -- ���ǿ� �Ȱɸ��� ���� �ڱⰪ ������. 
    end as continentName
from tblCountry;

select 
    name,
    continent,
    case 
        when continent = 'AS' then '�ƽþ�'
        when continent = 'EU' then '����'
        when continent = 'AF' then '������ī'
         else capital  -- ���ǿ� �Ȱɸ��� ���� �ڱⰪ ������. 
    end as continentName -- �ٸ� Į���� ���� ������ �����ϴ�. 
from tblCountry;

/*
select 
    name,
    continent,
    case 
        when continent = 'AS' then '�ƽþ�'
        when continent = 'EU' then '����'
        when continent = 'AF' then '������ī'
         else capital  -- ���ǿ� �Ȱɸ��� ���� �ڱⰪ ������. 
    end as 100 -- �ٸ� Į���� ���� ������ �����ϴ�.  > �ڷ����� ��ġ�ؾ� �Ѵ�.  > ������ ������ �����Ϳ� ������ �ڷ����� ������ 
from tblCountry;
*/

select 
    name,
    continent,
    case continent -- continent = �� �������� �÷���� 
        when 'AS' then '�ƽþ�'
        when 'EU' then '����'
        when 'AF' then '������ī'
        else continent 
    end as continentName
from  tblCountry;

select 
    last || first as name,
    weight, 
    case -- ���������� �˻��ϰ� �Ʒ��� �����´�. 
        when weight > 90 then '��ü��'
        when weight < 50 then '����ü��' -- 89���϶�� ��
        else '��ü��'
    end as state,
    case 
        when weight > 50 and weight <= 90 then '����ü��'
        else '�̻�ü��'
    end as state2,
    case 
        when weight between 50 and 90 then '����ü��'
        else '�̻�ü��'
    end as state3
from tblComedian;


select * from tblComedian;

select 
    name, jikwi,
    case 
        when jikwi = '����' or jikwi = '����' then '���α�'
        else '������ '
    end state ,
    case 
    when jikwi in ('����', '����') then '���α�'
        else '������'
    end  state2
from tblInsa;

select 
    name,
    case 
        when name like '��%' then 100
        when name like '��%' then 100
        when name like '��%' then 100
        else 50
    end as ������
from tblInsa;


select 
    title,
    case 
        when completedate is null then '�̿Ϸ�'
        when completedate is not null then '�Ϸ�'
    end as state
from tblTodo;



--�䱸����.001.employees
--������ ��͵��� �ִ��� �������ÿ�. > job_id

select distinct job_id
from employees;

--�䱸����.002.employees
--������� 2002~2004�� ������ �������� ��� �μ��� �ٹ��մϱ�? > hire_date + department_id

select distinct E.department_id "�μ�ID", D.department_name "�μ��̸�"
from employees E, departments D
where hire_date between '2002-01-01' and '2004-12-31' and E.department_id=D.department_id ;


select * from employees;

--�䱸����.003.employees > �Ŵ��� ��ȣ�� ��ģ��. 
--�޿��� 5000�� �̻��� �������� ��� �Ŵ����� ����? > manager_id
select distinct manager_id  -- null�� ���д�.
from employees
where salary >= 5000;

--�䱸����.004.tblInsa > �ֹε�Ϲ�ȣ�� like�� ������ �� ���͸��ؼ� �����̸鼭 80���� ã���� �ȴ�. 
--���� ���� + 80�������� ������ ���ϱ�? > ssn + jikwi
select distinct jikwi
from tblInsa
where ssn LIKE '8%';


--�䱸����.005.tblInsa > ���� 20���� �Ѵ� ����� �����ͼ� �� ����� ������ ����ִ� ������̳�? 
--���� 20���� �Ѵ� �������� ��� ��ϱ�? > sudang + city   

select distinct city
from tblInsa
where sudang > 200000 ;


select *
from tblInsa;
--�䱸����.006.tblInsa > ����ó�� ���� �������� ����μ� ������̳�? 3���߿� 2���� ���� �μ���. 
--����ó�� ���� ���� ������ ��� �μ��Դϱ�? > null + buseo
select distinct buseo
from tblInsa
where tel is null;



--�䱸����.001.employees
--������ ��͵��� �ִ��� �������ÿ�. > job_id
select distinct job_id from employees;

--�䱸����.002.employees
--������� 2002~2004�� ������ �������� ��� �μ��� �ٹ��մϱ�? > hire_date + department_id
select distinct department_id from employees where hire_date between '2002-01-01' and '2004-12-31';

--�䱸����.003.employees
--�޿��� 5000�� �̻��� �������� ��� �Ŵ����� ����? > manager_id
select distinct manager_id from employees where salary >= 5000;

--�䱸����.004.tblInsa
--���� ���� + 80�������� ������ ���ϱ�? > ssn + jikwi
select distinct jikwi from tblInsa where ssn like '8%-1%';

--�䱸����.005.tblInsa
--���� 20���� �Ѵ� �������� ��� ��ϱ�? > sudang + city   
select distinct city from tblInsa where sudang >= 200000;
    
--�䱸����.006.tblInsa
--����ó�� ���� ���� ������ ��� �μ��Դϱ�? > null + buseo
select distinct buseo from tblInsa where tel is null;
/*
    ex06_column
*/

-- 컬럼 명시
select name, buseo
    from tblInsa;
-- 연산 
select name, basicpay, basicpay * 2 as basicpay2
    from tblInsa;
-- 상수
select name, '홍길동', 100  -- '홍길동', 100은 상수다. 
    from tblInsa;




/*


    distinct 
    - 컬럼 리스트에서 사용
    - 중복값 제거 
    - distinct 컬럼명 > 중복값을 배제하려면 결과 테이블 자체가 중복값들로만 구분되는 행의 모습이 되어야 한다.
                    -> 다른 칼럼에 다른 값 붙어 있으면 안된다. 
                    -> 레코드에 대해 중복값을 제거한다. 레코드대 레코드로 비교한다. > 레코드 통으로 묶어서 생각해야 중복값제거다. 
                    
                    
*/

select * from tblCountry; 
select continent from tblCountry; -- 이경우 > 중복값들만 있음

-- tblCountry에는 어떤 어떤 대륙이 있나요? > 종류? > 여기엔 아시아 아프리카 유롭 사우스 아프리다, au도 있어요
select distinct continent from tblCountry; --> 앞에 붙이면 된다. > 중복된 애들이 통합이 된다.

-- tbalInsa. > 이 회사에는 어떤 부서들이??
select buseo from tblInsa; 
select distinct buseo from tblInsa; 
select distinct buseo, name from tblInsa; 

-- tblInsa. > 이 회사는 직위가 어떤것들이 있나요?
select distinct jikwi from tblInsa;

-- ******************************** DB의 테이블에는 셀병합이라는게 없다. 
select distinct continent, name from tblCountry; -- 이 때는 distinct가 붙어도 중복 제거가 안된다. 
             -- 대륙뿐 아니라 국가 이름도 있으니까 그렇다. > 튜플기준으로 로우 기준으로 중복값을 잡는 것이다. 
             
             
select age, height from tblAddressBook where age = 36;            -- 50개
select distinct age, height from tblAddressBook where age = 36;   -- 29개 > 두 칼럼이 완벽하게 일치하는 애들이 빠짐

/*
    case 
    - 대부분 절에서 사용
    - 조건문 역할 > 컬럼값 조작
   
*/


select 
    last || first as name,
    gender,
    case      -- case, end 붙이고 엘리아스 붙이고  >> 칼럼
        when gender = 'm' then '남자'
        when gender = 'f' then '여자'
    end as genderName --as를 꼭 붙이자... 반드시 붙이자 > when 면? then 무다
from tblComedian;
-- if() { -> sql은 괄호 표현이 없다. 
-- }
                          
select 
    name,
    continent,
    case 
        when continent = 'AS' then '아시아'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
        else '기타'
    end as continentName
from tblCountry;


select 
    name,
    continent,
    case continent -- continent = 를 공통으로 올려논거 
        when 'AS' then '아시아'
        when 'EU' then '유럽'
        when 'AF' then '아프리카'
    end as continentName
from  tblCountry;

select 
    name,
    continent,
    case 
        when continent = 'AS' then '아시아'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
        -- else '기타' > 조건이 없으면 null이다. 
    end as continentName
from tblCountry;

select 
    name,
    continent,
    case 
        when continent = 'AS' then '아시아'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
         else continent  -- 조건에 안걸리면 원래 자기값 찍힌다. 
    end as continentName
from tblCountry;

select 
    name,
    continent,
    case 
        when continent = 'AS' then '아시아'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
         else capital  -- 조건에 안걸리면 원래 자기값 찍힌다. 
    end as continentName -- 다른 칼럼의 값도 지정이 가능하다. 
from tblCountry;

/*
select 
    name,
    continent,
    case 
        when continent = 'AS' then '아시아'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
         else capital  -- 조건에 안걸리면 원래 자기값 찍힌다. 
    end as 100 -- 다른 칼럼의 값도 지정이 가능하다.  > 자료형도 일치해야 한다.  > 동일한 성격의 데이터와 동일한 자료형의 데이터 
from tblCountry;
*/

select 
    name,
    continent,
    case continent -- continent = 를 공통으로 올려논거 
        when 'AS' then '아시아'
        when 'EU' then '유럽'
        when 'AF' then '아프리카'
        else continent 
    end as continentName
from  tblCountry;

select 
    last || first as name,
    weight, 
    case -- 위에서부터 검사하고 아래로 내려온다. 
        when weight > 90 then '과체중'
        when weight < 50 then '정상체중' -- 89이하라는 것
        else '저체중'
    end as state,
    case 
        when weight > 50 and weight <= 90 then '정상체중'
        else '이상체중'
    end as state2,
    case 
        when weight between 50 and 90 then '정상체중'
        else '이상체중'
    end as state3
from tblComedian;


select * from tblComedian;

select 
    name, jikwi,
    case 
        when jikwi = '부장' or jikwi = '과장' then '간부급'
        else '평사원급 '
    end state ,
    case 
    when jikwi in ('부장', '과장') then '간부급'
        else '평사원급'
    end  state2
from tblInsa;

select 
    name,
    case 
        when name like '김%' then 100
        when name like '이%' then 100
        when name like '박%' then 100
        else 50
    end as 가산점
from tblInsa;


select 
    title,
    case 
        when completedate is null then '미완료'
        when completedate is not null then '완료'
    end as state
from tblTodo;



--요구사항.001.employees
--직업이 어떤것들이 있는지 가져오시오. > job_id

select distinct job_id
from employees;

--요구사항.002.employees
--고용일이 2002~2004년 사이인 직원들은 어느 부서에 근무합니까? > hire_date + department_id

select distinct E.department_id "부서ID", D.department_name "부서이름"
from employees E, departments D
where hire_date between '2002-01-01' and '2004-12-31' and E.department_id=D.department_id ;


select * from employees;

--요구사항.003.employees > 매니저 번호가 겹친다. 
--급여가 5000불 이상인 직원들은 담당 매니저가 누구? > manager_id
select distinct manager_id  -- null은 냅둔다.
from employees
where salary >= 5000;

--요구사항.004.tblInsa > 주민등록번호를 like로 적당히 잘 필터링해서 남자이면서 80년대생 찾으면 된다. 
--남자 직원 + 80년대생들의 직급은 뭡니까? > ssn + jikwi
select distinct jikwi
from tblInsa
where ssn LIKE '8%';


--요구사항.005.tblInsa > 수당 20만원 넘는 사람들 가져와서 그 사람들 지역이 어디있는 사람들이냐? 
--수당 20만원 넘는 직원들은 어디 삽니까? > sudang + city   

select distinct city
from tblInsa
where sudang > 200000 ;


select *
from tblInsa;
--요구사항.006.tblInsa > 연락처가 없는 직원들이 어느부서 사람들이냐? 3명중에 2명이 같은 부서다. 
--연락처가 아직 없는 직원은 어느 부서입니까? > null + buseo
select distinct buseo
from tblInsa
where tel is null;



--요구사항.001.employees
--직업이 어떤것들이 있는지 가져오시오. > job_id
select distinct job_id from employees;

--요구사항.002.employees
--고용일이 2002~2004년 사이인 직원들은 어느 부서에 근무합니까? > hire_date + department_id
select distinct department_id from employees where hire_date between '2002-01-01' and '2004-12-31';

--요구사항.003.employees
--급여가 5000불 이상인 직원들은 담당 매니저가 누구? > manager_id
select distinct manager_id from employees where salary >= 5000;

--요구사항.004.tblInsa
--남자 직원 + 80년대생들의 직급은 뭡니까? > ssn + jikwi
select distinct jikwi from tblInsa where ssn like '8%-1%';

--요구사항.005.tblInsa
--수당 20만원 넘는 직원들은 어디 삽니까? > sudang + city   
select distinct city from tblInsa where sudang >= 200000;
    
--요구사항.006.tblInsa
--연락처가 아직 없는 직원은 어느 부서입니까? > null + buseo
select distinct buseo from tblInsa where tel is null;
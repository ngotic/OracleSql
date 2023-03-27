/*
    ex08_aggregation_function.sql 
    
함수   > 독립적인 존재 오라클은 OOP가 아니다 그래서 함수라는 말을 쓴다.
메소드 > 객체가 소유한 함수 자바는 OOP임
    함수, Function 
    1. 내장형 함수(Built-in Function)
    2. 사용자 정의 함수(User Function)  > ANSI-SQL(X) , PL/SQL(O) 
    
    집계함수, Aggreegation Function
    1. count()
    2. sum()
    3. avg()
    4. max()
    5. min()
    
    1. count() : 개수를 세준다. 
    - 결과 테이블의 레코드 수를 반환한다. 
    - number count(컬럼명) 
    - null 레코드는 제외(***) > count(칼럼명)
                              count(*) null 포함
*/

select name from tblCountry; -- 이 결과셋 > 내코드 개수를 세고 싶다.
select count(name) from tblCountry; -- 이 결과셋 > 내코드 개수를 세고 싶다. > 반환값은 레코드 개수 - 14 > 이것도 테이블이다.
-- 1행 1열짜리 결과 테이블이다.

-- 'AS'에 속한 나라 갯수? > 총 4개의 나라가 있습니다. 
select count(name) from tblCountry where continent = 'AS';

select capital from tblCountry;            
select count(capital) from tblCountry;      

select population from tblCountry;         
select count(population) from tblCountry;      

-- tblCountry에 나라가 총 몇개? 14
select count(name) from tblCountry;
select count(capital) from tblCountry;
select count(population) from tblCountry;

select * from tblAddressBook; -- 데이터가 겁나 많으면 비어있는거 알아내기 어렵다. 

select count(*) from tblCountry;  --null과 상관없이 테이블의 행 갯수 정확하게 파악~ 
select * from tblCountry;         


-- 모든 직원수? 
-- 연락처가 있는 직원수?
-- 연락처가 없는 직원수?
select count(*) from tblInsa;      -- 모든 직원수?
select count(tel) from tblInsa; -- null 값은 빼고 개수를 센다. 연락처가 있는 직원수?
select count(*) - count(tel) from tblInsa; -- 데이터빼기 데이터 null인 개수가 나온다. 연락처가 없는 직원수?

select count(*) from tblInsa where tel is not null; -- 57명
select count(*) from tblInsa where tel is null;     -- 3명

-- tblInsa. 어떤 부서들이 있나요?
select distinct buseo from tblInsa; -- 7개의 부서가 있다.

-- tblInsa. 부서가 몇개 있나요?
select count(distinct buseo) from tblInsa; -- 중복없이 종류의 개수 구할 때


-- tblComedian. 남자수?, 여자수?
select * from tblComedian;

select count(*) from tblComedian where gender = 'm';
select count(*) from tblComedian where gender = 'f';

-- *** 자주 사용되는 패턴
select 
    case
        when gender = 'm' then 'A' -- ★ 조건을 만족못해서 아무도 못찾으면 null을 반환한다.
    end -- 이 자체가 칼럼
from tblComedian;

select 
    count(case
        when gender = 'm' then 'A' -- ★ 조건을 만족못해서 아무도 못찾으면 null을 반환한다.
    end) -- 이 자체가 칼럼
from tblComedian;

 -- 이 자체가 칼럼
 -- ★ 조건을 만족못해서 아무도 못찾으면 null을 반환한다.
select 
    count(*) as 전체인원수,
    count(case
        when gender = 'm' then 'A' 
    end) as 남자인원수,
    count(case 
        when gender ='f' then 'B'
    end)  as 여자인원수 -- null을 빼주려고 고의적으로 하는 짓이다.   
from tblComedian;

-- tblInsa. 부서별 인원수 

-- 기획부 몇명? 총무부 몇명? 개발부 몇명? 
select count(*) from tblInsa where buseo = '기획부'; -- 7
select count(*) from tblInsa where buseo = '총무부'; -- 7
select count(*) from tblInsa where buseo = '개발부'; -- 14


--select 
--    case
--        when buseo = '기획부' then 1
--        when buseo = '총무부' then 1 > 따로 써야지....
--    end
--from tblInsa; 이건 엉터리다. 

select   -- 자주 쓰는 패턴이다.
    count(case
        when buseo = '기획부' then 1
    end) as 기획부,
    count(case
        when buseo = '총무부' then 1
    end) as 총무부,
    count(case
        when buseo = '개발부' then 1
    end) as 개발부 
from tblInsa;

-- 단일컬럼 or *
select count(name, buseo) from tblInsa; 

/*
    2. sum()
    - 해당 칼럼의 합을 구한다.
    - number sum(컬럼명)
    - 숫자형만 적용 가능 
        
*/

select * from tblComedian;
select sum(height), sum(weight) from tblComedian;
-- select sum(first) from tblComedian; -- 숫자가 아닌거 넣으면 에러난다. 
-- ORA-01722: invalid number
-- 01722. 00000 -  "invalid number"

select 
    sum(basicpay) as "지출 급여 합",
    sum(sudang) as "지출 수당 합",
    sum(basicpay) + sum(sudang) as "총 지출",
    sum(basicpay + sudang) as "총 지출" -- 칼럼 더한거도 합 나오게 할 수 있다. 
from tblInsa;

/*
    3. avg()
    -  해당 컬럼의 평균값을 구한다.
    - number avg(컬럼명)
    - 숫자형만 적용 가능 
*/


select sum(basicpay) / 60 from tblInsa;       -- 1556526
select sum(basicpay) / count(*) from tblInsa; -- 1556526

select avg(basicpay) from tblInsa;       -- 1556526

-- 조심할 포인트 
-- 평균 인구수?
select 
    avg(population),         -- null 포함x분모 집계                 - 15588
    sum(population)/count(*), -- null 포함 분모 포함한 집계          - 14475
    sum(population)/count(population) -- null 포함 분모 포함한 집계  - 15588
from tblCountry;
-- avg는 null 칼럼 제외된다.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

select 
    count(*),           -- 14
    count(population)   -- 13
from tblCountry;

-- 회사 > 성과급 지급 > 성과급 출처 > 1팀 공로~
-- 1. 균등 지급: 총자급액 / 모든 직원수 = sum() / count(*) 
-- 2. 차등 지급: 총지급액 / 참여 직원수 = sum() / count(참여인원수) = avg()
-- 모직 vs 참직

/*
    4. max()
    - object max(칼럼명)
    - 최댓값 반환
    
    5. min()
    - object min(칼럼명)
    - 최솟값 반환
    
    - 숫자형, 문자형, 날짜형 모두 적용 

*/

select max(height),min(height) from tblComedian; -- 숫자형
select max(name), min(name) from tblInsa;         -- 문자형
select max(ibsadate), min(ibsadate) from tblInsa; --날짜형

select
    count(*) as "직원수",
    sum(basicpay) as "총급여 합",
    avg(basicpay) as "평균급여",
    max(basicpay) as "최고 급여",
    min(basicpay) as "최저 급여"
from tblInsa;


-- 집계 함수 사용 주의점!!!!

-- 집계함수 > sum(), avg(), max(), min()

-- 집계함수 > count()


-- 1. tblCountry. 아시아(AS)와 유럽(EU)에 속한 나라의 개수?? -> 7개
select * from tblCountry ;

select count(NAME) 
from tblCountry
where continent = 'AS' or continent = 'EU';

-- 2. 인구수가 7000 ~ 20000 사이인 나라의 개수?? -> 2개
select count(NAME) 
from tblCountry
where population between 7000 and 20000;


-- 3. hr.employees. job_id > 'IT_PROG' 중에서 급여가 5000불이 넘는 직원이 몇명? -> 2명
select * from employees;

select count(employee_id) 
from employees
where job_id = 'IT_PROG' and salary > 5000;


-- 4. tblInsa. tel. 010을 안쓰는 사람은 몇명?(연락처가 없는 사람은 제외) -> 42명
select count(*)
from tblInsa
where tel NOT LIKE '010-%' and tel is not null;

select count(*), count(tel), count(*) - count(tel)
from tblInsa;


select * from tblInsa;
-- 5. city. 서울, 경기, 인천 -> 그 외의 지역 인원수? -> 18명
select count(city)
from tblInsa
where city NOT IN('서울', '경기', '인천') and city is not null; -- 그러면 혹시 모르니까 집계 함수 사용 때 늘 and 칼럼명 is not null을 붙여야 하는 걸까?
-- 6. 여름태생(7~9월) + 여자 직원 총 몇명? -> 7명
select count(NAME)
from tblInsa
where SUBSTR(ssn,4,1) IN ('7','8','9') and ssn LIKE '%-2%';
select SUBSTR('1234567',4,1) 
from dual;

-- 7. 개발부 + 직위별 인원수? -> 부장 ?명, 과장 ?명, 대리 ?명, 사원 ?명
select 
    count(
    case 
        when jikwi = '부장' then 1
    end) as "부장",
    count(
    case 
        when jikwi = '과장' then 1
    end) as "과장",
    count(
    case 
        when jikwi = '대리' then 1
    end) as "대리",
    count(
    case 
        when jikwi = '부장' then 1
    end) as "사원"
from tblInsa
where  buseo ='개발부';


--sum()
--1. 유럽과 아프리카에 속한 나라의 인구 수 합? tblCountry > 14,198
select sum(POPULATION)
from  tblCountry
where continent='EU' or continent='AF';


--2. 매니저(108)이 관리하고 있는 직원들의 급여 총합? hr.employees > 39,600
select sum(salary)
from   employees
where  manager_id = 108;

--3. 직업(ST_CLERK, SH_CLERK)을 가지는 직원들의 급여 합? hr.employees > 120,000
select sum(salary)
from employees
where job_id = 'ST_CLERK' or job_id = 'SH_CLERK' ; -- or로 퉁쳐버리면 되긴함

--4. 서울에 있는 직원들의 급여 합(급여 + 수당)? tblInsa > 33,812,400
select sum(basicpay + sudang)
from tblInsa
where city ='서울';


select * from tblInsa;

--5. 장급(부장+과장)들의 급여 합? tblInsa > 36,289,000 > 누구나 누구 or의 활용
select sum(basicpay)
from tblInsa
where jikwi = '부장' or jikwi = '과장';

--avg()
--1. 아시아에 속한 국가의 평균 인구수? tblCountry > 39,165
select 
avg(population)
from tblCountry
where continent='AS';

--2. 이름(first_name)에 'AN'이 포함된 직원들의 평균 급여?(대소문자 구분없이) hr.employees > 6,270.4
select avg(salary)
from employees
where upper(first_name) LIKE '%AN%';

-- select upper(first_name), lower(first_name) from employees; -- upper든 lower든

--3. 장급(부장+과장)의 평균 급여? tblInsa > 2,419,266.66
select avg(basicpay)
from  tblInsa
where jikwi='부장' or jikwi='과장';


--4. 사원급(대리+사원)의 평균 급여? tblInsa > 1,268,946.66 > 합에서 누구 더하기 누구면 or이다. 
select avg(basicpay)
from  tblInsa
where jikwi='대리' or jikwi='사원';


--5. 장급(부장,과장)의 평균 급여와 사원급(대리,사원)의 평균 급여의 차액? tblInsa > 1,150,320 ★
select -- 칼럼 칼럼은 case end 라는 것을 알자고 
    avg(
    CASE
        when jikwi IN ('부장', '과장') then basicpay
    end)
    -
    avg(
    CASE
        when jikwi IN ('대리', '사원') then basicpay
    end) as 차액
    from tblInsa;
-- 이것 


--max(),min()
--1. 면적이 가장 넓은 나라의 면적은? tblCountry > 959
select max(AREA)
from tblCountry;


--2. 급여(급여+수당)가 가장 적은 직원은 총 얼마를 받고 있는가? tblInsa > 988,000
select min(basicpay+sudang)
from tblInsa;



select TO_DATE('201501','YYYYMM') from dual;
select extract (day from to_date('2020/10/21'))
from dual;

-- 집계 함수 사용 주의점
select count(*) from tblInsa;
select name from tblInsa; 

select name, count(*) from tblInsa;
select name from tblInsa;
-- ORA-00937: not a single-group group function 
-- 컬럼 리스트에 집계함수와 일반 컬럼은 동시에 사용할 수 없다. > 안됨
-- 집계 함수 사용 주의점 


select to_char(to_date('2015.01.01 10','YYYY.MM.DD HH24') + 1/24/(60/10), 'YYYY.MM.DD HH24:MI:SS') from dual;


-- 요구 사항] 평균 급여보다 더 많이 많는 직원을 가져오시오 
select avg(basicpay) from tblInsa; 

select * from tblInsa where basicpay >= avg(basicpay); -- where절에는 집계함수 불가능
select * from tblInsa where basicpay >= (select avg(basicpay) from tblInsa); -- 이건 가능 > 서브쿼리 > 단 스칼라



select *                         --3.
from tblInsa                     --1.
where basicpay >= avg(basicpay); --2. > where절은 자바로 치면 반복문이다. 이걸 만나면 오라클은 
                                 --   from절 테이블에서 가져온 원본 데이터를 하나씩 접근해서 이 질문을 물어본다. 
                                 --   where절은 개인을 건드리는 조건이다.
                                 --   개개인을 다루는 영역이 where절이니까 집합으로 여러개 다룰 땐 뻑이나는 것이다. 




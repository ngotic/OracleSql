/*


    ex5_where.sql
    
                                                  - select문
    [ WITH <Sub Query> ]                          - with절 
    SELECT column_list                            - select절    // : 이 두개부터 시작
    FROM table_name                               - from절
    [ WHERE search_condition]                     - where절
    [ GROUP BY group_by_expression]               - group by절
    { HAVING search_condition]                    - having절
    [ ORDER BY order_expression [ASC | DESC] ]    - order by절
    
    select 칼럼리스트         --3. 컬럼 지정
    from 테이블               --1. 테이블 지정 
    where 조건;              --2. 조건 지정
    
    where 절
    - 레코드를 검색한다. 
    - 원하는 행만 추출하는 역할 > 결과셋 반환 
    
*/

-- 컬럼(5), 레코드(14)
select *
    from tblCountry
        where name = '대한민국'; -- 대한민국만 가져올 조건;
        -- 이러면 모든 row에 대해서 물어본다 yes or no인데 no는 죄다 버린다. 
        
select *                        -- 열을 걸러준다.
    from tblCountry             -- 1.
        where continent = 'AS'; -- 조건절 > 행을 걸러준다.
    
    
select * 
    from tblInsa
    where basicpay > 2000000;  -- 19행
    
    
select * 
    from tblInsa
    where basicpay <= 2000000;  -- 41행
        
        
select *                        -- 14행
    from tblInsa
        where buseo = '개발부'; 
        
select *                        -- 46행
    from tblInsa
        where buseo <> '개발부'; -- 개발부 빼고 나머지 녀석들
        
select *                        
    from tblInsa
        where buseo = '개발부' and jikwi = '부장'; --&& 를 쓰면 에러다
        -- where buseo = '개발부' && jikwi = '부장'; --&& 를 쓰면 에러다

select * 
    from tblInsa 
        where city = '서울' or city = '경기';
        
select * 
    from tblInsa 
        where not buseo = '개발부';              -- 개발부가 아니다. 
            
-- tblComedian
-- 1. 몸무게가 60kg 이상이고, 키가 170cm 미만인 사람을 가져오시오. 3명
desc tblComedian;
select * 
from tblComedian
where HEIGHT < 170 and WEIGHT >= 60;
--select 
-- 2. 몸무게가 70kg 이하인 여자만 가져오세요. 1명 
select *
from tblComedian
where WEIGHT <= 70 and GENDER ='f';     -- sql은 대소문자를 가리지 않지만 데이터는 대소문자를 가린다.`

-- tblInsa
-- 3. 부서가 '개발부'이고, 급여를 150만원 이상 받는 직원을 가져오시오. 4명
desc tblInsa;
select * from tblInsa;
select *
from tblInsa
where BUSEO='개발부' and BASICPAY >= 1500000;

-- 4. 급여(basicpay) + 수당(sudang)을 합한 금액이 200만원 이상 받는 직원을 가져오시오. 26명      
select *
from  tblInsa
where  BASICPAY+SUDANG >= 2000000; -- 이것은 칼럼들 사이의 합, -- 집계함수는 >>> row 사이들에서의 합이다. 


/*
    between 
    - where 절에서 사용 > 조건으로 사용
    - 컬럼명 between 최솟값 and 최댓값
    - 범위 조건 
    - 가독성(***)
    - 최솟값, 최댓값 > 포함 
*/

-- 이걸 할 수 있는게 between 이다. 
select * from tblComedian
    where height >= 170 and height <= 180;
    
-- ↕ 위, 아래 두 문장이 동일하다. > 가독성 때문에 쓴다. 

select * from tblComedian
    where height between 170 and 180;

select * from tblComedian
    where 180 >= height and 170 <= height;

select * from tblComedian 
    where height between 172 and 178;
    
-- 비교연산 
-- 1. 숫자형
select * from tblInsa where basicpay >= 1500000 and basicpay <= 2000000;
select * from tblInsa where basicpay between 1500000 and 2000000;

-- 2. 문자형
select * from tblInsa where name >= '박'; -- sql는 이렇게 문자코드 비교가 바로 된다. 너무나 편하다.
select * from tblInsa where name >= '박' and name <= '유';
select * from tblInsa where name between '박' and '유';

-- 3. 날짜시간형
desc tblIns;

select * from tblInsa where ibsadate >= '2000-01-01';   -- 이렇게 연도 비교가 가능하다.
-- 2000년 이후에 입사한 직원들 
select * from tblInsa where ibsadate >= '2001-01-01' and ibsadate <='2005-12-31';

select * from tblInsa where ibsadate between '2000-01-01' and '2000-12-31';

/*

    in
    - where 절에서 사용 > 조건을 ㅗ사용
    - 열거형 조건
    - 컬럼명 in ( 값, 값, 값..)
    - 가독성 
    
*/

-- 홍보부 or 개발부
select * from tblInsa where buseo = '홍보부' or buseo = '개발부' or buseo = '총무부'; -- 
select * from tblInsa where buseo in ('홍보부', '개발부', '총무부');

select * from tblInsa
    where jikwi in ('과장','부장') and city in ('서울', '인천')
    and basicpay between 2500000 and 3000000;

-- between, in > 부정적 평가한다 대체로, 근데 절대적인 것은 없다. 유연하게 판단해야하는 상황도 있는데 자기 경험으로 판단 x 
-- 적재적소에 써야 한다. 
/*
    like
    - where절에서 사용 > 조건으로 사용
    - 패턴 비교 
    - 컬럼명 like '패턴 문자열'
    - 정규 표현식 초간단 버전 
    
    패턴 문자열 구성요소 
    1. _: 임의의 문자 1개 (.)
    2. %: 임의의 문자 N개 0~무한대 (.*)
    
*/

select name from tblInsa;

-- 김OO
select name from tblInsa where name like '김__';  -- 잘 찾는다. 
select name from tblInsa where name like '김_';   -- 언더바를 하나만 쓰면 못찾는다. 
select name from tblInsa where name like '__수';   -- 언더바를 하나만 쓰면 못찾는다. 
select name from tblInsa where name like '_길_';   -- 언더바를 하나만 쓰면 못찾는다. 

select name from tblInsa where name like '김%';

select * from tblAddressBook;

select * from tblAddressBook
where address like '서울특별시%';

select * from tblAddressBook
where address like '%동대문구%';


select * from tblAddressBook where name like '이%';
select * from tblAddressBook where name like '%이';
select * from tblAddressBook where name like '%이%'; -- 이라는 글자가 포함이 되어 있으면 다 찾는다. 

-- 771212-1022432 > SSN은 주민번호다. 
-- 여직원만
select * from tblInsa; 
select * from tblInsa where ssn like '______-2______';
select * from tblInsa where ssn like '%-2%'; -- 이렇게 해도 나오긴 한다.

/*
    RDBMS에서의 null 
    - 자바의 null 유사
    - 컬럼값(셀)이 비어있는 상태 
    - null 상수 제공
    - 대부분의 언어는 null은 연산의 대상이 될 수 없다.(***********)
    < 어떤 언어는 null==null 이렇게 되긴함 >
    
    10 + 20 = 30
    10 + null = ? 대상이 없다. > 결과는 null
    
    null 조건 
    - where절에서 사용
    
    
*/

-- 인구수가 미기재된 나라? 
select * from tblCountry; -- null은 실상은 아무것도 없다. > 선택적으로 값을 안넣어도 되는 경우에는 미입력 상태인데 이 때 null을 대체로 넣는다. 


select * from tblCountry where population = null;  -- X
select * from tblCountry where population is null; 


select * from tblCountry where population <> null; -- X
select * from tblCountry where population is null;
select * from tblCountry where population is not null; -- 선호도 높음(가독성) 


select * from tblTodo;

select * from tblTodo where completedate is null; -- 선호도 높음(가독성)

-- 도서관 > 대여 테이블(속성: 대여날짜, 반납날짜 )
-- 아직 반납을 안한 사람은?

-- 아직 반납을 안한 사람은?
select * from 도서대여 where 반납날짜 is null;

-- 반납이 완료된 사람은?
select * from 도서대여 where 반납날짜 is not null;



-- 요구사항.001.tblCountry
-- 모든 행과 모든 컬럼을 가져오시오.
select * from tblCountry;


-- 요구사항.002.tblCountry
-- 국가명과 수도명을 가져오시오.
desc tblCountry;
select name, capital from tblCountry;


-- 요구사항.003.tblCountry
-- 아래와 같이 가져오시오
-- [국가명]    [수도명]   [인구수]   [면적]    [대륙] <- 컬럼명
-- 대한민국   서울        4403       101       AS     <- 데이터
-- 이 문제의 의도는 Alias를 붙이라는 얘기다. 실제로 국가 이름이 들어간 column 이름이 들어간 것은 name이다. 
select name "국가명", 
       capital "수도명",
       population "인구수",
       area "면적",
       continent "대륙"
from tblCountry;



--요구사항.004.tblCountry
--아래와 같이 가져오시오
-- [국가정보]                                  <- 컬럼명
-- 국가명: 대한민국, 수도명: 서울, 인구수: 4403   <- 데이터 : 하나의 문자열이다. 컬럼컬럼컬럼컬럼을 더하기 해봐라는 이야기. || 
select '국가명: ' || name || ', 수도명: ' || capital|| ', 인구수: ' || population as "국가정보"  
from tblCountry;

--요구사항.005
--아래와 같이 가져오시오.employees
-- [이름]                [이메일]            [연락처]          [급여]
-- Steven King           SKING@gmail.com   515.123.4567      $24000
desc employees;

-- ♣ '글자' >>>>>> 상수
-- "이거" alias에는 들감

select * from employees;
select first_name || last_name as "이름",  EMAIL "이메일", PHONE_NUMBER "연락처", '$'||SALARY "급여"
from employees;


--요구사항.006.tblCountry
--면적(area)이 100이하인 국가의 이름과 면적을 가져오시오.
select name "국가명", area "면적"
from tblCountry
where area <= 100; -- 9개


--요구사항.007.tblCountry
--아시아와 유럽 대륙에 속한 나라를 가져오시오.
-- select 
desc tblCountry;
select * from tblCountry;
--
--CAPITAL             VARCHAR2(30) 
--POPULATION          NUMBER       
--CONTINENT           VARCHAR2(2)  
--AREA                NUMBER  
select name
from tblCountry
where CONTINENT='AS' or CONTINENT='EU'; -- 7개 


--요구사항.008.employees
--직업(job_id)이 프로그래머(it_prog)인 직원의 이름(풀네임)과 연락처 가져오시오.
select * from employees;

select first_name || ' ' || last_name "이름", phone_number "연락처"
from employees
where job_id='IT_PROG';


--요구사항.009.employees > 2개
--last_name이 'Grant'인 직원의 이름, 연락처, 고용날짜를 가져오시오.
select first_name || ' ' || last_name "이름", phone_number "연락처", hire_date "고용날짜"
from employees
where last_name = 'Grant';

--요구사항.010.employees > 8개
--특정 매니저(manager_id: 120)이 관리하는 직원의 이름, 급여, 연락처를 가져오시오.
select first_name || ' ' || last_name "이름",  '$' || SALARY "급여" , phone_number "연락처"
from employees
where manager_id = 120;


--요구사항.011.employees > 45명
--특정 부서(60, 80, 100)에 속한 직원들의 이름, 연락처, 이메일, 부서ID 가져오시오.
select  first_name || ' ' || last_name "이름", phone_number "연락처", email "이메일", DEPARTMENT_ID "부서ID"
from employees
where department_id IN ( 60, 80, 100) ;


select *
from tblInsa;

--요구사항.012.tblInsa > 7명
--기획부 직원들 가져오시오.
select * 
from tblInsa
where buseo='기획부';

--요구사항.013.tblInsa
--서울에 있는 직원들 중 직위가 부장인 사람의 이름, 직위, 전화번호 가져오시오.
select name "이름", jikwi "직위", tel "전화번호"
from tblInsa
where city ='서울' and jikwi='부장' ;

--요구사항.014.tblInsa > 9
--기본급여 + 수당 합쳐서 150만원 이상인 직원 중 서울에 직원만 가져오시오.
select *
from  tblInsa
where (basicpay + sudang) >= 1500000 and city ='서울' ;

--요구사항.015.tblInsa > 28
--수당이 15만원 이하인 직원 중 직위가 사원, 대리만 가져오시오.
select *
from tblInsa
where sudang <= 150000 and jikwi IN ( '사원', '대리' );

--요구사항.016.tblInsa > 3
--수당을 제외한 기본 연봉이 2천만원 이상, 서울, 직위 과장(부장)만 가져오시오.
select *
from tblInsa
where basicpay*12 >= 20000000 and city ='서울' and jikwi IN ('부장','과장') ;


--요구사항.017.tblCountry > 4
--국가명 'O국'인 나라를 가져오시오.
select * 
from tblCountry
where name Like '%국';


--요구사항.018.employees
--연락처가 515로 시작하는 직원들 가져오시오.
select * 
from employees
where PHONE_NUMBER Like '515%';
    

--요구사항.019.employees > 35
--직업 ID가 SA로 시작하는 직원들 가져오시오.
select * 
from employees
where JOB_ID Like 'SA%';

    

--요구사항.020.employees
--first_name에 'de'가 들어간 직원들 가져오시오.
select * 
from employees
where FIRST_NAME Like '%de%';


--요구사항.021.tblInsa
--남자 직원만 가져오시오.
select * 
from tblInsa
where SSN LIKE '%-1%';

-- 요구사항.022.tblInsa
--여자 직원만 가져오시오.   
select * 
from tblInsa
where SSN LIKE '%-2%';


--요구사항.023.tblInsa
--여름에(7,8,9월) 태어난 직원들 가져오시오.
select * 
from  tblInsa
where SUBSTR(SSN,3,2) IN ('07','08','09');



--요구사항.024.tblInsa
--서울, 인천에 사는 김씨만 가져오시오.    
select * 
from  tblInsa
where city IN ('인천', '서울') and name LIKE '김%';


--요구사항.025.tblInsa
--영업부/총무부/개발부 직원 중 사원급(사원/대리) 중에 010을 사용하는 직원들을 가져오시오.
select * 
from  tblInsa
where buseo IN ('영업부', '총무부', '개발부') and jikwi IN ('사원', '대리') and tel LIKE '010-%';


--요구사항.026.tblInsa
--서울/인천/경기에 살고 입사일이 1998~2000년 사이인 직원들을 가져오시오.
select * 
from  tblInsa
where ibsadate >= '1998-01-01' and ibsadate <='2000-12-31' and city IN ('인천', '서울', '경기');
 
--요구사항.027.employees > 1
--부서가 아직 배정 안된 직원들을 가져오시오. (department_id가 없는 직원)
select * 
from  employees
where department_id is null;



-- 요구사항.001.tblCountry
-- 모든 행과 모든 컬럼을 가져오시오.
select * from tblCountry;

-- 요구사항.002.tblCountry
-- 국가명과 수도명을 가져오시오.
select name, capital from tblCountry;

-- 요구사항.003.tblCountry
-- 아래와 같이 가져오시오. 모든 국가
-- [국가명]    [수도명]   [인구수]   [면적]    [대륙]   <- 컬럼명
-- 대한민국   서울        4403       101       AS     <- 데이터
select
    name as "[국가명]",
    capital as "[수도명]",
    population as "[인구수]",
    area as "[면적]",
    continent as "[대륙]"
from tblCountry;

--요구사항.004.tblCountry
--아래와 같이 가져오시오
-- [국가정보]                                   <- 컬럼명
-- 국가명: 대한민국, 수도명: 서울, 인구수: 4403   <- 데이터
select
    '국가명: ' || name || ', 수도명: ' || capital || ', 인구수: ' || population as "[국가정보]"
from tblCountry;


--요구사항.005
--아래와 같이 가져오시오.employees
-- [이름]               [이메일]                 [연락처]            [급여]
-- Steven King           SKING@gmail.com           515.123.4567         $24000
select 
    first_name || ' ' || last_name as "[이름]",
    email || '@gmail.com' as "[이메일]",
    phone_number as "[연락처]",
    '$' || salary as "[급여]"
from employees;


--요구사항.006.tblCountry
--면적(area)이 100이하인 국가의 이름과 면적을 가져오시오.
select name, area from tblCountry where area <= 100;

--요구사항.007.tblCountry
--아시아와 유럽 대륙에 속한 나라를 가져오시오.
select * from tblCountry where continent in ('AS', 'EU');


--요구사항.008.employees
--직업(job_id)이 프로그래머(it_prog)인 직원의 이름(풀네임)과 연락처 가져오시오.
select first_name || ' ' || last_name as name, phone_number from employees where job_id = 'IT_PROG';


--요구사항.009.employees
--last_name이 'Grant'인 직원의 이름, 연락처, 고용날짜를 가져오시오.
select first_name, last_name, phone_number, hire_date from employees where last_name = 'Grant';



--요구사항.010.employees
--특정 매니저(manager_id: 120)이 관리하는 직원의 이름, 급여, 연락처를 가져오시오.
select first_name, last_name, salary, phone_number from employees where manager_id = 120;


--요구사항.011.employees
--특정 부서(60, 80, 100)에 속한 직원들의 이름, 연락처, 이메일, 부서ID 가져오시오.
select first_name, last_name, phone_number, email, department_id from employees where department_id in (60, 80, 100);


--요구사항.012.tblInsa
--기획부 직원들 가져오시오.
select * from tblInsa where buseo = '기획부';


--요구사항.013.tblInsa
--서울에 있는 직원들 중 직위가 부장인 사람의 이름, 직위, 전화번호 가져오시오.
select name, jikwi, tel from tblInsa where jikwi = '부장' and city='서울';


--요구사항.014.tblInsa
--기본급여 + 수당 합쳐서 150만원 이상인 직원 중 서울에 직원만 가져오시오.
select * from tblInsa where basicpay + sudang >= 1500000 and city = '서울';


--요구사항.015.tblInsa
--수당이 15만원 이하인 직원 중 직위가 사원, 대리만 가져오시오.
select * from tblInsa where sudang <= 150000 and jikwi in ('사원', '대리');



--요구사항.016.tblInsa
--수당을 제외한 기본 연봉이 2천만원 이상, 서울, 직위 과장(부장)만 가져오시오.
select * from tblInsa where basicpay * 12 >= 20000000 and city = '서울' and jikwi in ('과장', '부장');



--요구사항.017.tblCountry
--국가명 'O국'인 나라를 가져오시오.
select * from tblCountry where name like '_국';



--요구사항.018.employees
--연락처가 515로 시작하는 직원들 가져오시오.
select * from employees where phone_number like '515%';

    

--요구사항.019.employees
--직업 ID가 SA로 시작하는 직원들 가져오시오.
select * from employees where job_id like 'SA%';

    

--요구사항.020.employees
--first_name에 'de'가 들어간 직원들 가져오시오.
select * from employees where first_name like '%de%';


--요구사항.021.tblInsa
--남자 직원만 가져오시오.
select * from tblInsa where ssn like '%-1%';


-- 요구사항.022.tblInsa
--여자 직원만 가져오시오.   
select * from tblInsa where ssn like '%-2%';


--요구사항.023.tblInsa
--여름에(7,8,9월) 태어난 직원들 가져오시오.
select * from tblInsa where ssn like '__07%' or  ssn like '__08%' or  ssn like '__09%'; 


--요구사항.024.tblInsa
--서울, 인천에 사는 김씨만 가져오시오.    
select * from tblInsa where city in ('서울', '인천') and name like '김%';


--요구사항.025.tblInsa
--영업부/총무부/개발부 직원 중 사원급(사원/대리) 중에 010을 사용하는 직원들을 가져오시오.
select * from tblInsa where buseo in ('영업부', '총무부', '개발부') and jikwi in ('사원', '대리') and tel like '010%';



--요구사항.026.tblInsa
--서울/인천/경기에 살고 입사일이 1998~2000년 사이인 직원들을 가져오시오.
select * from tblInsa where city in ('서울', '인천', '경기') and ibsadate between '1998-01-01' and '2000-12-31'; -- 날짜는 between도 된다. 


--요구사항.027.employees
--부서가 아직 배정 안된 직원들을 가져오시오. (department_id가 없는 직원)
select * from employees where department_id is null;
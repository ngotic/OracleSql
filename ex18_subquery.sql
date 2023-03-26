/* 
SQL > 시퀄(sequel) 옛날엔 이렇게 부르기도 했지만 
항공사 상호명과 같아서 sql이라고 바꿈 
ex18_subquery.sql 

Main Query
- 여태까지의 SQL
- 일반적인 SQL 
- 하나의 문장안에 하나의 select(insert, update, delete)로 구성된 쿼리를 메인쿼리라고 한다.

Sub Query 
- 하나의 문장(select, insert, update, delete)안에 또 다른 문장(select)이 들어있는 쿼리
- 하나의 select문안에 들어있는 또 다른 select문
- 삽입 위치 > 거의 대다수의 절(select절, from절, where절,,<- 많이 쓴다. ::: 별로 안쓴다. -> having절, order by절) 

*/

select * from tblCountry;

select max(population) from tblCountry;

-- 장점
-- 1. 2개의 sql> 1개의 sql로 만든다. 
-- 2. 변화에 강하다.( 인구수 변동) > 개발자 편의성 향상 
select name from tblCountry where population in (select max(population) from tblCountry) ;

select name from tblCountry where population in (select avg(population) from tblCountry) ;

select max(weight) from tblComedian;
select * from tblInsa where basicpay = 2650000;

select * from tblInsa where basicpay = (select max(basicpay) from tblInsa);

-- tblInsa. 막내지원? 이정석 05/09/26
select * from tblInsa where ibsadate = (select max(ibsadate) from tblInsa);

-- tblInsa. 왕고참? 김인수 95/02/23 
select * from tblInsa where ibsadate = (select min(ibsadate) from tblInsa);

-- 평균 급여보다 더 많이 받는 직원
select avg(basicpay) from tblInsa;
select * from tblInsa where basicpay >= (select avg(basicpay) from tblInsa);

-- tblInsa. '홍길동'보다 급여가 많은 직원?
select basicpay from tblInsa where name = '홍길동';

select * from tblInsa
    where basicpay >= (select basicpay from tblInsa where name ='홍길동') and name <> '홍길동';


-- 서브쿼리 삽입 위치

-- 1. 조건절
-- 2. 컬럼리스트
-- 3. from절 

-- 1. 조건절
-- : 비교 대상(비교값) 역할 > 값
-- : where절, having절, case문

-- a. 반환값이 1행 1열 > 단일값 반환 > 값 1개로 취급
-- b. 반환값이 N행 1열 > 다중값(같은 성질의 여러개의 데이터) 반환 > 값 N개로 취급 > 열거형 취금 > in 
-- c. 반환값이 1행 N열 > 다중값(서로 다른 성질의 여러개의 데이터) 반환 >
-- d. 반환값이 N행 N열 > 다중값 반환

-- a. 반환값이 1행 1열 > 단일값 반환 > 값 1개로 취급
select * from tblInsa 
    where basicpay >= (select avg(basicpay) from tblInsa);

-- b. 반환값이 N행 1열 > 다중값(같은 성질의 여러개의 데이터) 반환 > 값 N개로 취급

-- 급여가 260만원 이상 받는 직원이 근무하는 부서 직원 명단을 가져오시오. > 기획부 + 총무부 
-- select * from tblInsa
    -- where buseo = (select buseo from tblInsa where basicpay >= 2600000); > 안된다 비교가 잘못됨 > 1대 2로 비교가 안된다.
    -- where 부서 = 기획부/총무부
    -- ORA-01427: single-row subquery returns more than one row
    -- 레코드를 하나만 반환하는 서브쿼리 위치에 1개 이상의 row를 반환했다. 

select * from tblInsa
    -- where buseo = '기획부' or buseo ='총무부';
    -- where buseo in ('기획부', '총무부'); -- 같은 성질의 N개의 데이터 > 열거형
    where buseo IN (select buseo from tblInsa where basicpay >= 2600000);

-- '홍길동'과 같은 지역 + 같은 직위 > 소속 부서 직원 명단
select * from tblInsa where name = '홍길동'; -- 서울, 부장 
select * from tblInsa where city = '서울' and jikwi = '부장';


select * from tblInsa -- 칼럼이 다른 경우 이렇게 각각 서브쿼리로 날린 것 
    where city =(select city from tblInsa where name ='홍길동') 
        and jikwi = (select jikwi from tblInsa where name = '홍길동')
            and name <> '홍길동';

select * from tblInsa
    where buseo in ('기획부', '영업부'); -- city와 jikwi는 칼럼이 달라서 한번에 in으로 퉁칠수가 없다.
    
-- sub query도 중첩의 중첩의 중첩이 되는 경우도 있다.

select * from tblInsa 
    where buseo in (select buseo from tblInsa -- 칼럼이 다른 경우 이렇게 각각 서브쿼리로 날린 것 
        where city = (select city from tblInsa where name ='홍길동') 
            and jikwi = (select jikwi from tblInsa where name = '홍길동')
                and name <> '홍길동');
-- sub_query를 길게 길게 길게 해보자

-- 쿼리 중첩 중첩 중첩 중첩 중첩 되는 경우가 많다. 




-- c. 반환값히 1행 N열 > 다중값(서로 다른 성질의 여러개의 데이터) 반환 >
-- '홍길동'과 같은 지역 + 같은 직위 > 어떤 직원들? 
select city from tblInsa where name = '홍길동';
select jikwi from tblInsa where name = '홍길동';

select * from tblInsa where city ='서울' and jikwi = '부장';

select * from tblInsa 
    where city = (select city from tblInsa where name = '홍길동')
        and jikwi = (select jikwi from tblInsa where name = '홍길동');
        -- 이렇게 되면 하나는 1개로 다른 컬럼은 2개로 비교할 수 있다.
        
select * from tblInsa
    where (city, jikwi) = (select city, jikwi from tblInsa where name ='홍길동');
    -- 2대2 비교인데 대신이 서브쿼리 칼럼수랑 맞춰서 비교해야 한다.
    
select * from tblAddressBook; --기예주(성별, 나이, 직업, 키)
select * from tblAddressBook
    where (gender ,age, job, height) = (select gender, age, job, height
                                        from tblAddressBook where name = '기예주');
                                        -- 서브쿼리부터 한번 쿼리를 날려보고
                                        -- 이후에 전체 쿼리를 날려본다. 

select * from tblAddressBook;

select * from tblAddressBook
    where (gender ,hometown, job) = (select gender, hometown, job
                                        from tblAddressBook where name = '전예령');
                                -- n열이지만 반환값이 1개니까 이렇게 = 으로 쓴다. 

-- d. 반환값이 N행 N열 > 다중값 반환
-- 급여가 260만 이상 받는 직원과 > 같은 부서 + 같은 지역에는 모든 직원?
select * from tblInsa where basicpay >=2600000;

-- 서울 + 기획부 && 경남 + 총무부 

-- 레코드도 2줄 컬롬도 2개 
select city, buseo from tblInsa where basicpay >=2600000;


--select * from tblInsa
--    where (city, buseo) in (서브쿼리);
                         -- 레코드도 여러줄일 땐 in으로 쓴다.     
    
select * from tblInsa
    where (city, buseo) in (select city, buseo from tblInsa where basicpay >= 2600000);
 

select 
    buseo,
    avg(basicpay)
from tblInsa
    group by buseo                       
        having avg(basicpay) >= 1500000; -- 요거 숫자 대신에 서브쿼리를 쓴다. 
                                         -- 상수 들어가는 곳에 서브쿼리가 들어간다. 
                                         
select 
    buseo,
    avg(basicpay)
from tblInsa
    group by buseo                       
        having avg(basicpay) >= (select avg(basicpay) from tblInsa where buseo = '개발부');                                         
        
select 
    buseo,
    avg(basicpay)
from tblInsa
    group by buseo                       
        having avg(basicpay) >= (select avg(basicpay) from tblInsa where buseo = '총무부');        
        

-- 2. 컬럼리스트
-- : 단일 데이터(값) > 원자값 > 관계형 데이터베이스 > 표 > 속성(컬럼)의 값은 원자값이어야 한다.
-- a. 컬럼명
-- b. 상수
-- c. 연산
-- d. 함수 


-- 컬럼리스트에서 서브쿼리를 사용하기
-- -. 서브쿼리의 결과값이 반드시 1행 1열이어야 한다. > 스칼라 쿼리 
-- -  정적쿼리 > 모든 행에 동일한 값을 반환해주는 애 > 사용빈도가 적다. 
-- - 정적 서브쿼리를 잘 안쓸뿐이지 
-- 상관서브쿼리(상호서브쿼리)를  많이 쓴다. >>> 사용빈도 높다.


select 
    name as "컬럼",
    100 as "상수", -- 하나하나하나
    basicpay + 100 as "연산",
    length(name) as "함수"
from tblInsa;          -- 50개
select * from tblInsa; -- 50개

select 
    name,
    (select sysdate from dual),
    sysdate
from tblInsa;

select 
    name,
    (select basicpay from tblInsa where name ='홍길동') -- 고정으로 261만원만 반복된다. > 하나
from tblInsa;

select  -- 에러!!!
    name, buseo, basicpay,
    avg(basicpay) -- 동시에 컬럼으로 못쓴다. 왜냐면 얘네들은 성질이 다르다. 
from tblInsa;

-- 되게 하려면 서브쿼리로 상수화를 시킨다.     

select  -- 이러면 에러가 안난다.
    name, buseo, basicpay,
    (select round(avg(basicpay)) from tblInsa) as "평균급여"-- 하나의 단일 숫자만 가져오니 문제가 안된다.
from tblInsa;
-- -  정적쿼리 > 모든 행에 동일한 값을 반환해주는 애 > 사용빈도가 적다. 


-- 근데 왜 개인의 데이터랑 집합의 데이터를 하나의 레코드로 넣어??  >> 억지다. 

select avg(basicpay) from tblInsa;

select  -- 이러면 에러가 안난다.
    name, buseo, basicpay,                       -- ? 를 그냥 buseo라고 하면 구분을 못한다. 그래서 별명을 붙인다. 
    (select round(avg(basicpay)) from tblInsa where buseo = ? ) as "소속 부서 평균 급여"-- 조금은 더 개인적인 의미로 바꾼다. 
from tblInsa ;  -- 바깥의 메인쿼리의 컬럼을 안쪽으로 불러올 수 있어서 '서로 관계가 있는 쿼리다' 라고해서 상관서브쿼리다. 라고 하는 것 



-- 한 라인씩 출력할건데 이거 한라인씩을 a.컬럼명
select  -- 이러면 에러가 안난다.
    name, buseo, basicpay,                       -- ? 를 그냥 buseo라고 하면 구분을 못한다. 그래서 별명을 붙인다. 
    (select round(avg(basicpay)) from tblInsa b where a.buseo = b.buseo ) as "소속 부서 평균 급여"-- 조금은 더 개인적인 의미로 바꾼다. 
from tblInsa a;                        -- 부서 이름이 같은애들이 소속 부서 평균이 동일하다.
-- 오라클은 as를 붙여서 테이블 alias를 못한다. > 사실상 테이블이 두개이고 독립적인 두개의 테이블에서 연결된 셈이다. 

    
-- 식별자 정리
select * from tblInsa;

select * from hr.tblInsa; -- 계정명(스키마).테이블명 > 이렇게 적는게 fm이다. 

select tblInsa.name, tblInsa.buseo, tblInsa.jikwi from hr.tblInsa;

select hr.tblInsa.name, hr.tblInsa.buseo, hr.tblInsa.jikwi from hr.tblInsa; 
-- 원래 이게 찐 모습 
-- 계정명.테이믈명.칼럼명

select *, sysdate from tblInsa; -- 와일드 카드와 일반 컬럼표현이 동시에 못온다.
select *, name from tblInsa;    -- 와일드 카드와 일반 컬럼표현이 동시에 못온다.
-- 컬럼을 다 가져오고 현재시간을 가져오고 싶다. > 이게 안된다. 

select tblInsa.*, sysdate from tblInsa; --★ 와일드카드 앞에 테이블 이름을 명시적으로 적으면 된다.
-- 와일드카드(*)와 다른 칼럼을 동시에 가져오는 방법 > 테이블명.* 

-- 컬럼의 별칭 > 유효한 이름을 만들기 위해서 + 의미있게 짓는다. 
-- 테이블 별칭 > 최대한 줄여서 > 보통 알파벳 1글자로 적는다. > 컬럼 별칭과 다른 느낌이다. 

-- ♥ SQL의 별칭(ALIAS) > 별명(X), 개명(O)이다. > 이름을 뜯어 고치는 것이다. 

-- 에러가 난다. 호출순서 때문에 그렇다. 
select tblInsa.*, sysdate  -- 2. 이 단계에서는 tblInsa 인식을 못한다. > 대신 i로 접근 
from tblInsa i;            -- 1. > 응 난 tblInsa를 버리고 i로 이제 바꿀거야! 

-- ↓ 별명이 아니라 개명이다. 아래는 가능하다. 
select i.*, sysdate      
from tblInsa i;          

select 
    name, buseo, basicpay,    -- 여기 ?에 뭘 넣을까가 이슈 그래서 바깥쪽 from table의 부서를 가져다가 적는다.
    (select round(avg(basicpay)) from tblInsa where buseo=  ? ) as "소속 부서 평균 급여"
from tblInsa;

select  -- 이걸 상관서브쿼리라 붙이고 사용빈도는 높다. 
    name, buseo, basicpay,  
    (select round(avg(basicpay)) from tblInsa where buseo= i.buseo ) as "소속 부서 평균 급여"
from tblInsa i; -- 근데 이거 테이블을 그대로쓸까? 아니다. 아 그래서 i를 붙이고 이 바깥쪽 테이블을 가져다가 쓴다. 

select * from tblMen;
select * from tblWomen;

drop table tblMen;
drop table tblWomen;

CREATE TABLE tblmen
(
   name varchar2(30) primary key,
   age number not null,
   height number null,
   weight number null,
   couple varchar2(30) null
);

CREATE TABLE tblwomen
(
   name varchar2(30) primary key,
   age number not null,
   height number null,
   weight number null,
   couple varchar2(30) null
);

INSERT INTO tblmen VALUES ('홍길동', 25, 180, 70, '장도연');
INSERT INTO tblmen VALUES ('아무개', 22, 175, NULL, '이세영');
INSERT INTO tblmen VALUES ('하하하', 27, NULL, 80, NULL);
INSERT INTO tblmen VALUES ('무명씨', 21, 177, 72, NULL);
INSERT INTO tblmen VALUES ('유재석', 29, NULL, NULL, '김숙');
INSERT INTO tblmen VALUES ('박명수', 30, 170, NULL, '김지민');
INSERT INTO tblmen VALUES ('정준하', 31, 183, NULL, '신보라');
INSERT INTO tblmen VALUES ('정형돈', 28, NULL, 92, NULL);
INSERT INTO tblmen VALUES ('양세형', 22, 166, 55, '김민경');
INSERT INTO tblmen VALUES ('조세호', 24, 165, 58, '오나미');

INSERT INTO tblwomen VALUES ('박나래', 23, 150, 55, NULL);
INSERT INTO tblwomen VALUES ('장도연', 28, 177, 65, '홍길동');
INSERT INTO tblwomen VALUES ('김지민', 30, 160, NULL, '박명수');
INSERT INTO tblwomen VALUES ('김숙', 34, 158, NULL, '유재석');
INSERT INTO tblwomen VALUES ('오나미', 27, NULL, NULL, '조세호');
INSERT INTO tblwomen VALUES ('김민경', 22, 169, 88, '양세형');
INSERT INTO tblwomen VALUES ('홍현희', 20, 158, 75, NULL);
INSERT INTO tblwomen VALUES ('신보라', 26, 170, 60, '정준하');
INSERT INTO tblwomen VALUES ('이세영', 28, 163, NULL, '아무개');
INSERT INTO tblwomen VALUES ('신봉선', 27, 162, NULL, NULL);

COMMIT;

-- tblMen <- (연인) -> tblwomen;
select * from tblmen;
select * from tblwomen;

-- 남자 명단(이름, 나이) 출력 > 여자친구가 있으면 여자친구(이름, 나이)를 같이 출력하시오.
select 
    name, age, couple -- 여기 couple이라는 컬럼값이 있기에... 
from tblMen;

--> 상관서브쿼리!! 
select  -- 상관서브쿼리는 이렇게 이용한다. "바깥의 남자 테이블에서 여자 테이블을 가져온다."
    name, age, couple,
    (select age from tblwomen where name = tblmen.couple)
from tblmen; 

-- 3. from절
-- : 서브쿼리의 결과셋을 하나의 테이블이라고 생각하고, 또 다른 select를 실행~ 
-- : 구문을 단순화하기 위해서 사용한다.
select 
*
from ( select * from tblInsa ); 
-- 1. 쿼리를 하나 날리면 결과 테이블이 나온다. -> 이 테이블이 원본이라 생각한 것 

select 
    * -- 모든 컬럼(name, buseo, jikwi)
from (select name, buseo, jikwi from tblInsa); -- ★ 이넘의 컬럼에 의존한다. 이걸조심하자.

select -- 에러!!!!
    name, ssn
from ( select name, buseo, jikwi from tblInsa); -- 인라인뷰 서브쿼리에서 ssn을 안꺼내서 에러가 난다. 

select   -- 에러!!!
    name --여기 select절에서 별칭을 붙였는데 별칭은 이름을 바꾸는 것이다. 개명!! 
from ( select name as 이름, buseo, jikwi from tblInsa); -- 별칭 때문에 이거도 에러다.

select  
    이름 -- alias명으로 사용해야 한다!  
from ( select name as 이름, buseo, jikwi from tblInsa); -- 별칭 때문에 이거도 에러다.

select 
    name, length(name) -- length가 두번 호출된다. 물론 실행은 되지만 비효율적이기도 하다.
from(select name, length(name) as len from tblInsa);

select 
    name, len         -- 아! 그럼 별칭을 바로 가져다가 쓴다. 
from(select name, length(name) as len from tblInsa);

select 
    *
from ( select name, age, couple 
     ,(select age from tblwomen where name = tblmen.couple ) as age2
from tblMen) ; -- ORA-00918: column ambiguously defined : 컬럼이 모호하게 정의되어 있다.> 동일한 컬럼명이 두개가 있다. 
-- 서브쿼리나 join을 했을 때도 동일한 이름의 컬럼을 만들면 동일하게 이런 에러가 난다. 그래서 속성명을 바꾸면 된다.
-- join은 조심 ♣ 
-- 대부분의 툴은 이름을 똑같이 만들어줘도 걍 똑같이 표기를 하는데 developer는 다르게 해서 보여준다. 
-- 상관서브쿼리를 사용할 때 이걸 조심하자.
    
-- employees. 'Munich'에 위치한 부서에 소속된 직원 명단? 
select * from employees;   -- department_id 소석 부서 
select * from departments; -- location_id   위치 정보  
select * from locations;    

-- 뮌헨에 위치한 위치 아이디
select location_id from locations
    where city = 'Munich';
 
-- 부서정보의 위치 아이디가 위치정보에서 뮌헨이랑 같은거 
select * from departments
    where location_id = (select location_id from locations where city = 'Munich');


-- 고객의 department_id가 부서의 시에틀에 있는 위치 아이디와 같은 부서 
select * from employees
    where department_id in (select department_id from departments 
                            where location_id = (select location_id from locations
                                                  where city = 'Seattle'));


-- ★ with절을 잘 기억하자 with절끼리는 서로 참조가 가능하다. 
-- ★ with table1 as () select ~ 이런식으로 짜면 된다. 
-- ★ with table1 as () , table2 as () select ~ 이런식으로 짜면 된다. 

--WITH TEST AS (SELECT a.deptno AS deptno1 , b.emptno FORM a, b) ,
--     TEST2 AS (SELECT a.deptno AS deptno2, a.salaray , c.voc , c.label FROM a,c)
--SELECT * FROM TEST, TEST2 WHERE TEST.deptno1 = TEST2.deptno2;




-- ★ 컬럼에 집계함수, 일반 컬럼이랑 같이 못쓴다. 
-- ★ 가장 큰 것 테이블 조건에 맞는 걸로 찾고 정렬, 그리고 이걸 from절에 넣는 인라인뷰로 만들고 이걸 테이블로 참조해서 > rownum=1로 꺼내온다.

select * from employees;

select * from departments;

-- tblMen. tblWomen. 서로 짝이 있는 사람 중 / 남자와 여자의 정보를 모두 가져오시오. > select절
--    [남자]        [남자키]   [남자몸무게]     [여자]    [여자키]   [여자몸무게]
--    홍길동         180       70              장도연     177        65
--    아무개         175       null            이세영     163        null
--    ..
select * from tblmen;

select  -- 세칼럼 다 서브쿼리 쓰는 방법이 있긴한데... 너무 비효율적이다. 
    m.name "[남자]", m.height "[남자키]", m.weight "[남자몸무게]", w.name "[여자]", w.height  "[여자키]", w.weight "[여자몸무게]"
from tblmen m, tblwomen w
where m.couple = w.name;


-- tblAddressBook. 가장 많은 사람들이 가지고 있는 직업은 / 주로 어느 지역 태생(hometown)인가? > where절
--                           1. 직업을 찾고                     그 직업에서 hometown을 또 group by해서 

-- 1번-- 여기에 count(*)에 max를 걸면 job과 못쓴다.   -- 332라는 숫자를 찾았다. 
select max(count(*))  
from tblAddressBook 
group by job 
order by count(*); 


-- 여기에 count(*)에 max를 걸면 job과 못쓴다. 
select job 
from tblAddressBook group by job having count(*) = ( select max(count(*)) from tblAddressBook group by job);

select hometown, count(*) from tblAddressBook where job = (select job 
from tblAddressBook group by job having count(*) = ( select max(count(*)) from tblAddressBook group by job)) group by hometown;

-- tblAddressBook. 이메일 도메인들 중 / 평균 아이디 길이가 / 가장 긴  / 이메일 사이트의 도메인은 무엇인가? > group by + having
with test as (
select 
-- substr(email, instr(email, '@') + 1) as "도메인",
max(avg(length(substr(email, 1, instr(email, '@') - 1)))) as maxlen -- 평균아이디 길이 > length > avg > max로 단일값 뽑기
from tblAddressBook
group by substr(email, instr(email, '@') + 1) )

select substr(email, instr(email, '@') + 1) "도메인" -- , avg(length(substr(email, 1, instr(email, '@') - 1)))
from tblAddressBook
group by substr(email, instr(email, '@') + 1)  -- 이게 도메인 
having avg(length(substr(email, 1, instr(email, '@') - 1))) = ( select maxlen from test );


-- tblAddressBook. 평균 나이가 가장 많은 출신(hometown)들이 가지고 있는 직업 중 가장 많은 직업은? > where + group by + having
-- with절끼리 서로 참조가 가능하다. 
with test as ( -- 가장 많은 평균나이 리턴
select max(avg(age)) as maxAge
from tblAddressBook
group by hometown
), 

test2 as ( -- 가장 많은 평균나이 hometown 리턴
select hometown 
from tblAddressBook
group by hometown
having avg(age) = ( select maxAge from test )
)
select job
from ( -- 내림차순으로 광주에서 직업수를 정렬
select job, count(*)
from tblAddressBook
where hometown = (select hometown from test2)
group by job
order by count(*) desc -- 내림차순으로 정렬하고 이걸 from절 안으로 처리 
)
where rownum =1; -- 마지막에 rownum=1 처리를 한다. 

-- tblAddressBook. 남자 평균 나이보다 나이가 많은 서울 태생 + 직업을 가지고 있는 사람들을 가져오시오. > where절
select distinct job
from tblAddressBook where job ='취업준비생';

select *
from tblAddressBook 
where age > ( select avg(age) from tblAddressBook where gender = 'm' ) and hometown = '서울' and job not in ('취업준비생','백수');

-- tblAddressBook. gmail.com을 사용하는 사람들의 성별 > 세대별(10,20,30,40대) 인원수를 가져오시오. > where절 > 뭔말임? 
select * from
tblAddressBook ;
-- 1 단계 
select substr(email, instr(email, '@')+1) from 
tblAddressBook ;


with test as (
select 
case
when gender ='f' then '여자' else '남자'
end as genderstr,
case
when age between 10 and 19 then '10대'
when age between 20 and 29 then '20대'
when age between 30 and 39 then '30대'
when age between 40 and 49 then '40대'
end as 나이대
from tblAddressBook 
where substr(email, instr(email, '@')+1) = 'gmail.com'
)
select genderstr as "성별", 나이대, count(*) from test
group by genderstr, 나이대
order by genderstr;

select *
from tblAddressBook where substr(email, instr(email, '@')+1) = 'gmail.com';








-- tblAddressBook. 가장 나이가 많으면서 가장 몸무게가 많이 나가는 사람과 / 같은 직업을 가지는 사람들을 가져오시오. > where절
select *
from tblAddressBook 
where age = (select max(age) from tblAddressBook); -- 여러명이네 
select max(age) from tblAddressBook;


with findJob as  (
select job
from tblAddressBook 
where age = (select max(age) from tblAddressBook) and weight = (select max(weight) from tblAddressBook)
)

select * 
from tblAddressBook
where job = (select job from findJob);

-- tblAddressBook.  동명이인이 여러명 있습니다. 이 중 가장 인원수가 많은 동명이인(모든 이도윤)의 명단을 가져오시오. > where절
with test as (
select name 
from (
select name, count(*)
from tblAddressBook
group by name
order by count(*) desc
)
where rownum = 1
)
select * from tblAddressBook
where name = ( select name from test );

-- tblAddressBook. 가장 사람이 많은 직업의(332명) 세대별 비율을 구하시오.> where + group by + having
--    [10대]       [20대]       [30대]       [40대]
--    8.7%        30.7%        28.3%        32.2%

with test as (select job
from
(
select job, count(*)
from tblAddressBook
group by job
order by count(*) desc
)
where rownum=1)

,test2 as (
select 
case
when age between 10 and 19 then '10대'
end a, 
case 
when age between 20 and 29 then '20대'
end b, 
case
when age between 30 and 39 then '30대'
end c, 
case
when age between 40 and 49 then '40대'
end d
from tblAddressBook 
where job = (select job from test)
)
select round(count(a)/count(*)*100, 1) || '%' "[10대]",
       round(count(b)/count(*)*100, 1) || '%' "[20대]",
       round(count(c)/count(*)*100, 1) || '%' "[30대]",
       round(count(d)/count(*)*100, 1) || '%' "[40대]"
       from test2;





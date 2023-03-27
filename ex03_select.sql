
-- ex03_select.sql 

/*

    SQL, Query(질의) > SELECT 
    
    SELECT문
    - DML, DQL
    - 관계대수 연산 중 셀렉션 작업을 구현한 명령어 
    - 대상 테이블로부터 원하는 행을 추출하는 작업 > 오라클 서버한테 데이터좀 주세요 ~ 요청 명령어 
    - 읽기 
    
                                                  - select문
    [ WITH <Sub Query> ]                          - with절 
    SELECT column_list                            - select절    // : 이 두개부터 시작
    FROM table_name                               - from절
    [ WHERE search_condition]                     - where절
    [ GROUP BY group_by_expression]               - group by절
    { HAVING search_condition]                    - having절
    [ ORDER BY order_expression [ASC | DESC] ]    - order by절
    
    ********** 절의 실행순서가 정해져 있다.
    
*/ 

select 컬럼리스트     --2. 원하는 컬럼을 지정하는 역할 > 다 가져올수도 원하는것을 가져올 수도 

from 테이블명;        --1. 데이터소스를 지정(어느 테이블로 부터 데이터를 가져올지)
-- 테이블을 먼저 지정하고 테이블에 있는 원하는 컬럼을 가져 온다. 

-- 처음 보는 테이블의 구조(스키마, Schema) 확인
-- 1. 툴 > 메모장 같은게 뜨네? 
-- 2. 명령어(SQL Developer, SQL PLUS 에서만 돌아간다.

DESC employees; -- SQL이 아닌다. 특정 툴 명령어니까 이거 다른 데서 쓰면 뭔지 모른다고 에러난다. 

select * 
from employees; 

select first_name from employees;
select email from employees;

-- 다중 컬럼
select first_name, last_name from employees;

select first_name, last_name, email, salary, phone_number from employees; -- 가독성이 많이 떨어진다. 

select first_name, last_name, email, salary, phone_number 
from employees; -- 가독성이 많이 떨어진다. 


-- 컬럼명을 모두 명시 이게 더 빠르다. 와일드 카드보다 
select 
    first_name, last_name, email, salary, phone_number 
from 
    employees; -- 가독성이 많이 떨어진다. 

-- 컬럼명을 모두 명시 > 실제론 이게 이득이 되는 부분이 많다. 
select first_name, last_name, email, salary, phone_number -- 
    from employees;

-- 와일드 카드 사용     
select * -- 와일드 카드(*) > 모든 칼럼 > 칼럼명 다쓰는 것도 좋을 수 있다. 
    from employees;

-- 칼럼리스트의 칼럼순서는 원본 테이블의 컬럼순서와 무관하다. 필요하면 맘대로 재배치해라 
select last_name, first_name from employees; 

select first_name, first_name, first_name from employees;  -- 동일한 칼럼을 여러번 가져올 이유가 없다.

select first_name, length(first_name) from employees; -- 





select * from zipcode;        -- 
select * from tblAddressBook; -- 주소록
select * from tblComedian;    -- 코메디언
select * from tblCountry; 
select * from tblDiary;       
select * from tblHousekeeping; -- 가게부 
select * from tblInsa;         -- 직원정보
select * from tblMen;          -- 데이터가 안들어옴 > 남자
select * from tblWomen;        -- 여자
select * from tblTodo;         -- 할 일 > 언제 완료가 되었는지
select * from tblZoo;          -- 동물  > 

-- 문제를 낼 때 씀 

-- select 절  --> 2. 컬럼 지정
-- from 절 ;  --> 1. 테이블 지정 


select name from tblInsa; 

select name, buseo, jikwi
    from tblInsa;
    
-- 항상 select문의 결과는 테이블이다. > 메모리에 존재하는 임시 테이블 > 원본에서 따로 뽑아온 결과물이다.
-- 잠시 보고 버리는 테이블이라 생각하자. select 문의 결과를 결과테이블 or 결과셋이라 한다. 

select name, length(name)
    from tblInsa;

select * 
    from tblIns; -- 없는 테이블 이름 > 테이블이 존재하지 않는다. 
--    ORA-00942: table or view does not exist
-- 00942. 00000 -  "table or view does not exist"
    
select nama
    from tblInsa; 
-- 존재하지 않는 식별자
--    ORA-00904: "NAMA": invalid identifier
--    00904. 00000 -  "%s: invalid identifier" 


    
    
    
    
    
    
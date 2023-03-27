/*
    ex09_numerical_function.sql
    
    숫자 함수 ( = 수학 함수)
    - Math.random()
    
    round()
    - 반올림 함수
    - number round(컬럼명) : 정수 반환
    - number round(컬럼명, 소수이하 자릿수) : 실수 반환   
*/

select height/ weight, -- 너무 소수가 길다.
       round(height/ weight),    -- 같다.
       round(height/ weight, 0), -- 같다.
       round(height/ weight, 1),
       round(height/ weight, 2),
       round(height/ weight, 3)
from tblComedian;

-- 평균 급여
select round(avg(basicpay)) from tblInsa;

/*

    floor(), trunc()
    - 절삭 함수 
    - 무조건 내림 함수
    - number floor(컬럼명) : 무조건 정수 반환
    - number trunc(컬럼명 [, 소수이하 자릿수]) : 정수 or 실수 반환

*/

select trunc('1.23456',3) -- 어디까지 자를거냐의 인자가 필요있다. 
from dual;

select floor('1.23456')   -- 인자가 더 필요가 없음 
from dual;

select 
    height / weight,
    round(height / weight),
    floor(height / weight),
    trunc(height / weight),
    trunc(height / weight, 1),
    trunc(height / weight, 2)
from tblComedian;
    
/*
    ceil()
    - 무조건 올림 함수(천장)
    - number ceil(컬럼명) 
        
    mod()
    - 나머지 함수
    - number mod(피제수, 제수)
    
*/

select 
    height /weight, 
    round(height / weight),
    floor(height/weight),
    ceil(height/weight)
from tblComedian;

select chr(13)
from dual;

-- dual 테이블  > 레코드 1개짜리 테이블
select * from tblCountry;
select * from dual;
select sysdate from tblCountry; -- 오늘 날짜인데 where절안붙여서 이 테이블에 있는 레코드 개수만큼 나온다. 

select replace('oracle db hey ',' ') as result1,
replace('oracle db hey ','db','hello') as result2
from dual;

select 
    10/3,
    mod(10,3) as "나머지",
    floor(10/3) as "몫"
from dual;

-- dual은 오라클에만 있다.

select 10/3
from dual;

select 
    abs(10),
    abs(-10),
    power(2,2),
    power(2,3),
    power(2,4),
    sqrt(4),
    sqrt(9),
    sqrt(16)
from dual





/*

    ex11_date_time_function.sql
    
    날짜 시간 함수 
    
    1. sysdate
    - 현재 시스템의 시각을 반환
    - Calendar.getInstance()
    - date sysdate     > 소괄호가 생략되었다.
    
*/

-- YYYY-MM-DD HH24:MI:SS > 이 문자열을 기억하자. 

select sysdate from dual;  -- 23/03/16 > 포맷을 바꿀 순있는데 툴의 옵션을 건드려도 되긴하는데 권장 x

/*
    날짜 연산
    +, -
    1. 시각 - 시각 = 시간
    2. 시각 + 시간 = 시각
    3. 시각 - 시간 = 
    
*/

-- 1. 시각 - 시각 = 시간(일)

select
    name,
    ibsadate,
    round(sysdate - ibsadate) as "근무일수",
    round((sysdate - ibsadate) / 365) as "근무년수", -- 사용금지 > 1년에 365가 아닐수 있어서 오차범위가 생긴다. 
    round((sysdate - ibsadate)* 24) as "근무시수",
    round((sysdate - ibsadate)* 24*60) as "근무분수",
    round((sysdate - ibsadate)* 24*60*60) as "근무초수"
from tblInsa;
-- 1년은 365가 아니다.

select 
    title,
    adddate,
    completedate,
    completedate - adddate,
    round((completedate - adddate) * 24, 1) as "실행하기까지걸린시간",
    completedate - adddate as "실행하기까지걸린시간" -- 이거는 된다. 
    -- completedate - adddate as "실행하기까지 걸린 시간" -- 에러가 난다. 식별자가 너무 길다. 
    -- ORA-00972: identifier is too long 이게 한글이라 30바이트가 넘음 utf-8이니까 한글자당 3바이트다. 
from tblTodo
    --where  round((completedate - adddate) * 24, 1) <= 1;
    order by round((completedate - adddate) * 24, 1) desc;
-- as "식별자"

-- 2. 시각 + 시간(일) = 시각
-- 3. 시각 - 시간(일) = 시각
select 
    sysdate,
    sysdate + 100 as "100일뒤",
    sysdate - 100 as "100일전", -- 자바보다 편하다. 
    sysdate + ( 3 / 24 ) as "3시간후",
    sysdate - ( 5 / 24 ) as "5시간전",
    sysdate + ( 30 / 60 / 24 ) as "30분뒤"
from dual;

/*

    시각 - 시각 = 시간(일)
    
    months_between()
    - number months_between(date, date)
    - 시각 - 시각 = 시간(월) 
    
    add_months() > 시각에다가 시간을 더한다. 
    - number add_months(date, 시간) 
    - 시각 + 시간(월) = 시각 
*/
select 
    name, 
    round(sysdate - ibsadate) as "근무일수",
    round((sysdate - ibsadate)/365) as "근무일수", -- 신뢰 X
    round(months_between(sysdate, ibsadate)) as "근무월수", -- 신뢰 O
    months_between(sysdate, ibsadate) as 노라운드,
    round(months_between(sysdate, ibsadate)/12) as "근무년수"
from tblInsa;
-- 이게 몇개월이 지나고 몇년이 지나는지 표현?? 
-- 연산 한번으로는 사실 오차 때문에 정확하게 표현하기는 힘들다. 

select
    sysdate,
    sysdate + 10,          -- 10일 뒤    23/03/26
    sysdate + 30,          -- 한달 뒤??  23/04/15
    add_months(sysdate, 1), -- 한달 뒤??
    add_months(sysdate, -3), -- 3개월 전 
    add_months(sysdate, 3*12) -- 3년 뒤 
from dual;

/*
    시각 - 시각
    1. 일, 시, 분, 초 > 연산자(-) 
    2. 월, 년 > months_between() 

    시각 +- 시간
    1. 일, 시, 분, 초 > 연산자(+,-)
    2. 월, 년 > add_months()

*/

-- employees

-- 1. 전체 이름(first_name + last_name)이 가장 긴 -> 짧은 사람 순으로 정렬해서 가져오기
--    > 컬럼 리스트 > fullname(first_name + last_name), length(fullname)
select first_name || last_name as 이름, length(first_name || last_name) as 길이
from employees
order by length(first_name || last_name) desc;

-- 2. 전체 이름(first_name + last_name)이 가장 긴 사람은 몇글자? 가장 짧은 사람은 몇글자? 평균 몇글자?
--    > 컬럼 리스트 > 숫자 3개 컬럼
select max(length(first_name || last_name)) as 최대, min(length(first_name || last_name)) as 최소, trunc(avg(length(first_name || last_name))) as 평균
from employees;

-- 3. last_name이 4자인 사람들의 first_name을 가져오기
--    > 컬럼 리스트 > first_name, last_name
--    > 정렬(first_name, 오름차순)
select first_name, last_name
from employees
where length(last_name)=4
order by first_name;

-- decode( 나 case end ) 

-- 4. tblInsa. 부장 몇명? 과장 몇명? 대리 몇명? 사원 몇명?

select 
    count(decode(jikwi, '부장', 1)) as 부장,
    count(decode(jikwi, '과장', 1)) as 과장,
    count(decode(jikwi, '대리', 1)) as 대리,
    count(decode(jikwi, '사원', 1)) as 사원
from tblInsa;

-- 5. tblInsa. 간부(부장, 과장) 몇명? 사원(대리, 사원) 몇명?
select 
    count(decode(jikwi, '부장', 1, '과장', 1)) as "간부(부장, 과장)",
    count(decode(jikwi, '대리', 1, '사원', 1)) as "사원(대리, 사원)"
from tblInsa;

-- 6. tblInsa. 기획부, 영업부, 총무부, 개발부의 각각 평균 급여?
select 
    avg(decode(buseo, '기획부', basicpay)) as "기획부",
    avg(decode(buseo, '영업부', basicpay)) as "영업부",
    avg(decode(buseo, '총무부', basicpay)) as "총무부",
    avg(decode(buseo, '개발부', basicpay)) as "개발부"
from tblInsa;

select * from tblInsa;

-- 7. tblInsa. 남자 직원 가장 나이가 많은 사람이 몇년도 태생? 여자 직원 가장 나이가 어린 사람이 몇년도 태생?

select max(substr(ssn,1,2))
from tblInsa
where ssn LIKE '%-2%';

select min(substr(ssn,1,2))
from tblInsa
where ssn LIKE '%-1%';


select 
    decode(ssn, ssn LIKE '%-1%', 1)
from tblInsa;

select * from tblInsa;
-- 7. tblInsa. 남자 직원 가장 나이가 많은 사람이 몇년도 태생? 여자 직원 가장 나이가 어린 사람이 몇년도 태생?
select 
    min(decode(substr(ssn,8, 1 ), '2', substr(ssn, 0 ,2))) as 남자나이많은,
    max(decode(substr(ssn,8, 1 ), '1', substr(ssn, 0 ,2))) as 여자나이적은
from tblInsa;


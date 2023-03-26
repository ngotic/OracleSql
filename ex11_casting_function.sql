/*
ex11_casting_function.sql

1. to_char(숫자)   : 숫자 > 문자
2. to_char(날짜)   : 날짜 > 문자 *************
3. to_number(문자) : 문자 > 숫자
4. to_date(문자)   : 문자 > 날짜 ****

*/

/*

1. to_char(숫자, 형식문자열)

형식문자열 구성요소
a. 9: 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리를 스페이스로 치환 . %5d
b. 0: 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리를 0으로 치환.      %05d
c. $: 통화 기호 표현 
d. L: 통화 기호 표현 > 둘다 금액을 나타내는 단위를 붙일 때 쓴다. 
e. .: 소수점
f. ,: 첫단위


2. to_char(날짜)   : 날짜 > 문자 *************

형식문자열

a. yyyy
b. yy
c. month
d. mon
e. mm
f. day
g. dy
h. ddd
i. dd
j. d
k. hh
l. hh24
m. mi
n. ss
o. am(pm)
*/

select 
    weight,          -- 우측정렬(숫자)  
    to_char(weight)  -- 좌측정렬(문자)
from tblComedian;

-- *** Java은 엄격한 언어 > 문법을 칼같이 준수 > 자료형
-- *** SQL은 유연한 언어 > 문법을 적당히 준수 > 자료형 > 암시적 형변환 잦음 

select 
    weight,          -- 우측정렬(숫자)  
    to_char(weight),  -- 좌측정렬(문자)
    length(weight),    -- length() 문자열 > weight 숫자 
    length(to_char(weight))  -- 이게 내부적으로 호출이 된 것이다. > 숫자가 있더라도 내부적 형변환이 자동으로 된다. 
from tblComedian;

select 
    weight,
    to_char(weight),
    '@' || to_char(weight) || '@',
    to_char(weight, '99999'),-- 두자리는 채우고 나머지는 남아서 스페이스로 채운다. 
    '@' || to_char(weight, '99999'),
    '@' || to_char(weight, '00000')  || '@', -- 부호가 들어가는 자리 한칸은 비워둔다. 
    '@' || to_char(-weight, '00000') || '@' -- 마이너스를 넣었더니 들어간다. 
from tblComedian;

select 
    100,
     to_char(100, '999'),
     to_char(100, '999') || '달러' ,
     to_char(100, '999') || '원' ,
     to_char(100, '$999'),
     to_char(100, 'L999') -- ￦100 이렇게 나온다.
    -- to_char(100, '999달러') 이게 안된다. 여기의 to_char 두번째 문자열은 형식문자이다. 아무나 못적고 허락된 애들만 적는다. 
from dual;

select 
    1234567.89,
    to_char(1234567.89, '9,999,999') -- 자바는 %,d 였다. 
from dual;

select sysdate from dual; -- 구분이 안간다. 
select to_char(sysdate) from dual; -- 이거나 
select to_char(sysdate,'yyyy') from dual;

select to_char(sysdate) from dual; 
select to_char(sysdate, 'yyyy') from dual;  -- 2023 ( 4자리 ) 
select to_char(sysdate, 'yy') from dual;    -- 23년(2자리) 
select to_char(sysdate, 'month') from dual; -- 3월(풀네임)
select to_char(sysdate, 'mon') from dual;   -- 월(약어)
select to_char(sysdate, 'mm') from dual;    -- 월(2자리)
select to_char(sysdate, 'day') from dual;   -- 요일(풀네임)
select to_char(sysdate, 'dy') from dual;    -- 요일(약어)
select to_char(sysdate, 'ddd') from dual;   -- 일(올해의 며칠)
select to_char(sysdate, 'dd') from dual;    -- 일(이번달의 며칠)
select to_char(sysdate, 'd') from dual;     -- 일(이번주의 며칠)
select to_char(sysdate, 'hh') from dual;    -- 시(12시간)
select to_char(sysdate, 'hh24') from dual;  -- 시(24시간)
select to_char(sysdate, 'mi') from dual;    -- 분
select to_char(sysdate, 'ss') from dual;    -- 초
select to_char(sysdate, 'am') from dual;    -- 오전/오후
select to_char(sysdate, 'pm') from dual;    -- 오전/오후

-- 암기
select 
    sysdate,
    to_char(sysdate, 'yyyy-mm-dd'), -- 2023-03-16
    to_char(sysdate, 'hh24:mi:ss'), -- 14:46:54
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), -- 2023-03-16 14:46:54
    to_char(sysdate, 'day am hh:mi:ss')        -- 목요일 오후 02:46:54
from dual;

-- 홍길동	98/10/11	1998-10-11

select * from tblInsa;

select 
name,
ibsadate,
to_char(ibsadate, 'yyyy-mm-dd') as hire_date,
to_char(ibsadate, 'day') as day,
case
    when to_char(ibsadate, 'd') in ('1','7') then '휴일입사'
    else '평일입사' -- else에는 then 안쓴다. 
end
from tblInsa;

select * from tblInsa;

desc tblInsa;

-- 날짜 상수 
-- 입사날짜 > 2000년 이후
select * from tblInsa
    where ibsadate >= '2000-01-01';  -- 얘가 제기능을 한다. 근데 이게 문자열이다. 
    -- 자꾸만 이놈들이 형변환한다...

-- 입사날짜 > 2000년에 ...
select * from tblInsa 
    where ibsadate >= '2000-01-01' and ibsadate < '2001-01-01'; -- 이렇게 써야 한다. > 이 표현이 제일 안정적이다. 
    -- where ibsadate >= '2000-01-01' and ibsadate <= '2000-12-31'; -- 오답 > 마지막에 들어온 사람은 포함이 되지 않는다.
                                          -- 2000-12-31 00시0분0초이라서 마지막날이 포함이 안된다. > 조심하자!!
                     -- 년월일 시분초인데 
                     -- 날짜 상수 > 자동으로 00:00:00 > 자정으로 세팅된다.(그날짜의 시작이되는 자정이 된다.)
                     
-- 연월일도 자동으로 형변환이 되는데 형변환이 되면 시분초는 00:00:00이다.
select * from tblInsa
    where to_char(ibsadate, 'yyyy') = '2000';
    
    
select * from tblInsa
    where ibsadate >= '2000-01-01 00:00:00' and ibsadate <= '2000-12-31 23:59:59'; -- 형변환이 안된다. 년월일까지 쓴다.
    
select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') from dual;



-- 3. to_number(문자) 
select 
   123,
   '123',            -- 문자열 오른쪽 정렬
   to_number('1234') -- 숫자 왼쪽 정렬된다.
from dual;

select 123 * 2,
       to_number('123') * 2,
       '123'*2               -- 형변환을 안해도 그냥도 된다. > 암시적 형변환
from dual;

-- 4. to_date()
select 
    sysdate,     -- 23/03/16
    '2023-03-16', -- '2023-03-16'> 문자열!!!, 날짜 아니다 > 여기선 형변환 발생 안했다. 
    to_date('2023-03-16') + 1,
    to_date('2023-03-16', 'yyyy-mm-dd' ),
    to_date('20230316'),  -- 23/03/16
    to_date('20230316','yyyymmdd'),
    to_date('2023/03/16','yyyy/mm/dd'),
    to_date('2023-03-16 15:28:25', 'yyyy-mm-dd hh24:mi:ss') -- 시분초가 포함되면... 이상하게 된다. 
from dual; -- ' '으로 묶으니까 날짜 취급이 필요가 없으니까 '2023-03-16' + 1 이 안된다. 

select * from tblInsa;
desc tblInsa;

select * from tblInsa 
    where ibsadate >= to_date('2000-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss') and ibsadate <= to_date('2000-12-31 23:59:59', 'yyyy-mm-dd hh24:mi:ss');
    

-- to_date는 시분초까지 포함한 것을 바꾸기 위해서 쓴다.
-- to_date는 시분초까지 저장시킬 수 있다. > 하지만 테이블 데이터 안에서는 시분초가 안보인다. > to_char로 꺼내써야한다.


select 
    to_date('2023-03-16 15:28:25', 'yyyy-mm-dd hh24:mi:ss'),   -- 시분초까지 기록  --23/03/16
    to_char(to_date('2023-03-16 15:28', 'yyyy-mm-dd hh24:mi'), 'yyyy-mm-dd hh24:mi:ss'),      -- 시분초를 꺼내쓰려면 이렇게 -- default는 00으로 채워지고
    to_char(to_date('2023-03-16 15:28:25', 'yyyy-mm-dd hh24:mi:ss'), 'yyyy-mm-dd hh24:mi:ss')  -- 시분초를 꺼내쓰려면 이렇게 
from dual;

select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') from dual;  
-- 보일땐 년월일까지 사실은 시분초까지 저장됨, 시분초까지 꺼내보려면 to_char로 꺼내기





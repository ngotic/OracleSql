/*

    ex10_string_function.sql
    
    문자열 함수
    
    upper(), lower(), initcap()
    - varchar2 upper(컬럼)
    - varchar2 lower(컬럼)
    - varchar2 initcap(컬럼)
    
*/

select 
    first_name,
    upper(first_name),
    lower(first_name)
from employees;

select 
    'abc', initcap('abc'), initcap('aBC')  -- 카멜 표기법처럼 첫글자를 대문자로 바꿔주다.  > 카멜표기법으로 한다. 첫글자만 대문자, 나머지는 소문자로 일괄 변환
from dual;


select first_name 
    from employees
        where lower(first_name) like '%an%';
        
/*

    substr()
    - 문자열 추출 함수
    - varchar2 substr(컬럼, 시작위치, 가져올 문자 개수) 
    - varchar2 substr(컬럼, 시작위치)
    - *** SQL 인덱스 > 1부터 시작
*/

select
    title, 
    substr(title, 3, 4), -- 4글자를 짜르는데 공백도 포함해서 자른다.
    substr(title, 3)     -- 3번째 위치부터 끝까지 ~ 
from tblTodo;



select 
    name, 
    substr(name, 1, 1) as "성",
    substr(name, 2) as "이름",
    ssn,
    substr(ssn, 1, 2) as "생년",
    substr(ssn, 3, 2) as "생월",
    substr(ssn, 5, 2) as "생일",
    substr(ssn, 8, 1) as "성별"
from tblInsa;


select 
    sum
    (case 
        when substr(name, 1, 1) = '김' then 1 else 0
    end) as "김씨",
    count
    (case 
        when substr(name, 1, 1) = '이' then 1
    end) as "이씨",
    count
    (case 
        when substr(name, 1, 1) = '박' then 1
    end) as "박씨",
    count
    (case 
        when substr(name, 1, 1) = '최' then 1
    end) as "최씨",
    count
    (case 
        when substr(name, 1, 1) = '정' then 1
    end) as "정씨",
    count(case 
        when substr(name, 1, 1) NOT IN ('김', '이', '박', '최', '정') then 1
    end) as "나머지"
from tblInsa; -- 조건에 substring만 들어간 것이다.


-- 은근 케이스를 많이 쓰는 구나


select * from tblInsa
    where ssn like '%-2%';
    
select * from tblInsa
    where substr(ssn ,8, 1) = '2';
    
-- or로 뭐가 아니면 뭐가 아니면 이렇게도 쓰는데 IN으로 or를 떠올려도 된다. 

-- 남자 > 여자 ~ 남자순으로 먼저 출력하고 여자순으로 출력한다. 
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
    end; -- case로 만든 칼럼을 order 기준으로 뜯어온다.    
    
select 
    *
from tblInsa
    order by substr(ssn, 8, 1); -- 남자 직원이 쭉 나오고 여자 직원이 쭉 나온다. 
    
    
/*

    length()
    - 문자열 길이
    - number length(칼럼)
    
*/

-- 컬럼 리스트에서 사용
select name, length(name) from tblCountry;

-- 조건절에서 사용 
select name, length(name) from tblCountry where length(name) > 3;
select name, length(name) from tblCountry where length(name) between 4 and 6;

-- 정렬에서 사용
select name, length(name) from tblCountry order by length(name) desc;

-- 게시판 제목 > 길면 > 잘라서 > 말줄임표(..) 
select 
    title,
    case 
        when length(title) >= 8 then substr(title, 1, 8) || '..'
        else title
    end
from tblTodo;

/*
    instr()
    - 검색함수(indexOf)
    - 검색어의 위치를 반환
    - number instr(컬럼, 검색어) 
    - number instr(컬럼, 검색어, 시작위치) 
    - number instr(컬럼, 검색어, 시작위치, -1)  -- 이렇게 하면 lastIndex 역할을 한다.
    
*/

select 
    '안녕하세요. 홍길동님',
    instr('안녕하세요. 홍길동님', '홍길동') as r1, -- 딱 8번째부터 
    instr('안녕하세요. 홍길동님', '아무개') as r2, -- 없는거 찾으면 
    instr('안녕하세요. 홍길동님. 홍길동님', '홍길동') as r3,
    instr('안녕하세요. 홍길동님. 홍길동님', '홍길동', 11) as r4,
    instr('안녕하세요. 홍길동님. 홍길동님', '홍길동'
    , instr('안녕하세요. 홍길동님. 홍길동님', '홍길동') + length('홍길동')) as r5, -- 다음걸 찾는다. 
    instr('안녕하세요. 홍길동님. 홍길동님', '홍길동', -1 ) as t6
from dual;



/*
    lpad(), rpad()
    - left padding, right padding
    - varchar2 lpad(컬럼, 개수, 문자)
    - varchar2 rpad(컬럼, 개수, 문자)
*/


-- 내가 얼만큼 자리 공간을 잡고 그 빈 공간에다가 이 문자로 채울 것이다.
select 
    'a',
    lpad('a', 5, 'b'), -- 남는 여백을 채운다 > 패딩 
    'a',
    lpad('1', 3, '0'),
    lpad('12', 3, '0'),
    lpad('123', 3, '0'),
    lpad('1234', 3, '0'),
    rpad('1', 3, '0')
from dual;











/*

    trim(), ltrim(), rtrim()
    - varchar2 trim(컬럼)
    - varchar2 ltrim(컬럼)
    - varchar2 rtrim(컬럼)

*/


select 
    '    하나       둘        셋     ',
    trim('    하나       둘        셋     '), -- 공백만 지운다. 다른 문자 제거는 못함, 인자가 하나만 들어간다. 
    ltrim('    하나       둘        셋     '), -- 다른 문자 제거도 가능
    rtrim('    하나       둘        셋     '), -- 다른 문자 제거도 가능 
    rtrim('    하나       둘        셋     xx','x') -- 다른 문자 제거도 가능 
from dual;


/*
    replace()
    - 문자열 치환
    - varchar2 replace(컬럼, 찾을 문자열, 바꿀 문자열)
*/

select 
    replace('홍길동', '홍', '김'),
    replace('홍길동', '이', '김'),
    replace('홍길동', '이', '김')
from dual;

select 
    name,
    continent,
    case
        when continent='AS' then '아시아'
        when continent='EU' then '유럽'
        when continent='AF' then '아프리카'
    end as c1,
    replace(continent, 'AS', '아시아'),
    replace(replace(replace(continent, 'AS', '아시아'),'EU','유럽'),'AF','아프리카') -- 연쇠적 replace
from tblCountry;
    
-- case end는 조건을 만족하지 않으면 null을 반환한다.
-- replace는 못찾으면 원본을 돌려준다.

/*

    decode()
    - 문자열 치환 
    - replace와 비슷
    - varchar2 decode( 컬럼, 찾을 문자열, 바꿀 문자열 [, 찾을 문자열, 바꿀 문자열] x N )
    - 문자열 조작 > case의 간단한 버전 
    - 못찾으면 null을 돌려준다. ( replace는 못찾으면 원본을 돌려준다.)
    - >>> 그래서 case end와 비슷하다.
*/

select * from tblComedian;

select 
    gender,
    case 
        when gender = 'm' then '남자'
        when gender = 'f' then '여자'
    end as g1,
    replace(replace(gender, 'm', '남자'), 'f' ,'여자') as g2,
    decode(gender, 'm', '남자') as g3, -- 조건을 못찾으니까 null이 들어왔다.
    decode(gender, 'm', '남자', 'f','여자') as g4
    
from tblComedian;
-- 글자를 찾아서 저렇게 바꾼다.

-- 남자 몇명? 여자 몇명?

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
from tblComedian; -- 올 집계함수만 되니까 조심!!! 

-- decode나 case가 비슷한데 .... 


/*
ex07_order.sql
    
                                                  - select문
    [ WITH <Sub Query> ]                          - with절 
    SELECT column_list                            - select절    // : 이 두개부터 시작
    FROM table_name                               - from절
    [ WHERE search_condition]                     - where절
    [ GROUP BY group_by_expression]               - group by절
    { HAVING search_condition]                    - having절
    [ ORDER BY order_expression [ASC | DESC] ]    - order by절
    
    select 칼럼리스트                --3. 원하는 칼럼들을 가져와서
    from 테이블                     --1. 테이블로부터
    where 조건                      --2. 원하는 행들을 
    order by 정렬기준;               --4. 순서대로 정한다. > order by는 모든절 중에 꼴찌다.

    order by 절
    - 결과셋의 정렬(O)
    - 원본 테이블의 정렬(사용자가 관여 불가능하다 > 오라클 )
    - order by '정렬컬럼' [asc|desc]                     > 기준 정렬컬럼이 온다. 생략하면 오름차순이다. 
*/


select * from tblCountry;  -- 이런 테이블이 있고 이 테이블좀 정렬해줘! 누군가 요청한다. 

select * from tblCountry order by name asc;

select * from tblCountry order by population desc; -- 인구수가 많은 나라로 정렬해주세요. 
               -- null 컬럼을 대상으로 정렬 ~ ! 큰쪽으로 편입이 되서 정렬된다. > 그래서 null을 빼면 된다.
select * from tblCountry where population is not null order by population desc; -- 이상태에서 케냐를 뺀다. 

select * from tblInsa order by name asc; -- 문자열 + 오름차순 
select * from tblInsa order by basicpay; -- 숫자 + 오름차순  > 급여가 낮은 사람부터 오른사람배치 
select * from tblInsa order by ibsadate; -- 날짜 + 오름차순 


select * from tblInsa order by buseo asc; -- 정렬기준이 중복이 일어난다. 개발부가 개많다.

-- 다중 정렬 

select * from tblInsa order by buseo asc, city asc; -- 개발부가 개많으니까 그 사이에서도 시티기준으로 정렬 

select * from tblInsa order by buseo asc, city asc, name asc; -- 내가 뭔가를 하고싶은데 오라클에서도 자바에서도 해서 겹친다.
-- 이걸 db에서 할지 아니면 자바단에서 할지 고민된다. 

select 
    name, buseo, jikwi
from tblInsa
    order by buseo, jikwi, name;  -- 여러개 기준으로 정렬 
    
    
    ------ ↕
    
    
select 
    name, buseo, jikwi
from tblInsa
    order by 2, 3, 1; -- 컬럼순서가 번호다. > 권장 x 가독성이 낮다. > 유지보수에 취약하다. 


-- 가공된 값을 > where 절에 쓰던거처럼
-- 가공된 값을 > order by 절에다가 쓸 수 있다.

select * from tblInsa order by basicpay desc; -- 허경운 홍길동
select * from tblInsa order by basicpay + sudang desc; -- 허경운 홍길동 > 순위가 바뀐다. 
-- 이런식으로 조작한 값을 order by로 넣을 수 있다. 

-- 직위순으로 정렬: 부장 > 과장 > 대리 > 사원 > 자바는 얘네들을 각각에 대응하는 숫자로 만들었었다.
select 
    name, jikwi
from tblInsa
    order by jikwi desc;
    
-- 과,부,대,사를 우리가 원하는 숫자로 하고 싶다. 

select 
    name, jikwi,
    case
        when jikwi = '부장' then 1
        when jikwi = '과장' then 2
        when jikwi = '대리' then 3
        when jikwi = '사원' then 4
    end as 순서 -- alias를 안붙이면 order by 옆에 붙일것도 없다.
    
from tblInsa
    order by 순서 asc; -- 내가 원하는 직위순으로 출력되었다. 
    -- 새로운 칼럼을 만들어서 그기준을 정렬한다. 
    





select 
    name, jikwi,
    case
        when jikwi = '부장' then 1
        when jikwi = '과장' then 2
        when jikwi = '대리' then 3
        when jikwi = '사원' then 4
    end as 순서 -- alias를 안붙이면 order by 옆에 붙일것도 없다. > 여기선 case ~ end가 칼럼이다. 
    
from tblInsa
    order by 3 asc; -- 이렇게 3으로 해도 된다.
    -- 새로운 칼럼을 만들어서 그기준을 정렬한다. 

select name, jikwi
from tblInsa 
order by 
(case
        when jikwi = '부장' then 1
        when jikwi = '과장' then 2
        when jikwi = '대리' then 3
        when jikwi = '사원' then 4
end) asc; -- alias를 안붙이면 order by 옆에 붙일것도 없다.
--> 여기선 case ~ end가 칼럼이었으므로 짤라서 넣은 것이다.
--> 요렇게 하면 순서 부분의 칼럼을 없앨 수 있다.
-- case end는 select 문에도 들어가고 order by에도 들어간다.
-- case문을 where절에도 들어간다. 

select name, jikwi
from tblInsa 
where case  -- where 옆에도 들어간다 걍 컬럼이라 생각해라
    when jikwi = '부장' then 1
    when jikwi = '과장' then 2
    when jikwi = '대리' then 3
    when jikwi = '사원' then 4
    end = 1
order by case 
    when jikwi = '부장' then 1
    when jikwi = '과장' then 2
    when jikwi = '대리' then 3
    when jikwi = '사원' then 4
    end asc;
    
-- 성별순으로 정렬 : 남자 > 여자     
-- 771212 - 1022432    
select * from tblInsa;

select * from tblInsa
    order by 성별 asc;

-- case end문으로 내가 칼럼을 직접 만든다. 
select 
    case 
        when ssn like '%-1%' then '남자'
        when ssn like '%-2%' then '여자'
    end as 성별-- 이게 하나의 컬럼이다. 내가 가공해서 만든 컬럼이다. 
from tblInsa;
    
-- 원래 테이블에 있는 칼럼이던 컬럼이든 동등하다. 

/*
    ex23_pseudo.sql
    
    의사컬럼, Pseudo Column
    - 실제 컬럼이 아닌데 컬럼처럼 행동하는 요소
    
    rownum 
    - 오라클 전용
    - row num > 행번호 > 레코드의 일련번호
    - from절이 실행될 때 각 레코드에 일련번호를 할당한다.(****)
    - where절의 영향을 받으면 일련번호를 다시 정비한다.(reindexing) (****) > 일련번호 변화!!!
    - rownum을 사용 > 서브 쿼리를 자주 사용한다.
*/

select
    name, buseo,     -- 컬럼(속성)   > output > 객체에 특성에 따라 다른 값을 가진다.(개인 데이터)
    sysdate,         -- 함수        > output > 모든 레코드가 동일한 값을 가진다.(정적 데이터)
    substr(name, 2), -- 함수        > input + output > 객체마다 다른 값을 가진다. 
    '상수',            -- 상수        > output > 모든 레코드가 동일한 값을 가진다. ( 정적 데이터 )
    rownum           -- 의사 칼럼 > output > 객체의 특성에 따라 다른 값을 가진다.(개인 데이터 )
from tblInsa;

-- 숫자들이 주르륵 나온다. 그게 일련번호 같이 나온다.

-- 게시판 > 페이징 : 페이지 기법을 쓸 때 rownum을 쓴다. 
-- 1페이지 > rownum between 1 and 20 
-- 2페이지 > rownum between 21 and 40 
-- 3페이지 > rownum between 41 and 60 

select name, buseo, rownum from tblInsa;
select name, buseo, rownum from tblInsa where rownum = 1;  -- 얘는 된다!!!! 인덱스 정렬없이 첫번쨰로 바로 찾아서
select name, buseo, rownum from tblInsa where rownum <= 5; -- 얘도 일치가 되니까 인덱스 정렬이 필요가 없음

select name, buseo, rownum from tblInsa where rownum = 10; -- 안됨안됨!!
select name, buseo, rownum from tblInsa where rownum = 2;  -- 이런거는 안된다.
-- 이런거는 안된다. ★ 1보다 큰 값 하나 딱 지정은 안됨 > 조건을 만족하는 기준이 없다. 

select name, buseo, rownum from tblInsa where rownum > 5; -- 이것도 안된다. 



select 
    name, buseo, rownum
from tblInsa; --1. *** 이 시점의 데이터를 가지고 rownum이 이미 할당되어 있다. 


select 
    name, buseo, rownum
from tblInsa          -- from절로 가져온 데이터중에 첫번째 사람 찾는다. 
    where rownum = 1; --2. 조건, rownum에 1이 들었니??
    
select 
    name, buseo, rownum
from tblInsa
    where rownum = 3;   -- 이게 왜 안될까? rownum=3은 분명히 있는뎁...?
    -- 탈락이 되버리면 사라진거다.
    -- rownum을 조건으로 사용 > 반드시 1~조건 범위 > 조건에 포함



-- order by 랑은 쓰기가 애매하다. rownum도 같이 재정렬된다.  
select 
    name, buseo, rownum
from tblInsa         -- 1. 생성(+rownum)
    order by name;  
    

select 
    name, buseo, basicpay, rownum
from tblInsa
    order by basicpay desc;

-- rownum은 from절이 할당될 때 실행된다. 근데 order by는 마지막에 실행된다.
-- 이것때문에 ... 문제다!! 순서때문에 기능이 원하는 대로 되지 않는다.
-- rownum은 order by전에 매개진 넘이라 order by날려버리면 뒤섞이는 것이다.

-- 이러니까 좋다. 
select name, buseo, basicpay, rownum  -- 인라인뷰쪽의 rownum과 안쪽 rownum이 완전 다르다. 
-- ★ 안쪽의 rownum으로 실행되지 않는다.
from (select 
          name, buseo, basicpay, rownum 
      from tblInsa
          order by basicpay desc);


select name, buseo, basicpay, rownum, rnum  -- 근데 alias로 인라인뷰의 rownum를 가져오면??
-- ★ 안쪽의 rownum으로 실행되지 않는다.
from (select 
          name, buseo, basicpay, rownum as rnum 
      from tblInsa
          order by basicpay desc)
          where rownum <= 5;
          

-- 인구수가 가장 많은 나라 1~3등 
select * from tblCountry;

-- 1. 원하는 정렬을 먼저해야 한다.
select * from tblCountry where population is not null order by population desc;
select rownum from tblCountry where population is not null order by population desc;

-- 2. 위의 결과셋을 가지고 한번더 rownum을 만들기 > from 절 실행 
select * from (select * from tblCountry where population is not null order by population desc)
    where rownum <= 3;



-- tblInsa. 급여가 3등 
select * from tblInsa; 
-- 거의 공식이다. > 1+1 정도이다.

-- 1. 급여 순으로 정렬
select * from tblInsa order by basicpay desc;

select rownum from tblInsa order by basicpay desc;

-- 2. 원하는 순서대로 정렬 결과셋> from절 적용 > rownum 다시 매긴다.
select a.*, rownum from(select * from tblInsa order by basicpay desc) a where rownum = 1;
select a.*, rownum from(select * from tblInsa order by basicpay desc) a where rownum <= 5;
select a.*, rownum from(select * from tblInsa order by basicpay desc) a where rownum = 3;

-- ★ rownum이 = 1 이 아닌 상태일 때 써먹는 방법 
--------------------- 안쪽은 고정이 되버려 가장 바깥에서 where 로 검색해도 된다. ---------------------
select * from (select a.*, rownum as rnum from(select * from tblInsa order by basicpay desc) a)
    where rnum = 3; -- 이러면 리indexing이 된다. 
-- 가장 바깥 rownum도 있는데 안쓴다.

---- ★ select가 세번 가운데 select에서 나온 rownum을 사용하는 방법 ★ ---- 가장 안쪽은 정렬기준 셋팅
select * from (select  a.*, rownum as rnum from(select * from tblInsa order by basicpay desc) a)
    where rnum = 3;
-- 행번호와 관련된 함수들도 있다. 

-- tblComedian. 5번째 뚱뚱한 사람?

select * from tblComedian;
-- ★ 공식처럼 외워야 하는 부분 ★
-- 1. 정렬을 한다. 정렬기준도 셋팅
select * from tblComedian order by weight desc;

-- 2. 서브쿼리 > rownum 별칭을 등록
select a.*, rownum as rnum from (select * from tblComedian order by weight desc) a;

-- 3. 서브쿼리 처리시켜서 rownum 별칭을 메인쿼리에서 가져다가 사용한다.
select * from (select a.*, rownum as rnum from (select * from tblComedian order by weight desc) a)
where rnum = 5;

-- 1. tblInsa. 남자 급여(기본급+수당)을 (내림차순)순위대로 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
select name, buseo, jikwi, basicpay+sudang as 급여 from tblInsa order by 급여 desc; -- 1. 정렬 및 > '필요한 칼럼 한정'

select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang as 급여 from tblInsa order by 급여 desc) a;

-- rank, dense_rank, row_number()
select * from (select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang as 급여 from tblInsa order by 급여 desc) a);

-- 2. tblInsa. 여자 급여(기본급+수당)을 (오름차순)순위대로 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
-- 1. 정렬, 칼럼 한정
select name, buseo, jikwi, basicpay+sudang as 급여 from tblInsa where substr(ssn,8, 1) ='2' order by 급여;
select * from tblInsa;
-- > 답 
select a.*,rownum as rnum from ( select name, buseo, jikwi, basicpay+sudang as 급여 from tblInsa where substr(ssn,8, 1) ='2' order by 급여 ) a;



-- 3. tblInsa. 여자 인원수가 (가장 많은 부서 및 인원수) 가져오시오.
--1
select buseo, count(*) from tblInsa where substr(ssn,8, 1) ='2' group by buseo order by count(*) desc;

select a.*, rownum as rnum from (select buseo, count(*) from tblInsa where substr(ssn,8, 1) ='2' group by buseo order by count(*) desc) a;

select * from (select a.*, rownum as rnum from (select buseo, count(*) from tblInsa where substr(ssn,8, 1) ='2' group by buseo order by count(*) desc) a) where rnum =1;

-- 4. tblInsa. 지역별 인원수 (내림차순)순위를 가져오시오.(city, 인원수)

select * from tblInsa;

select city, count(*) from tblInsa group by city order by count(*) desc;

select a.*, rownum from (select city, count(*) from tblInsa group by city order by count(*) desc) a;

-- 5. tblInsa. 부서별 인원수가 가장 많은 부서 및원수 출력.
select buseo, count(*) as cnt from tblInsa group by buseo order by count(*) desc;

select  buseo, cnt, rownum as rnum from (select buseo, count(*) as cnt from tblInsa group by buseo order by count(*) desc) a;

-- from 절 인라인뷰를 연쇄적으로 사용
select buseo, cnt from (select  a.*, rownum as rnum from (select buseo, count(*) as cnt from tblInsa group by buseo order by count(*) desc) a) where rnum = 1;

-- 6. tblInsa. 남자 급여(기본급+수당)을 (내림차순) 3~5등까지 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
-- 1. 
select name, buseo, jikwi, basicpay+sudang from tblInsa where substr(ssn,8,1) = '1' order by basicpay+sudang desc;

select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang from tblInsa where substr(ssn,8,1) = '1' order by basicpay+sudang desc) a ;

select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang from tblInsa where substr(ssn,8,1) = '1' order by basicpay+sudang desc) a where rownum <=5
minus
select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang from tblInsa where substr(ssn,8,1) = '1' order by basicpay+sudang desc) a where rownum <=2;

-- 답
select * from (select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang from tblInsa where substr(ssn,8,1) = '1' order by basicpay+sudang desc) a ) where rnum >=  3 and rnum <=5;

-- 7. tblInsa. 입사일이 빠른 순서로 5순위까지만 가져오시오.
select * from tblInsa order by ibsadate;

--> 답
select a.*, rownum from (select * from tblInsa order by ibsadate) a where rownum <=5;


-- 8. tblhousekeeping. 지출 내역(가격 * 수량) 중 가장 많은 금액을 지출한 내역 3가지를 가져오시오.
select t.*, price*qty from tblhousekeeping t order by price*qty desc;

-- 답
select a.*, rownum from (select t.*, price*qty from tblhousekeeping t order by price*qty desc) a where rownum <= 3;

-- 9. tblinsa. 평균 급여 2위인 부서에 속한 직원들을 가져오시오.
select buseo, round(avg(basicpay + sudang)) as 급여 from tblinsa group by buseo order by 급여 desc;

select buseo, rownum as rnum from (select buseo, round(avg(basicpay + sudang)) as 급여 from tblinsa group by buseo order by 급여 desc) ;

-- 답
select *
from tblinsa
where buseo = (select buseo from (select buseo, rownum as rnum from (select buseo, round(avg(basicpay + sudang)) as 급여 from tblinsa group by buseo order by 급여 desc)) where rnum = 2 );

-- 10. tbltodo. 등록 후 가장 빠르게 완료한 할일을 순서대로 5개 가져오시오.

select * from tbltodo;
-- completedate가 null 이 아닌 것 체크 
select * from tbltodo where completedate is not null order by adddate;

-- 시간이 초단위로 들어있네 ? 
select a.*, completedate - adddate as test from (select * from tbltodo where completedate is not null order by adddate) a order by test ;

select a.*, rownum as rnum from (select a.*, completedate - adddate as test from (select * from tbltodo where completedate is not null order by adddate) a order by test) a;

select * from (select a.*, rownum as rnum from (select * from (select * from tbltodo where completedate is not null order by adddate) order by completedate - adddate) a) where rnum <= 5;


-- 11. tblinsa. 남자 직원 중에서 급여를 3번째로 많이 받는 직원과 9번째로 많이 받는 직원의 급여 차액은 얼마인가?
-- 답
with thirdPay as (
select 급여 from (select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang as 급여 from tblInsa where substr(ssn,8,1) = '1' order by basicpay+sudang desc) a ) where rnum =  3),
ninethPay as (
select 급여 from (select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang as 급여 from tblInsa where substr(ssn,8,1) = '1' order by basicpay+sudang desc) a ) where rnum =  9)
select (select 급여 from thirdPay)
- (select 급여 from ninethPay ) as 차이
from dual;

-------------------------------------------------------------------------------------------------


-- 1. tblInsa. 남자 급여(기본급+수당)을 (내림차순)순위대로 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
select a.*, rownum from (select name, buseo, jikwi, (basicpay + sudang) as salary 
                                    from tblInsa
                                       where substr(ssn, 8, 1) = '1'
                                          order by (basicpay + sudang) desc) a;

-- 2. tblInsa. 여자 급여(기본급+수당)을 (오름차순)순위대로 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
select a.*, rownum from (select name, buseo, jikwi, (basicpay + sudang) as salary 
                                    from tblInsa
                                       where substr(ssn, 8, 1) = '2'
                                          order by (basicpay + sudang) asc) a;

-- 3. tblInsa. 여자 인원수가 (가장 많은 부서 및 인원수) 가져오시오.
select * from (select buseo, count(*) as cnt from tblinsa where substr(ssn, 8, 1) = '2'
   group by buseo order by count(*) desc) where rownum = 1;


-- 4. tblInsa. 지역별 인원수 (내림차순)순위를 가져오시오.(city, 인원수)
select city, count(*) as cnt from tblinsa
   group by city order by count(*) desc;

-- 5. tblInsa. 부서별 인원수가 가장 많은 부서 및원수 출력.
select * from (select buseo, count(*) as cnt from tblinsa
   group by buseo order by count(*) desc) where rownum = 1;

-- 6. tblInsa. 남자 급여(기본급+수당)을 (내림차순) 3~5등까지 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
select * from (select a.*, rownum as rnum from (select name, buseo, jikwi, (basicpay + sudang) as salary from tblinsa    order by (basicpay + sudang) desc) a) where rnum between 3 and 5;

-- 7. tblInsa. 입사일이 빠른 순서로 5순위까지만 가져오시오.
select * from (select * from tblinsa order by ibsadate asc) where rownum <= 5;

-- 8. tblhousekeeping. 지출 내역(가격 * 수량) 중 가장 많은 금액을 지출한 내역 3가지를 가져오시오.
select * from (select * from tblhousekeeping
   order by (price * qty) desc) where rownum <= 3;

-- 9. tblinsa. 평균 급여 2위인 부서에 속한 직원들을 가져오시오.
select * from (select a.*, rownum as rnum from (select buseo, avg(basicpay) from tblinsa
   group by buseo
      order by avg(basicpay) desc) a) where rnum = 2;

-- 10. tbltodo. 등록 후 가장 빠르게 완료한 할일을 순서대로 5개 가져오시오.
select a.*, round((completedate - adddate) * 24 * 60) || '분' from (select * from tbltodo
   order by (completedate - adddate) asc) a where rownum <= 5;

-- 11. tblinsa. 남자 직원 중에서 급여를 3번째로 많이 받는 직원과 9번째로 많이 받는 직원의 급여 차액은 얼마인가?
select () - () from dual;

select 
   (select basicpay from (select basicpay, rownum as rnum from (select basicpay from tblinsa where substr(ssn, 8, 1) = '1' order by basicpay desc)) where rnum = 3)
   -
   (select basicpay from (select basicpay, rownum as rnum from (select basicpay from tblinsa where substr(ssn, 8, 1) = '1' order by basicpay desc)) where rnum = 9) as "급여 차액"
from dual;   




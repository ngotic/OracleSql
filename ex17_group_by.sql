/* ex17_group_by.sql 

    [ with <sub query> ]
    select column_list
    from table_name
    [where search_condition]
    [group by group_by_expression]
    [having search_condition]
    [order by order_expression [asc|desc]];
    
    
    // _> 추가 *** 
    
    select 컬럼 리스트 
    
    group by 절 
    - 레코드를 대상으로 그룹을 나누는 역할
    - 특정 칼럼을 대상으로 같은 값을 가지는 레코드들끼리 그룹을 묶는 역할
    - 그룹을 왜 나누는지? > 각각의 나눠진 그룹을 대상 > 집계함수를 적용하기 위해서!!!!
    

*/

select * from tblComedian;

-- tblInsa. 부서별 평급 급여? 

select * from tblInsa; 

select avg(basicpay) from tblInsa; -- 155만원, 60명

select distinct buseo from tblInsa; -- 7개

select round(avg(basicpay)) from tblInsa where buseo = '총무부'; -- 171
select round(avg(basicpay)) from tblInsa where buseo = '개발부'; -- 138
select round(avg(basicpay)) from tblInsa where buseo = '영업부'; -- 160
select round(avg(basicpay)) from tblInsa where buseo = '기획부'; -- 185
select round(avg(basicpay)) from tblInsa where buseo = '인사부'; -- 153
select round(avg(basicpay)) from tblInsa where buseo = '자재부'; -- 141
select round(avg(basicpay)) from tblInsa where buseo = '홍보부'; -- 145
-- 이 작업을 줄이려고 groupby를 한다.

select * from tblInsa group by buseo; -- 이대로는 실행이 안된다. 에러가 난다. 
-- 컬럼리스트 때문이다. group by는 컬럼리스트에 아무거나 적을 수 없다. 제약이 있다. 
-- 1. 집계함수
-- 2. group by 의 기준 컬럼

select 
buseo, avg(basicpay)
from tblInsa
    group by buseo;

-- 남자 몇명? 여자 몇명? > 남녀별 각각 몇명인지? 
-- 남자 그룹, 여자 그룹의 카운트를 세야 한다. 
select * from tblComedian;

select count(*), gender from  -- 누가 누군지 모르니까 기준을 써준다.
tblComedian 
    group by gender;
    
-- 대륙별 국가수 ? 
select 
count(*), continent
from tblCountry
group by continent;

select 
    buseo, 
    count(*) as "부서별 인원수",
    sum(basicpay) as "부서별 급여 합",
    avg(basicpay) as "부서별 평균 급여",
    max(ibsadate) as "부서별 막내의 입사일",
    min(ibsadate) as "부서별 고참의 입사일"
from tblInsa
    group by buseo;
    
select 
gender,
round(avg(height)) as "남녀별 평균 키" ,
round(avg(weight), 1) as "남녀별 평균 몸무게" ,
max(height) as "키가 가장 큰사람",
min(height) as "키가 가장 작은사람"
from tblComedian
    group by gender ;
    
-- 직업별 인원수? > 많은 > 적게 순으로 통계를 구한다. 
select 
job,
count(*)
from tblAddressBook
group by job
-- order by count(*) desc;
order by job; 

-- 직업 이름순으로도 정렬

--select 
--    round(avg(basicpay)), --OK
--    buseo,     -- OK
--    name               -- 이것때문에 에러가 난다. 
--from tblInsa
--    group by buseo;

-- 1차 그룹(부서) > 2차 그룹(직위)

select -- 1차그룹 
buseo as "부서명",
count(*) as "인원수"
from tblInsa 
    group by buseo;
        
select -- 2차그룹 >> 세세하게 많아진다. 
buseo as "부서명",
jikwi as "직위명",
count(*) as "인원수"
from tblInsa 
    group by buseo, jikwi
        order by buseo, jikwi;

-- 성별 인원수?
select 
count(*), 
substr(ssn,8,1) as 가공
from tblInsa
group by substr(ssn,8,1); --?? 그룹을 나눌려면 적어도 동일한 값들을 가진 집단이 필요하다. 
-- group by의 조건도 컬럼 그자체가 아니라 가공된 조건으로 group by를 만들 수 있다. 
-- group by에는 alias로 못쓴다.

-- instr > indexOf이다. 
select instr('hellow','w') -- w의 위치는 6
from dual;


-- 지역별 인원수 ? 
-- 서울특별시 광진구 긴고랑로13길 5 ~ 42
-- 광주광역시 ~
-- 경기도 ~ 
-- 이걸 그룹으로 못쓰고 앞부분을 짤라내야한다. 
select 
substr(address, 1, instr(address,' ') -1 ) -- ' '공백의 지점은 딱 그 부분임 그래서 개수만큼 짜르니까 -1
from tblAddressBook
    group by substr(address, 1, instr(address,' ') -1 ); 
    
-- 가공한 것으로 group by하는 연습


-- 이메일 사이트별 인원수
-- prevent@gmail.com
-- international_dog@duam.net
-- small@gmail.com
-- daughter@daum.net 

select 
    substr(email, instr(email, '@')+1), -- 1차적으로 가공해보고 
    count(*)
from tblAddressBook
    group by substr(email, instr(email, '@')+1)
        order by count(*) desc;
        
        
-- 급여별 그룹 > 인원수?
 -- 100만원 이하
 -- 100만원 ~ 200만원 이상
 -- 200만원 이상
select 
    basicpay,
    floor(basicpay / 1000000)
    from tblInsa;

select 
    (floor(basicpay / 1000000)+1) *100 || '만원 이하' as "급여대",
    count(*)
    from tblInsa
        group by floor(basicpay / 1000000)
            order by floor(basicpay / 1000000) asc;

-- floor를 써보자 

-- 한일? 안한일? 각각 몇개? completedate의 존재 유무에 따라 달라진다. 
select 
completedate,
count(*) from tblTodo
group by completedate;
 

select 
    case 
        when completedate is null then '안한일' 
        when completedate is not null then '한일'
    end
    from tblTodo
        group by case 
        when completedate is null then '안한일'  
        when completedate is not null then '한일' 
    end;

-- select * from traffic_accident;
-- traffic_accident. 각 교통 수단 별(지하철, 철도, 항공기, 선박, 자동차) 발생한 총 교통 사고 발생 수, 총 사망자 수, 사건 당 평균 사망자 수를 가져오시오.
-- 이건 테이블이 없다.

-- tblZoo. 종류(family)별 평균 다리의 갯수를 가져오시오.
select * from tblZoo;
select floor(avg(leg)) "평균다리 개수" from tblZoo group by family;

-- tblZoo. 사이즈와 종류별로 그룹을 나누고 각 그룹의 갯수를 가져오시오.
select sizeof "사이즈", family "종류", count(*) "각 그룹개수" from tblZoo group by sizeof, family;

-- tblAddressBook. 이메일이 스네이크 명명법으로 만들어진 사람들 중에서 여자이며, 20대이며, 키가 150~160cm 사이며, 고향이 서울 또는 인천인 사람들만 가져오시오.
select *
from tblAddressBook;

select *
from tblAddressBook
where email like '%a_%' escape 'a' and
      gender ='f' and
      age >= 20 and age <30 and
      height >150 and height < 160 and
      hometown in ('서울', '인천') ; 

/*
 group by 절
 - 레코드를 대상으로 그룹을 나누는 역할
 - 특정 칼럼을 대상으로 같은 값을 가지는 레코드들끼리 그룹을 묶는 역할
 - 그룹을 왜 나누는거지? > 각각의 나눠진 그룹을 대상 > 집계 함수를 적용하기 위해서 !!!(***************)
 
select 컬럼리스트  --5. 컬럼을 선택
from 테이블       --1. 테이블로부터
where 조건        --2. 원하는 레코드를 
group by 기준     --3. 그룹을 나눠서
having절          --4. 그룹에 대한 조건
order by 정렬     --6. 정렬한다.

-- from, where, group by, having, select, order by
 
 select문(***)
 1. 각절의 역할
 2. 각절의 실행순서
 
 ** where절 vs having절 
 
 having절 > group으로 분류된 하나의 카테고리에 대한 조건이다. 
 - 조건절
 - group by으로부터 나온 셋에 대한 조건(실행 순서: group by > having)
 - 집합에 대한 질문 > 집계 함수값을 조건으로 사용 
 
 where절  > from에서 나온테이블에서 개개인에 대한 조건을 건다.
 - 조건절
 - from으로부터 나온 셋에 대한 조건(실행 순서 : from > where)
 - 개인에 대한 질문(행) > 컬럼값을 조건으로 사용
 
 
*/

select 
count(*), buseo --3.
from tblInsa    --1.
group by buseo; --2.


select 
    count(*), buseo           --4.
from tblInsa                  --1.
    where city = '서울'        --2.
        group by buseo;       --3.

select 
    count(*), buseo            -- 4.
from tblInsa                   -- 1. 
    where basicpay >= 2500000  -- 2. 
        group by buseo;        -- 3. 걸러진 상태에서 group by가 된다. 

select max(basicpay) from tblInsa group by buseo;

select name, buseo, jikwi, city, basicpay
from tblInsa
    where basicpay>=2500000;

select name, buseo, jikwi, city, basicpay
from tblInsa
    where basicpay>=2500000
        order by buseo;


select 
    buseo, 
    round(avg(basicpay))    --3. 나뉘어진 그룹별로 집계함수를 각각 구한다. 
from tblInsa                --1. 60명의 데이터를 가져온다. 
    group by buseo;         --2. 60명의 대상으로 > 부서로 그룹을 나눈다. 


select 
    buseo,
    round(avg(basicpay))
from tblInsa
    where basicpay >= 1500000  -- 1. 60명의 데이터를 가져온다.
        group by buseo;        -- 2. 60명을 대상을 조건에 맞는 직원만 남긴다.
                               -- 3. where절을 만족한 직원들을 대상으로 그룹을 나눈다. 

select 
    buseo,
    round(avg(basicpay))
from tblInsa                                 --1. 60명의 데이터를 가져온다.
        group by buseo                       --2. 60명을 대상으로 > 부서로 그룹을 나눈다. 
            having avg(basicpay) >= 1500000; --3. 그룹별 집계함수값을 조건으로 필터링 

-- having은 레코드를 대상으로 하지 않는다. 그룹들 중의 하나의 카테고리를 보고 필터링을 한다.
-- 부서중에 조건을 만족하는 부서를 걸러내는 역할을 한다. 
-- ex) 만약에 홍보부가 avg(basicpay) >= 1500000; 조건에 맞지 않으면 필터링이 된다. 

select 
    buseo, 
    round(avg(basicpay))                     -- 5.
from tblInsa                                 -- 1. 
    where basicpay >= 1500000                -- 2.
        group by buseo                       -- 3.
            having avg(basicpay) >= 2200000  -- 4. having으로 평균급여가 220만원 이상인 애들만 걸러라 
                order by avg(basicpay) desc; -- 6.

select name, buseo, jikwi from tblInsa where basicpay >= 1500000 order by buseo;

-- tblZoo. 체온이 변온인 종류 중 아가미 호흡과 폐 호흡을 하는 종들의 갯수를 가져오시오.
select breath, count(*) "갯수"
from tblZoo
where thermo = 'variable' 
group by breath;


-- tblAddressBook. 관리자의 실수로 몇몇 사람들의 이메일 주소가 중복되었다. 중복된 이메일 주소만 가져오시오.
select email --, count(*)
from tblAddressBook
group by email
having count(*) >= 2;

-- tblAddressBook. 성씨별 인원수가 100명 이상 되는 성씨들을 가져오시오.
select * from tblAddressBook;

select substr(name,1,1) -- , count(*)
from tblAddressBook
group by substr(name,1,1)
having  count(*) >= 100;


-- tblAddressBook. '건물주'와 '건물주자제분'들의 거주지가 서울과 지방의 비율이 어떻게 되느냐?
select job, count(*) "수",

sum(case 
    when instr(address,'서울') <> 0 then 1 else 0
end) "서울러",
sum(case 
    when instr(address,'서울') = 0 then 1 else 0
end) "지방러",
round( sum(case 
    when instr(address,'서울') <> 0 then 1 else 0
end)/count(address),2)*100 ||'%' "서울의 비율 ",

round( sum(case 
    when instr(address,'서울') <> 0 then 0 else 1
end)/count(address),2)*100 ||'%' "지방의 비율 "

from
tblADdressBook
group by job
having job='건물주' or job='건물주자제분';



select instr(address,'서울')
from tblAddressBook;

select count(address) "서울러" from tblAddressBook where job='건물주' and instr(address,'서울')<>0 ;
select count(address) "지방러 "from tblAddressBook where job='건물주' and instr(address,'서울') = 0 ;
select count(address) "서울러" from tblAddressBook where job='건물주자제분' and instr(address,'서울')<>0 ;
select count(address) "지방러 "from tblAddressBook where job='건물주자제분' and instr(address,'서울') = 0 ;
select count(address) from tblAddressBook where job='건물주자제분';


/*

cube()

rollup()
    -group by 반환 결과에서 자세하게 표현
    

*/

select 
    buseo,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by buseo;
    
select
    buseo,
    jikwi,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by rollup(buseo, jikwi);
 
select
    buseo,
    jikwi,
    city,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by buseo, jikwi, city;
  
select
    buseo,
    jikwi,
    city,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by rollup(buseo, jikwi, city);

 
-- 잘써먹으면 보고서 만들기 좋다.  > 이렇게 안해주면 수많은 쿼리를 날려야 한다. 
-- 이것에 대한 생산성을 도와준다. 
-- 근데 format 형태가 이런 형태라서 안쓰는 경우도 많음 


/*
     cube()
     - group by 결과에서 집계 결과를 더 자세하게 반환
     - rollup() 보다 좀 더 자세하게 표현 
     - rollup() 에 비해 좀 더 다양한 기준으로 중간 집계 추가 
*/


select 
    buseo,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by cube(buseo);
    
-- 1차 그룹은 rollup과 cube는 같다. 순서만 같다.

select 
    buseo,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by rollup(buseo);


select 
    buseo,
    jikwi,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by cube(buseo, jikwi);


select 
    buseo,
    jikwi,
    city,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by cube(buseo, jikwi, city);
    
-- 적당한 차원수에서 cube를 써라.. 배보다 배꼽이 ???     
    

/*

    ex25_with.sql
    
    [with <sub query> ]  - with절
    select column_list
    from table_name
    [where search_condition]
    [group by group_by_expression]
    [having search_condition]
    [order by order_expression [asc|desc]];
    
    with절
    - 인라인뷰(from절 서브쿼리)에 이름을 붙이는 기술
    
    with 임시테이블명 as (
        결과셋 select문
    )
    select 문; 
    
    with절 실행 방식 ]
    1. Materialize 방식 > 임시 테이블이 2번이상 사용되면 내부에 임시 테이블 생성 + 반복 재사용 > with절 먼저 
    -- 처음 호출시 임시로 메모리에 만들고 그것을 재사용한다. : 이점 > 속도상의 이득이다. 추가적인 이득을 볼 수 있다. 
    
    2. Inline 방식 > 임시 테이블 생성없이 매번 인라인 쿼리를 반복 실행 > 일반적으로 메인쿼리 먼저 실행되고 서브쿼리 같이 실행
    
    -- [ 한번 쏵 스캔함 그리고 동일 테이블이 여러개 있나 확인해서 있으면 1번, 아니면 2번 ]
        
*/

select * from (select name, buseo, jikwi from tblInsa where city = '서울');

with seoul as (select name, buseo, jikwi from tblInsa where city ='서울' )
select * from seoul; 
-- with절 단독으로 못쓴다. select문에 딸려있는 것 
-- 순서상 with절이 먼저 나온다. 
-- 이로 인해서 얻는 이득 : 메인쿼리가 짧아진다. 


select * 
    from (select name, age, couple from tblMen where weight < 90) a
            inner join (select name, age, couple from tblwomen where weight > 60 ) b 
                on a.couple = b.name;
                
-- 가독성이 떨어진다....                
-- with절 테입르 임시테이블인데 실제로는 하드에 저장 x, 만들어졌다가 버려짐 
with a as (select name, age ,couple from tblmen where weight < 90),
     b as (select name, age ,couple from tblwomen where weight > 60) 
    select * from a inner join b on a.couple = b.name;
            
            
-- 순위함수 or rownum 

-- 급여 5위

select
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa;

select * from (
select
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa
) where rnum = 5;


with insa as (
select
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa
)
select * from insa where rnum = 5;





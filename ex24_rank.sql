/*
ex24_rank.sql

순위함수
- rownum의 사용을 여러가지 용도로 구현해놓은 함수

** over 안에 order by는 필수,,,, 

1. rank() over()
    - rank() over(order by 컬럼명 [asc|desc])
    - 순위 부여시, 중복값이 발생하면 동일한 순위를 부여하고, 중복값의 개수만큼 건너뛰기 한다.
    
2. dense_rank() over()
    - dense_rank() over(order by 컬럼명 [asc|desc])
    - 순위 부여시, 중복값이 발생하면 동일한 순위를 부여하고, 그 뒤의 순위는 건너뛰기 안하고 순차적으로 부여한다.
    
3. row_number() over()
    - row_number() over(order by 컬럼명 [asc|desc])
    - 순위 부여시, 중복값과 상관없이 순차적으로 부여
    - 직접 rownum을 사용한 결과와 동일 
*/

select a.*, rownum from (select name, buseo, basicpay from tblInsa order by basicpay desc) a;

select name, buseo, basicpay, rank() over(order by basicpay desc) as  rnum from tblInsa;

select name, buseo, basicpay, dense_rank() over(order by basicpay desc) as  rnum from tblInsa;

select name, buseo, basicpay, row_number() over(order by basicpay desc) as  rnum from tblInsa;

-- 급여 5위 
select name, buseo, basicpay,
       row_number() over(order by basicpay desc) as  rnum 
from tblInsa
    where rnum = 5; -- alias가 안써진다.... !? > 실행순서 때문에 from . where 순인데 rnum이 아직은 안생겼으니 where절에서 못쓴다. 
    

select name, buseo, basicpay,
       row_number() over(order by basicpay desc) as  rnum 
from tblInsa
    where (row_number() over(order by basicpay desc)) = 5; 
    
-- alias가 안써진다.... !? > 실행순서 때문에 from . where 순인데 rnum이 아직은 안생겼으니 where절에서 못쓴다.  
-- 실패!! 순위 함수도 where절에 못적는다.
-- 결론은 얘도 서브쿼리로 만들어야 한다.  > 순위를 조작하려면 적어도 서브쿼리가 필수다. 

-- rownum을 직접쓰는거보다 한단계 생략과정이 있어서 조금은 줄었다. 
select * from ( select 
                    name, buseo, basicpay,
                    row_number() over(order by basicpay desc) as rnum 
                from tblInsa )
                        where rnum = 5;
                        
-- 이 방법도 약간은 호불호가 갈린다. 순위함수 쓸 때는 순위함수를 쓰고 ~ 
    

select * from (select
                    name, buseo, basicpay,
                    dense_rank() over(order by basicpay desc ) as rnum
               from tblinsa)
                    where rnum = 8; -- 복수개가 나올 수 있다. 
    
select * from (select
                    name, buseo, basicpay,
                    rank() over(order by basicpay desc ) as rnum
               from tblinsa)
                    where rnum = 9; -- rank_over에서 건너뛰기 당하면 찾지 못한다.



select name, buseo, basicpay, rank() over(order by basicpay desc, name asc) as  rnum from tblInsa;
-- 2차정렬을 넣으면 비교 기준이 늘어나게 된다. 1차 정렬에선 동순위가 또 순위가 메겨질수도 있다.

update tblInsa set sudang = 200000 where name = '이미인';

select name, buseo, basicpay, sudang, rank() over(order by basicpay desc, sudang desc) as  rnum from tblInsa;

-- 다중 정렬도 개입이 되서 등수에 영향을 미친다. 

/*
    그룹별 순위 구하기 
    - 순위 함수 + group by 
    
*/

-- 급여 + 순위 
select 
    name, buseo, basicpay
from tblInsa;

select -- 급여순으로 순위를 매긴 것 
    name, buseo, basicpay,
    dense_rank() over( order by basicpay desc) as rnum
from tblInsa;

-- 부서별( 급여 + 순위 ) > 전제조건을 건다. 
select 
    name, buseo, basicpay,
    dense_rank() over(partition by buseo order by basicpay desc) as rnum 
from tblInsa;
-- group by buseo; 안써진다. > 근데 이게 rank 관련 집계 함수가 그런것 
-- order by는 꼭 써줘야 하네? 

select 
    name, buseo, basicpay,
    rank() over(partition by buseo order by basicpay desc) as rnum 
from tblInsa;

select 
    name, buseo, basicpay,
    row_number() over(partition by buseo order by basicpay desc) as rnum 
from tblInsa;

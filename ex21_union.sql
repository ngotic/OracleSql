/*

    ex21_union.sql
    
    관계 대수 연산
    1. 셀렉션 > select where
    2. 프로젝션 > select column
    3. 조인 > a join b
    4. 합집합, 차집하브 교집합
    
    union 
    - 합집합
    
    intersect 
    - 교집합
    
    minus 
    - 차집합
    
*/  

-- 조인: 컬럼 + 컬럼
-- 유니온 : 레코드 + 레코드
-- select * from tblMen + select * from tblWomen; 결과셋을 합치는 것이다.

select * from tblMen    -- 이정도 들여쓰기를 한다.
union 
select * from tblWomen; -- 남자 10명, 여자 10명이 한꺼번에 섞여 있다.

--- 회사 부서별 > 게시판 ------------------
-- 통으로 ~
select * from 게시판; -- 4천만건

-- 나눠서 ~
select * from 영업부게시판; -- 천만건
select * from 총무부게시판; -- 2천만건
select * from 개발부게시판; -- 천만건

--- 사장님 > 모든 부서의 게시판 > 한번에 열람
-- 한번에 ~
select * from 영업부게시판
union
select * from 총무부게시판
union
select * from 개발부게시판;
-----------------------------------------

-- SNS > 게시물 > 년도별로~ > 싸이월드
select * from 게시판2020;
select * from 게시판2021;
select * from 게시판2022;
select * from 게시판2023;

select * from 게시판2023 where 검색; 
-- 내역을 나누는 이유는 이렇게 테이블이 나뉘어졌을 수도 있고 
-- 나누는 이유는 검색이 과부하가 오니까 ... 

select * from 게시판2020
union
select * from 게시판2021
union
select * from 게시판2022
union
select * from 게시판2023
where 검색;

-- 평소에 나눠서 저장했다가 나중에 전체 검색을 하기위해 합쳐서 검색

-- ★ 조건 > 스키마(컬럼의 순서와 개수, 자료형)가 동일해야 한다.
-- ★ 조건> 데이터의 성질이 동일해야 한다.
select * from tblCountry -- 5개 칼럼
union
select * from tblInsa;   -- 10개 칼럼

select name, capital, population from tblCountry  -- 성질이 맞지가 않다.
union 
select name, buseo, basicpay from tblInsa;        -- 성질이 맞지가 않다.


create table tblUnionA ( 
    name varchar2(30) not null
);

create table tblUnionB ( 
    name varchar2(30) not null
);

insert into tblUnionA values ('강아지');
insert into tblUnionA values ('고양이');
insert into tblUnionA values ('토끼');
insert into tblUnionA values ('거북이');
insert into tblUnionA values ('병아리');

insert into tblUnionB values ('호랑이');
insert into tblUnionB values ('사자');
insert into tblUnionB values ('강아지');
insert into tblUnionB values ('코끼리');
insert into tblUnionB values ('고양이');

select * from tblUnionA;
select * from tblUnionB;

--[ union > 수학 집합의 개념 > 합집합 > 중복값 허용X ]
select * from tblUnionA
union 
select * from tblUnionB;

-- union all > 중복값 허용 O
select * from tblUnionA
union ALL
select * from tblUnionB;

-- intersect > 교집합
select * from tblUnionA
intersect
select * from tblUnionB;

-- minus > 차집합
select * from tblUnionA
minus 
select * from tblUnionB;

select * from tblUnionB
minus 
select * from tblUnionA;




/* 


2. 계정
3. 제약사항
4. 시퀀스
5. 뷰

 ex20_view.sql 
 View, 뷰 
    - 데이터베이스 객체 중 하나
    - 가상 테이블, 뷰, 테이블 등..
    - 테이블처럼 사용한다.(*****)
    - 뷰는 SQL을 저장한 객체이다.
    - 뷰는 호출될때마다 저장된 SQL이 실행된다.(실시간 가장 테이블)
    
    View 역할(목적)
    1. 쿼리를 단순화한다. > 가독성 향상 > 긴쿼리를 줄여주지만 거기다가 이름을 붙이면 가독성이 높아진다.
    2. 보안적인 측면에서 관리한다.
    3. 쿼리 > 다른 사용자(hr 등)과 공유
    
    create view 뷰명
    as 
    select 문;
    
    create [ or replace ] view 뷰명 
    as 
    select문;
*/

-- 이건 누누히 말하자면 테이블은 아니다. 
create or replace view vwInsa -- tblInsa 테이블의 복사본 > 복사한거처럼 생각 
as 
select * from tblInsa;

select * from vwInsa; -- tblInsa 처럼 행동 

-- 테이블이나 시퀀스는 or replace를 넣지 못해서 쓸 수 없다. 
create or replace view vwInsa -- 만들래!? 아니면 바꿀래!? 
as 
select name, jikwi, city, buseo from tblInsa where buseo = '영업부';
-- 여기 적힌 select문을 어떻게 만드냐가 관건이다. 

select * from vwInsa; -- 뷰 == 영업부 테이블

-- 영업부 목록 가져오기(컬럼4개)
select name, jikwi, city, buseo from tblInsa where buseo= '영업부';
select * from vwInsa;

select * from tblVideo; -- 장르 

-- 비디오 대여점 사장 > 날마다 하는 업무가 있다. 
create or replace view 대여체크
as -- 아래처럼 정말 긴 쿼리를 뷰로 만든다. 
select 
    m.name as nname,
    v.name as vname,
    to_char(r.rentdate, 'yyyy-mm-dd') as rentdate,
    case
        when r.retdate is not null then '반납완료' else '미반납'
    end as state,
    case 
        when r.retdate is null 
            then (sysdate-(r.rentdate + (select period from tblGenre where seq = v.genre)))
    end as 연체일수
    ,case
        when r.retdate is null
            then round( (sysdate-(r.rentdate + (select period from tblGenre where seq = v.genre)))* g.price * 0.1 )
    end as 연체금 -- 대여가격(10%) x 연체일
--    r.rentdate as "대여날짜",
--    (select period from tblGenre where seq = v.genre) as "대여기간(일)",
--    r.rentdate + (select period from tblGenre where seq = v.genre) as "반납날짜",
--    sysdate-(r.rentdate + (select period from tblGenre where seq = v.genre)) as "연체기간(일)"
from tblRent r
    inner join tblVideo v
        on v.seq = r.video
            inner join tblMember m
                on m.seq = r.member
                    inner join tblGenre g 
                        on g.seq = v.genre
                           order by state asc;

-- 대여날짜
-- 대여기간
-- 현재날짜
-- 현재날짜 - ( 대여날짜 + 대여기간 )
-- 현재날짜 - 반납날짜 

select sysdate - ( r.rentdate + 3 ) from tblRent r; 
-- 연체한 시간임 이 3 이라는 시간 어디서 나옴?? 
-- 이거 장르테입르에 있다... 아 그거였음? 

select * from tblRent;
select * from tblGenre;
-- select sysdate - ( r.rentdate + (select priod from tblGenre where seq = ) ) from tblRent r; 

select * from 대여체크; 
-- 비디오 가게 사장님이 날마다 해야함 그래서 이걸 재사용해서 가져온다. 
-- 긴 쿼리를 반복적으로 사용할 때 짤막하게 재호출 가능하다. 

-- 뷰를 이용해서는 기존 테이블의 수정과 삭제가 불가능하다.

-- 뷰 정의 > select 결과셋의 복사본  > 데이터 저장한 객체(X)
-- 뷰 정의 > select 문을 저장한 객체 > SQL 저장한 객체(메소드)

create or replace view vwComedian -- 뷰는 쿼리 자체를 그대로 저장함 
as 
select * from tblComedian;  -- 원본 테이블 

-- 데이터를 복사한 것이 아니거 select문을 복사한 것이다.


select * from vwComedian;                  -- 뷰 테이블 재사용을 목적으로 한다.
select * from (select * from tblComedian); -- 근데 사실상 from 서브쿼리와 같다. 
                                           -- 인라인뷰 > 1회용

update tblComedian set
    weight = 70 where first = '재석';
    
select * from tblComedian;    

-- view를 보면 view를 정의한 문장으로 가서 

-- view는 쿼리 자체를 기억한다. 


-- 생성된 뷰를 다음 테이블에서 확인
select * from user_views;


-- 보안(권한)
select * from tblInsa;
-- 신입사원 > 영업부 > 업무 > 영업부 직원들에게 일괄 문자 메세지 전송
select * from tblInsa; -- 신입사원에게 tblInsa 접근할 권한  > tblInsa 접근 권한 > 신입사원한테 권한 뺏음
-- 아예 막아버리고 view를 만든다.

drop view 연락처;

create or replace view 연락처
as 
select name, tel from tblInsa where buseo ='영업부';

select * from 연락처; -- 신입사원에게 연락처 객체에 대한 접근 권한만 부여, 이러면 연락처만! 다른 접근은 못하게! > 보안과 관련된 뷰의 역할 



create or replace view vwTodo
as
select * from tblTodo; 

select * from vwTodo;
insert into vwTodo values (21, '오라클 복습하기', sysdate, null); -- 이게 됨??

select * from tblTodo; 

update vwTodo set title = '오라클 정리하기' where seq = 21;

delete from vwTodo where seq = 21;

-- 뷰가 insert, update, delete 도 된다. 뷰를 대상으로 명령어를 썼는데 심지어 원본도 바뀐다. 

-- 뷰 사용
-- ★ 무조건 select 전용으로 한다.
-- 1. select > 실행 O > 뷰는 읽기 전용이다.(***) == 읽기 전용 테이블 
-- 2. insert > 실행 O > 절대 사용 금지 > 뷰에다가 하지말고 직접 테이블 대상으로 해라
-- 3. update > 실행 O > 절대 사용 금지 > 뷰에다가 하지말고 직접 테이블 대상으로 해라
-- 4. delete > 실행 O > 절대 사용 금지 > 뷰에다가 하지말고 직접 테이블 대상으로 해라

select * from vwTodo; -- 단순뷰 > 뷰의 select문이 1개의 테이블로 구성


select * from 대여체크; -- 복합류 > 2개 이상의 테이블이 모여서 select를 날림 > 
insert into 대여체크 values('홍길동', '반지의 제왕',
                            sysdate, '미반납', 0, 0); -- 이게 되겠냐?? > 얘네들은 우리가 계산해서 만든 것이다.
                            
-- 복합류는 이 데이터를 넣을 수 없는 애들이 대부분이다. 되는 애는 쓰고 안되는 애들은 안쓰는데 밖에서 구분할 방법이 없다.
-- 만든 사람만 알 수 있다. > 관리자 같이 얘네들의 정의를 들여다 보는 친구들만 쓴다. 

-- 그래서 insert, update, delete를 안된다고 가정한다. 이게 말이 안됨 




















/*

    ex16_update.sql
    
    update 
    - DML
    - 데이터 수정하는 명령어
    - 원하는 행의 원하는 컬럼값을 수정하는 명령어
    
    구문
    - update 테이블명 set 칼럼명 = 값;
    
    - update 테이블명 set 컬럼명 = 값, 컬럼명 = 값, 컬럼명 = 깂;
    
    - update 테이블명 set 컬럼명 = 값 where절;
    
    - update 테이블명 set 컬럼명 = 값 [, 컬럼명=값 ] x N [where절] : 수정할거 컬럼명=값 쓰고 where절은 왠만하면 붙이고 
    
*/

commit;
rollback;

select * from tblCountry;

-- 대하민국: 서울 > 세종
update tblCountry set capital = '세종'; -- where없이 이렇게 바꾸는 경우 안된다. 큰일난다. -- 모든 레코드를 대상으로 한다.
rollback;
update tblCountry set capital = '세종' where name = '대한민국'; --1행이 업데이트 됨
rollback;

update tblCountry set 
    name ='한국', capital ='제주', continent='EU'
    where name ='대한민국';
    

-- 모든 나라의 인구 증가!! > 일괄적으로 증가 > 10% 증가 > 4405 > 4845.5
update tblCountry set population = population * 1.1;
-- null * 1.1 하면 null이 나온다. 연산의 대상이 되지 않지만 피연산자가 되면 결과가 null이 나온다.

-------------------------------------------------------------------------------------



/*
    delete 
    - DML
    - 데이터 삭제하는 명령어
    - 행을 삭제하는 명령어
    
    구문 
    - delete [from] 테이블명 [where절]
    
*/
commit;
rollback;

select * from tblCountry;

delete from tblCountry where name = '일본';

delete from tblCountry where continent = 'EU';

delete from tblCountry;


-- update, delete > 실수
-- 1. 백업
-- 2. commit/rollback > 트랜잭션 > 현재 세션에 한해서다... 이번 접속이 끈기면 이어지지 않는다. -- 범위가 조금은 좁은 형태의 관리다.
-- 3. 스크립트를 가지고 있는 경우


desc tblCountry;
select MIN(name)
from tblInsa;


select name
from tblInsa
where buseo not in ('개발부', null);


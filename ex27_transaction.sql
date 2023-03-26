/*

    ex27_transaction.sql
    
    트랜잭션, Transaction
    - 데이터를 조작하는 업무의 시간적 단위
    - 일련의 사건의 집합. ex) 은행에서 돈을 인출하는 행동( 1~ 8번 행동) 
    
    트랜잭션 명령어
    - DCL, TCL(Transaction Control Language) 
    1. commit
    2. rollback
    3. savePoint
    
*/

-- 테이블을 만드는데 기존 테이블을 복사 > 완전한 복사본 > 데이터 카피
create table tblTran
as
select name, buseo, jikwi from tblInsa;


-- ************** 어떤 명령어를 어떤 순서대로 실행했는지 반드시 기억해야 한다. 
commit; -- 먼저 이걸 실행 > 이 시각부터 새로운 트랜잭션이 시작된다.!
-- > insert, update, delete만 트랜잭션에 포함한다. 데이터에 변화를 줄 수 있는 명령어만 관리 
-- 현재 시작시킨 트랜잭션은 delete 만 들어있다. select는 안들어있다. 이상태에서 또다른 commit이던 rollback이던 한다. 


select * from tblTran where name='박문수';

delete from tblTran where name ='박문수';

-- 우리가 하는 모든 insert, update, delete는 데이터베이스에 적용되지 않는다.
--> 임시로 메모리에 적용된다. 실제 DB에 적용이 안된다. 

-- commit;   -- 현재 트랜젝션에 썻던 모든 명령어를 있었던 일로 만들어라.
rollback; -- 현재 트랜잭션에 했던 모든 명령어를 없었던 일로 만들어라. > 이순간 이전 commit시점으로 돌아간다. 
-- rollback 직후 > 이전 트랜잭션 완료시점으로 간다. > 새로운 트랜잭션이 시작된다. 그리고 또 지금부터하는 모든 행동들이 기록된다. 

-- Transaction 시작!  > Tx1

select * from tblTran where name='박문수'; 

delete from tblTran where name='홍길동';  --  Tx1 
update tblTran set jikwi = '대리' where name='이순신'; -- Tx1
commit; -- 현재 트랜잭션의 모든 작업을 실제 DB에 반영 > 현재 트랜잭션 완료> 새로 트랜잭션 시작~ 

select * from tblTran;
-- 야 ... 길동이 지우면 안됬대... !? 이젠 되돌리지 못한다.

rollback; -- 다시 롤백을 하더라도 
select * from tblTran; -- 되돌리지 못한다.

-- where을 안붙이고 바로 알아차렸으면 롤백을 바로 하면되는데
-- 그걸 까먹고 잊다가 나중에 깨닳으면 이걸 돌릴수가 없다. 



/*

    트랜잭션이 언제 시작하고? 언제 끝나는지?
    
    새로운 트랜잭션이 시작하는 경우
    1. commit 실행 직 후
    2. rollback 실행 직 후
    3. 클라이언트 접속 직 후 (로그인)
    
    현재 트랜잭션이 종료되는 경우 
    1. commit 실행 > 현재 트랜잭션을 DB에 반영을 한다. 
    2. rollback 실행 > 현재 트랜잭션을 DB에 반영하지 않는다. 
    3. 클라이언트 접속 종료 
        a. 정상 종료
            - 현재 트랜잭션에 아직 반영 안된 명령이 남아있으면 사용자에게 질문? 
        b. 비정상 종료 > 작업관리자로 강제 종료
            - 커밋했을까? 롤백했을까? 
            - 뭐든 된게 아니라 둘다 안된 것이다. Tx의 행동이 DB에 반영이 안되었다.
            - 이순신은 실제 DB에서 지워지지 않았다. 
    4. DDL 실행 > DB 특성!! 오라클인 일단 이렇다. 
        a. create, alter, drop, rename, 시퀀스생성도 > 실행 > 그 즉시 commit 동반!!!
            - 위의 핻옹은 DB 구조 변경> 데이터 영향 O > 사전에 미리 저장 
            
    
*/

delete from tblTran where name ='이순신';

select * from tblTran where name='이순신';

-- 잠시 뒤에 commit or rollback ? > 보류 

-- 테이블 or 시퀀스 
create sequence seqTest; -- >> 이게 의심된다. 

rollback;

select * from tblTran; -- 이순신은 영영 갔다.

-- start!!!!
select * from tblTran where name ='이기자'; 
delete from tblTran where name ='이기자';
rollback;
select * from tblTran where name ='이기자'; 

-- 개인작업은 transaction을 켜놓는데 팀작업은 불편할 때가 많다.....
-- 그래서 상황에 맞게 조절하라고 자동커밋이 있다. 


commit;

select * from tblTran;

delete from tblTran where jikwi = '사원';

select count(*) from tblTran;



-- 3. savepoint > 꼼꼼한 사람들은 잘쓰는거임 ㅋ
-- rollback하는 시점을 사용자가 마음대로 정의한다. 이름 그래도 savepoint
commit;



select * from tblTran;

-- 김종서
update tblTran set jikwi = '이사' where name ='김종서'; -- 가.
select * from tblTran where name = '김종서';
savepoint a;

-- 허경윤
delete from tblTran where name = '허경운';             -- 나.
savepoint b;


insert into tblTran values('하하하', '기획부', '사원'); -- 다.

rollback to b;
select * from tblTran;
-- 하하하 넣은거 없어짐

--      시작  u     d       i     현재 
--------|----|------|------|------|-----------------------
------------    가       나    다

rollback to a; -- 허경운이가 살아옴
select * from tblTran where name ='허경운'; 

commit;


/*
    ex14_sequence.sql
    
    데이터베이스 객체
    1. 테이블
    2. 계정(hr)
    3. 제약사항
    4. 시퀀스 
    
    시퀀스, Sequence
    - 데이터베이스 객체 중 하나 
    - 오라클 전용 객체(다른 DMBS에는 없음) 
    - 일련번호를 생성하는 객체(**********) 
    - (주로) 식별자를 만드는 용도로 많이 사용한다. > PK 컬럼에 일련 번호를 넣을 때 많이 사용한다.
    
    mysql > auto increment라는 걸 제공  > 일련번호를 만드는 기능을 자체적을 보유하는데 이게 표준이 아니다.
    표준이 아니라 유틸리티성 기능이다. db마다 다른 형태로 제공하는 것인데 비슷비슷하다. 오라클의 sequence 가 조금 불편하다.   
    
    시퀀스 객체 생성하기
    - create sequence 시퀀스명 [옵션];
    
    시퀀스 객체 삭제하기
    - drop sequence 시퀀스명;
    
    시퀀스 객체 사용하기
    - 시퀀스명.nextVal > 주로 사용 > 다음 숫자
    - 시퀀스명.currVal > 가끔 사용 > 현재 숫자
    ☞ 딸랑 이거다...
*/

create sequence seqNum;
drop sequence seqNum;

select seqNum.nextVal from dual;
-- 실행을 반복하면 1부터 점점 증가된다. 일련 번호를 만드는 애다. 

create sequence seqTest;
select seqTest.nextVal from dual;
-- 시퀀스는 서로 독립적이고 각자 자기번호만 센다.! 

-- 이상태에서 sql developer를 끈다. > 서버도 죽인다. services.msc 

select seqTest.nextVal from dual; -- 서버를 끄고 다시 접속했는데도 영구적으로 남아있는 기록이라 다서 써도 기록이 남는다. 

drop table tblMemo;

create table tblMemo (
    seq number(3) primary key,
    name varchar2(50),
    memo varchar2(1000),
    regdate date
);

create sequence seqMemo;

insert into tblMemo(seq, name, memo, regdate) 
    values (seqMemo.nextVal, '홍길동', '메모입니다. 안녕하세요.', sysdate);
    
select *from tblMemo;

insert into tblMemo(seq, name, memo, regdate) values(seqMemo.nextVal, '홍길동', '메모입니다. 안녕하세요.> ' || seqMemo.nextVal , sysdate);

-- currVal > 시퀀스 객체가 마지막에 만든 숫자를 의미한다. 확인하는 함수이다. > 큐, 스텍 peek() 역할 
select seqMemo.currVal from dual; 
-- 로그인을 한 뒤(접속) 최소 1회 이상 nextVal를 호출하고 난뒤에만 currVal를 호출할 수 있다. 
-- 아무리 호출해도 숫자가 증가되지 않는다. 그런데 이게 좀 불편하다. 

-- 일련번호 > 숫자로만 x
-- 쇼핑몰 상품번호 > ABC10010 > 영어:카테고리, 숫자:아이템 번호

select seqNum.nextVal from dual;

select 'ABC' || seqNum.nextVal from dual;

select 'ABC' || to_char(seqNum.nextVal, '0000') from dual; -- 중간에 공백이 생긴다. > 부호자리는 기본 

select 'ABC' ||  ltrim(to_char(seqNum.nextVal, '0000')) from dual; -- 공백이 사라진다. 

select -seqNum.nextVal from dual;
select -seqNum.currVal from dual;  -- 반드시 nextVal을 선행하고 나서 써야 한다. 


/*

    시퀀스 객체 생성하기
    create sequence 시퀀스명 ;    
    create sequence 시퀀스명
                    increment by n  -- 증감치(**)
                    start with n    -- 최댓값
                    minvalue n      -- 최솟값 
                    cycle           -- 루프 
                    cache n;        -- 캐시 
*/

drop sequence seqNum;
create sequence seqNum;
-- 메모장을 초기화하면 이걸 드랍시키고 다시 만든다.

insert into tblMemo(seq, name, memo, regdate) 
    values (seqNum.nextVal, '홍길동', '메모입니다. 안녕하세요.', sysdate);
-- 시퀀스를 지우고 다시만듬 그리고 다시 생성하고 넣음 >>> 기존에 값과 충돌난다. 
-- 이 제약사항에 위반이 난다. ORA-00001: unique constraint (HR.SYS_C007260) violated
-- 이게 새로 시퀀스를 만들어서 1부터 넣으려니까 그렇다. 이럼 기존에 있는 게시판 값 번호로 다시 되돌려야함..
--> 함부로 시퀀스 객체를 지우면 안된다. 지웠다가 다시 만드는 것은 어렵지 않음
select seqNum.nextVal from dual;

select *from tblMemo;

-- 아 그러면 엄청나게 큰 수로 시작하려면 start with를 붙여준다. 
drop sequence seqNum;
create sequence seqNum 
                start with 200;
                
select seqNum.nextVal from dual;                

-- 메모장의 마지막 번호를 눈으로 본다. 

select max(seq) from tblMemo;
drop sequence seqNum;

create sequence seqNum 
                start with 23;

-- create sequence seqNum start with select max(seq) from tblMemo;  -- 서브쿼리를 넣을 수 없다.

drop sequence seqNum;
create sequence seqNum 
                start with 2;
create sequence seqNum 
                increment by 2;


create sequence seqNum
                increment by 100;
select seqNum.nextVal from dual;                                
create sequence seqNum
                increment by -1;
                

create sequence seqNum
                start with 100
                increment by -1
                maxvalue 100; -- 이 값을 넘을 때 문제가 되는것 걸치면 상관없다. 
                
select seqNum.nextVal from dual;       

drop sequence seqNum;

create sequence seqNum
                maxvalue 10; -- 10 넘어가면 에러다. 

select seqNum.nextVal from dual;                   

--declare
--TEST_STR VARCHAR2(10);
--vNum number;
--
--IS
--vNum := 23;
--
--begin
--
--
--query := 'create sequence seqNum
--                start with ' || vNum ;
--end;
--                pl/sql로 구성해보기 

drop sequence seqNum;

create sequence seqNum
                increment by 1
                start with 1
                maxvalue 10
                cycle    -- 루프 
                cache 5; -- 10보다 작은 값 줘야 한다. 
                -- cache 는 프로젝트 규모에 따라 다르다. 잘나가는 사이트는 많이많이 큰 수를 쓴다. 
                
select seqNum.nextVal from dual; -- 10까지 가고 다시 1로 시작한다.

-- 메모번호 > 1다음에 반드시 2??? 아니다. > 유일한 식별자가 메모번호다.

-- 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 

-- 버그 > 가끔씩 캐시 날라감
-- 게시판 글쓰기 > 마지막 15번~ 다시 글쓰기 해야지 하는데 갑자기 글번호가 21번부터 시작할 수 있다.
-- 가끔식 캐시가 날라간다. 왜 16번으로 시작을 안하지 고민을하지마라 21번부터 다시시작해라 그게 일반적인 것이다.
-- 만약 진짜로 구멍이 생기면 안되는 번호가 있다. 

drop sequence seqMemo; -- 시퀀스를 버리고 다시 만든다.

create sequence seqMemo start with 16;
-- 가끔씩 번호가 튀는데 이게 캐쉬가 터지는 경우 그래서 위처럼 메꾸면 된다.. 그걸 조절하는 옵션이 캐쉬다. 




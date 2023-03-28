/* ex30.sql */


-- 일련번호가 필요한 업무 > 순차적으로 증가하는 숫자(날짜)가 필요한 업무에 많이 쓰는 기법
-- 오라클 전용 > 계층형 쿼리 

select 
    level, 
    prior name as "상사",
    name as "직원"
from tblSelf
    -- start with name = '홍사장'
        connect by super = prior seq;

-- 계층형 쿼리는  > start with절을 생략할 수 있다. 
-- 모든 애들을 start점으로 삼는다. 

-- ****** 기억
select 
    level
from 
    dual connect by level <= 5 ; -- 무한루프에 빠진다. 이 레벨이 계속 깊어진다. 

-- [ 2023-03-01 ~ 2023-03-31 > date ] 
-- 1. ANSI-SQL > 계층형 쿼리 
-- 2. PL/SQL
-- 3. Java

-- 알아서 숫자를 만들어준다. 
select 
    to_date('2023-03-01','yyyy-mm-dd') + level -1
from dual
    connect by level <= 31;

-- 이런것을 응용하면 근태 상황을 만든다.(출석) > 학교에 직접 출석했을때만 기록한다.
create table tblDate (
    seq number primary key,      -- 번호(PK)
    state varchar2(30) not null, -- 정상|지각|조퇴
    regdate date not null        -- 날짜
);


-- 공유일도 이슈다. !!!!

insert into tblDate values (1, '정상', '2023-03-01');
insert into tblDate values (2, '정상', '2023-03-02');
insert into tblDate values (3, '정상', '2023-03-03');
--insert into tblDate values (4, '정상', '2023-03-04');
--insert into tblDate values (5, '정상', '2023-03-05');
insert into tblDate values (6, '정상', '2023-03-06');
insert into tblDate values (7, '지각', '2023-03-07');
insert into tblDate values (8, '조퇴', '2023-03-08');
insert into tblDate values (9, '정상', '2023-03-09');
insert into tblDate values (10, '정상', '2023-03-10');
--insert into tblDate values (11, '정상', '2023-03-11');
--insert into tblDate values (12, '정상', '2023-03-12');
insert into tblDate values (13, '정상', '2023-03-13');
insert into tblDate values (14, '지각', '2023-03-14');
-- insert into tblDate values (15, '정상', '2023-03-15'); -- 결석
insert into tblDate values (16, '지각', '2023-03-16');
insert into tblDate values (17, '정상', '2023-03-17');
--insert into tblDate values (18, '정상', '2023-03-18');
--insert into tblDate values (19, '정상', '2023-03-19');
insert into tblDate values (20, '정상', '2023-03-20');


select * from tblDate;

-- 요구사항] 3월 1일 ~ 3월 20일까지 모든 날짜와 근태정보를 가져오시오.
--          **** 근태 기록이 없는 빠진 날짜도 같이 가져오시오.
-- 왜 빠졌는지 가져오시오 2개 빠졌는 것  ... 

-- 조회 기간 > 날짜 생성
select 
    to_date('2023-03-20', 'yyyy-mm-dd') - to_date('2023-03-01', 'yyyy-mm-dd') +1
from dual;
    


select 
    level
from dual
    connect by level <= (to_date('2023-03-20', 'yyyy-mm-dd') - to_date('2023-03-01', 'yyyy-mm-dd') +1);
    
create  or replace view vwDate
as
select 
    to_date('2023-03-01', 'yyyy-mm-dd') + (level - 1) as regdate
from dual
    connect by level <= (to_date('2023-03-20', 'yyyy-mm-dd') - to_date('2023-03-01', 'yyyy-mm-dd') +1);
    
select * from vwDate;    
select * from tblDate;

select * from vwDate
minus
select regdate from tblDate;


select 
    *
from vwDate v
    left outer join tblDate t
        on v.regdate = t.regdate
        where seq is null -- 근태 기록이 빠진 날짜 이빠진 날짜 
            order by v.regdate asc;
        
select  -- join을 해서 state 까지 다 출력
    v.regdate,
    t.state
from vwDate v
    left outer join tblDate t 
        on v.regdate = t.regdate
            order by v.regdate asc;
            
-- 날짜 데이터에 대해 꾀 많이 쓰는 방식 중에 하나 
-- 비어 있는 것 왜 비어있나 밝히자... 
-- 주말 처리(토, 일) 

select 
    v.regdate,
    case
        when to_char(v.regdate, 'd') = '1' then '일요일'
        when to_char(v.regdate, 'd') = '7' then '토요일'
        else t.state
    end state    
from vwDate v
    left outer join tblDate t
        on v.regdate = t.regdate
            order by v.regdate asc;


create table tblHoliday (
    seq number primary key,
    regdate date not null,
    name varchar2(30) not null
);


insert into tblHoliday values(1, '2023-03-01', '삼일절');
select * from tblHoliday;

select 
    v.regdate,
--    t.state,
--    h.name,
    case
        when to_char(v.regdate, 'd') = '1' then '일요일'
        when to_char(v.regdate, 'd') = '7' then '토요일'
        when  h.name is not null then h.name
        when t.state is null and h.name is not null then '결석'
        else t.state
    end state    
from vwDate v
    left outer join tblDate t
        on v.regdate = t.regdate
            left outer join tblHoliday h 
                on v.regdate = h.regdate
                    order by v.regdate asc;


/*
--------------------------------------------------
    1. 익명 프로시저
        - 1회용
        
    2. 실명 프로시저
        - 재사용
        - 오라클에 저장
        
    실명 프로시저
        - 저장 프로시저(Stored Procedure)
    
    1. 저장 프로시저, Stored Procedure 
        - 매개변수 구성 / 반환값 구성 > 자유
        
    2. 저장 함수, Stored Function
        - 매개변수 필수 / 반환값 필수 > 고정
        
    익명 프로시저 선언
    [declare 
        변수 선언;
        커서 선언;]
    begin
        구현부;
    [ exception 
        처리부;]
    end;
    
    // 익명의 declare가 실명에서는 is나 as가 쓰인다.
    저장 프로시저 선언
    create [or replace] procedure 프로시저명
    is(as)
    [변수 선언;
        커서 선언;]
    begin
        구현부;
    [ exception 
        처리부;]
    end;
    
*/

-- 익명 프로시저 > 즉시 실행 > 실행 회차별 비용 = 동일 
declare
    vnum number;
begin
    vnum := 100;
    dbms_output.put_line(vnum);
end;

-- 저장 프로시저  > 선언 > 오라클 서버에 저장 
create or replace procedure procTest
is
    vnum number;
begin
    vnum := 100;
    dbms_output.put_line(vnum);
end; -- Procedure PROCTEST이(가) 컴파일되었습니다.

-- 저장 프로시저를 호출하는 방법(메소드를 실행하는 방법)
-- 현재 코딩하는 영역 > ANSI-SQL 영역
select * from tblInsa;

procTest; -- procTest  오류 보고 -알 수 없는 명령 이렇게 호출하면 에러다. 
-- 직접 호출

-- PL/SQL 영역을 만든 뒤 > 그안에서 프로시저를 호출할 수 있다.
begin
    -- 이 안이 PL/SQL 영역
    procTest;
end;
-- begin end로 엮는다. 
-- 3가지
execute procTest; -- 인자값이 없으면 괄호를 안붙인다. 
exec procTest;    -- 인자값이 없으면 괄호를 안붙인다. 
call procTest();  -- 얘는 좀 다른 친구다. 

-- 저장 프로시저 = 메소드 
-- 매개변수 & 반환값

-- 1. 매개변수가 있는 프로시저
create or replace procedure procTest
is 
begin
    null;
end procTest; -- end에 procedure 적어라 관례임 

create or replace procedure procTest(
pnum number
) -- 매개변수 
is 
    vnum number; -- 일반변수(지역 변수)
begin
    vnum := pnum * 2;
    dbms_output.put_line(vnum);
    
end procTest; -- end에 procedure 적어라 근데 다르다? 이러면 에러

-- public void m1() { }


--begin
--    procTest 
--end; -- 에러다.
--ORA-06550: line 3, column 1:
--PLS-00103: Encountered the symbol "END" when expecting one of the following:

begin
    procTest(100);
end; -- 에러다.


create or replace procedure procTest(
    width number,
    height number)
is
    vnum number;
begin
    vnum := width * height;
    dbms_output.put_line(vnum);
end procTest;

begin
    procTest(10, 20);
end;


-- 일반 변수 : vname varchar2(30) not null default '이름'
-- *** 프로시저 매개변수는 길이와 not null 표현이 불가능하다. 
create or replace procedure procTest(
    pname varchar2 -- 여기에 길이를 적어야 한다. 
)
is -- declare 대신하는 is(as)는 변수 선언이 없어도 반드시 기재 
begin
    dbms_output.put_line('안녕하세요.' || pname || '님');
end procTest;

begin
    procTest('홍길동');
end;


create or replace procedure procTest(
    width number,
    height number default 10
)
is
    vnum number;
begin
    vnum := width * height;
    dbms_output.put_line(vnum);
end procTest;

begin
    -- 오버로딩...(X) > 매개변수 기본값의 개념이다. 
    procTest(10, 20); 
    procTest(10); -- default 설정을 하면 인자를 안줄 수 있다.
end;



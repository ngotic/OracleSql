/* 
    ex31_account.sql 
    
    사용자 관련 > DCL
    - 계정 생성, 삭제, 잠금 제어
    - 리소스 접근 권한 제어
    
    현재 사용 계정
    - system(X)
    - hr
    
    프로젝트 계정 생성 
    
    계정 생성하기
    - 권한을 가지고 있는 계정만 가능하다. > 관리자급(sys, system)
    
    - create user 계정명 identified by 암호 : 계정 만들기
    - alter user 계정명 identitfied by 암호 > 암호 변경
    - drop user 계정명 > 계정 삭제
    
    ** 새로 생성된 계정은 아무 권한이 없다. > 접속할 권한도 없다. 
    
    사용자에게 권한 부여하기 
    - grant 권한명 to 유저명 
    
    사용자에게 권한 제거하기
    - revoke 권한명 from 유저명;
    
    
    권한 종류
    .... 뭔가를 만드는 권한
    - create user
    - create session
    - create table 
    - create view
    - create sequence 
    - create procedure
    .... 뭔가를 삭제하는 권한 
    - drop user
    - drop any table
    
    권한의 집합 > Role
    1. connect 
        - 사용자가 DB 접속 + 기본적 행동 
    2. resource
        - 사용자가 객체 조작
    3. dba 
        - 준관리자급 권한
*/
create user hong identified by java1234; -- hr계정으로는 못만든다. 
drop user hong;
alter user hong identified by java1111;


-- connect>
-- ALTER SESSION, CREATE CLUSTER, CREATE DATABASE LINK, CREATE SEQUENCE, CREATE SESSION,
-- CREATE SYNONYM, CREATE TABLE

-- resource>
-- CREATE CLUSTER, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TABLE, CREATE TRIGGER

show user; -- 내가 누군지 알려준다. USER이(가) "SYSTEM"입니다.


grant create session to hong; --Grant을(를) 성공했습니다.
grant create table to hong; -- 아근데 이거해도 안된다. 테이블 권한인데.

---- "hong으로 접속"> 이제 로그인이 된다. 

select * from tabs; -- 지금은 이제 hong이 하는 행동이다. 

-- 
create table tblTest(
    seq number primary key,
    data varchar2(30) not null
); -- 실행 안된다. ORA-01031: insufficient privileges

-- 프로젝트 진행> 프로젝트용 계정 만드는 것이 좋다.
create user team identified by java1234;

grant connect, resource to team;              -- 일반 계정, 뷰를 못만듬
grant connect, resource, create view to team; -- 이렇게 하면 뷰까지 만듬 > 수업계정(hr)과 동일
grant connect, resource, dba to team;         -- 학습용, > 혹은 프로젝트 계정도 이렇게 하면 좋다. 

-- Java + Oracle = 연동 > JDBC ! 










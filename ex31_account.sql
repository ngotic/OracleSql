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




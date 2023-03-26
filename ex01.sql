select * from tabs;

-- 단일라인 주석

/*

다중라인 주석 
    
*/

-- ex01.sql 

select * from tabs;


/*

   [ system 접속 ]
    
    일반 계정 접속  
    1. 관리자 생성  
    2. 이미 생성되어 있는 일반 계정 > 교육용( 테스트용 ) > scott 오라클 직원 이름, hr(human resource) 이라는 계정
    
    hr 계정 
    - 일반 계정
    - 테스트용 샘플 데이터 제공
    - 설치 직후 > 잠겨있는 상태 > 잠금 해제
    - 설치 직후 > 암호 변경
    
*/


alter user hr account unlock; -- 계정 풀기
alter user hr account lock;   -- 계정 잠그기


alter user hr identified by java1234; -- 암호 바꾸기 


-- 현재 계정이 보유하고 있는 테이블 목록 가져오기 
select * from tabs;

select * from REGIONS;             -- 부서 지역 국가 대륙 정보 
select * from COUNTRIES;           -- 부서 지역 국가 정보
select * from LOCATIONS;           -- 부서 지역 정보
select * from DEPARTMENT;          -- 부서 정보
select * from JOBS;                -- 직원 직업 정보 
select * from EMPLOYEES;           -- 직원 정보 
select * from JOB_HISTORY;         -- 직원 이직 이력 정보 


/*

    오라클 
    - 데이터베이스 + 데이터베이스관리 시스템
    
    SQL
    - Structured Query Language 
    - 구조화된 질의 언어
    - 대화형 언어 
    - 오라클 데이터베이스 <-> (SQL) <-> 클라이언트(개발자) 
    
    오라클(SQL + 많은 기능) 누가 공부? 
    1. 데이터베이스 관리자
        - DBA 
        - 모든 기능 관리/조작
        
    2. 데이터베이스 개발자
        - > DBA들 중에 개발자 출신도 많다. 
        - DB 팀 
        - 거의 대다수 기능 관리/조작
        
    3. 응용프로그램 개발자
        - 전부 or [ 일부 사용 ] > 소규모회사들이 응용 프로그램 개발자도 DB를 하긴함
        
    데이터베이스 종류 > 거의 대부분이 관계형 데이터베이스다. 
    1. Oracle
    2. MS-SQL
    3. MYSQL
    4. MariaDB
    5. PostreSQL
    6. DB2
    7. SQLite
    
    클라이언트 프로그램 
    1. SQL Developer > 따로 설치
    2. SQL Plus      > 오라클과 같이 설치된다.(콘솔) 
    3. DataGrip      > *** ( 학교 이메일 ) 
    4. DBeaver       > 완전무료다. ***
    5. SQLGate
    6. Toad          > 클라이언트 프로그램 끝판왕 
    
    관게형 데이터베이스
    - 데이터를 표현식으로 저장/관리한다.
    - SQL을 사용한다.
    
    [ SQL ]
    1. DBMS 제작사와 독립적이다. 
       - 모든 관계형 데이터베이스에서 공통적으로 적용하기 위해 만들어진 언어
       - DBMS 제작사에서 SQL란 언어를 자신의 제품에 적용
       
    2. 표준 SQL, ANSI-SQL 
       - 모든 DBMS에 적용 가능한 SQL 
       
    3. 각 제작사별 SQL 
       - Oracle vs MS-SQL 
       - 자기네 제품에서만 동작하는 추가 SQL 
       - Oracle(오라클에만 제공하는 기능이 있다.) 
         vs Maria DB(무료다.)
       - Oracle > PL/SQL  > 첫 DB가 오라클이면 좋다.
       - MS-SQL > T-SQL   > 
       
    오라클 수업 = ANSI-SQL(5~60%) + PL/SQL(2~30%) + 설계, 기타(10%)
    오라클이 자체적으로 확장해서 만든 SQL은 PL/SQL이다. 
    
    ANSI-SQL(5~60%) + PL/SQL(20~30%) + 설계,기타(10%)
    
    ANSI-SQL 종류
    1. DDL 
        - Data Definition Language
        - 데이터 정의어
        - 테이블, 뷰, 사용자, 인덱스, 트리거 등의 데이터베이스 오브젝트를 생성/수정/삭제하는 명령어
        - 구조 생성/관리하는 명령어
        - 건물 > 기초공사(벽, 바닥..) 
        a. create : 생성
        b. drop   : 삭제
        c. alter  : 수정
        - 데이터베이스 관리자 
        - 데이터베이스 담당자 
        - 프로그래머(**)  
        
    2. DML 
        - Data Manipulation Language
        - 데이터 조작어
        - 데이터베이스에 데이터를 추가/수정/삭제/조회하는 명령어(CRUD)
        - 사용 빈도가 가능 높음
        a. select 조회(읽기) > R ***** 중요하다. 읽기작업이 나머지 작업보다 압도적으로 높다. 
                            > 쿼리 짠다. 대부분이 SELECT를 짜는 것
        b. insert 추가(생성) > C
        c. update 수정       > U
        d. delete 삭제       > D
        - 데이터베이스 관리자 
        - 데이터베이스 담당자 
        - 프로그래머(*****)  
        
    3. DCL 
            - Data Control Language
            - 데이터 제어어
            - 계정 권한 관리, 보안 제어, 트랜젝션 처리 등...
            a. commit
            b. rollback
            c. grant
            d. revoke
            - 데이터베이스 관리자 
            - 데이터베이스 담당자 
            - 프로그래머(일부)      
            
    4. DQL 
        - Data Query Language
        - DML 중에 select 만을 따로 호칭
            
    5. TCL
        - Transaction Control Language 
        - DCL 중에 commit, rollback 만 따로 호칭한다.
        
    오라클 인코딩 
    - 1.0 ~ 8i: EUR-KR > 이때는 자바와 같이 쓸 때 한글이 막 깨졌었다...  [ i > 인터넷, g > 그리드 시스템, c > cloud ] 
    - 9i, 10g, 11g, 12c, 18c, 19c, 21c 등 이런식으로 버전이 올라온다. ..  >> 버전만 기억하면 된다. 
    - 9i, 10g, 11g, 12c, 18c, 19c, 21c .. : UTF-8 쓴다. 요즘은 깨질 리가 없다.
    
    오라클 제품군 
    - Oracle Enterprise       >  복잡한거 잘 함
    - Oracle Express Edition  > 복잡하거나 큰 일 못한다. > 근데 무료다.
    
    Oracle Express Edition
    - 무료
    - 개인용 or 소규모 회사
    - 사용 메모리 최대 1GB 
    - 지금은 Express Edition은 11g와 18c 두가지 버전밖에 없다. 아직까지 18c보다 11g를 많이 쓴다.
    - 11g 
    - 18c  >  여기로 오면서 추가된 문법이 조금 있다. // 이걸로 수업해도 되는데 귀찮다.
   
*/

-- hr 계정으로 보통 수업한다. 
-- 대소문자 
-- 1. SQL 명령어는 대소문자를 구분하지 않는다.
-- 파란색 > 키워드
-- 검정색 > 식별자
select * from tabs; -- 올소문자 --> 수업은 전부다 소문자로 한다. 스타일의 문제다. 

SELECT * FROM TABS; -- 올대문자

select * from TABS; -- 혼용1

SELECT * FROM tabs; -- 혼용2

-- 초기작성만 이렇게 하다가 나중에 또 바꿀 수 있는 기능이 있다. 

-- 코드 컨벤션 



-- Ctrl + F7 입력하면 두줄이 된다. 
 
select * from tabs; -- 


-- 모든 구문을 대문자로 작성하는 것을 권핮앟ㄴ다.

-- 식별자 > 
create table aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa  ( -- 31개일 때 
    num number
);

--ORA-00972: identifier is too long
--00972. 00000 -  "identifier is too long"
--*Cause:    An identifier with more than 128 bytes was specified,
--           or a password identifier longer than 30 bytes was specified.
--*Action:   Specify at most 128 bytes for identifiers,
--           and at most 30 bytes for password identifiers.







select * from tabs;




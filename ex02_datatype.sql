/*

    ex02_datatype.sql
    
    Java > SQL
    
    자료형을 보면 언어의 견적이 잡힌다. 
    
    ANSI-SQL 자료형
    - Oracle 자료형(***)
    
    1. 숫자형
        - 정수, 실수   
        a. number     
            - (유효자리) 38자리 이하까지 표현하는 자료형
            - 12345678901234567890123456789012345678
            - 1x10^-130 ~ 9.9999x10^125
            - 5~22byte
            
            1. number 
                - 정수, 실수 
                - 1x10^-130 - 9.9999x10^125
                
            2. number(precision)
                - 정수만 저장(반올림)
                - precision : 저장 가능한 자릿수 
                
            3. number(precision, scale)
                - 정수, 실수 
                - precision: 저장 가능한 자릿수
                - scale : 소수이하 자릿수(%.1f)
                
    2. 문자형
        - 문자, 문자열
        - char + String   > String
        - char vs nchar   > n의 의미?
        - char vs varchar > var 의미? 
        
        ----------------
        a. char        
            - 고정 자릿수 문자열 > 컬럼(공간)의 크기가 불변
            - char(n) : n자리 문자열, n(바이트)
                - n 최소크기 : 1 바이트 
                - n 최대크기 : 2000 바이트
            - char(10) > 'ABC' > 'ABC         ' : 남는 부분을 공백으로 채운다.
            - 주어진 공간을 데이터가 채우지 못하면 나머지 공간을 스페이스로 채운다. 무조건 10바이트로 만드는게 직성에 풀린다.
                       > 아무 생각없이 데이터 채운다.
        b. nchar       
            - n : national > 오라클 인코딩과 상관없이 해당 칼럼을 UTF-16 동작하게 
            - 고정 자릿수 문자열 > 컬럼(공간)의 크기가 불변
            - nchar(n) : n자리 문자열, n(문자수) 
                - n 최소크기 : 1 글자 ~ 
                - n 최대크기 : 1000글자 
                
            
        ----------------------------------------------- 주민번호 char(고정) /// 주소 같은거 varchar2를 쓰는데 시간에 따라서 얘네 둘의 속도차이가 사라짐
                                                        -- 그래서 ♣ 현재는 varchar2를 대부분을 쓴다. > 많이 쓰는 것은 주구장창 쓴다. 
        c. varchar2     > 운용하는 측면에서 얘가 이득이다. 나머지 쓸모 없는 부분을 trim시키는 과정이 추가로 들어간다. char 보다 느리다.
            - 가변 자릿수 문자열 > 컬럼(공간)의 크기가 가변
            - char(n) : n자리 문자열, n(바이트)
                - n 최소크기 : 1 바이트  >> 최소크기 ★
                - n 최대크기 : 4000 바이트
            - varchar2(10) > 'ABC' > 'ABC' : 나머지 7 바이트를 버린다. 실제 데이터 상관없이 무조건 그 공간을 확보한다. 
            - 주어진 공간을 데이터가 채우지 못하면 나머지 공간을 버린다. 
            - 즉, 데이터의 크기가 공간의 크기가 된다. 훨씬 더 공간을 효율적으로 쓸 수 있다.            
            
        >> ★ 오라클 현시점에선 varchar2를 주로 쓴다. 
        
        d. nvarchar2   
            - n : national > 오라클 인코딩과 상관없이 해당 칼럼을 UTF-16 동작하게 
            - 가변 자릿 수 문자열 > 컬럼(공간)의 크기가 가변
            - varchar2(n) : n자리 문자열, n(글자수)
                - n 최소크기 : 1 글자
                - n 최대크기 : 2000 글자 > 이거 넘어가면?? > 자료형이 더 있다.
        
        >> varchar2를 더 많이 쓴다. 
        ----------------
    
        e. clob, nclob
        character large object 
        n character large object 
        - 대용량 텍스트
        - 128TB
        - 잘 사용 안함, 참조형이다. > 속도가 느리다. 데이터 공간이 모자를 때 쓴다.
       
    3. 날짜시간형
    
        a. date
            - '년월일시분초'까지 저장함
            - 기원전 4712년 1월 1일 ~ 9999년 12월 31일 
                   
        b. timestamp 
            - 년월일시분초 + 밀리초 + 나노초   
        
        c. interval 
            - 시간
            - 틱값 저장용
        
    
    4. 이진 데이터형
        - 비 텍스트 데이터를 집어넣는다.
        - 이미지, 영상, 파일 등... 실제로는 잘 안쓴다. 무겁다. 
        - ex) 게시판( 첨부파일 ), 회원가입( 사진 ) > 문자열로 저장(파일명만 저장) > hong.png > 파일이름
        - 공간에다가 입출력하기 쉬운 이름 몇글자만 기억 > 그 이름만 db에서 꺼내서 그 이름에 해당하는 파일만 꺼내는게 더 싸게 먹힌다.
        a. blob 
            - 최대 128TB

오라클 
1. 숫자 > number
2. 문자 > varchar2(+char)
3. 날짜 > date
4. 논리형 > X : 조건문도 반복문도 없다보니 true / false가 필요 없게된 것이다. 

    
자바
1. 숫자   > int, long, double
2. 문자열 > String
3. 날짜   > Calendar
4. 논리형 > boolean 

      
    create table 테이블명 (
       '컬럼을 선언한다.'
        컬럼명 자료형,
        컬럼명 자료형,
        컬럼명 자료형 
    );
    
    -- 테이블 자체는 아무것도 없다. 
*/
--  수업 코드 컨밴션 
-- - 객체 생성 > 객체 접두어 사용 > 이 객체가 뭐냐? 라고 가리킨다.

-- 테이블 생성
create table tblType(
    num number 
);

-- 테이블 삭제 
drop table tblType; 

-- 테이블 생성 확인
-- 1. SQL > 모든 툴이 동일하게 반응한다. 
select * from tabs;

-- 2. 툴마다 기능이 다름

-- 오라클은 사용자가 만든 모든 식별자를 대문자로 변환해서 저장한다. 

create table tblType(
    
    -- num number(3) -- [ -999 ~ 999 ] 까지 저장한다. 
    num number(4,2) -- 소수이하 2자리는 고정으로 확보를 하고 > 나머지 정수 부분 2자리 99.99, -99.99
    
); 
-- 또 만들면 에러나니까 기존 것 삭제한다.
-- 데이터를 추가하기

insert into tblType (num) values (100); -- 정수 데이터 > 정수형 리터럴 > 자바와 같다.
insert into tblType (num) values (200); -- 
insert into tblType (num) values (300); -- 
insert into tblType (num) values (3.14); -- 실수형 리터럴 
insert into tblType (num) values (-100); -- 음수 

-- sql로 확인하기
select * from tblType;

drop table tblType;

select * from tblType;

insert into tblType (num) values (1000); -- 오버플로우

insert into tblType (num) values (9.9);  -- 반올림 // double a = 3.99 // (int)a > 3이다.

insert into tblType (num) values (999);  -- 반올림 // double a = 3.99 // (int)a > 3이다.

insert into tblType (num) values (-999);  -- 반올림 // double a = 3.99 // (int)a > 3이다.

insert into tblType (num) values (-1000);  -- 응 이건 안되

create table tblType(
    num number(4,2) -- 소수이하 2자리는 고정으로 확보를 하고 > 나머지 정수 부분 2자리 99.99, -99.99
);  -- 소수 이하 둘쨰자리까지
drop table tblType;
select * from tblType;

insert into tblType (num) values (100); -- 정수 데이터 > 정수형 리터럴 > 자바와 같다.
insert into tblType (num) values (200); -- 
insert into tblType (num) values (300); -- 
insert into tblType (num) values (3.14); -- 실수형 리터럴 
insert into tblType (num) values (1000); -- 오버플로우
insert into tblType (num) values (9.9);  -- 반올림 // double a = 3.99 // (int)a > 3이다.
insert into tblType (num) values (999);  -- 반올림 // double a = 3.99 // (int)a > 3이다.
insert into tblType (num) values (-999);  -- 반올림 // double a = 3.99 // (int)a > 3이다.
insert into tblType (num) values (-1000);  -- 응 이건 안되
insert into tblType (num) values (-100); -- 음수 ;
insert into tblType (num) values (3.142); -- 실 반올림해서 3.14가 된다.
insert into tblType (num) values (3.149); -- 실 반올림을해서 3.15가 된다. > 둘째 자리까지 나오는 것이다.
insert into tblType (num) values (33.14);
insert into tblType (num) values (333.14); -- 합치면 5자리가 된다. 
insert into tblType (num) values (99.99);
insert into tblType (num) values (-99.99);
insert into tblType (num) values (100);

drop table tblType;

create table tblType(
   txt1 char(10)
); 

insert into tblType (txt1) values('A'); -- 문자열 리터럴 
insert into tblType (txt1) values("A"); -- 문자열 리터럴 쌍따옴표는 에러난다.!!!

-- 10 바이트 > 몇 글자? > 오라클 인코딩? > UTF-8 > 영어(1), 한글(3)
insert into tblType (txt1) values('ABCDEFGHIJ');  -- 실행 된다. 
insert into tblType (txt1) values('ABCDEFGHIJK'); -- 에러 난다.

-- 오류 보고 -
-- ORA-12899: value too large for column "HR"."TBLTYPE"."TXT1" (actual: 11, maximum: 10) > 최대 10바이트 넣을 수 있는데 11바이트 넣으려고 해서 에러 난거다. 
select * from tblType;

insert into tblType (txt1) values ('가');
insert into tblType (txt1) values ('가나다');
insert into tblType (txt1) values ('가나다라');
insert into tblType (txt1) values ('가나다A');
select * from tblType;

drop table tblType;

create table tblType (

    txt1 char(10),
    txt2 varchar2(10)
    
); -- 컬럼의 수 맥시멈 40~50개 > 너무 access시에 많아지면 느려진다. 

-- 보편적으로 10개 미만에서 10개 전후 
                                    --  char    varchar2
insert into tblType(txt1, txt2) values( 'ABC', 'ABC' );
-- 데이터 확인?
-- 1. 

select * from tblType;

select sysdate from dual; -- sysdate를 호출하고 결과값을 반환 ! -> 23/03/14



create table tblType (

    txt1 char(10),
    txt2 varchar2(10)
    
);
drop table tblType;



insert into tblType(txt1) values( 'ABC' );

select * from tblType;





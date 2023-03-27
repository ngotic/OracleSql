/*

    ex13_ddl.sql

    1. DDL 
        - Data Definition Language
        - 데이터 정의어
        - 테이블, 뷰, 사용자, 인덱스, 트리거 등의 데이터베이스 오브젝트를 생성/수정/삭제하는 명령어
        a. create: 생성
        b. drop: 삭제
        c. alter: 수정
        
     테이블 조작하기
     
     create table 테이블명
     (
        컬럼 정의,
        컬럼 정의,
        컬럼 정의,
        컬럼 정의,
        컬럼 정의,
        컬럼명 자료형(길이) NULL 제약사항 [ 제약 선언문 ]
     );
    제약사항, Constraint
    - 해당 칼럼에 들어갈 데이터(값)에 대한 조건
        - 조건을 만족하면 > 대입
        - 조건을 불만족하면 > 에러발생
    - 유효성 검사 도구
    - 데이터베이스 > 데이터 관리 > 데이터 무결성(***)을 보장하는 도구
    
    
    1. NOT NULL
    - 해당 컬럼이 반드시 값을 가져야 한다.
    - 해당 컬럼에 값이 없으면 에러발생
    - 필수값 
    
    2. PRIMARY KEY
    - 기본키 
    - 테이블에서 행과 행을 구분하기 위한 수단이다. 
    - 행을 식별하는 대표 컬럼을 지정하는 역할 
    - 모든 테이블은 반드시 1개의 키본키가 존재해야한다.(*****************)
    - 중복값을 가질 수 없다. > UNIQUE 도 그렇다. 근데 UNIQUE는 null이 될수 있다.
    - 값을 반드시 가진다. > not null
    - Not NULL + Unique > Primary Key 
    
    
    3. FOREIGN KEY 
    pass
    
    4. UNIQUE 
    - 유일하다. > 행들간에 동일한 값을 가질 수 없다.
    - NULL은 가질 수 있다. 
    ex) 경품
        - 고객(번호(PK), 이름,  주소,  당첨(UQ)) 
                1.     홍길동, 서울,  1등
                2.     아무개,  부산 , null
                3.     하하하,  서울,  2등 
                4.     호호호,  인천,  3등 
    ex) 초등학교 교실 
    - 학생(번호(PK), 이름, 직책(UQ))
        1. 홍길동, 반장 
        2. 아무개, 부반장
        3. 하하하, null
        4. 호호호, 체육부장
        
    -- pk는 번호를 안가져도 에러               
    5. CHECK
        - 사용자 정의 제약 조건
        - where절과 동일한 조건을 컬럼에 적용한다. 
    
    6. DEFAULT 
        - 기본값 설정이다. 
        - insert/update 작업 때 값을 대입하지 않으면, 미리 준비해놓은 기본값을 대신 넣는 역할 
        
    
        
*/  

create table TAB1 (
    col1 varchar(10) ,
    col2 varchar(10) 
);

select * from TAB1;

insert  into TAB1 values('a', NULL);
insert  into TAB1 values('b', '');
insert  into TAB1 values('c', 3);
insert  into TAB1 values('d', 4);
insert  into TAB1 values('e', 3);
select col2  from TAB1 where col1='b';


select NVL(col2,'x') from TAB1 where col1='a';

create table tblMemo(
    seq number(3) null,
    name varchar2(30) null,
    memo varchar2(1000) null,   -- null허용
    regdate date null
);

drop table tblMemo;


-- insert into 테이블(컬럼리스트) values(값리스트) ;

insert into tblMemo(seq, name, memo, regdate) 
            values(1, '홍길동', '메모입니다.', sysdate);


insert into tblMemo(seq, name, memo, regdate) 
            values(2, '아무개', null, sysdate); -- 메모내용 생략

insert into tblMemo(seq, name, memo, regdate) 
            values(3,  null,   null,  null); -- 메모내용 생략

insert into tblMemo(seq, name, memo, regdate) 
            values(null,  null,   null,  null); 
            
insert into tblMemo(seq, name, memo, regdate) 
            values(4,  '홍길동',   '메모입니다.',  '2023-03-15');    -- 2023-03-15 자동 형변환 된다.          

insert into tblMemo(seq, name, memo, regdate) 
            values(4,  '홍길동',   '메모입니다.',  '2023-03-15 12:30:50');  -- 이건 형변환 안된다.
            
insert into tblMemo(seq, name, memo, regdate) 
            values(4,  '홍길동',   '메모입니다.',  to_date('2023-03-15 12:30:50','yyyy-mm-dd hh24:mi:ss'));  -- to_date쓰면 잘 드감           
            
-- 절대 생성 금지다. 전부다 null이다. 그 어떤 누구도 이런 형태로 데이터를 만들지 않는다.  > 모든 컬럼이 null 허용하는 경우는 없다. 
            
select * from tblMemo;

drop table tblMemo;

-- null이 디폴트다. 
create table tblMemo(
    seq number(3) not null,
    name varchar2(30) null,
    memo varchar2(1000) not null,   -- null허용 > 필수값들은 not null
    regdate date null
);

insert into tblMemo(seq, name, memo, regdate) 
            values(1, '홍길동', '메모입니다.', sysdate);


insert into tblMemo(seq, name, memo, regdate) 
            values(2, '아무개', null, sysdate); -- 메모가 not null이라서 안들어간다. 
--ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."MEMO") -- hr이 소유하는 ~ tblmemo에는 못넣는다. 


insert into tblMemo(seq, name, memo, regdate) 
            values(3, '홍길동', '', sysdate); -- 빈문자('') > 오라클은 null로 취급한다. 오라클은 빈문자를 null로 취급한다. 

select * from tblMemo;


-- PK를 만드는 법 

create table tblMemo(
    seq number(3) not null,
    name varchar2(30) null,
    memo varchar2(1000) not null,   -- null허용 > 필수값들은 not null
    regdate date null
); -- 테이블을 잘못만들었다. 



insert into tblMemo(seq, name, memo, regdate) 
            values(1, '홍길동', '메모입니다.', sysdate);
            
            
insert into tblMemo(seq, name, memo, regdate) 
            values(1, '홍길동', '메모입니다.', sysdate);
            
-- 동일값이 두개 들어간다. 



create table tblMemo(
    seq number(3) primary key, -- not null 대신에 이렇게 쓴다. primary key  > 이친구는 유일하다. null이 안된다. 
    name varchar2(30) null,
    memo varchar2(1000) not null,   -- null허용 > 필수값들은 not null
    regdate date null
); 

drop table tblMemo;

insert into tblMemo(seq, name, memo, regdate) 
            values(1, '홍길동', '메모입니다.', sysdate);
            
insert into tblMemo(seq, name, memo, regdate) 
            values(1, '홍길동', '메모입니다.', sysdate);
            
-- ORA-00001: unique constraint (HR.SYS_C007236) violated > Unique 제약 사항을 위반했다고 하는 것이다. 
-- seq는 같은 값을 두개를 가지지 못하는데 그걸 위반함

insert into tblMemo(seq, name, memo, regdate) 
            values(2, '홍길동', '메모입니다.', sysdate); -- 이건 잘들어간다.
                 
 insert into tblMemo(seq, name, memo, regdate) 
            values(null, '홍길동', '메모입니다.', sysdate); -- 이건 잘들어간다.           
-- ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."SEQ")




select 0/300,
        300/0
from dual;

drop table tblMemo;

create table tblMemo(
    seq number(3) primary key, -- not null 대신에 이렇게 쓴다. primary key  > 이친구는 유일하다. null이 안된다. 
    name varchar2(30) unique,  -- 작성자이름이 유니크하다(unique) > 이름이 중복될 수 없다. > 1사람이 딱 1개의 글작성 가능
    memo varchar2(1000) not null,   -- null허용 > 필수값들은 not null
    regdate date null
); 

insert into tblMemo(seq, name, memo, regdate) 
            values(1, '홍길동', '메모입니다.', sysdate);
            
insert into tblMemo(seq, name, memo, regdate) 
            values(2, '홍길동', '메모입니다.', sysdate);
--ORA-00001: unique constraint (HR.SYS_C007238) violated

insert into tblMemo(seq, name, memo, regdate) 
            values(2, '아무개', '메모입니다.', sysdate); -- 이제는 된다. 
insert into tblMemo(seq, name, memo, regdate) 
            values(3, null, '메모입니다.', sysdate); -- 이제는 된다. 
select * from tblMemo;
drop table tblMemo;

create table tblMemo(
    seq number(3) primary key,   -- 반드시 필요 
    name varchar2(30),           
    memo varchar2(1000),              
    regdate date,
    priority number check(priority between 1 and 3 )             -- 1(중요), 2(보통), 3(사소)
); 
--  check가 where라는 키워드라고 생각한다. 내가 원하는 테이블을 찾는 조건이라 생각 

select * from tblMemo where priority between 1 and 3 ; -- where절에다가 쓴 내용을 그대로 check안에다가 넣는다. 



insert into tblMemo(seq, name, memo, regdate, priority) 
            values(1, '홍길동', '메모입니다.', sysdate, 1);
            
insert into tblMemo(seq, name, memo, regdate, priority) 
            values(2, '홍길동', '메모입니다.', sysdate, 10);
-- ORA-02290: check constraint (HR.SYS_C007240) violated 체크제약에 어긋남



drop table tblMemo;


create table tblMemo(
    seq number(3) primary key,   -- 반드시 필요 
    name varchar2(30),           
    memo varchar2(1000),              
    regdate date,
    priority number check(priority between 1 and 3 ) ,            -- 1(중요), 2(보통), 3(사소)
    category varchar2(30) check(category in ('할일' ,'장보기', '공부'))
); 

insert into tblMemo(seq, name, memo, regdate, priority, category) 
            values(1, '홍길동', '메모입니다.', sysdate, 1, '할일');

select * from tblMemo;

insert into tblMemo(seq, name, memo, regdate, priority, category) 
            values(2, '홍길동', '메모입니다.', sysdate, 1, '스타디');

select * from tblMemo;


drop table tblMemo;



-- check안에 where절에다가 쓰는 것을 얻는다. 
create table tblMemo(
    seq number(3) primary key,   -- 반드시 필요 
    name varchar2(30) check(length(name) > 1), -- 없에 칼럼들고오고 check 제약쓰면 최소값도 통제가능하다.           
    memo varchar2(1000),              
    regdate date,
    priority number check(priority between 1 and 3 ) ,            -- 1(중요), 2(보통), 3(사소)
    category varchar2(30) check(category in ('할일' ,'장보기', '공부'))
); 

insert into tblMemo(seq, name, memo, regdate, priority, category) 
            values(1, '홍길동', '메모입니다.', sysdate, 1, '할일');
            
            
insert into tblMemo(seq, name, memo, regdate, priority, category) 
            values(1, '홍', '메모입니다.', sysdate, 1, '할일');
-- ORA-02290: check constraint (HR.SYS_C007249) violated

drop table tblMemo;

-- 메모 테이블 
create table tblMemo(
    seq number(3) primary key,   -- 반드시 필요 
    name varchar2(30) default '익명', -- 없에 칼럼들고오고 check 제약쓰면 최소값도 통제가능하다.           
    memo varchar2(1000),              
    regdate date default sysdate
); 

insert into tblMemo(seq, name, memo, regdate) 
            values(1, '홍길동', '메모입니다.', sysdate); -- 값을 다 주면 default는 동작하지 않는다. 

insert into tblMemo(seq, name, memo, regdate) 
            values(2, '홍길동', '메모입니다.', '2023-01-01'); -- 값을 다 주면 default는 동작하지 않는다. - - 가  > 23/01/01 여렇 드감

select * from tblMemo;

insert into tblMemo(seq, name, memo, regdate) 
            values(3, null, '메모입니다.', sysdate); -- 값을 다 주면 default는 동작하지 않는다. 
-- 내가 명시적으로 null이 드감 
select * from tblMemo;            
            
-- 아예 칼럼 이름과 칼럼 리스트를 빼라
insert into tblMemo(seq, memo, regdate) 
            values(4, '메모입니다.', sysdate); -- 이래야 익명이 들어간다. 
            
insert into tblMemo(seq, memo, regdate) 
            values(5, '메모입니다.', default); -- default라는 상수가 있다.  해당 컬럼을 넣을 때 default를 넣어라 
            
select * from tblMemo;            


select buseo, count(*) 
from tblInsa
group by buseo
having buseo='총무부'; -- having으로 단일칼럼 조건도 가능하다. 


/*

    제약 사항을 만드는 방법
    1. 컬럼 수준에서 만드는 방법
        - 어제 수업 내용
        - 컬럼 선언 + 제약 선언 > 동시에 같이 ! 
        
    2. 테이블 수준에서 만드는 방법
        - 컬럼 선언과 제약 선언을 분리해서 관리 
    
    3. 외부에서 만드는 방법  > 다음주에 할듯!? 
        - alter 명령어
        - 테이블 선언과 제약 선언을 분리해서 관리  > dba들이 많이 쓰는데 관리능력이 없으면 추천하지 않는다.
        
    이 세가지가 똑같은데 동일한 코드를 저기에 적냐 저기에 적냐의 차이다.     
    
    
*/

drop table tblMemo;

-- 메모 테이블 
create table tblMemo( 
    -- seq number(3) primary key,    -- 컬럼 생성과 동시에
    -- seq number(3) [ constraint 제약사항명] 제약종류, -- 이게 원리 FM이다. 이방식이 권장사항이다. 
    -- 제약사항도 object다. 객체다 우리가 만드는 것, 우리가 이름을 붙여줄 수 있다. 
    seq number(3) constraint tblMemo_seq_pk primary key, -- 이게 원래 모습이다. 
    
    name varchar2(30) default '익명', -- 옆에 칼럼들고오고 check 제약쓰면 최소값도 통제가능하다.           
    member varchar2(1000),              
    regdate date default sysdate
); 
select * from tblMemo;
insert into tblMemo(seq, name, member ,regdate) values(1, '홍길동', '메모', sysdate);
-- ORA-00001: unique constraint (HR.TBLMEMO_SEQ_PK) violated 
-- 한번더 호출시 제약조건 때문에 에러가 난다. > TBLMEMO_SEQ_PK 이 이름을 가지고 의지해서 찾는다. 


drop table tblMemo;

-- 메모 테이블 
create table tblMemo( 
    seq number(3) primary key, 
    
    name varchar2(30) default '익명',        
    member varchar2(1000),              
    regdate date default sysdate
); 
select * from tblMemo;
insert into tblMemo(seq, name, member ,regdate) values(1, '홍길동', '메모', sysdate);
insert into tblMemo(seq, name, member ,regdate) values(1, '홍길동', '메모', sysdate);
-- ORA-00001: unique constraint (HR.SYS_C007256) violated 이렇게 뜬다. 오라클이 우리가 이름을 안정해줘서 이렇게 뜬다. 
-- 임의의 코드명으로 띄워주는데 우리가 이름을 주면 어디부분에서 문제 였는지 알려준다. 테이블이 백개니까 이걸... 에러로그가 찍히면 찾기가 쉽다는 것 

drop table tblMemo;
create table tblMemo( 
    -- 컬럼리스트들 
    seq number(3), 
    name varchar2(30) default '익명',        
    member varchar2(1000),              
    regdate date,
    -- 제약사항들
    constraint tblmemo_seq_pk  primary key(seq), -- 대신에 이렇게 컬럼며을 넣어준다.
    constraint tblmemo_name_uq unique(name),
    constraint tblmemo_memo_ck check(length(member) >= 10) 
); 

-- constraint 이름 제약종류(칼럼명)

insert into tblMemo(seq, name, member ,regdate) values(1, '홍길동', '메모', sysdate);
-- ORA-02290: check constraint (HR.TBLMEMO_MEMO_CK) violated > 아~ 내가 메모내용을 짧게 입력했구나~ 



-- 아무런 제약이 없는 상태
create table tblMemo( 
    seq number(3) , 
    name varchar2(30), 
    member varchar2(1000),              
    regdate date 
); 

insert into tblMemo(seq, name, member ,regdate) values(1, '홍길동', '메모', sysdate);
insert into tblMemo(seq, name, member ,regdate) values(1, '홍길동', '메모', sysdate);

select * from tblMemo;

-- 외부에서 pk를 쓰는건 db로 밥먹고 사는 사람들이 많이 쓰기도 한다.
alter table tblMemo -- 이미 중복된 상태일 때 이 조건을 걸면 에러가 뜬다. ORA-02437: cannot validate (HR.TBLMEMO_SEQ_PK) - primary key violated
    add constraint tblmemo_seq_pk primary key(seq);

drop table tblMemo;
-- 다시 테이블 만들고 값을 넣기전에 위에 제약사항 건다.
















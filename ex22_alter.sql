/*

    ex22_alter.sql
    
    DDL
    - 객체 생성: create > 이상적인 ddl은 create로 끝나야 한다. 
    - 객체 삭제: drop  > drop alter는 쓰면 별로...
    - 객체 수정: alter > 이 수정이 흔하면 큰일 난다.
    
    DML > Data(Record)
    - 데이터 생성: insert
    - 데이터 삭제: delete
    - 데이터 수정: update
  
  테이블 수정하기 
  - 테이블 정의 수정 > 컬럼 수정> 컬럼명 or 자료형(길이) or 제약사항
  
  테이블 수정해야 하는 상황 발생!!
      1. 테이블 삭제(drop) > 테이블 DDL(create) 수정> 수정된 DDL로 새롭게 테이블 생성
        a. 기존 테이블 데이터가 없었을 경우 > 아무 문제가 없음
        b. 기존 테이블 데이터가 있었을 경우 > 미리 데이터 백업 > 테이블 삭제 > 수정 후 생성 > 데이터 복구
            - 공부할때 사용
            - 개발 중에 사용
            - 서비스 운영 중 > 거의 불가능!!!
    
      2. alter 명령어 사용 > 기존 테이블 구조(컬럼 정의) 변경
        a. 기존 테이블 데이터가 없었을 경우 > 아무 문제 없음
        b. 기존 테이블 데이터가 있었을 경우 > 경우에 따라 다름
            - 공부할 때 사용
            - 개발 중에 사용
            - 서비스 운영 중 > 이 방식을 사용 > DB는 검토를 잘하자. > 설계도 만들 때 잘 만들자
            
*/

create table tblEdit (
    seq number primary key,
    data varchar2(20) not null
);

insert into tblEdit values(1, '마우스');
insert into tblEdit values(2, '키보드');
insert into tblEdit values(3, '모니터');

select * from tblEdit;

-- 1. 새로운 칼럼 추가하기
-- 가격 컬럼 추가하기 > price, number
-- ORA-01758: table must be empty to add mandatory (NOT NULL) column > 테이블이 비어있어야 한다. > not null 떄문에 그래 이거 칼럼 잘못추가해버리면 null이 생김
alter table tblEdit 
    add ( price number not null ); -- not null이 발목을 잡는다.
    -- 난이거 못넣겟따 배짼다. 테이블에 데이터가 없어야 이 컬럼을 추가한다.
    
    
delete from tblEdit;    

alter table tblEdit add ( price number not null ); -- 이제야 이게 실행이 된다. 

desc tblEdit;

drop table tblEdit;

create table tblEdit (
    seq number primary key,
    data varchar2(20) not null
);

insert into tblEdit values(1, '마우스');
insert into tblEdit values(2, '키보드');
insert into tblEdit values(3, '모니터');

alter table tblEdit 
    add ( price number null ); -- not null이 발목을 잡는다.
    
select * from tblEdit ;  --> 이건 추가가 된다. null인 상태로 남는다.


drop table tblEdit;

create table tblEdit (
    seq number primary key,
    data varchar2(20) not null
);

-- 아예 지우고 다시 만들고 insert문을 따로 백업을 따는게 좋다.

-- 데이터를 지울건데 그 데이터를 미리 다른데 가지고 있어야 한다.


alter table tblEdit 
    add ( price number not null ); -- not null이 발목을 잡는다.

alter table tblEdit 
    add (memo varchar2(100) not null);
    
    
insert into tblEdit values(1, '마우스', 10000, '로지텍');
insert into tblEdit values(2, '키보드', 20000, 'MS');
insert into tblEdit values(3, '모니터', 30000, 'Dell');    

select * from tblEdit;

--2. 컬럼 삭제하기
alter table tblEdit
    drop column memo; -- 근데 데이터가 이미 들어있다.  > 삭제를하면 삭제가 된다.

select * from tblEdit; -- 컬럼과 함께 데이터가 사라진다. 이건 복구가 안된다.

-- 데이터가 들어있는 칼럼을 지운느 순간 데이터도 날라간다. 다 날라간다. 이건 조심하기 > 신중하게 미리 데이터를 백업하고 해야한다.

alter table tblEdit
    drop column seq; -- PK 칼럼 삭제> 절대로 금지!!!!!!!!!!!!!! > PK도 지워지네!??.....
    
drop table tblEdit;

create table tblEdit (
    seq number primary key,
    data varchar2(20) not null
);

insert into tblEdit values(1, '마우스');
insert into tblEdit values(2, '키보드');
insert into tblEdit values(3, '모니터');

--3. 컬럼 수정학;
insert into tblEdit values ( 4, '인텔 i7 13세대 최신형 노트북'); -- varchar2(20) 길이가 안맞는다. overflow되서 추가가 안된다.

--3.1 컬럼의 길이를 수정하기(확장/축소)
alter table tblEdit
    modify (data varchar2(100)); -- 그대로 유지 
-- 수정후에 다시 실행    
insert into tblEdit values ( 4, '인텔 i7 13세대 최신형 노트북'); -- 이제 삽입된다. 

select * from tblEdit; --

desc tblEdit; -- 반영이 되었다. 

--3.2 컬럼의 제약 사항 수정하기
alter table tblEdit
    modify (data varchar2(100) null);

desc tblEdit;

alter table tblEdit
    modify (data varchar2(100) not null); -- 컬럼의 제약사항 수정 구문이다.
    
-- 3.3 컬럼의 자료형 바꾸기
alter table tblEdit -- 기존에 데이터가 문자열로 들어가 있는데 숫자로 바꾼다고??? 
    modify ( data number); -- ORA-01439: column to be modified must be empty to change datatype 
                    -- 수정하려거든 비워놔라 
                    
alter table tblEdit -- 기존에 데이터가 문자열로 들어가 있는데 숫자로 바꾼다고??? 
    modify ( seq varchar2(30));  -- 얘도 안된다.
    
    
delete from tblEdit;

select * from tblEdit; --

alter table tblEdit -- 기존에 데이터가 문자열로 들어가 있는데 숫자로 바꾼다고??? 
    modify ( data number); -- ORA-01439: column to be modified must be empty to change datatype 
                    -- 수정하려거든 비워놔라 
                    
alter table tblEdit -- 기존에 데이터가 문자열로 들어가 있는데 숫자로 바꾼다고??? 
    modify ( seq varchar2(30));  -- 얘도 안된다.

desc tblEdit; -- 이제는 다 타입을 바꾸었다. 

drop table tblEdit;

create table tblEdit (
    seq number primary key,
    data varchar2(20) not null
);

insert into tblEdit values(1, '마우스');
insert into tblEdit values(2, '키보드');
insert into tblEdit values(3, '모니터');

select * from tblEdit; --

alter table tblEdit add (price number default 0 not null);
--> 데이터가 있었는데도 추가가 되는데 이건 price값을 default로 해놓았기에 값을 넣을 값이 있어서 그렇다.

-- ex13_ddl.sql 에서 제약사항 추가~ 


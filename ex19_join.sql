/*

    ex19_join.sql
    
    관계형 데이터베이스 시스템(RDBMS, Oracle)이 지양하는 것들 ....
    1. 테이블에 기본키(PK)가 없는 상태 > 데이터 조작 곤란 
    2. null이 많은 상태의 테이블을 극도로 싫어한다.... > 데이터 조작 + 공간 낭비 
    3. 데이터가 중복되는 상태 > 데이터 조작 곤란 + 공간 낭비
    4. 하나의 속성값이 원자값이 아닌 상태 
   
*/


create table tblTest (
    name varchar2(30) not null,
    age number(3) not null,
    address varchar2(300) not null
);

drop table tblTest;

select * from tblTest;

insert into tblTest(name, age, address) values('홍길동', 20, '서울시');
insert into tblTest(name, age, address) values('아무개', 25, '인천시');
insert into tblTest(name, age, address) values('호호호', 20, '부산시');
insert into tblTest(name, age, address) values('홍길동', 20, '서울시');

select * from tblTest;

update tblTest set address='강릉시' where name = '홍길동'; 

drop table tblTest;

create table tblTest (
    name varchar2(30) not null,
    age number(3) not null,
    address varchar2(300) not null,
    hobby varchar2(300) null
);

insert into tblTest(name, age, address, hobby) values('홍길동', 20 ,'서울시', '독서');
insert into tblTest(name, age, address, hobby) values('아무개', 25 ,'인천시', null);
insert into tblTest(name, age, address, hobby) values('호호호', 27 ,'부산시', '맛집, 여행, 운동, 낮잠');
insert into tblTest(name, age, address, hobby) values('후후후', 29 ,'부산시', '운동유튜브보기');

select * from tblTest;

-- 독서가 취미인?
select * from tblTest where hobby = '독서';

-- 운동이 취미? 
select * from tblTest where hobby = '운동'; -- 이렇게라도 찾으면 되긴 함
select * from tblTest where hobby like '%운동%'; -- 이렇게라도 찾으면 되긴 함

-- 운동 > 신체단련 
-- 맛집, 여행, 운동, 낮잠> 맛집, 여행, 신체단련, 낮잠
-- 원자값이 들어가야해 근데 이렇게 하면 고생을 한다. 
-- 의도적으로 피해야 한다. 

drop table tblTest;

create table tblTest (
    name varchar2(30) not null,
    age number(3) not null,
    address varchar2(300) not null,
    hobby1 varchar2(300) null,
    hobby2 varchar2(300) null,
    hobby3 varchar2(300) null
);

-- 그럼 칼럼을 여러개 만들까?
-- 호호호, 27, 부산시, 운동, null, null, null, null, null, null > 이래버리면 공간 낭비 
-- 후후후, 29, 서울시, A, B, C, D, E, F, J > 이렇게 다쓰면 상관없는디

-- 직원정보 
-- 직원(번호(PK), 이름, 급여, 거주지, 담당프로젝트)
--create table tblStaff (
--    seq number primary key,         -- 번호(PK) 
--    name varchar2(30) not null,     -- 이름
--    salary number not null,         -- 급여
--    address varchar2(300) not null, -- 거주지
--    project varchar2(300) null      -- 담당 프로젝트 --> 요놈이 문제였다. 
--); -- old


insert into tblStaff(seq, name, salary, address, project) values (1, '홍길동', 300, '서울시', '홍콩 수출');
insert into tblStaff(seq, name, salary, address, project) values (2, '아무개', 250, '인천시', 'TV 광고');
insert into tblStaff(seq, name, salary, address, project) values (3, '하하하', 350, '부산시', '매출 분석');
                
select * from tblStaff;

-- 직원 + 담당프로젝트
-- 1명의 직원 > 여러개의 프로젝트 담당 
-- '홍길동'에게 담당 프로젝트 1건 추가 > '고객관리' 
-- '아무개'에게 담당 프로젝트 1건 추가 > '게시판 관리'
insert into tblStaff(seq, name, salary, address, project) 
values (4, '홍길동', 300, '서울시', '홍콩 수출');
update tblStaff set project = project || ',게시판관리' where name = '아무개'; -- 하나의 칼럼에 두개의 프로젝트가 들어간다??... 말이 안됨 이거 고쳐보자
select * from tblStaff;

drop table tblStaff;

create table tblStaff (
    seq number primary key,         -- 번호(PK) 
    name varchar2(30) not null,     -- 이름
    salary number not null,         -- 급여
    address varchar2(300) not null  -- 거주지
    
); -- 원래 tblStaff에 있던 프로젝트를 아래 테이블로 분리 

create table tblProject (
    seq number primary key,           -- 원래부터 필요했던 것은 아닌데 기본키 역할을 위해서 만든 키 
    project varchar2(300) not null,   -- 담당 프로젝트
    staff_seq number not null         -- 직원번호
);

insert into tblStaff(seq, name, salary, address) values (1, '홍길동', 300, '서울시');
insert into tblStaff(seq, name, salary, address) values (2, '아무개', 300, '인천시');
insert into tblStaff(seq, name, salary, address) values (3, '하하하', 300, '부산시');

-- >> 이제 이런 관리가 잘됨 
insert into tblProject( seq, project, staff_seq) values ( 1, '홍콩 수출', 1 );  -- 홍길동
insert into tblProject( seq, project, staff_seq) values ( 2, 'TV 광고',  2);   -- 아무개
insert into tblProject( seq, project, staff_seq) values ( 3, '매출 분석', 3);  -- 하하하
insert into tblProject( seq, project, staff_seq) values ( 4, '노조 협상', 1 ); -- 홍길동
insert into tblProject( seq, project, staff_seq) values ( 5, '대리점 분양',2 ); -- 아무개

-- 원자값 보장 & 중복 발생X > 정규화 : 제 1정규화의 작업을 한 것이다. 
-- 물리적으로 문제가 있는 테이블을 제대로된 구조의 테이블로 바꿈 
select * from tblStaff; 
select * from tblProject;

-- A. 신입 사원 입사 > 신규 프로젝트 담당 
-- A.1 신입 사원 추가 
insert into tblStaff (seq, name, salary, address)  values (4, '호호호', 250, '일산시');

-- A.2 신규 프로젝트 추가 + 담당 지정 
insert into tblProject ( seq, project, staff_seq ) values (6, '자재 매입', 4);

-- A.3 신규 프로젝트 추가 > 문제 발생!! > 존재하지 않는 직원 번호를 사용!!! 
insert into tblProject ( seq, project, staff_seq ) values (7, '고객 유치', 5); -- X 말 안됨 : 잘 되는데... 

-- 사장님!! > '고객 유치' 담당자!!!
select * from tblStaff
where seq = (select staff_seq from tblProject where project ='고객 유치'); -- 아무것도 없음 
-- 담당자가 없음.... 여기서 이미 잘못도니 것이다. 
-- 업무상의 오류고 논리 오류다. 

-- B.  '홍길동' 퇴사
-- B.1 '홍길동' 삭제 
delete from tblStaff where seq = 1;

select * from tblStaff;

-- 사장님!! > "홍콩 수출" > 담당자 누구얌? > 없다. 길동이를 내보내니까 이런 문제가.... 
select * from tblStaff
where seq = (select  staff_seq from tblProject where project ='홍콩 수출');

-- 길동이가 담당자로 되어 있는 프로젝트가 존재함에도 이렇다. 

-- B.2 '아무개' 퇴사 > 인수 인계(위임) > '하하하'
update tblProject set staff_seq = 3 where staff_seq = 2; 
-- 두 건의 프로젝트를 맡고 있어서 두개의 행이 업데이트 된다.

update tblProject set staff_seq = (select seq from tblStaff where name='하하하') 
    where staff_seq = (select seq from tblStaff where name ='아무개'); 


--B.3 '아무개' 퇴사 
delete from tblStaff where seq= 2;

-- 사장님!! > 'TV 광고'
select * from tblStaff 
    where seq = (select staff_seq from tblProject where project = 'TV 광고');

-- 이런 제약사항을 fk로 관리한다. 
drop table tblStaff;
drop table tblProject;

-- 부모 테이블(기본 테이블)  
create table tblStaff (
    seq number primary key,         -- 번호(PK) 
    name varchar2(30) not null,     -- 이름
    salary number not null,         -- 급여
    address varchar2(300) not null  -- 거주지
); -- 원래 tblStaff에 있던 프로젝트를 아래 테이블로 분리 


-- 자식 테이블(참조테이블) 
create table tblProject (
    seq number primary key,                                 -- 원래부터 필요했던 것은 아닌데 기본키 역할을 위해서 만든 키 
    project varchar2(300) not null,                         -- 담당 프로젝트
    staff_seq number not null references tblStaff(seq)      -- 직원번호(참조키, 외래키, FK) > 이 칼럼 때문에 문제다. 
); 
-- 이제부터 이 컬럼에 들어가는 데이터는 아무거나 넣을 수가 없다. staff 테이블이 가지고 있는 staff_seq를 넣어야 한다. 
-- tblProject 테이블 > 이것 먼저 만들면 에러가 난다. 
-- tblStaff이게 어딧는지 모르니까 에러를 띄워주는 것이다.

-- 만들 때 테이블 순서를 조심해라 fk붙은건 나중에 만들어 왜냐면 참조하는 테이블이 먼저 만들어야 하기 때문에 

-- 지울 때는 Project table 먼저 지워야 한다.
-- 그러고 나서 tblStaff테이블도 지운다. 

-- ★ 부모 테이블부터 만들고 자식테이블 만들어야 한다.
-- ★ 지울 때는 자식테이블 먼저 지워야 한다. 

insert into tblStaff(seq, name, salary, address) values (1, '홍길동', 300, '서울시');
insert into tblStaff(seq, name, salary, address) values (2, '아무개', 300, '인천시');
insert into tblStaff(seq, name, salary, address) values (3, '하하하', 300, '부산시');

insert into tblProject( seq, project, staff_seq) values ( 1, '홍콩 수출', 1 );  -- 홍길동
insert into tblProject( seq, project, staff_seq) values ( 2, 'TV 광고',  2);   -- 아무개
insert into tblProject( seq, project, staff_seq) values ( 3, '매출 분석', 3);  -- 하하하
insert into tblProject( seq, project, staff_seq) values ( 4, '노조 협상', 1 ); -- 홍길동
insert into tblProject( seq, project, staff_seq) values ( 5, '대리점 분양',2 ); -- 아무개

-- A.1 신입 사원 추가 
insert into tblStaff (seq, name, salary, address)  values (4, '호호호', 250, '일산시');

-- A.2 신규 프로젝트 추가 + 담당 지정 
insert into tblProject ( seq, project, staff_seq ) values (6, '자재 매입', 4);

-- A.3 신규 프로젝트 추가 > 문제 발생!! > 존재하지 않는 직원 번호를 사용!!! -- 이제 에러가 난다.
-- ORA-02291: integrity constraint (HR.SYS_C007334) violated - parent key not found
insert into tblProject ( seq, project, staff_seq ) values (7, '고객 유치', 5);
                                             -- 5번이라는 번호가 존재하지 않는다. 
-- 홍길동 퇴사 문제가 생긴다. 
delete from tblStaff where seq = 1; 
-- ORA-02292: integrity constraint (HR.SYS_C007334) violated - child record found
-- 자식 테이블이 있어서 못나간다. > 나를 참조하는 애가 있어서 못나가.... child record

update tblProject set staff_seq = 3 where staff_seq = 2; -- 업무 위임 
select * from tblProject;      -- staff_seq = 2 에 해당하는 친구가 없음
delete from tblStaff where seq= 2;  -- 2, '아무개'는 이제 일이 없으니 퇴사 가능
select * from tblStaff;

-- 두 (테이블) 데이터 비교 > 먼저 존재해야할 성격의 데이터 > 부모 테이블 

-- 고객 테이블 
create table tblCustomer (
    seq number primary key,        -- 고객번호(PK)
    name varchar2(30) not null,    -- 고객명
    tel varchar2(15) not null,     -- 연락처
    address varchar2(100) not null -- 주소
);

-- 판매내역 테이블 
create table tblSales(
    seq number primary key,
    item varchar2(50) not null,
    qty number not null,
    regdate date default sysdate not null,
    cseq number not null references tblCustomer(seq)
);  

select * from tblCustomer;
select * from tblSales;
-- 장르 테이블
create table tblGenre (         -- 좀더 큰 느낌
    seq number primary key ,    -- 장르번호(PK)
    name varchar2(30) not null, -- 장르면
    price number not null,      -- 
    period number not null      -- 
);

-- 비디오 테이블
create table tblVideo (
    seq number primary key,        -- 비디오 번호(PK)
    name varchar2(100) not null,   -- 비디오 제목
    qty number not null,           -- 보유 수량
    company varchar2(50) null,     -- 제작사
    director varchar2(50) null,    -- 감독
    major varchar2(50) null,       -- 주연배우 
    genre number not null references tblGenre(seq) -- 장르 번호(FK) 
);

-- 멤버 테이블 
create table tblMember (
    seq number primary key ,
    name varchar2(30) not null,
    grade number(1) not null,
    byear number(4) not null,
    tel varchar2(15) not null,   
    address varchar2(300) null,        -- 주소 
    money number not null              -- 예치금
);

-- 대여 테이블 
create table tblRent ( -- 누가 빌려가 이런건 자식, 아니면 여기에 뭘 글을 달아 
    seq number primary key,                                 -- 대여번호(PK)
    member number not null references tblMember(seq),       -- 회원번호(PK)
    video number not null references tblVideo(seq),         -- 비디오번호(FK)
    rentdate date default sysdate not null,                 -- 대여날짜
    retdate date null,                                      -- 반납날짜
    remark varchar2(500) null                               -- 비고 
);
-- 순서 > 장르 > 비디오 > 회원 > 대여 테이블 생성 



-- 고객 데이터
insert into tblcustomer (seq, name, tel, address)
      values (1, '홍길동', '010-1234-5678', '서울시');
insert into tblcustomer (seq, name, tel, address)
      values (2, '아무게', '010-3333-4444', '인천시');
insert into tblcustomer (seq, name, tel, address)
      values (3, '하하하', '010-5555-6666', '부산시');


-- 판매 데이터
insert into tblsales (seq, item, qty, cseq) values (1, '전화기', 1, 1);
insert into tblsales (seq, item, qty, cseq) values (2, '다이어리', 3, 2);
insert into tblsales (seq, item, qty, cseq) values (3, '노트', 10, 2);
insert into tblsales (seq, item, qty, cseq) values (4, '볼펜', 20, 3);
insert into tblsales (seq, item, qty, cseq) values (5, '지우개', 15, 3);
insert into tblsales (seq, item, qty, cseq) values (6, '마우스', 5, 1);
insert into tblsales (seq, item, qty, cseq) values (7, '키보드', 2, 3);
insert into tblsales (seq, item, qty, cseq) values (8, '모니터', 1, 2);
insert into tblsales (seq, item, qty, cseq) values (9, '선풍기', 2, 1);

commit;






-- 장르 데이터
INSERT INTO tblGenre VALUES (1, '액션',1500,2);
INSERT INTO tblGenre VALUES (2, '에로',1000,1);
INSERT INTO tblGenre VALUES (3, '어린이',1000,3);
INSERT INTO tblGenre VALUES (4, '코미디',2000,2);
INSERT INTO tblGenre VALUES (5, '멜로',2000,1);
INSERT INTO tblGenre VALUES (6, '기타',1800,2);


-- 비디오 데이터
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (1, '영구와 땡칠이',5,'영구필름','심영래','땡칠이',3);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (2, '어쭈구리',5,'에로 프로덕션','김감독','박에로',2);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (3, '털미네이터',3,'파라마운트','James','John',1);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (4, '육복성',3,'대만영화사','홍군보','생룡',4);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (5, '뽀뽀할까요',6,'뽀뽀사','박감독','최지후',5);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (6, '우정과 영혼',2,'파라마운트','James','Mike',5);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (7, '주라기 유원지',1,NULL,NULL,NULL,1);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (8, '타이거 킹',4,'Walt','Kebin','Tiger',3);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (9, '텔미 에브리 딩',10,'영구필름','강감독','심으나',5);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (10, '동무',7,'부산필름','박감독','장동근',1);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (11, '공동경쟁구역',2,'뽀뽀사','박감독','이병흔',1);




-- 회원 데이터
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (1, '김유신',1,1970,'123-4567','12-3번지 301호',10000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (2, '강감찬',1,1978,'111-1111','777-2번지 101호',0);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (3, '유관순',1,1978,'222-2222','86-9번지',20000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (4, '이율곡',1,1982,'333-3333',NULL,15000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (5, '신숙주',1,1988,'444-4444','조선 APT 1012호',0);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (6, '안중근',1,1981,'555-5555','대한빌라 102호',1000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (7, '윤봉길',1,1981,'666-6666','12-1번지',0);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (8, '이순신',1,1981,'777-7777',NULL,1500);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (9, '김부식',1,1981,'888-8888','73-6번지',-1000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (10, '박지원',1,1981,'999-9999','조선 APT 902호',1200);

-- 대여 데이터
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (1, 1,1,'2022-01-01',NULL);
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (2, 2,2,'2022-02-02','2022-02-03');
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (3, 3,3,'2022-02-03',NULL);
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (4, 4,3,'2022-02-04','2022-02-08');
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (5, 5,5,'2022-02-05',NULL);
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (6, 1,2,'2022-02-10',NULL);

commit;

select * from tblcustomer;
select * from tblsales;

select * from tblGenre;
select * from tblVideo;
select * from tblMember;
select * from tblRent;

/*
    조인, join
    - (서로 관계를 맺은) 2개(1개) 이상의 테이블을 사용해서, 1개의 결과셋을 만드는 연산
    - 테이블A + 테이블B = 테이블C
    
    조인의 종류
    1. 단순 조인, Cross join
    2. 내부 조인, Inner join *** 
    3. 외부 조인, Outer join ***
    4. 셀프 조인, Self join
    5. 전체 외부 조인, Full Outer Join
    
    1. 단순 조인, Cross Join
        - 카티션곱, 데카르트곱
        - A 테이블 레코드 개수 x B 테이블 레코드 개수 = 결과셋 레코드 개수
        - A 테이블 컬럼 개수 + B 테이블 컬럼 개수 = 결과셋의 컬럼 수 
        - 쓸모없다. > 가치가 있는 행과 가치가 없는 행이 뒤섞여 있다. 
        - 개발용, 테스트용 > 유효성과 상관없이 다량의 데이터를 만들 때.... 
        
     * 왼쪽의 테이블, 오른쪽의 테이블 1대1로 매칭해서 결과셋을 만든다. 
        
     2. 내부 조인, Inner Join
     - 단순 조인에서 유효한 레코드만 추출하는 조인(노란색 추출)
     - select 컬럼리스트 from 테이블A inner join 테이블B on 테이블A.컬럼 = 테이블B.컬럼; -- ANSI-SQL
                                --> 왼쪽 테이블의 컬럼과 오른쪽 테이블의 컬럼이 동일한 조건을 가져야 한다.
     - select 컬럼리스트 from 테이블A, 테이블B where 테이블A.컬럼 = 테이블B.컬럼;        -- Oracle 전용표기법
                            -- 이게 where가 조인용도인지 아니면 다른 용도인지 헷갈린다. > 가독성 떨어진다. 
    
    select 컬럼리스트
    from tableA 
        inner join tableB
            on tableA.컬럼 = tableB.컬럼;
            
select 컬럼리스트
from 테이블A
    inner join 테이블 B
        on 부모테이블.id = 자식테이블.id
*/

select * from tblCustomer; -- 3명
select * from tblSales;    -- 9명

select * from tblCustomer cross join tblSales; 
-- ANSI-SQL > 권장 
-- 곱하기 연산자 느낌이다.
select * from tblCustomer; -- 얘도 seq
select * from tblSales; -- 얘도 seq가 있다. 

select * from tblCustomer 
    inner join tblSales
        on seq = cseq; -- ORA-00918: column ambiguously defined
        -- 여기 seq가 tblSales 것인지, tblCustomer것인지 모른다.



select name, item, tblCustomer.seq, tblSales.seq 
from tblCustomer 
    inner join tblSales
        on tblCustomer.seq = tblSales.cseq; 
       
-- 귀찮다. 그래서 별칭을 붙인다.... 

select 
    c.name, s.item, c.seq, s.seq -- 가독성은 좋아진다. 
from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq;


select * from tblCustomer, tblSales; -- Oracle 전용 > 두 테이블의 row의 수들을 곱한 것이 결과행수이다.

-- 원래 아래 2개의 테이블은 1개의 테이블이었다.
select * from tblStaff; -- 한사람이 2개이상의 프로젝트를 저장하니 문제다. 
select * from tblProject;

-- 원래 1개의 테이블 정보를 2개로 나눴다. > 가끔씩 2개의 정보를 다시 1개로 합쳐서 봐야할 업무가 생긴다. 
-- > 그 때 쓰는 것이 Join이다. 

select 
*
from tblStaff s 
    inner join tblProject p 
        on s.seq = p.staff_seq;
        -- 자식 fk
        -- 부모쪽의 pk
        
-- 쪼개놓은 것들 다시 합치는 것이 join이다. 

-- 1. 직원 명단을 가져오시오.
select * from tblStaff;

-- 2. 진행중인 프로젝트 목록을 가져오시오.
select * from tblProject;

-- 3. 진행중인 프로젝트(tblProject)와 해당 담당직원의 이름(tblStaff)을 가져오시오.
select 
*
from tblStaff s
    inner join tblProject p 
        on s.seq = p.staff_seq;

-- 나뉘어져 있는 정보를 하나의 테이블로 가져온다. 

select * from tblGenre;
select * from tblVideo;
-- 비디오 제목, 대여 가격이 각각 얼만지 알고 싶다.

select 
*
from tblVideo v
    inner join tblGenre g
        on v.genre = g.seq;
        
select 
    v.name,
    g.price
from tblGenre g
    inner join tblVideo v
        on v.genre = g.seq;

-- tblCustomer + tblSales
-- :> 조인 or 서브쿼리 

-- 고객명 + 상품명
-- 1. join > 얘가 속도가 조금 빠르긴 하다.
select 
    c.name as "고객명",
    s.item as "상품명"
from tblCustomer c
    inner join tblSales s 
        on c.seq = s.cseq;

-- 2.subquery > 절대적으로 join이 빠르진 않다.
select 
    item as "상품명",
    (select name from tblCustomer where seq = tblSales.cseq) as "고객명"
from tblSales;

select * from tblGenre;
select * from tblVideo;
select * from tblRent;


-- 누구랑 관계를 맺고 있는지 잘 기억해라... 
select 
    v.name as "비디오",
    r.rentdate as "언제",
    g.period as "대여기간",
    r.rentdate + g.period as "반납날짜"
from tblGenre g
        inner join tblVideo v
            on g.seq = v.genre              -- tblGenre <-> tblVideo
                inner join tblRent r
                    on v.seq = r.video;     -- tblVideo <-> tblRent

select * from tblGenre;
select * from tblVideo;
select * from tblRent;
select * from tblMember;

select 
    m.name as "누가?",
    v.name as "비디오?",
    r.rentdate as "빌린날",
    m.money as "돈얼마?"
    
from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre --
            inner join tblRent r
                on v.seq = r.video --
                    inner join tblMember m
                        on m.seq = r.member;

select * from tblStaff;
select * from tblSales;


select  
* 
from tblStaff s1
    inner join tblSales s2
        on s1.seq = s2.cseq;
-- join은 반드시 부모 자식으로 엮인 테이블로 동작되는게 아니다.
-- 근데 관계가 있어야 한다. 자식 테이블 부모 테이블 간의 관계를 이용해야 한다.!!!!
-- 근데 fk를 안걸어놔도 데이터상에도 관계를 걸어놓은 테이블이 있다. > 설계상 그런것이 물리적으로 있다. 

select * from employees;


-- hr > 7개 > 이렇게 5개가 연달아 1열로 참조한다.
select * from employees;
select * from departments;
select * from locations;
select * from countries;
select * from regions;

select * from jobs;

-- 어느지역
select  
    *
from employees e
    inner join departments d 
        on d.department_id = e.department_id
            inner join locations l
                on l.location_id = d.location_id; -- pk와 fk 이름을 통일 시켜놓음

select  
    *
from employees e
    inner join departments d 
        on d.department_id = e.department_id
            inner join locations l
                on l.location_id = d.location_id
                    inner join countries c 
                        on c.country_id = l.country_id; -- pk와 fk 이름을 통일 시켜놓음

-- join을하면 *표를 안적는다 중복되는데 연달아 붙어서 나온다. 그래서 이게 낭비다. > 원하는 칼럼만 가져오자
select  
    *
from employees e
    inner join departments d 
        on d.department_id = e.department_id
            inner join locations l
                on l.location_id = d.location_id
                    inner join countries c 
                        on c.country_id = l.country_id
                            inner join regions r
                                on r.region_id = c.region_id
                                    inner join jobs j
                                        on j.job_id = e.job_id; -- pk와 fk 이름을 통일 시켜놓음
                                      

-- join을하면 *표를 안적는다 중복되는데 연달아 붙어서 나온다. 그래서 이게 낭비다. > 원하는 칼럼만 가져오자
select  
    e.first_name || ' ' || e.last_name as "이름",
    d.department_name as "부서",
    l.city as "도시",
    c.country_name as "국가",
    r.region_name as "대륙",
    j.job_title as "직업"
from employees e
    inner join departments d 
        on d.department_id = e.department_id
            inner join locations l
                on l.location_id = d.location_id
                    inner join countries c 
                        on c.country_id = l.country_id
                            inner join regions r
                                on r.region_id = c.region_id
                                    inner join jobs j
                                        on j.job_id = e.job_id; -- pk와 fk 이름을 통일 시켜놓음
                                      
-- [ 클라이언트의 요구사항을 구현하는 것이 1순위다. > 요구사항을 명확하게 파악하는 것이 좋다. ]


/*
    3. 외부 조인, Outer join
    - 내부 조인 결과 + 결과셋에 포함되지 못한 부모 테이블의 나머지 레코드
    
    select 
        컬럼리스트
    from 테이블A
        inner join 테이블A
            on 테이블A.컬럼 = 테이블B.컬럼;
            
    select 
        컬럼리스트
    from 테이블A
        (left|right) outer join 테이블B  -- 왼쪽에도 테이블이 있고 오른쪽에도 테이블이 있는데 둘 중에 하나를 가르켜야 한다.
            on 테이블A.컬럼 = 테이블B.컬럼;
            
            
*/

select * from tblCustomer; -- 3명
select * from tblSales;    -- 9건


insert into tblCustomer values (4, '호호호', '010-1234-4321', '서울시' );

-- 한번이라도 구매한 이력 있는 고객들의 정보와 구매 이력을 가져오시오.
select 
*
from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq; 
        
-- 구매 이력과 상관없이 모든 고객 정보를 가져오되, 단 구매 이력 있으면 그것도 같이 가져오시오.
select -- inner join 양쪽 테이블에 동시에 존재하는 것만 가져오는 느낌 
* 
from tblCustomer c
    left outer join tblSales s -- 왼쪽에서는 다 가져온 것이다. 
        on c.seq = s.cseq;
-- 고객 테이블에 있는 고객번호는 물건을 산 이력이 있었다. 
-- 근데 새로 넣은 데이터는 구매한 이력이 없다. 

-- inner join의 결과를 outer join에 가지고 있다.

select *
from tblCustomer c
    right outer join tblSales s
        on c.seq = s.cseq;
        
select * from tblStaff;
select * from tblProject;

insert into tblStaff(seq, name, salary, address) values (2, '아무개', 250, '인천시');

-- 직원 명단 + 담당 프로젝트 
-- 1. inner join 
-- : '아무개' 제외 > 담당 프로젝트가 없어서 .. > 부모 레코드가 자식 테이블에 참조되지 않았기 때문에 
select 
    * 
from tblStaff s
    inner join tblProject p 
        on s.seq = p.staff_seq; 

-- 2. outer join 
-- : 담당 프로제그가 없는 직원들까지.. > 참조가 없는 부모레코드까지 가져오시오.
select 
    *
from tblStaff s
    left outer join tblProject p
        on s.seq = p.staff_seq;
        

-- tblVideo, tblRent
-- 대여가 한번이라 된 비디오와 그 대여 내역을 가져오시오. > inner join
select * 
    from tblVideo v
        inner join tblRent r
            on v.seq = r.video;
            
select name, count(*) 
    from tblVideo v
        inner join tblRent r
            on v.seq = r.video
                group by name
                    order by count(*) desc; -- 일부 칼럼이 null이라도 레코드 전체를 샌다.
                    
                    
select name, count(rentdate)
    from tblVideo v
        left outer join tblRent r
            on v.seq = r.video
                group by name
                    order by count(rentdate) desc;
            
            
-- 대여와 상관없이 모든 비디오와 그 대여 내역을 가져오시오. > outer join
select * 
    from tblVideo v
        left outer join tblRent r
            on v.seq = r.video;  -- 대여내용이 있든 없든 다 가져옴
         
select * 
    from tblVideo v
        left outer join tblRent r
            on v.seq = r.video
                where rentdate is null; -- 악성재고


-- tblMember, tblRent 
-- [ 대여를 1회 이상 > 고객 정보 + 대여 정보 ]
select 
*
from tblMember m
    inner join tblRent r
        on m.seq = r.member;
        

select -- 대여를 한번도 하지 않은 고객들도 대여를 했던 고객이랑 같이 출력해줘 
*
from tblMember m
    left outer join tblRent r
        on m.seq = r.member;


select -- 대여를 한번도 하지 않은 고객들도 대여를 했던 고객이랑 같이 출력해줘 
*
from tblMember m
    left outer join tblRent r
        on m.seq = r.member
            where rentdate is null;

-- 멤버테이블, 대여테이블 대여에 없어? 그러면 대여를 한번도 안한 고객이 있다!?


select *  from tblStaff;
select *  from tblProject;


-- tblStaff, tblProject. 현재 재직중인 모든 직원의 이름, 주소, 월급, 담당프로젝트명을 가져오시오.
select distinct s.name, s.address, s.salary, p.project
    from tblStaff s inner join tblProject p
        on s.seq = p.staff_seq;
    

-- 고객 대여 비디오 장르
    
-- tblVideo, tblRent, tblMember. '뽀뽀할까요' 라는 비디오를 빌려간 회원의 이름은?
select * from tblVideo; -- 뽀뽀는 5번이다. 5번을 찾아서 
select * from tblRent; -- video 5번으로 member 찾기 멤버는 5번이다.
select * from tblMember; -- 5번 멤버는 이름이 머야?


-- 답>
select name
from ( select *
from tblRent 
where video = ( select seq from tblVideo
where name ='뽀뽀할까요')) sr inner join tblMember
on sr.member = tblMember.seq;

-- 2번 조인하고 마지막에 where문으로 써도 되긴함

    
select * 
from tblStaff;
select * 
from tblProject;
-- tblStaff, tblProject. 'TV 광고'을 담당한 직원의 월급은 얼마인가?
-- 답> 
select s.salary
from tblStaff s inner join tblProject p
on p.project = 'TV 광고' and p.staff_seq = s.seq;

   
   
select * from tblVideo;
select * from tblRent;
select * from tblMember;
-- tblVideo, tblRent, tblMember. '털미네이터' 비디오를 한번이라도 빌려갔던 회원들의 이름은?

-- > 답
select m.name
from tblMember m 
    inner join tblRent r
        on m.seq = r.member 
            inner join tblVideo v
                on v.seq = r.video and v.name ='털미네이터';
          
select  * from tblStaff;
select  * from tblProject;
-- tblStaff, tblProject. 서울시에 사는 직원을 제외한 나머지 직원들의 이름, 월급, 담당프로젝트명을 가져오시오.
select s.name, s.salary, p. project
from tblStaff s inner join tblProject p
on s.seq = p.staff_seq and s.address <> '서울시';


-- tblCustomer, tblSales. 상품을 2개(단일상품) 이상 구매한 회원의 연락처, 이름, 구매상품명, 수량을 가져오시오.
select * from tblCustomer;
select * from tblSales; -- 이거는 구매기록 

select c.tel, c.name, s.item, s.qty
from tblCustomer c  inner join tblSales s
    on c.seq = s.cseq
        where s.qty > 1
            ORDER BY c.name asc, s.item asc;


-- qty가 수량이엇음?

SELECT c.name, c.tel, s.item, s.qty FROM tblcustomer c
    inner join tblsales s
        on c.seq = s.cseq
            where s.qty > 1
                ORDER BY c.name asc, s.item asc;

-- tblVideo, tblRent, tblGenre. 모든 비디오 제목, 보유수량, 대여가격을 가져오시오.
select * from tblVideo; -- 제목은 여기, 보유수량 
select * from tblRent; -- 
select * from tblGenre; -- 가격
select * from tblMember;

-- > 답 
select 
v.name, v.qty, g.price
from tblVideo v inner join tblGenre g
on v.genre =  g.seq;
                
-- tblVideo, tblRent, tblMember, tblGenre. 2022년 2월에 대여된 구매내역을 가져오시오. 회원명, 비디오명, 언제, 대여가격


-- tblVideo > 비디오명 
-- tblGenre > 가격 
-- tblRent > 언제 
-- tblRent > 조건거르기
-- tblMember > 회원명


select m.name "회원명", v.name "비디오명", r.rentdate "언제", g.price "가격"
from tblVideo v inner join tblGenre g
on v.genre = g.seq inner join tblRent r 
on r.video = v.seq and r.rentdate in (
select rentdate -- 2022 2월의 구매 내역들 ~ 
from tblRent
where rentdate between to_date('2022-02-01') and to_date('2022-12-31') 
) inner join tblMember m
on r.member = m.seq;

-- 선생님꺼 
SELECT m.name, v.name, r.rentdate, g.price FROM tblmember m
    inner join tblrent r
     on m.seq = r.member
        inner join tblvideo v
            on r.video = v.seq
                inner join tblgenre g
                    on v.genre = g.seq
        where r.rentdate >= to_date('2022-02-01', 'yyyy-mm-dd');



-- tblVideo, tblRent, tblMember. 현재 반납을 안한 회원명과 비디오명, 대여날짜를 가져오시오.
-- tblRent의 retdate가 null인 친구를 찾아라 
select m.name "회원명", v.name "비디오명", r.rentdate "언제"
from tblVideo v  inner join tblRent r 
on r.video = v.seq and r.rentdate in (
select rentdate 
from tblRent
where retdate is null 
) inner join tblMember m
on r.member = m.seq;
-- 다 조인하고 마지막에 조건달기     
    
SELECT m.name, v.name, r.rentdate FROM tblmember m
    inner join tblrent r
        on m.seq = r.member
            inner join tblvideo v
                on r.video = v.seq
    where r.retdate is null;
    

-- employees, departments. 사원들의 이름, 부서번호, 부서명을 가져오시오.
-- 답
select e.first_name || ' ' || e.last_name "이름", e.department_id "부서번호", d.department_name "부서명"
from employees e inner join departments d
on e.department_id = d.department_id;
    
select * from departments; -- department_id
-- employees_id, department_id


-- employees, jobs. 사원들의 정보와 직업명을 가져오시오.
select * from employees;
select * from jobs;

select e.*,j.job_title
from employees e inner join ( -- 칼럼 줄이기
                            select job_id, job_title 
                            from jobs) j
on e.job_id = j.job_id;


-- 일단 보류   
-- ★ employees, jobs. 직무(job_id)별 최고급여(max_salary) 받는 사원 정보를 가져오시오.
--with test as (
--select e.job_id, max_salary
--from employees e inner join jobs j
--on e.job_id = j.job_id
--)



desc jobs;

select e1.*
from employees e1
where  (job_id, salary) in (select job_id, max_salary from jobs);

select * from jobs;

--SELECT * FROM HR.employees e
--    INNER JOIN ( SELECT j.job_id as job1,count(*),max(j.max_salary) as maxvalue FROM HR.employees e
--        inner join HR.jobs j
--            on e.job_id = j.job_id
--                group by j.job_id ) k
--    on e.job_id = k.job1
--        where e.salary = k.maxvalue;
--        
-- ★ 이거 하나만 나중에 다시 풀기





-- departments, locations. 모든 부서와 각 부서가 위치하고 있는 도시의 이름을 가져오시오.
select * from departments;
select * from  locations;

select department_name, city 
from departments d inner join locations l
on d.location_id = l.location_id;

        
-- locations, countries. location_id 가 2900인 도시가 속한 국가 이름을 가져오시오.

select * from countries; -- country_id
select * from locations;

-- > 답
select c.country_name
from countries c inner join locations l
on c.country_id = l.country_id and l.location_id = 2900;
            
-- departments 
select * from employees; -- department_id
select * from departments;


-- employees. 급여를 12000 이상 받는 사원과 같은 부서에서 / 근무하는 사원들의 이름, 급여, 부서번호를 가져오시오.

-- 1. 급여를 12000 이상 받는 사원이 있는 부서 찾기
--with test as (
--select distinct department_id 
--from employees
--where salary >= 12000 )
--
--select e.first_name || ' ' || e.last_name, e.salary, e.department_id
--from employees e
--where department_id in (select * from test) and salary >= 12000;

SELECT e.first_name||' '||e.last_name as name, e.salary, e.department_id FROM HR.employees e
    inner join (SELECT DISTINCT (job_id) FROM HR.employees where salary >= 12000) f
        on e.job_id = f.job_id;

-- ★ inner join시에 서브쿼리를 대상으로 조인도 가능
        
-- employees, departments. locations.  'Seattle'에서(LOC) 근무하는 사원의 이름, 직위(job_id), 부서번호, 부서이름을 가져오시오.
--> 답
select e.first_name || ' ' || e.last_name, e.job_id, e.department_id, d.department_name
from employees e inner join departments d
on e.department_id = d.department_id inner join locations l
on d.location_id = l.location_id and l.city ='Seattle';

    
    
-- employees, departments. first_name이 'Jonathon'인 직원과 같은 부서에 근무하는 직원들 정보를 가져오시오.
with test as (
select e.department_id
from employees e inner join departments d
on e.department_id = d.department_id and e.first_name = 'Jonathon')

select *
from employees
where department_id = (select * from test ) ;


    
-- employees, departments. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을 출력하는데 월급이 3000이상인 사원을 가져오시오.
select e.first_name || ' ' || e.last_name, d.department_name, e.salary
from employees e inner join departments d
on e.department_id = d.department_id and e.salary>=3000;
            
            
-- employees, departments. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름, 월급을 가져오시오.
select d.department_id,d.department_name, e.first_name || ' ' || e.last_name,  e.salary
from employees e inner join departments d
on e.department_id = d.department_id and e.department_id=10;
            

select * from 
job_history;
select * from 
departments;
select * from employees;
-- departments, job_history. 퇴사한 사원의 입사일, 퇴사일, 근무했던 부서 이름을 가져오시오.
-- > 답
select h.start_date, h.end_date, d.department_name
from departments d inner join job_history h
on h.department_id = d.department_id;
        
SELECT h.employee_id, h.start_date, h.end_date, d.department_name FROM HR.job_history h
    inner join HR.departments d
        on h.department_id = d.department_id;



        
-- employees. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호', '사원이름', '관리자번호', '관리자이름'으로 하여 가져오시오.
select * from employees;
-- self join
select e.employee_id "사원번호", e.first_name || ' ' || e.last_name "사원이름", m.employee_id "관리자번호", m.first_name || ' ' || m.last_name "관리자이름"
from employees e inner join employees m
on e.manager_id = m.employee_id;
        
-- employees, jobs. 직책(Job Title)이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 평균 급여를 가져오시오. 년도를 기준으로 오름차순 정렬.
select * from jobs;
with test as (
select to_char( hire_date, 'YYYY') as 입사년도, salary
from employees e inner join jobs j
on e.job_id = j.job_id
where job_title = 'Sales Manager')
select 입사년도, avg(salary)
from test 
group by 입사년도
order by 입사년도;

SELECT to_char(e.hire_date, 'yyyy')||'년도' as "입사년도", avg(e.salary) as "평균 급여" FROM HR.employees e
    inner join HR.jobs j
        on e.job_id = j.job_id
            where j.job_title = 'Sales Manager'
                GROUP BY to_char(e.hire_date, 'yyyy')
                    ORDER BY to_char(e.hire_date, 'yyyy') asc;


select * from departments;
select * from departments;
-- employees, departments. locations. 각 도시(city)에 있는 모든 부서 사원들의 평균급여가 가장 낮은 도시부터 도시명(city)과 평균연봉, 해당 도시의 사원수를 가져오시오. 단, 도시에 근무하는 사원이 10명 이상인 곳은 제외하고 가져오시오.
select city, round(avg(e.salary)), count(e.employee_id)
from employees e inner join departments d
        on e.department_id = d.department_id 
    inner join locations l
        on d.location_id=l.location_id 
        group by city
        having count(e.employee_id) < 10
        order by avg(e.salary);

            
-- employees, jobs, job_history. 
-- ‘Public  Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 가져오시오.
-- 현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려 하지 말것.
select * from employees;
select * from jobs;
select * from job_history; -- Accountant 이친구들의 employee_id를 뽑아서 이름을 찾고 

select e.employee_id "사번", e.first_name || ' ' || e.last_name "사원이름"
from jobs j inner join job_history h -- 여기서 찾는 
on j.job_id = h.job_id and j.job_title = 'Public Accountant' inner join employees e
on h.employee_id = e.employee_id;


    
-- employees, departments, locations. 커미션을 받는 모든 사람들의 first_name, last_name, 부서명, 지역 id, 도시명을 가져오시오.
select * from employees;
select * from departments;

select e.first_name || ' ' || e.last_name "사원이름", d.department_name, l.location_id, l.city
from employees e inner join departments d 
on e.department_id = d.department_id and e.commission_pct is not null inner join locations l
on d.location_id = l.location_id;
    
-- ★ 조인은 다걸어버리고 where 조건은 최대한 뒤로 빼기     
    
-- employees. 자신의 매니저보다 먼저 고용된 사원들의 first_name, last_name, 고용일을 가져오시오.
select e.first_name , e.last_name , e.hire_date "고용일"
from employees e inner join employees m
on e.manager_id = m.employee_id and e.hire_date < m.hire_date ;

select * from employees where first_name ='Lex'; --01/01/13


select * from employees; --03/06/17




/*
    4. 셀프조인, self join
    - 1개의 테이블을 사용하는 조인
    - 테이블 스스로가 자신과 관계를 맺는 경우 
*/

-- 직원 테이블
create table tblSelf (
    seq number primary key,                    -- 직원번호(PK)
    name varchar2(30) not null,                -- 직원명
    department varchar2(50) null,              -- 부서명
    super number null references tblSelf(seq)  -- 집합이 똑같을 뿐이다. -- 상사번호(FK)
);


insert into tblSelf values(1, '홍사장', null, null);
insert into tblSelf values(2, '김부장', '영업부', 1); 
insert into tblSelf values(3, '이과장', '영업부', 2); 
insert into tblSelf values(4, '정대리', '영업부', 3); 
insert into tblSelf values(5, '최사원', '영업부', 4); 
insert into tblSelf values(6, '박부장', '개발부', 1); 
insert into tblSelf values(7, '박부장', '개발부', 6); 

select * from tblSelf;

-- 직원 명단을 가져올건데 상사도 가져와라
--1. join
--2. subquery 
select
b.name as "직원명",
a.name as "상사명"
from tblSelf a
    inner join tblSelf b -- 직원
        on a.seq = b.super;    
-- 조인시에 앞에 있는 정보가 먼저나오는데 
-- 근데 홍사장이라는 애는 없다. 

select
b.name as "직원명",
a.name as "상사명"
from tblSelf a
    right outer join tblSelf b -- 직원 >> right 이긴한데
        on a.seq = b.super;    

select
a.*,
( select name from tblSelf where seq = a.super ) as "상사명"
from tblSelf a; -- 직원
-- 연관서브쿼리를 사용하는 방법인데 이건 join보다 조금더 직관적? 
-- 자기가 자기를 참조하는 관계 


-- 직원명 + 상사명
select 
    e1.first_name as "직원명",
    e2.first_name as "매니저명"
from employees e1
    inner join employees e2
        on e1.manager_id = e2.employee_id;

-- ★ select절 서브쿼리를 기억하자
select 
    e1.first_name as "직원명",
    (select first_name from employees where employee_id = e1.manager_id) as "매니저명"
from employees e1;

/*
    5. 전체 외부 조인, Full Outer Join
    - 서로 참조하고 있는 관계에서 사용
*/
select * from tblmen;   -- couple > 여자 테이블 참조
select * from tblwomen; -- couple > 남자 테이블 참조

-- 커플(남자명 + 여자명) 
select
    w.name as "여자",
    m.name as "남자"
from tblmen m -- 자식
    inner join tblwomen w -- 부모
        -- on m.name = w.couple; 
        on w.couple =  m.name ; -- 이거도 동일하다. 
        
-- 여자의 이름과 남자의 이름 
-- 자식테이블이 메인인데 그거만으로 정보를 얻을 수 없어서 부모테이블을 끌어오는 것이다.

-- 커플(남자명 + 여자명) + 솔로(남자) 


select
    m.name as "남자", -- 순서상 이쪽에 left 기준테이블 잡는게 나음
    w.name as "여자"
from tblmen m -- 자식 --> 메인임 
    left outer join tblwomen w -- 부모
        on w.couple =  m.name ; -- 이거도 동일하다. 

select
    w.name as "여자",
    m.name as "남자" 
from tblmen m 
    full outer join tblwomen w 
        on w.couple =  m.name ; 












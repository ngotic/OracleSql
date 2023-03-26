/*

    ex28_modeling.sql
    
    주제 > 기존의 다른 시스템 or 사이트들 사용해보면서 기능파악 > 요구사항 추출 : 기획의도 정하기 - 기본적인 기능 파악 > 데이터 모델링 [> 추가적인 기능 도출 ]
    
    데이터베이스 설계
    1. 요구사항 수집 및 분석
    2. 개념 데이터 모델링
    3. 논리 데이터 모델링
    4. 물리 데이터 모델링
    5. 데이터베이스 구축 
    
    데이터 모델링
    - 요구 분석 기반 > 수집한 데이터 > 분석 > 저장 구조 생성 > 도식화 > ERD(산출물) 
    - 데이터 저장하기 위한 데이터 구조를 설계하는 작업 
    - DBMS 종류를 결정하지 않는다.
    
    [-> 개념 데이터 모델링 > 간단하게 표현한 설계도 > 테이블 + 컬럼 + 관계 : 러프하게 스케치 ] : 얘를 만드는 툴이 없었다. 

    - 논리 데이터 모델링 > 관계형 데이터베이스 성질 반영 > 속성 + 도메인 + 키 > 제대로된 설계도 
    - 물리 데이터 모델링 > 특정 DBMS 결정 > 오라클 > 오라클에 종속적인 모든 것들이 추가로 설계 > 오라클 선정 + 반영 > 물리적 설정...
    
    
    1. ERD, Entity Relationship Diagram
    - 엔터티간의 관계를 표현한 그림
    - 관계형 데이터베이스 모델링 기법 중 하나 
    - 손, 오피스, 전문틀(exERD, ER-Win 등 ) 
    
    2. Entity, 엔티티
    - 다른 Entity와 분류될 수 있고, 다른 Entity에 대해 정해진 관계를 맺을 수 있는 데이터 단위
    - 릴레이션 = 객체 = 레코드 = 엔터티 = 테이블(행)
        a. 학생 정보 관리 ( 정보들이 수집이 된다. 
            - 정보 수집 : 아아디, 학생명, 나이, 주소, 연락처...  이걸 묶었더니 학생 한명의 데이터다. 이걸 실제로 묶는다.
            - 학생(_아이디_, 학생명, 나이, 주소, 연락처) > 이때 이 학생을 Entity라고 부른다. 
            얘네들은 속성이라고 한다. 근데 이 속성중엔 식별자 역할을 하는 애가 있다. 
        b. 강의실 정보 관리 
            - 정보 수집: 강의실 호수, 크기, 인원수, 용도, 면적...
            - 강의실(강의실 호수, 크기, 인원수, 용도, 면적) 
        - 이런식으로 관계가 있는 정보를 모아둔 것이다. 
    3. Attribute, 속성
    - 엔티티를 구성하는 정보
    - 컬럼
    4. Entity Relationship, 엔티티 관계
    - 학생(이름,나이...)
    - 교사(이름,담당과목..)
    - 학급(학년,반..)
    - 학생 <-> 학급 <-> 교사 : Entity Relationship 이라고 부른다.
    - 비디오 장르, 비디오 랜트, 랜트랑 멤버 관계를 맺고 있는데 이런게 relationship이다. 
    
    
    ERD를 그리는 법 > Entity, Attribute, Relationship 등을 표현하는 방법 
    이런걸 어떻게 그리는지에 대한 얘기다. 
    
    1. Entity 
    - 사각형
    - 이름을 작성
    - ERD내에 동일한 엔티티 명은 사용금지 
    
    2. Attribute
    - 동그라미
    - 엔터티에 연결
    - 추가 표기사항 (속성에 대한 성질 기술)
        a. NN, Not null
            - 해당 속성은 반드시 작성해야 한다.
            - 필수값
        b. ND, Not Duplicate
            - 해당 속성은 중복될 수 없다.
            - 유일값(Unique)
        1. 중복되면 안되고, 생략되면 안된다.(NN, ND)
            - #*속성명
            
        2. 생략되면 안된다.(NN)
            -*속성명
            
        3. 중복되면 안된다.(ND)
            -#속성명
        4. 중복되도 되고, 생략되도 된다.
            - 속성명
            - o속성명
            - optional
            
    3. Relationship
    - 마름모
    - 엔티티와 엔티티의 관계
    - 가장 중요한 표현(****)
    
        A엔티티 : B엔티티
        a. 1:1
            - 일대일
        b. 1:0
        c. 1:N
            - 일대다
        d. N:M
            - 다대다
        
        비디오 대여점 
        
        1. 엔티티 정의
            - 장르 
            - 비디오
            - 회원
            - 대여
            
        2. 속성 정의
            -
        3. 식별자 선언
            -기본키
        ------------------------ 개념적 모델링
        4. 논리 모델링 
        
            - 1~3을 반복 > 전문적으로 그리기 
        ------------------------ 논리 모델링
        5. 물리 데이터 모델링 > 오라클 맞게 구체화!!!
            - 물리명(식별자) 생성 > name
            - 자료형 > varchar2 
            - 길이 > 30 
            - 도메인 > 2~5자 이내의 한글 
            - 제약사항 생성
        ------------------------- 물리모델링
        
        모델링 작업 > ERD(논리, 물리) > [정규화] > 안정성 높고, 효율적 구조로 변경 > ERD 가능
        숙련되면 정규화를 안거쳐도 될 정도로 안정성 높게 만든다. >>>>> 
        
        정규화, Normalization 
        - 자료의 손실이나, 불필요한 정보를 없애고, 데이터의 일관성을 유지하며, 데이터 종속성을 최소화하기 위해
        ERD를 수정하는 작업
        ( 처음부터 잘하는 사람은 정규화 상태로 이미 짬 )
        - 우리가 만든 테이블(ERD) > 비정형, 비정규화 상태 > 정규화 > 정규화된 구조 ERD 
        - 제 1정규화 > 제 2 정규화 > 제 3 정규화 
        - 제 1~3 정규화
            
        -> 이런 상태를 유지하면서
        관계형 데이터베이스 시스템이 지향하는 데이터베이스 상태
        1. 원자값을 가진다.
        2. 최대한 null을 가지지 않는다.
        3. 중복값을 가지지 않는다.
        
        -> 이런 상태를 배제하고자 한다. 
        이상 현상
        1. 삽입 이상, Insertion Anomaly
            - 테이블에 데이터를 삽입할 때, 원하지 않는 데이터까지 같이 넣어야 하는 상황
        2. 갱신 이상, Update Anomaly
            - 동일한 데이터가 2개 이상의 테이블에 동시 존재 > 둘 중 1개만 수정 발생 
            -> 둘 중 어느것이 올바른지 ? 알수가 없다.
        3. 삭제 이상, Delete Anomaly 
            - 테이블의 데이터를 삭제할 때, 원하지 않는 데이터까지 같이 지워야 하는 상황
        
        -> 최대한 데이터베이스가 좋아하고자 하는 모습으로 바꾸고자 한다.
        
        함수 종속, Functional Dependency 
        - 1개의 테이블 내 컬럼끼리의 관계를 표현한다.
        - *** 정규화란 '부분 함수 종속'이나 '이행함수 종속'을 모두 없애고,(3정규형까지 가정)
              모든 컬럼 관계를 '완전 함수 종속'으로 만드는 작업이다. 
              
        1. 완전 함수 종속, Full Functional Dependency
        2. 부분 함수 종속, Partial Functional Dependency
        3. 이행 함수 종속, Transitive Functional Dependency
        
        정규화 
        - 비정규화 > 정규화
        - 1NF > 2NF > 3NF(Normal Form)
        
        제 1정규화, 1NF
        - 모든 컬럼(속성)은 원자값을 가진다.
        - 다중값(여러개로 분리 가능한 값)을 1개의 컬럼안에 넣지 않는다.
        - 다중값을 가지는 컬럼 찾기 > 없애는 작업
        
        제 2 정규화, 2NG
        - 기본키(PK)가 아닌 모든 나머지 칼럼은 기본키에 완전 함수 종속되어야 한다.
        - 부분 함수 종속 검색!!> 부분 함수 종속 제거!!
        - 주로 복합키를 가지는 테이블에서 발견된다.
            - 일부 컬럼이 복합키 일부에만 종속되는 현상을 제거하는 정규화다.
            
        ** 근데 복합키를 잘 사용안하기도 한다. 가상키를 생성해서 > PK로 만든다. > seq 같은거
        복합키를 싫어하는 사람들이 많다. 왜냐면 쿼리를 짜기 힘드니까 그렇다.
            
        제 3 정규화, 3NF
        - 기본키(PK)가 아닌 모든 나머지 컬럼은 기본키에 완전 함수 종속이어야 한다.
        - 이행 함수 종속 검색!!> 이행 함수 종속 제거!!
        - 컬럼이 기본키가 아닌 다른 키에 종속되는 현상을 제거하는 정규화.
        
        역정규화
        - 정규화된 결과를 다시 원래대로 되돌리는 작업 
        - 2개로 나뉘어진 테이블을 다시 하나로 합치는 작업이다.
        - 수업 중 사용 금지!!
        
*/

-- 복합키 생성하기 + 사용하기
create table tblStudent (
    seq number primary key,     -- 번호(PK)
    name varchar2(30) not null  -- 학생명
);

-- 과목
create table tblSubject (
    seq number primary key,       -- 번호
    name varchar2(30) not null    -- 과목
);

-- 수강 신청
create table tblRegister (
    -- 컬럼 수준에서는 복합키를 지정할 수 없다. !!!!
    -- student_seq number primary key, -- 두 칼럼으로 pk 만들고 싶을 땐 이게 안된다.
    -- subject_seq number primary key, -- 두 칼럼으로 pk 만들고 싶을 땐 이게 안된다.
    regdate date default sysdate
); --ORA-02260: table can have only one primary key

create table tblRegister (
    -- 컬럼 수준에서는 복합키를 지정할 수 없다. !!!!
    student_seq number, -- 두 칼럼으로 pk 만들고 싶을 땐 이게 안된다.
    subject_seq number, -- 두 칼럼으로 pk 만들고 싶을 땐 이게 안된다.
    regdate date default sysdate,
    
    constraint register_pk primary key(student_seq, subject_seq) -- 복합키 선언
);
-- constraint나 alter로 가능

-- **** 이렇게만 하면 안되고 FK도 만들어야 한다.
drop table tblRegister;


create table tblRegister (
    -- 컬럼 수준에서는 복합키를 지정할 수 없다. !!!!
    student_seq number references tblStudent(seq), 
    subject_seq number references tblSubject(seq), 
    regdate date default sysdate,
    constraint register_pk primary key(student_seq, subject_seq) -- 복합키 선언
);

drop table tblRegister;

create table tblScore(
    seq number primary key,
    score number not null,
    --- 복합키를 참조하는 외래키는 컬럼 수준으로 선언할 수 없다.
    student_seq number,
    subject_seq number,
    constraint score_f foreign key(student_seq, subject_seq) references tblRegister(student_seq, subject_seq)
);

-- 학생 정보가 들어가고 
insert into tblStudent values (1, '홍길동');
insert into tblStudent values (2, '아무개');
insert into tblStudent values (3, '하하하');

-- 그 학생이 수강하는 과목들 정보가 들어가고 
insert into tblSubject values (1, '자바');
insert into tblSubject values (2, '오라클');
insert into tblSubject values (3, 'JDBC');
insert into tblSubject values (4, 'JSP');
insert into tblSubject values (5, 'Spring');

-- 신청날짜
insert into tblRegister values (1, 1, sysdate);
insert into tblRegister values (1, 2, sysdate);
insert into tblRegister values (1, 3, sysdate);
insert into tblRegister values (2, 2, sysdate);
insert into tblRegister values (2, 4, sysdate);
insert into tblRegister values (2, 5, sysdate);
insert into tblRegister values (2, 1, sysdate);
insert into tblRegister values (3, 2, sysdate);
insert into tblRegister values (3, 5, sysdate);

-- 점수가 나왔어 ~
insert into tblScore values (1, 100, 1, 1);
insert into tblScore values (2, 90,  1, 2);
insert into tblScore values (3, 80,  1, 3);
insert into tblScore values (4, 70,  2, 2);
insert into tblScore values (5, 60,  3, 2);

select * from tblStudent;
select * from tblSubject;
select * from tblRegister;
select * from tblScore;

-- 학생 + 과목 > 수강 신청 > 목록
select 
    st.name as "학생명",
    sj.name as "과목명"
from tblStudent st
    inner join tblRegister r
        on st.seq = r.student_seq
            inner join tblSubject sj
                on sj.seq = r.subject_seq;

-- 수강 목록보다 개수가 쭐어들음 score를 개입시켰더니 줄어든 것
-- 학생 + 과목 > 수강 신청 > 목록
select 
    st.name as "학생명",
    sj.name as "과목명",
    sc.score as "성적"
from tblStudent st
    inner join tblRegister r
        on st.seq = r.student_seq
            inner join tblSubject sj
                on sj.seq = r.subject_seq
                    inner join tblScore sc -- 두개의 FK
                        on r.student_seq = sc.student_seq 
                            and r.subject_seq = sc.subject_seq; -- 단지 비교 조건이 늘어남

-- 수강 신청은 했는데 아직 시험을 안본 친구들이 빠져나감
-- 이렇게 빠져나간 친구들도 나는 같이 포함시키고 싶을 때 left outer join을 하면 된다. 
select 
    st.name as "학생명",
    sj.name as "과목명",
    sc.score as "성적"
from tblStudent st
    inner join tblRegister r
        on st.seq = r.student_seq
            inner join tblSubject sj
                on sj.seq = r.subject_seq
                    left outer join tblScore sc -- 두개의 FK
                        on r.student_seq = sc.student_seq 
                            and r.subject_seq = sc.subject_seq; -- 단지 비교 조건이 늘어남


-- 복합키를 쓸 때의 장점은 있느냐? .... 모르겠다. > 그냥 똑같아. 편한거 써! 


/*

설계 작업을 해보자
    데이터 설계 > 
    
    주제는 통일
    
    네이버 영화(https://movie.naver.com/)
    
    1. 영화 랭킹에 들어가서 어떤 데이터인지 파악 > 50개?? 순위 영화제목
    -- 영화누르면 영화에 대한 상세정보 나온다. 이것도 요구하는 타겟이다. 모든 영화정보를 타겟으로 한다.
    -- 모든 데이터에 대한 설계를 하는 것이 요구사항이자 주제
    
    abcdefg~~~~~ > 
    
    1. 데이터 수집 + 분석
        - 데이터 인식
        - 데이터베이스 저장할 데이터를 선별하자 
        
    2. ERD 작성(****)
        a. 개념적 모델링 > 산출물(v)
        b. 논리 모델링   > 산출물(v)
        c. 물리 모델링   > 산출물(v)
    
    3. DDL 작성
        - create 문 작성
        a. 테이블
        b. 시퀀스
        c. 뷰
        - 스크립트 > 산출물 (v)
        
    4. DML 작성
        - 데이터 추가
        - insert문
        - 스크립트 > 산출물(v)(x)
        - 50편 영화
        
   5. select 문 > 검증용
      a. 조회수 순서대로 가져오시오.(순위, 영화명, 변동폭)
      b. '박성웅' 배우가 출연한 영화를 가져오시오.
      c. '김주환' 감독이 제작한 영화를 가져오시오.
      d. 남자들이 선호하는 영화를 가져오시오. > 
      e. 20대가 선호하는 영화를 가져오시오. >
      f. '좋아요'를 20,000개 이상 받은 영화를 가져오시오.
      g. 한줄평 개수가 40,000개 이상 달린 영화를 가져오시오.
      h. 네티즌 관람객 평점이 4.5이상인 영화를 가져오시오.
      i. 영화의 명대사를 영화 제목과 함께 가져오시오.(명대사 배우명도 같이)
      j. 등록된 50개의 영화중 가장 많은 영화에 참여한 배우를 가져오시오.
      k. '드라마'와 '코미디' 2개 장르에 속한 영화를 가져오시오.
      l. 런타임이 120분 미만인 영화를 가져오시오.
      m. 성인 관람가 영화를 가져오시오.
      n. 누적 관객 100,000명이 넘는 영화를 가져오시오.
*/      

desc employees;



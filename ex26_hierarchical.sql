/* 


    ex26_hierarchical.sql 
    
    계층형 쿼리, Hierarchical Query 
    - 오라클 전용 > 되게 편해서 다른 db에 있었으면 좋겠다. 
    - 레코드 관계가 서로 상하 수직구조일 때 사용
    - 서로 다른 테이블간의 관계가 수직 구조일 때 사용
    - 자기 참조를 하는 테이블에서 사용
    - ex) 카테고리, 답변형 게시판, 조직도... 트리 구조에 사용 
    
    1. 계층형태의 데이터
    2. 테이블 상의 관계 고려
    
    컴퓨터
        - 본체
            - 메인보드
            - 그래픽 카드
            - CPU 
            - 메모리
        - 모니터
            - 모니터암
            - 보호필름
   
*/

-- 트리구조를 DB에 저장할 때 저장이 불편하다. 
-- 관계형 db는 차원수를 표현하기 힘들다. > 표는 2차원 배열 

create table tblComputer (
    seq number primary key,                      -- 식별자(PK)
    name varchar2(50) not null,                  -- 부품명 
    qty number not null,                         -- 수량
    pseq number null references tblComputer(seq) -- ★ 부모부품(FK) 
);

insert into tblComputer values(1, '컴퓨터', 1, null); -- 부모가 없는 애들 존재
insert into tblComputer values(2, '본체', 1, 1); 
insert into tblComputer values(3, '메인보드', 1, 2); 
insert into tblComputer values(4, '그래픽카드', 1, 2); 
insert into tblComputer values(5, 'CPU', 1, 2); 
insert into tblComputer values(6, '메모리', 2, 2); 

insert into tblComputer values(7, '모니터', 1, 1); 
insert into tblComputer values(8, '모니터암', 1, 7); 
insert into tblComputer values(9, '보호필름', 1, 7); 


-- Case 2. > 계층형 형태는 자기참조일때 씀 이런건 ??? 머지 
create table tblCategoryBig (
    seq number primary key,                 --식별자(PK)
    name varchar2(100) not null             --카테고리명
);

create table tblCategoryMedium (
    seq number primary key,                             --식별자(PK)
    name varchar2(100) not null,                        --카테고리명
    pseq number not null references tblCategoryBig(seq) --부모카테고리(FK)
);

create table tblCategorySmall (
    seq number primary key,                                 --식별자(PK)
    name varchar2(100) not null,                            --카테고리명
    pseq number not null references tblCategoryMedium(seq)  --부모카테고리(FK)
);

insert into tblCategoryBig values (1, '카테고리');

insert into tblCategoryMedium values (1, '컴퓨터용품', 1);
insert into tblCategoryMedium values (2, '운동용품', 1);
insert into tblCategoryMedium values (3, '먹거리', 1);

insert into tblCategorySmall values (1, '하드웨어', 1);
insert into tblCategorySmall values (2, '소프트웨어', 1);
insert into tblCategorySmall values (3, '소모품', 1);

insert into tblCategorySmall values (4, '테니스', 2);
insert into tblCategorySmall values (5, '골프', 2);
insert into tblCategorySmall values (6, '달리기', 2);

insert into tblCategorySmall values (7, '밀키트', 3);
insert into tblCategorySmall values (8, '베이커리', 3);
insert into tblCategorySmall values (9, '도시락', 3);


-- 어딜가나 구조가 존재한다. 계층형을 사용할 수 있을 지 고민을 해봐라
-- 중간 > 최상위 > 최하위 >


-- tblComputer > 애매하다. 트리구조 같은 느낌이 안든다. 
-- 1. 조인
select
    c1.name as "부품명",
    c2.name as "부모부품명"
from tblComputer c1 -- 자식부품 > 참조를 해야한다. 
    inner join tblComputer c2 -- 부모부품 > 참조를 당하고
        on c2.seq = c1.pseq; 

-- 2. 계층형 쿼리
/*

    start with절 + connect by 절
    
    계층형 쿼리 의사 칼럼
    a. prior > 자기와 연관된 부모 레코드 참조
    b. level > 세대수(depth) > 1부터시작
    
*/

select 
*
from tblComputer
    start with seq = 1
        connect by prior seq = pseq;
        
-- 이렇게하면 prior와 level을 쓸 수 있다.        
        
        
        
-- lpad(채울것, 몇개?)        

-- 셀프조인의 느낌이 나온다.
select 
    seq, 
    lpad(' ', (level-1) * 5) || name,  -- level을 이용해서 시각적인 효과를 준다. > 들여쓰기효과
    prior name,    -- 자릿수 역할한다.
    level
from tblComputer
    start with seq = 1  -- 부모 부품시퀀스, 자식부품 시퀀스
        connect by prior seq = pseq; -- 현재 레코드와 부모 레코드를 연결하는 조건(조인 on 역할)
        -- on c2.seq = c1.pseq;  이렇게와 동일하다. 
        -- 여긴 테이블이 하난데? prior 때문에 그렇다.
        -- 자기와 부모의 연결이 prior 때문에 그렇다.
        -- pseq는 자기 자신이 누구다? 라고 알려준다. 
        -- prior seq 는 부모역할로서의 시퀀스를 찾음 

-- level은 1부터    

-- 일종의 부분집합을 뽑아온다. 소그룹만 보고 싶다. 
select 
    seq, 
    lpad(' ', (level-1) * 5) || name,  
    prior name,    -- 자릿수 역할한다.
    level
from tblComputer        -- 모니터번호를 아니까 그걸로 지정 
    start with seq = 7  -- 내가 보고싶은 애들만 가져올 수 있다. 
        connect by prior seq = pseq; 

select 
    seq, 
    lpad(' ', (level-1) * 5) || name,  
    prior name,    -- 자릿수 역할한다.
    level
from tblComputer        -- 모니터번호를 아니까 그걸로 지정 
    start with seq = (select seq from tblComputer where name ='본체')
        connect by prior seq = pseq; 



select 
    seq, 
    lpad(' ', (level-1) * 5) || name,  
    prior name,    -- 자릿수 역할한다.
    level
from tblComputer        
    start with pseq is null -- 루트가 여러개일 수도 있긴함
        connect by prior seq = pseq; 


select * from tblSelf;
select 
lpad(' ', (level-1)*2) || name as "직원명"
 from tblSelf 
    start with seq = 1
        connect by super = prior seq; -- 자식테이블의 seq에다가 prior
                 -- 부모테이블의 super
                 
select * from tblCategoryBig;
select * from tblCategoryMedium where pseq = 1;
select * from tblCategorySmall where pseq = 2;
                 
-- 얘를 한꺼번에 보고싶다!? join을 해라 


select * 
from tblCategoryBig b
    inner join tblCategoryMedium m 
        on b.seq = m.pseq
            inner join tblCategorySmall s
                on m.seq = s.pseq;
                
-- 상위 카테고리, 중위 카테고리 한번에 가져오고 싶어서 join을 했다.
-- 그런데 얘네들이 반복해서 나와도 반복 안되게 하고 싶다.... 



/*

    1. SQL
    
    3. 설계(모델링)
    
    ---------------------------- 수업 > 내일쯤 끝날 듯
    
    2. PL/SQL
    
    -------------------------- 수업(오전) + 프로젝트(오후) > 프로젝트(종일) 
    
*/









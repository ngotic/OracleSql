/* 
    ex30_Index.sql
    인덱스, Index
    - 검색을 빠른 속도로 하기 위해서 사용되는 도구 
    - 도서의 색인과 동일한 역할 > 수많은 내용 중 원하는 걸 빠르게 찾기 위한 도구
    - SQL 명령 처리 속도를 빠르게 하기 위해서, 특정 컬럼에 대해서 생성되는 도구 
    
    데이터베이스 상태
    - 테이블내의 레코드 순서는, 개발자가 원하는 정렬 상태가 아니다. > order by 
    - 어떤 데이터 검색 > 처음 ~ 끝까지 차례대로 검색 > Table full scan 기본적으로 데이터의 크기가 짝을 때 문제가 안된다.
    - 특정 컬럼 선택 > 별도의 테이블에 복사 > 미리 정렬(***) >> 이걸 인덱스라고 부른다.
    - 따로 뭔가 찾을 만한 데이터를 따로 모아놓은것인데 이걸 미리 가나다순으로 정렬해놓고
    - 이걸 색인이라는 이름으로 같이 정렬 해놓으면 어떤 사람이 이페이지에 있는 내용중 원하는 것 찾고 싶으면? 
    
    [>> 단, 데이터가 많았을 때 검색 속도를 향상시킬 수 있다. ] > 색인이 빛을 발하는 것은 책이 두꺼울 때이다. 
    
    
    인덱스 장단점
    - 검색 처리 속도를 향상 시킨다.
    - 너무 인덱스를 사용은 전체적인 DB 성능을 저하시킨다. 
    
    자동으로 인덱스가 걸리는 컬럼 
    1. Primary key
    2. Unique
    - 테이블에서 PK 컬럼을 검색하는 속도 >>> 테이블에서 일반컬럼을 검색하는 속도 
    
    인덱스를 사용하는 경우
    1. 테이블에 데이터(행)가 많은 경우
    2. where절에 사용되는 횟수가 많은 컬럼에 적용(*******), PK는 자동인덱스
    3. join에 조건으로 사용되는 컬럼에 적용 > 복합인덱스(PK, FK)
    4. 인덱스의 손익분기점 > 검색 결과가 10~15% 이하인 경우 
    5. null을 포함하는 경우 > null 인덱스에서 제외 
    
    select .. where조건으로 해서 
    
    결과 3500000건임 >>>> 개많음 이럴 때 그냥 인덱스 안쓰는게 낫다.
            책을 봐서 색인을 봤는데 이미 엄청나게 많은 걸 봐야하면? 
   
    > 데이터가 많은 것은 몇건? 적은 것은 몇건??? 
    
    인덱스를 사용하지 말아야 하는 경우  
    1. 테이블에 데이터(행)가 적은 경우(의미 없음) 
    2. 인덱스의 손익분기점 > 검색 결과가 15% 이상일 경우 > 검색결과 개많을 때....
    3. 해당 테이블에 데이터 삽입/수정/삭제가 빈번하게 일어나는 경우(******) > 이 때는 인덱스 걸지마라 
    
    --> 인덱스 속도차이 
    
    -- 시나리오.
    인덱스를 만듬
    
    [ 인덱스 ] > B tree > 인덱스가 어떤 자료구조로 되어 있느냐에 따라 다르다. 
    새로운 직원을 추가 > 정렬이 흐트러진다. > 트리구조만 바꾸면 되는데 인덱스를 다시만듬?? 
    정렬을 위해 이상황에서 인덱스를 다시 만듬 
    
    
    
*/

select * from tblInsa;

select * from tblInsa where name ='고순정'; 
-- 만약에 이게 name이 색인으로 만들어져 있다면
-- 검색을 색인으로가서 검색한다. 왜냐면 정렬이 되어 있으니까 그렇다.
-- 정렬이 되었을 떄와 아닐 떄의 검색속도는 넘사벽

-- 근데 만약에 주민등록번호로 찾으면 > 색인이 없어서 원본 테이블에서 주민등록번호를 하나씩 뒤진다. full scan

create table tblIndex
as
select * from tblInsa;

select count(*) from tblIndex; -- 3866624
insert into tblIndex select * from tblIndex;


-- 시간 확인
set timing on; --- ★ 이걸 키고 f5를 누르면 경과시간이 나온다.!!!!!!!

-- SQL 실행
-- 1. Ctrl + Enter > 결과 > 테이블 출력
-- 2. F5           > 결과 > 텍스트 출력 
select * from tblInsa; 

-- 인덱스 없이 검색

select * from tblInsa;
-- 인덱스 없이 검색 > 경과시칸 : 00:00:01.953 > 00.150
select name from tblIndex where name = '김신애';


-- name > 인덱스 생성 > 
create index idxName on tblIndex(name);

-- >0.121
select name from tblIndex where name = '김신애'; -- 개발부

select * from tblInsa;

/*
    인덱스 종류
    1. 고유 인덱스
    2. 비고유 인덱스
    3. 단일 인덱스
    4. 복합 인덱스
    5. 함수기반 인덱스

*/


-- 고유 인덱스
--: 색인의 값이 중복이 불가능하다. 
--: PK, Unique > 컬럼을 인덱스로 생성하면 고유 인덱스가 된다.
drop index idxName;
create unique index idxName on tblIndex(name); -- ORA-01452: cannot CREATE UNIQUE INDEX; duplicate keys found

-- 비고유 인덱스
-- : 색인의 값이 중복이 가능하다.
-- : 일반 컬럼

-- 단일 인덱스
-- : 컬럼 1개를 대상
create index idxBuseo on tblIndex(buseo);

select count(*) from tblIndex where buseo = '기획부'; -- 금방

select count(*) from tblIndex where jikwi ='사원' and name ='김신애'; --몰라 빠른편인데 조금 느리다.

select count(*) from tblIndex where name ='김신애' and buseo = '개발부'; -- 2개의 인덱스를 따로 각각 적용 > 엄청 느리다...


-- 복합 인덱스
-- : 검색을 2개 이상의 컬럼을 대상으로 할 때 
create index idexNameBuseo on tblIndex(name, buseo);
select count(*) from tblIndex where name ='김신애' and buseo = '개발부'; -- 2개의 인덱스를 복합으로 만들어서 적용
-- 인덱스 잘못쓰면 더 느린 경우도 있다. 그래서 인덱스는 경력자가 다루고 적용은 나중에 한다. 
select count(*) from tblIndex where  buseo = '개발부' and name ='김신애'; -- 순서 바꿔도 빠르넹 

create index idxSsn on tblIndex(ssn);
create index idxSsn2 on tblIndex(substr(ssn, 8, 1)); -- 함수기반 인덱스 

select count(*) from tblIndex where ssn = '811112-1566789'; -- 인덱스 걸고 찾으니까 빠름 

select * from tblInsa;

select count(*) from tblIndex where substr(ssn, 8, 1) = '1'; 









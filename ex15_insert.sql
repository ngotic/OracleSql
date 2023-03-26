/*

    ex15_insert.sql
    
    insert 
    - DML
    
    insert into 테이블 value(다적어)
    insert into 테이블(컬럼리스트) value(컬럼리스트에 있는거 값적어)
    
*/

drop table tblMemo;

create table tblMemo (
    seq number(3) primary key ,
    name varchar2(50),
    memo varchar2(1000) not null,
    regdate date default sysdate
);

drop sequence seqMemo;
create sequence seqMemo;


-- 1. 표준 
-- :  원본 테이블에 정의된 컬럼 순서와 개수대로 컬럼리스트를 만들고
-- 값리스트를 구성하는 방법(b)
-- : 권장 
insert into tblMemo(seq, name, memo, regdate) -- a
        values ( seqMemo.nextVal, '홍길동', '메모입니다.' , sysdate); -- b

-- 권장하는 방법이지만 코드가 길다. 줄이는 방법들도 많다.         
        
-- 2. 컬럼 리스트의 순서는 원본 테이블과 상관없다. 
-- : 컬럼 리스의 순서와 값리스트의 순서는 반드시 일치해야한다.
insert into tblMemo( name, memo, regdate, seq)
                values('홍길동', '메모입니다.', sysdate, seqMemo.nextVal);
                
select * from tblMemo;                

insert into tblMemo( memo, regdate, seq, name)
                values('홍길동', '메모입니다.', sysdate, seqMemo.nextVal); -- 순서가 다르면 에러가 난다. 
                
select * from tblMemo;                

insert into tblMemo( memo, name, regdate, seq)
                values('홍길동', '메모입니다.', sysdate, seqMemo.nextVal);      -- 칼럼 순서가 어긋난다. 
        
select * from tblMemo;                        
        
-- 3.00947. 00000 -  "not enough values"
  insert into tblMemo( seq,  name, memo , regdate)  -- 4개
            values(seqMemo.nextVal, '홍길동', sysdate );      -- 3개

-- 4. ORA-00913: too many values
insert into tblMemo( seq,  name, memo )  -- 3개
            values(seqMemo.nextVal, '홍길동', '메모입니다.' ,sysdate ); --4개
        

-- 5. null 조작 > name을 안넣고 싶다. > null 대입
insert into tblMemo(seq, name, memo, regdate)
            values ( seqMemo.nextVal, null, '메모입니다.', sysdate);
        
-- 5.2 컬럼 생략> 암시적
insert into tblMemo(seq, memo, regdate)
            values (seqMemo.nextVal, '메모입니다.', sysdate); -- 컬럼을 생략했지만 null이 들어깠다. 

select * from tblMemo;            
        
-- 6. default를 조작        
insert into tblMemo(seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', '메모입니다.', default); 
        
-- 6.2 컬럼 생략 
insert into tblMemo(seq, name, memo)
    values (seqMemo.nextVal, '홍길동', '메모입니다.'); -- 컬럼을 생략했지만 테이블생성에서 default를 지정해서 default가 들어갔다. 

select * from tblMemo; 

-- 6.3 null 상수를 사용하면 사용자의 의지를 존중해준다. 그래서 default가 동작을 안한다. 
insert into tblMemo(seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', '메모입니다.', null); 
    
-- 7. 단축 표현
-- : 컬럼 리스트를 생략할 수 있다. > 원본 테이블의 칼럼 순서를 참고해서 실행 
insert into tblMemo  values(seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);
insert into tblMemo  values( '홍길동', '메모입니다.', sysdate, seqMemo.nextVal); -- 에러!! 오라클은 이걸 바꿨다는 사실을 모른다. 

-- : null 조작
insert into tblMemo values ( seqMemo.nextVal, null, '메모입니다.', sysdate);
insert into tblMemo values ( seqMemo.nextVal, '메모입니다.', sysdate);  -- 에러 

--: default 조작 
insert into tblMemo values ( seqMemo.nextVal, '홍길동', '메모입니다.', default);
insert into tblMemo values ( seqMemo.nextVal, '메모입니다.','메모입니다.');  -- 에러 

-- 8.tblMemo 테이블 > (복사) > tblMemoCopy 테이블 > 실사용 가능 개발용 가능 > 테이블 자체를 내가 만들었으니 문제 될일이 없다. 
create table tblMemoCopy(
    seq number(3) primary key,
    name varchar2(50),
    memo varchar2(1000) not null,
    regdate date default sysdate
);

-- 서브쿼리 
insert into tblMemoCopy select * from tblMemo; -- 테이블 복사할 때 이렇게 쓴다. 

drop table tblMemoCopy;

select * from tblMemo;
select * from tblMemoCopy;

-- 9 .tblMemo 테이블 > (복사) tblMemoCopy 테이블 > 실사용X , 테스트O > 제약사항 copy를 안해줘서 문제가 많이 생길 소지가 크다. 

create table tblMemoCopy as select * from tblMemo;

select * from tblMemoCopy; -- 테이블과 데이터가 복사가 되었다. 

desc tblMemoCopy; -- 제약조건 날라가....
desc tblMemo;


insert into tblMemoCopy(seq, name, memo, regdate)
        values(1, '홍길동', '메모입니다.', sysdate); -- 이건 왜댐??  > 원본의 PK였던 부분이 없어진다. 
        
        
        
-- 8번은 테이블내가 만듬 제약조건도 다 내가만들고 데이터만 복사
-- 9번은 개발용으로 대용량의 더미가 필요한 경우에 사용한다. 




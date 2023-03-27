/*

    ex29_plsql.sql
    
    PL/SQL
    - Oracle's Procedural Language Extension to SQL 
    - ANSI-SQL에 절차 지향 언어의 기능을 추가한 SQL
    - ANSI-SQL + 자바같은 프로그래밍 언어의 기능 = PL/SQL
    
    ANSI-SQL
    - 비절차 지향 언어
    - 순서가 없고 문장간의 행동이 서로 독립적이다.
    - 문장 단위 구조
    
    프로시저, Procedure
    - 메소드, 함수 등.. 
    - '순서가 있는' 명령어의 집합(ANSI-SQL + PL/SQL)의 집합     
    - SQL은 명령어들 간 순서가 없었음... 근데 프로시저엔 순서가 위에서부터 아래로 존재한다. 
    
    1. 익명 프로시저
        - 1회용 코드 작성용 > 실행할 때는 익명 프로시저로 1회용으로 쓰겠다.
        
    2. 실명 프로시저
        - 저장(데이터베이스) > DB Object 중에 하나다. 
        - 재사용 가능 ** 
        - 계정간 공유 가능 
    
    PL/SQL 프로시저 블럭 구조 
    - 4개의 키워드(블럭)으로 구성 
        a. declare 
        b. begin
        c. exception
        d. end
    
    a. declare 
        - 선언부
        - 프로시저내에서 사용할 변수, 객체 등 선언하는 영역
        - 생략가능 
        
    * begin end는 생략이 불가능하다. 이게 핵심이다. > 이거할려고 만드는건데
    
    b. begin
        - 실행부, 구현부
        - begin ~ end
        - begin(구현부 시작) ~ end(구현부 끝) 
        - 생략 불가능
        - 핵심파트
        - 구현 코드 > ANSI-SQL + PL/SQL
    
    c. exception
        - 예외처리부
        - catch 역할 
        - 예외 처리 코드를 작성
        - 생략 가능
    -- draft> mid
    d. end
        - begin 
        - 생략 불가능     
        
    1. 일반적인 경우
    declare 
    
        변수 선언
        객체 선언
        
    begin
    
        구현한 코드(SQL)
        
    end;
    
    2. 예외가 날 수 있네? 하는 경우
    
    declare 
        변수 선언
        객체 선언
        
    begin
    
        구현한 코드(SQL)
        
    exception  
        예외처리 코드
    end;
    
    3. 생략형
    
    begin
        구현할 코드(SQL)
    end
    
    public void test() { > '이런 느낌'?
     
    }
    
    ANSI SQL은 있고 PL/SQL이 붙어있다.
    이것의 목적이 ANSI SQL을 서포터하기 위해 붙어있는 것이다.
    
    PL/SQL의 대부분의 환경이 > ANSI-SQL의 환경과 거의 동일하게 구현되어 있다.
    
    PL/SQL 자료형
    - ANSI-SQL 거의 동일하다. 
     
    
    변수 선언하기 
    - 변수명 자료형 [ not null ][default 값];
    - 이때 만들어지는 변수는 자바의 변수 같은데 완전이 그런 느낌은 아니다. 역할이 달라...
    - 주로 질의(select)의 결과값을 저장하는 용도.. 
    - 일반적인 데이터를 저장하는 용도 
    
    PL/SQL 연산자
    - ANSI-SQL과 거의 동일
    
    대입 연산자
    - ANSI-SQL
        ex) update table set column = 값;
    - PL/SQL 
        ex) 변수 := 값 ( 여기 클론이 =연산자 앞에 붙는다 )
    
*/


-- 메소드:       선언(저장) > 호출 
-- 익명프로시저:  호출 
begin
    -- System.out.println( )의 느낌이다.
    dbms_output.put_line(100);
    dbms_output.put_line('홍길동'); 
end;
-- 컨트롤 엔터해서 실행시키면 되는데 호출이 되는게 없음...(???)
-- 왜냐면 dbms_output.put_line의 결과가 화면에 안보이게 설정(기본값)

-- 켤 때는
set serveroutput on;
set serverout on;      -- 이걸 실행시키고 위에 프로시저 실행시키면 100과 홍길동이 출력된다. 

-- 끌 때는
set serveroutput off;
set serverout off;

-- 하지만 이 옵션은 접속할 때마다 켜야한다. 영구적으로 반영되지는 않는다.
-- put_line은 세션마다 세팅해줘야 한다. 

-- 값을 대입해서 > 그 값을 출력하는 프로시저 > 자바와 비슷하다. 
declare 
    num number;
begin
    num := 10;
    dbms_output.put_line(num);
end;

declare 
    num number;
    name varchar2(30);
    today date;
begin
    num := 10;
    dbms_output.put_line(num);
    name := '홍길동';
    dbms_output.put_line(name);
    today := sysdate;
    dbms_output.put_line(today);
end;


-- 변수의 선언과 동시에 초기화 
declare 
    num1 number;
    num2 number;
    num3 number := 30;      -- int num3 = 30;
    num4 number default 40; -- default를 걸 수 있다. 
    num5 number not null := 50;        -- 초기화를 하지 않으면 에러가 난다. 
    num6 number not null default 11;   -- 이런 패턴으로 초기화해도 된다.
begin
    num1 := 10; -- begin 이후에 초기화도 가능
    dbms_output.put_line(num1);
    dbms_output.put_line('---');
    dbms_output.put_line(num2); -- 아무것도 초기화를 안하면 null이 찍힌다. 아무것도 안찍힘 > 빈 줄!! 
    dbms_output.put_line('---');
    dbms_output.put_line(num3); -- num3에 30 대입한거 출력 
    dbms_output.put_line(num4); -- default로 지정을 해놔서 40 출력
    num4 := 400;
    dbms_output.put_line(num4);
    num5 := 50;                 -- 이값은 초기화가 아니다. 이래도 아래 에러가 뜬다.
    dbms_output.put_line(num5); -- PLS-00218: a variable declared NOT NULL must have an initialization assignment
                                -- declare에서  num5 number not null := 50;  이렇게 선언
    dbms_output.put_line(num6);                           
end;


-- SELECT INTO 라는게 있다.
-- PL/SQL 변수에 select문의 결과를 대입한다. 
declare
    vname varchar2(20);
begin
    -- vname := (select name from tblInsa where num = 1001);
    -- 안된다. 
    -- select name from tblInsa where num = 1001; -- 결과는 테이블이 나옴
    -- PLS-00428: an INTO clause is expected in this SELECT statement
    -- 현재 select절에 into절이 와야 한다. 
    -- ***** PL/SQL 블럭안에는 우리가 사용하던 ANSI-SQL의 select문을 적을 수가 없다. > select into 사용해라!! > 이건 그냥 select이다.
                                                                                --> 의도가 담긴 select라고 보면 된다. 
    -- ***** PL/SQL 블럭안에서는 select문을 제외한 ANSI-SQL은 그대로 사용 가능하다.(insert, update, delete)
    -- select로 어떤 테이블이 나오고 조치가 필요하다. 그 조치를 위해서 쓰이는것이 select into문이다.
    -- 대입 연산자 역할
    -- select 컬럼 into 변수 --> 이렇게 해야 변수에 담는다. 
    select name into vname from tblInsa where num = 1001; -- 엄밀히 따지면 PL/SQL이다. > into 들은거 빼고는 우리가 알던 select문
    dbms_output.put_line(vname);     
end;

declare
    vname varchar2(20);
    buseo varchar2(30);
begin
    select name, buseo into vname, buseo from tblInsa where num = 1001; -- 엄밀히 따지면 PL/SQL이다. > into 들은거 빼고는 우리가 알던 select문
    dbms_output.put_line(vname);     
    dbms_output.put_line(buseo);     
    --     컬럼  /   pl/sql변수 : 변수를 다르게 만드는 것이 낫다.
    select buseo into buseo from tblInsa where num = 1001;  -- 이경우는 pl/sql변수가 테이블의 실제 컬럼과 같다.
    dbms_output.put_line(buseo);     
end;



select * from tblTodo;

-- 회사 > 프로젝트 > 직원 중 > 몇명을 뽑아서 임시로 프로젝트 팀을 만든다.
create table tblTeam (
    num number primary key,
    name varchar2(15) not null,
    buseo varchar2(15) not null,
    jikwi varchar2(15) not null
);

select * from tblTeam;
-- 개발부 + 부장 
-- 1. ANSI-SQL
-- 2. PL/SQL

-- 1.1 노가다 > 비추천
select * from tblInsa where buseo = '개발부' and jikwi = '부장';
insert into tblTeam values ( 1003, '이순애', '개발부', '부장');

rollback;

-- 1.2 서브쿼리 이용 
insert into tblTeam values ( (select num from tblInsa where buseo = '개발부' and jikwi = '부장'),
                             (select name from tblInsa where buseo = '개발부' and jikwi = '부장'),
                             '개발부', '부장');

-- 오늘 수업들어와서 커밋이나 롤백을 하지 않은 경우.... > 
-- 우리는 커밋과 롤백을 하지 않았지만 create table을 하면서 auto commit이 일어났다.
-- 꼼꼼해야 transaction 처리를 잘한다. > ★
select * from tblTeam; -- 이순애가 사라짐 

-- 2. 
declare 
-- 변수는 필요할 때 만들면 된다.
    vnum number;
    vname varchar2(15);
begin
    -- **** select의 결과는 반드시 PL/SAL에 넣어야 한다. > select into 사용해야 한다. 
    select num into vnum from tblInsa where buseo ='개발부' and jikwi = '부장';
    select name into vname from tblInsa where buseo ='개발부' and jikwi = '부장';
    
    -- vnum, vname 확보 
    insert into tblTeam values ( vnum, vname, '개발부', '부장'); -- 온전한 insert이다. 
                           -- 파라미터로 들어간 값들이 pl/sql의 값들이 들어간다.
end; 

-- program화 되었다. >> 절차 지향적이다.  > 실행이 잘 되었다. 

rollback;



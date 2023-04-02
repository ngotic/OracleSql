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
        ex) 변수 := 값 ( 여기 클론이 = 연산자 앞에 붙는다 )
    
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
    -- ***** PL/SQL 블럭안에는 우리가 사용하던 ANSI-SQL의 select문을 적을 수가 없다. 
    -- > select into 사용해라!! > 이건 그냥 select이다.
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

declare 
    vname varchar2(15);
    vbuseo varchar2(15);
    vjikwi varchar2(15);    
begin
    -- (X) 이런방식은 안된다. select name into vname, buseo into vbuseo, jikwi into vjikwi from tblInsa where num = 1001;
    -- 주의점> into는 한번만 쓰는 방향으로 한다. 
    
    -- 1. 컬럼의 개수와 변수의 개수는 동일!! 
    -- 동일하지 않으면    > PL/SQL : ORA-00947: not enough values
    -- 인자가 너무 많으면 > PL/SQL : ORA-00913: too many values
    -- 2. ★ 컬럼의 순서와 변수의 순서가 일치!! 
    -- 3. ★ 컬럼과 변수의 자료형이 일치!! 
    select name, buseo, jikwi into vname, vbuseo, vjikwi from tblInsa where num = 1001;
                                -- "여기로 넣어줘" --
                                
    -- 여러개 select into 
    -- into 절 딱 한번만     
    --> 반드시 pl/sql의 변수들만 써라 
    dbms_output.put_line(vname);     
    dbms_output.put_line(vbuseo);     
    dbms_output.put_line(vjikwi);  
    
end;


/*
    타입 참조
    - 변수를 선언할 때 같이 사용
    
    select name, buseo, jikwi into vname, vbuseo, vjikwi from tblInsa where num = 1001;
    홍길동은 9바이트임 근데 vname을 5바이트로 잡으면 에러가 난다. 
    우리가 select값을 저장할 변수 > 해당 컬럼의 자료형 + 길이 > 미리 숙지해야 한다.!!
    그래서 실제로 테이블 안에 name이나 buseo컬럼의 자료형 길이와 동일하게 하는게 좋다. 
    근데 이걸 실제로 들여다보면 피곤하다. 그 피곤함을 줄이려고 하는것이 type 참조이다. 
    
    1. %type
        - 사용하는 테이블의 컬럼의 스키마를 알아내서 변수에 적용
        - 복사되는 정보
            a. 자료형
            b. 길이            
    
*/

declare 
    vname  tblInsa.name%type;   -- tblInsa 테이블에서 name에 대한 type만큼 vname의 타입을 잡아줘 ! 
    vbuseo tblInsa.buseo%type; -- 테이블 참조해서 하니까 느리다. 정적으로 하는게 나을 때도 있다.  
    vjikwi tblInsa.jikwi%type; 
    
begin
    select name, buseo, jikwi into vname, vbuseo, vjikwi from tblInsa where num = 1002;
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
end;

-- 특정 직원에게 보너스 지급 > 내역 저장
-- 보너스 = basicpay * 1.5
create table tblBonus (
    seq number primary key,
    num number(5) not null references tblInsa(num), -- 제약조건 
    bonus number not null
);

create sequence seqBonus;


select * from tblInsa where buseo = '영업부' and jikwi = '부장';

insert into tblBonus values ( seqBonus.nextVal, 1046, 2650000 * 1.5);
                                    
insert into tblBonus values ( seqBonus.nextVal, 
                                    (select num from tblInsa where buseo = '총무부' and jikwi = '부장'),
                                    (select basicpay from tblInsa where buseo = '총무부' and jikwi ='부장') * 1.5);                                    
select * from tblBonus;


-- 3.
declare
    vnum      tblInsa.num%type;
    vbasicpay tblInsa.basicpay%type;
begin
    select num, basicpay into vnum, vbasicpay from tblInsa
        where buseo = '총무부' and jikwi = '부장';
    insert into tblBonus values ( seqBonus.nextVal, vnum, vbasicpay * 1.5);
end;

-- select * from tblInsa;
select * from tblBonus;

/*
    타입 참조
    - 변수를 선언할 때 같이 사용
    
    1. %type
        - 컬럼 1개 참조
        
    2. %rowtype
        - 레코드 전체 참조(모든 컬럼 참조)
        - 와일드 카드의 성질 
    
*/

-- 홍길동 > 모든 정보(컬럼 10개) 출력!하는 프로시저
declare  -- 이거 다쓰는거 귀찮다. 
    vnum      tblInsa.num%type;    
    vname     tblInsa.name%type;    
    vbuseo    tblInsa.buseo%type;    
    vjikwi    tblInsa.jikwi%type;    
    vssn      tblInsa.ssn%type;    
    vcity     tblInsa.city%type;    
    vbasicpay tblInsa.basicpay%type;    
    vsudang   tblInsa.sudang%type;    
    vibsadate tblInsa.ibsadate%type;    
    vtel      tblInsa.tel%type;    
    
    -- 특정 컬럼을 참조하는 것이 아니라 행 전체를 참조한다. 
    vrow tblInsa%rowtype; -- 총 10개의 칼럼 참조
    vrow2 tblInsa%rowtype; -- 총 10개의 칼럼 참조
    
begin
    select num, name, buseo, jikwi, ssn, city, basicpay, sudang, ibsadate, tel 
        into vnum, vname, vbuseo, vjikwi, vssn, vcity, vbasicpay, vsudang, vibsadate, vtel 
    from tblInsa where name = '홍길동';
    
--    이렇게 여러 컬럼을 입력하는 법을 해결하는 것이 rowtype
--    select -- 순서가 다르다. 이건 에러가 난다.
--        num, name, buseo, jikwi, ssn, city, basicpay, sudang, ibsadate, tel
--        into vrow
--    from tblInsa where name = '이순신';

    select 
        num, name, ssn, ibsadate, city, tel, buseo, jikwi, basicpay, sudang
        into vrow
    from tblInsa where name = '이순신';
    
    select 
    * into vrow2
    from tblInsa where name = '이순애';
    
    dbms_output.put_line(vname);
    -- dbms_output.put_line(vrow); -- 에러난다. 이런 object를 출력할 수 있는 기능이 없다 > 하나씩 꺼내야 한다.
    dbms_output.put_line(vrow.name);
    dbms_output.put_line(vrow2.name);
    
end;

--desc tblInsa;
--NUM      NOT NULL NUMBER(5)    
--NAME     NOT NULL VARCHAR2(20) 
--SSN      NOT NULL VARCHAR2(14) 
--IBSADATE NOT NULL DATE         
--CITY              VARCHAR2(10) 
--TEL               VARCHAR2(15) 
--BUSEO    NOT NULL VARCHAR2(15) 
--JIKWI    NOT NULL VARCHAR2(15) 
--BASICPAY NOT NULL NUMBER(10)   
--SUDANG   NOT NULL NUMBER(10)   

declare 
    vname     tblInsa.name%type;    
    vbuseo    tblInsa.buseo%type;    
    vjikwi    tblInsa.jikwi%type;    
    vcity     tblInsa.city%type;    
    vbasicpay tblInsa.basicpay%type;    
    
begin
    select name, buseo, jikwi, city, basicpay 
    into 
    vname, vbuseo, vjikwi, vcity, vbasicpay 
    from tblInsa where name = '홍길동';
end;


declare -- 이 방법이 편하다. 
    vrow tblInsa%rowtype; -- 컬럼 추가되어도 건드릴 것이 없다. 
begin
    select 
    * -- name, buseo, jikwi, city, basicpay --> 해결책은 이거다.
    into 
    vrow -- 10개를 담을 수 있는건데 5개만 담으려 해서 에러가 난다. 
    from tblInsa where name = '홍길동';
end; -- 이러면 근데 쓰지도 않는 컬럼을 가져와서 낭비다. 근데 declare가 매우 편하다.



select * from tblmen;
select * from tblwomen;

-- '하하하' > 성전환 > tblWomen 이동 
-- 1. tblmen   > select > 정보 : 남자 테이블에서 해당 사람의 정보를 알아낸다.
-- 2. tblwomen > insert(1번) > 복사 
-- 3. tblmen > delete 
-- 하나의 흐름을 구상해서 한다.

declare
    vrow tblmen%rowtype;
begin
    --1.
    select * into vrow from tblmen where name = '하하하';
    --2. 
    insert into tblwomen values(vrow.name, vrow.age, vrow.height,
                                    vrow.weight, vrow.couple);
    --3. 
    delete from tblmen where name = '하하하';
end;

select * from tblmen;
select * from tblwomen;

-- 제어문
-- 1. 조건문
-- 2. 반복문

declare  -- basic 조건문
    vnum number := 10;
begin
    if( vnum > 0 ) then
        dbms_output.put_line('양수');
    end if; -- 참일 때의 실행블럭
end;
-- sql은 괄호를 쓰지 않는다. 키워드로 쓴다. 

declare  -- else 포함
    vnum number := -10;
begin
    if( vnum > 0 ) then
        dbms_output.put_line('양수');
    else 
        dbms_output.put_line('양수 아님');
    end if; -- 참일 때의 실행블럭
end;

declare  -- elsif > 키워드 조심
    vnum number := -10;
begin
    if( vnum > 0 ) then
        dbms_output.put_line('양수');
    elsif vnum < 0 then --
        dbms_output.put_line('음수');
    else 
        dbms_output.put_line('양수 아님');
    end if; -- 참일 때의 실행블럭
end;

declare  --> 빈 블럭 
    vnum number := 10;
begin
    if( vnum > 0 ) then
        dbms_output.put_line('양수');
    elsif vnum < 0 then --
        dbms_output.put_line('음수');
    else 
        null; --python의 pass 느낌이다. 빈 블럭을 사용하고 싶으면 null을 쓰라.
    end if; -- 참일 때의 실행블럭
end;

-- 특정 직원 선택 > 보너스 지급 > 간부(basicpay * 1.5), 사원(basicpay * 2)

declare
    vnum      tblInsa.num%type;
    vbasicpay tblInsa.basicpay%type;
    vjikwi    tblInsa.jikwi%type;
    vbonus    number;
    
begin
    -- 1.
    select num, basicpay, jikwi into vnum, vbasicpay, vjikwi from tblInsa where name = '이순신';
    
    --2. if - elsif - end if; 끝 
    if vjikwi = '부장' or vjikwi = '과장' then
        vbonus := vbasicpay *1.5;
    elsif vjikwi in ('대리','사원') then
        vbonus := vbasicpay *2;
    end if;
    
    --3. 
    insert into tblBonus values(seqBonus.nextVal, vnum, vbonus);
end;

-- 기존에 쓰던 ansi sql을 넣는다.
select * from tblBonus; -- num > 1046

select b.* , -- 상관서브쿼리 select절에 조건으로 꺼낼 때
    (select name from tblInsa where num = b.num) as name,
    (select jikwi from tblInsa where num = b.num) as jikwi,
    (select basicpay from tblInsa where num = b.num) as basicpay
from tblBonus b;

/*
    
    조건문
    1. if
    2. case
        - ANSI-SQL과 동일
    
            
*/

declare
    vcontinent tblCountry.continent%type;
    vresult varchar2(30);
begin

    select continent into vcontinent from tblCountry where name = '대한민국';
    
    if vcontinent = 'AS' then 
        vresult := '아시아';
    elsif vcontinent = 'EU' then
        vresult := '유럽';
    elsif vcontinent = 'AF' then
        vresult := '아프리카';
    else 
        vresult := '기타';
    end if;
    
    dbms_output.put_line(vresult);
    
    case
        when vcontinent = 'AS' then vresult := '아시아';
        when vcontinent = 'EU' then vresult := '유럽';
        when vcontinent = 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    
    dbms_output.put_line(vresult);
    
--    case
--        when vcontinent = 'AS' then vresult := '아시아';
--        when vcontinent = 'EU' then vresult := '유럽';
--        when vcontinent = 'AF' then vresult := '아프리카';
--        else insert; --- 여기선 insert를 써도 된다.
--    end case;
    
    case vcontinent 
        when 'AS' then vresult := '아시아';
        when 'EU' then vresult := '유럽';
        when 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    
    dbms_output.put_line(vresult);
        
end;

-- pl/sql은 case 내용 end case;  > 이게 ansi와의 차이다.



-- '신숙주'가 대여한 비디오 제목? > '뽀뽀할까요?'
select * from tblMember;
select * from tblRent;
select * from tblVideo;

-- 1. 조인
-- 2. 서브쿼리
-- 3. 프로시저

declare
    mseq tblMember.seq%type;
    vseq tblVideo.seq%type;
    vname tblVideo.name%type;
    
begin -- 연쇄적으로 select를 한다. 
    select seq into mseq from tblMember where name = '신숙주';
    select video into vseq from tblRent where member = mseq;
    select name into vname from tblVideo where seq = vseq;
    dbms_output.put_line(vname);
end;


/*
    반복문
    
    1. loop
        - 단순 반복
    
    2. for loop 
        - 횟수 반복
        - loop 기반
        
    3. while loop
        - 조건 반복(자바 while)
        - loop 기반
    
    
*/

begin -- 무한루프
    -- ORA-20000: ORU-10027: buffer overflow, limit of 1000000 bytes 무한루프인데 1000000을 벗어남
    loop -- loop이긴한데 탈출조건이 없다. 
        -- 실행문;
        dbms_output.put_line(to_char(sysdate, 'hh24:mi:ss'));
    end loop;
    
end; -- 무한루프 돈다.


-- 이름 타입 := 숫자
declare 
    vnum number :=1;
begin -- 무한루프
    loop 
        -- 실행문; += 이런거 없다.
        dbms_output.put_line(to_char(sysdate, 'hh24:mi:ss'));
        dbms_output.put_line(vnum);
        vnum := vnum +1;
        exit when vnum > 10 ; -- 조건 만족시 > loop 탈출
    end loop;
end; 


--> 더미 데이터 추가 x 1000건
create table tblLoop (
    seq number primary key,
    data varchar2(30) not null
);

create sequence seqLoop;

insert into tblLoop values (seqLoop.nextVal, '데이터1');
insert into tblLoop values (seqLoop.nextVal, '데이터2');
insert into tblLoop values (seqLoop.nextVal, '데이터3');


-- loop 내용 exit 탈출조건 end loop;
declare 
    vnum number := 4;
begin
    loop 
        insert into tblLoop values(seqLoop.nextVal, '데이터' || vnum);
        vnum := vnum + 1;
        
        exit when vnum > 1000;
        
    end loop;
end;    

select * from tblLoop;
select count(*) from tblLoop;

-- for > foreach > for in
begin
    -- : 자바로 치면 : 이다.
    for i in 1..10 loop -- 향상된 for문에 가깝다.. 
    
        dbms_output.put_line(i);
        
    end loop;

end;

create table tblGugudan (
    dan number,
    num number,
    result number not null,
    constraint tblgugudan_dan_num_pk primary key(dan, num)
);

-- for 변수 in 시작값..종료값 loop 내용 end loop;
begin 
    for dan in 2..9 loop
        for num in 1..9 loop
            insert into tblGugudan(dan, num, result) values(dan, num, dan*num);
        end loop;
    end loop;
end;

select * from tblGugudan;



-- while 조건 loop 내용 end loop;
declare 
    vnum number := 1;
begin
    while vnum <= 10 loop
        dbms_output.put_line(vnum);
        vnum := vnum + 1;
    end loop;

end;


/*
    select > 결과셋 > PL/SQL 변수에 대입
    
    1. select into 
        - 결과셋의 레코드가 1개일때만 가능하다. 
        
    2.cursor + loop
        - 결과셋의 레코드가 n개일때 사용한다.
    
    declare 
        변수 선언;
        커서 선언;
    begin
        커서 열기;
            loop;
                커서 사용 > 데이터 접근 > 조작
            end loop;
        커서 닫기;
        
    end
        
*/

-- ORA-01422: exact fetch returns more than requested number of rows
declare 
    vname tblInsa.name%type;
begin
    -- 60:1 로 본다. > 그래서 에러가 났다. 
    -- select name into vname from tblInsa; 
    -- select name from tblInsa는 60개가 나온다. 
    -- vname은 1개다. 
    select name into vname from tblInsa where name ='유재석';  -- 이것도 에러가 난다. 데이터가 안나옴
    dbms_output.put_line(vname);
end;


select name from tblInsa where name ='유재석'; -- 없는 결과 






create or replace view vwTest
as 
select * from tblInsa; -- 뷰랑 비슷하다.



-- cursor에 테이블을 담아놓았다가 ... 꺼내온다.
declare
    cursor vcursor  -- 커서는 select문을 저장하는 객체 
    is
    select name from tblInsa; -- 커서는 이렇게 생겼다.
    vname tblInsa.name%type;
begin
    open vcursor; -- select 문 실행 > 결과셋에 커서 연결(참조) > 탐색 > 자바의 Iterator
--        fetch vcursor into vname; -- select into와 동일한 역할
--        dbms_output.put_line(vname);
--        fetch vcursor into vname; -- select into와 동일한 역할
--        dbms_output.put_line(vname);
--        fetch vcursor into vname; -- select into와 동일한 역할
--        dbms_output.put_line(vname);
--        fetch vcursor into vname; -- select into와 동일한 역할
--        dbms_output.put_line(vname);
--        fetch vcursor into vname; -- select into와 동일한 역할
--        dbms_output.put_line(vname);
    for i in 1..60 loop
        fetch vcursor into vname;
        dbms_output.put_line(vname);
    end loop; -- 이러면 사람이 더 들어가거나 덜들어가면 맞지 않다. 
    
    -- 이렇게도 할 수 있다. > 보기에 편해보인다. > 이렇게 하면 결과는 낼수는 있더라.. 
    
    loop -- ORA-20000: ORU-10027: buffer overflow, limit of 1000000 byte > 탈출조건이 없다.
        fetch vcursor into vname;
        --exit when 커서가 더이상 다음 레코드를 발견하지 못할 때;
        exit when vcursor%notfound; --상태값(boolean) 
                     -- notfound 더이상 나오면 true리턴
        dbms_output.put_line(vname);
    end loop;
    
    close vcursor;
end; -- 이게 전형적인 cursor 루프다. 


-- 커서 선언 cursor vcursor is [ select 문 ]

-- 커서를 선언하고 
declare 
    cursor vcursor is
    select name from tblInsa; 
    vname tblInsa.name%type;
begin
    open vcursor; 
    loop 
        fetch vcursor into vname;
        exit when vcursor%notfound; -- 있니 없니 하다가 빠져나온다.
        dbms_output.put_line(vname);
    end loop;
    close vcursor;
end; -- 가장 중요하다. 



-- null 처리 함수
-- null value 함수
-- 1. nvl(컬럼, 대체값)
-- 2. nvl2(컬럼, 값A, 값B)
select name from tblInsa where num = 1101;

select nvl(name, '대체값') from tblInsa where num=1101;


select name, nvl(tel, '대체값') from tblInsa;

select 
    name,
    case
        when tebl is not null then tel
        else '대체값'
    end
from tblInsa;


select name, nvl2(tel, '값A', '값B')from tblInsa;

select name,
    case 
        when tel is not null then '값a'
        else '값b'
    end
from tblInsa;


-- 기획부 직원 > 다른 테이블 복사
select * from tblTeam;

select * from tblInsa where buseo = '기획부';

insert into tblTeam(select num, name, buseo ,jikwi from tblInsa where buseo = '기획부');
-- 7명 추가 > 7명 제거 
rollback;

declare
    cursor vcursor is select num, name, jikwi, buseo from tblInsa where buseo = '기획부';
    vnum   tblInsa.num%type;
    vname  tblInsa.name%type;
    vjikwi tblInsa.jikwi%type;
    vbuseo tblInsa.buseo%type;
begin 
        open vcursor;
            loop
                fetch vcursor into vnum, vname, vjikwi, vbuseo;
                exit when vcursor%notfound;
                insert into tblTeam values(vnum, vname, vbuseo, vjikwi);
            end loop;
        close vcursor;
end;

select * from tblTeam;


-- 전 직원 > 보너스 지급 > 간부(1.5), 사원(2)
select * from tblBonus;


select * from tblInsa;

declare -- ★ 나주엥 체크
    cursor vcursor is
        select * from tblInsa;
--    vnum tblInsa.num%type;
--    vbasicpay tblInsa.basicpay%type;
--    vjikwi tblInsa.jikwi%type;
    vrow tblInsa%rowtype;
begin
    -- 반복 패턴 코드 > Boilerplate Code, 축제코드
    open vcursor;
        loop 
            fetch vcursor into vrow;
            exit when vcursor%notfound;
            -- 간부 vs 사원
            dbms_output.put_line(vrow.jikwi);
            dbms_output.put_line(vrow.num);
            dbms_output.put_line(vrow.basicpay);
            if vrow.jikwi in ('과장', '부장') then
                insert into tblBonus values(seqBonus,nextVal, vrow.num, vrow.basicpay * 1.5);
            else 
                insert into tblBonus values(seqBonus.nextVal, vrow.num, vrow.basicpay * 2);
            end if;
        end loop;
    close vcursor;        
end;

select seqBonus.nextVal from dual;
select * from tblBonus;

-- 커서 탐색
-- 1. 커서 + loop   > 비선호
-- 2. 커서 + for loop > 선호

select seqBonus.currVal from dual;





declare 
    cursor vcursor is 
        select * from tblInsa;
    vrow tblInsa%rowtype;
begin
    open vcursor;
        loop  -- fetch vcursor into 머 exit when
            fetch vcursor into vrow;
            exit when vcursor%notfound;
            dbms_output.put_line(vrow.name);
        end loop;   
    close vcursor;
end;


declare 
    cursor vcursor is
        select * from tblInsa;
begin
       for vrow in vcursor loop -- open(close) loop + fetch into + vrow + exit when
            dbms_output.put_line(vrow.name);
       end loop;   
end;

--: 예외 처리
--: 실행부(begin~end)에서 발생하는 예외를 처리하는 블럭
declare
    vname varchar2(15);
begin
    dbms_output.put_line('시작');
    select name into vname from tblInsa where name='이순신';  
    select name into vname from tblInsa ;  -- 여기서 뻒이남  > ORA-01422: exact fetch returns more than requested number of rows
    dbms_output.put_line(vname);
    dbms_output.put_line('종료');    
exception -- 뻑이 난 순간 여기 예외로 빠진다. 
    -- when 예외상수 then 처리;
    when TOO_MANY_ROWS then -- 두루 뭉실한 예외처리가 아닌 내가 알고 있는 예외처리로 처리가 된다. 
         dbms_output.put_line('select가 너무 많은 레코드를 반환했씀다.'); -- > ORA-01422에러는 이걸로 막는다.
    when others then
         dbms_output.put_line('예외 처리');
end;

select * from tblInsa;
    
-- 나머지 일을 실행 안시키게 끔 중간에서 끝

-- DB 오류 발생 > 기록 남긴다. 
create table tblError (
    seq number primary key,
    code varchar2(4) not null check(code in ('A001', 'B001', 'B002')), -- 에러 상태 코드 
    regdate date default sysdate not null
);


select * from tblCountry;


declare 
    vcnt number;
    vname varchar2(15);
begin
    -- 1. 
    select count(*) into vcnt from tblCountry;
    dbms_output.put_line(100 / 0);
    -- 2.
    select name into vname from tblInsa where num = 1001;
    dbms_output.put_line(vname);
    
exception
    when ZERO_DIVIDE then
        dbms_output.put_line('0으로 나누었습니다.');
        insert into tblError values ( (select nvl(max(seq), 0)+1 from tblError) , 'A001', default);
        
    when TOO_MANY_ROWS then
        dbms_output.put_line('가져온 행이 많습니다.');
        insert into tblError values ( (select nvl(max(seq), 0)+1 from tblError) , 'A001', default);
        
    when others then
        dbms_output.put_line('예외 처리');
        insert into tblError values ( (select nvl(max(seq), 0)+1 from tblError) , 'A001', default);
end;   

select * from tblError order by regdate desc;

-----------------------------------------------

select * from tblStaff;
select * from tblProject;

--A. 신입 사원 추가 + 프로젝트 담당

--B. 사원 퇴사 : 담당 프로젝트 확인 > 다른 직원에게 위임 > 퇴사 

--A. > 자바가 얘를 호출한다. 얘한테 일을 맡긴다. 
create or replace procedure procAddstaff (  -- 지금해야하는 프로젝트 중에 해야하는 일이다. 
    pname    in varchar2, -- 신입 사원명
    psalary  in number,   -- 신입 급여
    paddress in varchar2, -- 신입 주소
    pproject in varchar2, -- 프로젝트명
    presult  out number   -- 피드백(성공/실패) 
)
-- 이 작업은 100퍼센트 성공한다고 보장 못한다. 
is 
    vseq number;
begin
    select nvl(max(seq), 0) + 1 into vseq from tblStaff;
    --1. 신입 사원 추가
    insert into tblStaff (seq, name, salary, address) values(  vseq, pname, psalary, paddress);
    
    --2. 프로젝트 담당
    insert into tblProject (seq, project, staff_seq)
        values( (select nvl(max(seq), 0 ) + 1 from tblProject), pproject, vseq);
        
    presult := 1; -- 성공
    
exception
    when others then
        presult := 0; -- 실패 
end procAddStaff;

-- 테스트 
declare
    vresult number; -- 결과(out)
begin
    -- procAddStaff('이순신', 300, '서울시', '박물관 건립', vresult);
    procAddStaff('유관순', 350, '부천시', '미술관 건립', vresult);
    if vresult = 1 then
        dbms_output.put_line('성공');
    else 
        dbms_output.put_line('실패');
    end if;
end;

-- 여러가지 기능들을 합쳐서 모듈로 만들었다. 

-- 기존 방식 > 프로시저
-- 1. 단순화(모듈화)
-- 2. 팀작업이 원할
-- 3 저장 객체(팀간에 공유가 수월하다.)


-- user의 procudures를 저장 
SELECT *  FROM user_procedures ;


-- boolean(X) > 오라클에는 없다. 근데 혹시 모르니까 변경이 될 수 있는 것은 NUMBER
-- C언어 > int > 1(true), 0(false)
-- B.
create or replace procedure procRemoveStaff (
    pseq    in number,  -- 퇴사할 직원번호
    pdseq   in number, -- 위임할 직원번호
    presult out number
)
is  
    vcnt number;
begin
    --1. 퇴사 직원 번호가 유효한지? 존재하는 번호인지? 
    select count(*) into vcnt from tblStaff where seq = pseq;
    
    --2. 확인
    if vcnt = 1 then
        -- 존재
        -- 3. 담당 프로젝트 확인 
        select count(*) into vcnt from tblStaff where seq = pdseq;
        -- 4. 담당 프로젝트 확인 > 위임 
        if vcnt = 1 then
            --4. 담당 프로젝트 확인 > 위임 > 프로젝트가 있을 때 위임한다. 
            select count(*) into vcnt from tblProject where staff_seq = pseq;
            if vcnt > 0 then
                --5. 위임
                update tblProject set
                    staff_seq = pdseq
                        where staff_seq = pseq; 
            end if;
            -- 6. 퇴사 
                delete from tblStaff where seq  = pseq;      
                presult :=1;
        else
            presult :=0;
        end if;
    else
        presult := 0;
    end if;
    
exception
    when others then 
        presult := 0;
        
end procRemoveStaff;



declare 
    vresult number;
begin
   --procRemoveStaff('하하하','이순신,result');
    procRemoveStaff(6, 5, vresult);
end;

select * from tblStaff;
select * from tblProject;



/*

    저장 프로시저
    1. 저장 프로시저
    2. 저장 함수 
    
    저장 함수, Stored Function > 함수, Function
    - 저장 프로시저와 동일 
    - 반환값이 반드시 존재 > out 파라미터 사용(X) > return 문(O)
    - out 파라미터 사용 안함 > out 동작 가능
    - in 파라미터 사용함
    - 이 특성때문에 함수는 프로시저와 조금 다른 상황에서 사용(**) : 함수 vs 프로시저 
   
*/

-- public int sum(int a, int b)

-- 1 + 2 > 3
create or replace function fnSum (
    pnum1 number,
    pnum2 number -- presult out number > 이걸 안쓴다.
--) return date  -- 타입이 맞지 않으면 에러 난다.  PLS-00382: expression is of wrong type
) return number
is 
begin
    return pnum1 + pnum2;
end fnSum;
declare 
    vresult number;
begin
    -- 프로시저 out > 개수 1개 이상
    -- 함수 result > 개수 딱 1개 > 무조건 리턴값이 있어야 한다. 리턴값이 없으면 함수가 아니다. 
    vresult := fnSum(10, 20); -- 단일 상수다. 
    dbms_output.put_line(vresult);
end;

select 
    height, weight,
    height + weight,
    fnSum(height, weight) -- 숫자 2개를 넣으면 숫자 하나를 반환한다. > 이게 일반 컬럼값을 반환하는 것과 동일한 효과다. 
    -- procSum(height, weight); -- 프로시저는 못적는다. 리턴문이 없다. 
from tblComedian;

-- pl/sql 구문 끝에다가 /를 붙이면 
-- 블럭을 안잡아도 컨트롤 엔터치면 잡아진다.

-- 이름, 부서, 직위, 성별 > 함수나 프로시저 같은 것들 오라클 꺼지면 다 메모리에 내려감??
-- 그럼 오라클 키면 셋팅하는 코드를 짜야하나? 
-- 팀 프로젝트(A 팀원 작업) 
select 
    name, buseo, jikwi,
    case substr(ssn, 8, 1)
        when '1' then '남자'
        when '2' then '여자'
    end as gender
from tblInsa;

-- 팀 프로젝트(B 팀원 작업) 
-- 이름, 급여, 성별(남자|여자) 
select 
    name, buseo, jikwi,
    case substr(ssn, 8, 1)
        when '1' then '남자'
        when '2' then '여자'
    end as gender
from tblInsa;

-- 너도 그거하니? 나도 그거해 하고 서로 합의를 봐서 function을 만든다.
-- 팀 단위로 만드는 것이 좋다. 같이 만드는 것이 이득이다. 

create or replace function fnGender (
    pssn varchar2
) return varchar2
is
begin
    return case substr(pssn, 8, 1)
                -- when '1' then '남자' --
                -- when '2' then '여자' -- 갑자기 영어로 해줘!
                when '1' then 'Male' --
                when '2' then 'Female'
           end;
end fnGender;

select 
    name, buseo, jikwi,
    fnGender(ssn) as gender
from tblInsa;
-- 한번만 만들면 

/*
    
    SQL 처리 순서 
    - select문 실행(select * from tblInsa;)
    
    1. ANSI-SQL or 익명 프로시저
        a. 클라이언트 > 구문 작성 
        b. 클라이언트 > 실행(Ctrl+Enter)
        c. 명령어를 오라클 서버로 전송
        d. 서버 > 명령어 수신 
        e.     > 파싱(토큰 분해) > 올바른 키워드로 구성되어 있는지 문법검사 
        f.     > 컴파일(기계어) 
        g.     > 실행(SQL)
        h.     > 결과셋 생성
        i.     > 결과셋을 크랄이언트에게 반환
        j. 클라이언트 > 결과셋 > 화면출력
        - 동일한 명령어를 재실행해도 실행비용이 항상 동일하다.
        
    2. 저장 프로시저(프로시저 or 함수)
        a. 클라이언트 > 구문 작성(select)
        b.           > 실행(Ctrl+Enter)
        c. 명령어 오라클 서버로 전송
        d. 서버 > 명령어 수신
        e.    > 파싱(토큰 분해) > 문법 검사
        f.    > 컴파일(기계어) 
        g.    > 실행(SQL)
        h.    > 서버에 프로시저 생성 > 영구 저장(HDD)
        i.    > 종료
        
        a. 클라이언트 > 구문 작성(호출)
        b.          > 실행(Ctrl + Enter)
        c. 명령어를 오라클 서버로 전송
        d. 서버 > 명령어 수신
        e.     > 파싱(토큰 분해) > 문법 검사
        f.     > 컴파일(기계어) 
        g.     > 실행(SQL)
        h.     > 아까 컴파일 완료한 프로시저가 실행 > 프로시저에 관련된 작업을 재사용
        i.     > select 결과셋을 반환
        j.  클라이언트 > 결과셋 > 화면출력
        
        -- 동일한 명령어 실행 > 반복 비용 저렴(컴파일된 프로시저 호출 > 파싱 + 컴파일 > 생략) > 속도 향상
        -- 전체 컴파일, 부분 컴파일 등이 있다. 프로젝트가 너무 커서 그렇다.         
        
        반복적으로 호출해야 하는 상황이면 프로시저나 함수 만들어서 날리면 좋다. 
*/

-- 반복되는 업무들을 다시 컴파일하지 않아도 된다. 
create or replace procedure procTest
as
begin
select * from tblInsa;
end;
begin
    procTest;
end;

-- 우리가 쓰는 sql developer는 쿼리를 처리 못한다. 그냥 메신저다. 대화창이다.

/*    
    트리거, Trigger
    - 프로시저의 한 종류 
    - 호출을 개발자가 아니라, 미리 저장한 특정 사건이 발생하면 자동으로 실행되는 프로시저
    - 예약(사건) > 사건 발생 > 프로시저 호출 
    - 특정 테이블 지정 > 감시(insert or update or delete) > 데이터에 대한 변화이다.
    - 그 사건이 뻥 터지면 미리 준비해놓은 프로시저가 자동으로 호출이 된다. 
    ---> 특정 사건 전, 후 
    ---> 어떤사건??
    트리거 구문
    create or replace trigger 트리거명
        before|after
        insert|update|delete on 테이블명
        [for each row] 
    declare 
        선언부;
    begin         --- 사건이 난 직후 동시에 호출되는 코드 
        구현부;
    exception
        예외처리부;
    end;        
    
*/

-- tblInsa > 직원 삭제
create or replace trigger trgInsa
    before
    delete on tblInsa 
begin
    dbms_output.put_line('트리거가 실행되었습니다.');
end trgInsa;

select * from tblInsa;
delete from tblInsa where name = '홍길동'; 
-- 레코드 삭제 > 관계 맺은 자식 테이블에서 참조가 있는 경우.. 
-- 보너스 테이블에 길동이의 기본키가 있다...

-- 부모 레코드가 있는데 지우는 경우 자식이 딸려 있는 경우 > default는 참조하는 자식이 있어서 안지워진다. 
-- 여러가지 시나리오가 있다. 
/*

    레코드 삭제 > 관계 맺은 자식 테이블에서 참조가 있는 경우... 
    
    1. 홍길동 > 취소 
    2. 홍길동 > 삭제 
        a. 홍길동 삭제 + 자식을 삭제  > delete cascade
        b. 홍길동 삭제 + 자식을 보존 > FK 제약 삭제 > 비권장!!! 
        c. 홍길동 변형 + 자식 보존 > 회원탈퇴 임의의 값을 수정해서 채워넣기

*/
desc tblBonus;
select *from tblBonus;
select * from tblBonus where num = 1001;

select * from tblInsa;
update tblInsa set
    name     = '탈퇴',
    ssn      = '탈퇴',
    ibsadate = sysdate,
    city     = '탈퇴',
    tel      = '탈퇴',
    buseo    = '탈퇴',
    jikwi    = '탈퇴',
    basicpay = 0,
    sudang   = 0
        where num = 1001;

-- 데이터는 실제로 제거를 못하지만 .... 수정를 통해서 제거에 준하는 상태로 만든다. 현업에서 많이 쓰인다.
-- 이게 회원탈퇴이다. > 우리가 활동했던 정보는 참조키가 여럿있는데 이걸 잘못해서 삭제해버리면 큰일남





/*
    create table tblTest ( -- 내가 인지를 못하는 사이에서 지워진다. 내가 모르는 사이에 이런 조건을 인지하기가 힘듬 
        num number references tblInsa(num) ON DELETE CASCADE - 
    )

*/


-- tblInsa > 직원 삭제
create or replace trigger trgInsa
    before     -- 이것 때문에 덩달아서 실행이 된다. 삭제하기 직전에 프로시저를 실행해라 > 앞에 실행, 뒤에 실행 결정
    -- delete    -- 삭제든, 수정이든 다  > 어떤 사건 결정 
    update
    on tblInsa -- 삭제가 발생하는지 감시해라  > 대상을 결정 
begin
    dbms_output.put_line('트리거가 실행되었습니다.');
end trgInsa;

select * from tblInsa;
delete from tblInsa where num = 1001;  -- 트리거 실행됨

update tblInsa set city = '서울' where num = 1003; -- 트리거 실행

-- tblInsa > 직원 퇴사
-- 수요일 > 퇴사 금지!

create or replace trigger trgRemoveInsa
    before
    delete
        on tblInsa
begin
    dbms_output.put_line('트리거 실행.');
    -- 수요일 퇴사 금지 > 현재 무슨 요일?
--    if to_char(sysdate, 'day') = '수요일' then
--    if to_char(sysdate, 'dy') = '수' then
    if to_char(sysdate, 'd') = '4' then
        dbms_output.put_line('수요일');
        -- 퇴사 금지 > 지금 트리거 호출의 원인 > 실행 중인 delete문을 없었던 일로 > 취소 > 강제 예외 발생!!!!
        -- 자바 > throw new Exception();
        -- -20000 ~ -29999까지 쓸 수 있다. 
        raise_application_error(-20000, '수요일에는 퇴사가 불가능합니다.'); -- 이 함수가 있다. 이건 강제로 에러를 나게 한다.> 자바 throw 같은 개념 
        -- 이놈이 뻒하고 실행 그러면서 강제로 취소가 된다. 이게 왜그러냐면 before 트리거라서 그렇다. 
        
    else 
        dbms_output.put_line('다른 요일');
    end if;
end;

delete from tblInsa where num = 1003; -- 위에서 트리거 떄문에 퇴사가 불가능 before로 걸어서 그렇다. 
select * from tblInsa where num = 1003;

delete from tblInsa where num = 1004;
rollback;

select * from tblmen;




create or replace trigger trgLogmen
    after
    insert or update or delete 
    on tblmen
declare
    vmessage varchar2(1000);
begin
    -- 호출 : insert?가 나를 부른건지, update? delete? 구분해야 한다. > 식별 방법
    dbms_output.put_line('트리거 실행');
    
    if inserting then 
        dbms_output.put_line('새로운 항목이 추가되었습니다.');
        vmessage := '새로운 항목이 추가되었습니다.';
    elsif updating then
        dbms_output.put_line('항목이 수정되었습니다.');
        vmessage := '항목이 수정되었습니다.';
    elsif deleting then
        dbms_output.put_line('항목이 삭제되었습니다.');
        vmessage := '항목이 삭제되었습니다.';
    end if;
    insert into tblLogmen values(seqLogmen.nextVal, vmessage, default);
end trgLogmen;

select * from tblmen;

insert into tblmen values('테스트', 22, 175, 60, null);
update tblmen set weight = 65 where name = '테스트';
delete from tblmen where name = '테스트';

create table tblLogmen(
    seq number primary key,
    message varchar2(1000) not null,
    regdate date default sysdate not null
);

create sequence seqLogmen;
select * from tbllogmen;

-- 트리거가 부하가 올 수 있다. 너무 추가,수정,삭제가 많은 테이블에 대해선 트리거를 걸지말자
-- 최소한에 대해서만 트리거를 걸자 > 일단 걸어보고 알자 > 트리거를 걸어도 되는 업무가 있으면 걸자
-- 보통, 트리거 선언시, 감시 대상 테이블을 구현부에서 조작하지 않는다. 
create or replace trigger trgCountry
    after
    update
    on tblCountry         -- A 테이블 > 감시 
begin                     -- ★ 이런식의 테이블 처리는 하지 않는다. !!

    update tblCountry set -- A 테이블 > 감시를 조작 
        population = population * 1.1;
        -- 이렇게 해야할 업무가 있대 !
end trgCountry;

update tblcountry set capital = '제주' where name = '대한민국';

-- ORA-00036: maximum number of recursive SQL levels (50) exceeded 계속 반복이다.
-- update > trigger > update > trigger 계속 반복 

/*

-- [for each row] 이것 때문에 조금 복잡해진다. 
    1. 사용 x
        - 문장(Query) 단위 트리거
        - 트리거 실행 1회
        
    2. 사용 o
        - 행 단위 트리거 
        - 트리거 실행 반복 
    
*/

select * from tblwomen;

-- 문장 단위 트리거
--: delete 1회 실행 > 적용된 행 1개  > 프로시저 1회 호출
--: delete 1회 실행 > 적용된 행 10개 > 프로시저 1회 호출
--: old.name 누가 지워졌는데 지움을 당한 레코드르 참조한 것이다.
-- new or old references not allowed in table level 삭제가 되었는데 누가 삭제가 되었는지 중요핮 ㅣ않음
create or replace trigger trgwomen
    after
    delete
    on tblwomen
begin 
    dbms_output.put_line('레코드를 삭제했습니다.');
    -- dbms_output.put_line('레코드를 삭제했습니다.'||:old.name); -- 에러가난다. old 안된다.
end trgwomen;

delete from tblwomen where name = '하하하';
delete from tblwomen; -- 10개가 지워지지만 트리거가 한번 실행 

rollback;


-- 이제 행단위 트리거로 바꿔보자 !!
-- 행단위 트리거 > 개인을 대상으로 실행 > 영향받는 row들의 개수 만큼지운다. 
--: delete 1회 실행 > 적용된 행 1개  > 프로시저 1회 호출
--: delete 1회 실행 > 적용된 행 10개 > 프로시저 10회 호출
--: 개개인의 정보를 참조해서 구체적인 작업을 하는 것이 행단위 트리거의 목적이다. 

create or replace trigger trgwomen
    after
    delete
    on tblwomen
    for each row
begin 
    dbms_output.put_line('레코드를 삭제했습니다.'||:old.name);
end trgwomen;

delete from tblwomen; -- 10개가 지워지지만 트리거가 지운 row개수 만큼 실행

/*
'레코드를 삭제했습니다.'
'레코드를 삭제했습니다.'
'레코드를 삭제했습니다.'
'레코드를 삭제했습니다.'
'레코드를 삭제했습니다.'
'레코드를 삭제했습니다.'
'레코드를 삭제했습니다.'
'레코드를 삭제했습니다.'
'레코드를 삭제했습니다.'
'레코드를 삭제했습니다.'
*/

create or replace trigger trgwomen
    after
    delete
    on tblwomen
begin 
    dbms_output.put_line('레코드를 삭제했습니다.'||:old.name);
end trgwomen;


-- insert 
create or replace trigger trgwomen
    after
    insert -- 방금 추가된 레코드 정보를 알 수 있다. 
    on tblwomen
    for each row
begin 
    -- 상관관계(: new) > 새롭게 추가되는 행 참조 객체
    -- 새로 추가된 레코드! 
    dbms_output.put_line('레코드를 추가했습니다.'||:new.name || :new.age); -- 각 칼럼들을 접근해서 정보들을 알아낸다. 
end trgwomen;


insert into tblwomen values ('호2f', 20, 160, 50, null);

select * from tblwomen;

-- 상관 관계 
-- 1. :new
-- 2. :old

create or replace trigger trgwomen
    after
    --insert
    update
    on tblwomen 
    for each row -- insert는 new만 !! 
begin
    dbms_output.put_line(':old >' ||:old.weight); -- :old > insert에서는 old는 아무것도 안들어온다.
    dbms_output.put_line(':new >' ||:new.weight); -- :new > 테스트
    -- update 때는 old.weight는 전상태, new.weight는 후상태이다.
    dbms_output.put_line(' ');
end trgwomen;

create or replace trigger trgwomen
    after
    delete
    on tblwomen 
    for each row
begin
    dbms_output.put_line(':old >' ||:old.name); -- :old > 삭제되는 것을 불러온다.
    dbms_output.put_line(':new >' ||:new.name); -- :new > delete 때는 new로 아무것도 접근을 못한다. 
    dbms_output.put_line(' ');
end trgwomen;

-- delete는 old 과거만! / new는 X

insert into tblwomen values('테스트', 22, 175, 60, null);
update tblwomen set weight = 66 where name = '테스트';
delete from tblwomen where name = '테스트';


-- "퇴사" > 위임
select * from tblStaff;
select * from tblProject;

-- '이순신' 퇴사
create or replace trigger trgRemoveStaff 
    before       -- 3. 퇴사 직전에
    delete       -- 2. 퇴사를 하면 
    on tblStaff  -- 1. 직원 테이블을 감시 > ★ 대상 테이블 이건 절대로 트리거 구현부에서 쓰지마라 
    for each row -- 4. 담당 프로젝트 위임한다. 
    -- 퇴사 직전에 일안하는사람 찾아서 일을 맡긴다. 
    
declare 
    vdseq number;
begin
    -- 5. 퇴사전에 담당 프로젝트를 다른 사람에게 위임한다. > 현재 맡고 있는 프로젝트 수가 가장 적은 직원에게 
    -- select * from tblProject group by staff_seq;
    
    
--    select seq from (select s.seq
--    from tblStaff s
--        left outer join tblProject p
--            on s.seq = p.staff_seq
--                having count(p.seq) = (select
--                        min(count(p.seq))
--                    from tblStaff s
--                        left outer join tblProject p
--                            on s.seq = p.staff_seq
--                                group by s.seq)
--                group by s.seq )
--                where rownum =1 ;
    
--    select 
--        min(count(p.seq))   
--    from tblStaff s 
--        left outer join tblProject p
--            on s.seq = p.staff_seq
--                group by s.seq;
--    
    update tblProject set
        staff_seq = 2
            where staff_seq = :old.seq;
        

end trgRemoveStaff;


select count(*) from tblProject group by staff_seq;
select min(count(*)) from tblProject group by staff_seq;
select * from tblProject; --1, 2, 3, 4, 5
select * from tblStaff; 

delete from tblStaff where seq = 5;


-- 우리 프로젝트는 트리거를 많이 만들필요는 없다.
-- 굳이 개수를 따지면 한사람의 한두개 정도 > 형식 갖출정도만 
-- 근데 최소 하나이상은 해라 > 트리거 하나이상은 만들어라 

-- 공부만(X), 취업 서류(O) 
-- 1개 주제 > 수업 > 공부 + 서류화
-- 주제 > 수업 > 공부 + 서류화 > 뭔가를 배웠다가 어디다가 어떻게 써먹었는지 생각해라 




create table tblUser (
    id varchar2(30) primary key,
    point number default 1000 not null
);

insert into tblUser values('hong', default);

create table tblBoard(
    seq number primary key,
    subject varchar2(1000) not null,
    id varchar2(30) not null references tblUser(id)
);

-- 회원 > 글쓰기 > +100 
-- 회원 > 글삭제 > -50
-- A. 글을 쓴다.(삭제한다) > insert or delete
-- B. 포인트를 누적시킨다. > update

-- Case1. ANSI-SQL
-- 절차> 개발자 직접 제어 
-- 실수> 일부 업무 누락; 

create sequence seqBoard;

-- 1.1 글쓰기
insert into tblBoard values(seqBoard.nextVal, '게시판입니다.', 'hong');
--1.2 포인트 누락하기
update tblUser set point = point + 100 where id ='hong';
--1.3 글삭제
delete from tblBoard where seq =1;

--1.4 포인트 누적하기
update tblUser set point = point -50 where id = 'hong';

select * from tblBoard;
select * from tblUser;

-- commit 은 필수다 다른사람이 내 글을 볼려면 해야하는 상황  > 유저 단위로 한다는 것 
-- Case2. Procudure > 트랜잭션 처리 
create or replace procedure procAddboard(
    psubject varchar2,
    pid varchar2
) 
is 
begin
    
    -- 2.1 글쓰기 
    insert into tblBoard values(seqBoard.nextVal, psubject, pid);
    -- 2.2 포인트 누적하기
    update tblUser set point = point + 100 where id = pid;
        
    commit; 
    
exception -- 1번이 성공하고 2번이 실패 > 글은 써졌는데 포인트가 누적이 안됨!! > 근데 우리가 예외처리에서 롤백을 시켜버려서 글 쓴 경우조차 없는 경우다.
    when others then
        
        rollback;


end procAddboard;


create or replace procedure procRemoveBoard(
    pseq number 
)
is 
    vid number ;
begin
    -- 삭제글을 작성한 id
    select id into vid from tblBoard  where seq = pseq;
    -- 2.3 글삭제
    delete from tblBoard where seq = pseq;
    -- 2.4 포인트 누적하기 
    update tblUser set point = point - 50 where id = 'hong';

    commit;
    
exception
    when others then
        dbms_output.put_line('--');
        rollback;

end procRemoveBoard;


begin
    -- procAddBoard('다시 글을 작성합니다.', 'hong');
    procRemoveBoard(2);
end;

select * from tblBoard;
select * From tblUser;

-- Case3

create or replace trigger trgBoard
    after 
    insert or delete 
    on tblBoard
    for each row
begin
    if inserting then
        update tblUser set point = point + 100 where id = :new.id; --:는 붙어있다. old나 new에는 :를 붙여쓰자 
    elsif deleting then -- 위에서 ansi sql에서 테스트 
        update tblUser set point = point - 50 where id = :old.id; -- [ph2csql_strdef_to_diana:bind] 저거 :를 띄어쓰면 에러다.
    end if;
end;

-- 트리거의 장점 눈 앞에 있는 업무에 집중할 수 있다. 포인트 누적은 사이드 업무 > 글 조회수

select * from tblBoard;
select * from tblUser;


-- 프로시저 vs 트리거
-- 프로시저 : 모든 작업을 명시적으로 직접 관리
-- 트리거 : 메인작업 명시적 + 보조작업 암시적


/*
    커서를 반환하는 프로시저 
    - out > cursor(O)
    - return > cursor(X)
*/


set serveroutput on;

create or replace procedure procBuseo (
    pbuseo varchar2
)
is 
    cursor vcursor is 
        select * from tblInsa where buseo = pbuseo;
    vrow tblInsa%rowtype;
begin
    --1. loop + cursor 
    --2. for loop + cursor 
    open vcursor;
        loop
            fetch vcursor into vrow;
            exit when vcursor%notfound;
            dbms_output.put_line(vrow.name);
        end loop;
    close vcursor;
end procBuseo;

create or replace procedure procBuseo (
    pbuseo varchar2
)
is
    cursor vcursor is
        select * from tblInsa where buseo = pbuseo;
begin
    for vrow in vcursor loop
        dbms_output.put_line(vrow.name);
    end loop;
end procBuseo;

-- 커서를 가져와서 소비
begin 
    procBuseo('개발부');
end;

create or replace procedure procBuseo (
    pbuseo in varchar2,
    pcursor out sys_refcursor -- 리턴 타입에 사용되는 커서의 쓰는 자료형이다. 
               -- 그냥 cursor로 쓰면 받지를 못한다. 
)
is 
    --cursor vcursor is select...
begin
    open pcursor
    for
    select * from tblInsa where buseo = pbuseo;
    
end procBuseo;


declare
    vcursor sys_refcursor;
    vrow tblInsa%rowtype;
begin
    procBuseo('영업부', vcursor);
    -- 이 전달받은 vcursor는 따로 열 필요가 없다. 
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        dbms_output.put_line(vrow.name);
    end loop;
end;



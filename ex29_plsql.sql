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
    vname tblInsa.name%type;   -- tblInsa 테이블에서 name에 대한 type만큼 vname의 타입을 잡아줘 ! 
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
    num number(5) not null references tblInsa(num),
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



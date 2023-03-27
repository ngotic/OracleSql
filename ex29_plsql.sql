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



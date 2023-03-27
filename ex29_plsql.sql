/*

    ex29_plsql.sql
    
    PL/SQL
    - Oracle's Procedural Language Extension to SQL 
    - ANSI-SQL�� ���� ���� ����� ����� �߰��� SQL
    - ANSI-SQL + �ڹٰ��� ���α׷��� ����� ��� = PL/SQL
    
    ANSI-SQL
    - ������ ���� ���
    - ������ ���� ���尣�� �ൿ�� ���� �������̴�.
    - ���� ���� ����
    
    ���ν���, Procedure
    - �޼ҵ�, �Լ� ��.. 
    - '������ �ִ�' ��ɾ��� ����(ANSI-SQL + PL/SQL)�� ����     
    - SQL�� ��ɾ�� �� ������ ������... �ٵ� ���ν����� ������ ���������� �Ʒ��� �����Ѵ�. 
    
    1. �͸� ���ν���
        - 1ȸ�� �ڵ� �ۼ��� > ������ ���� �͸� ���ν����� 1ȸ������ ���ڴ�.
        
    2. �Ǹ� ���ν���
        - ����(�����ͺ��̽�) > DB Object �߿� �ϳ���. 
        - ���� ���� ** 
        - ������ ���� ���� 
    
    PL/SQL ���ν��� �� ���� 
    - 4���� Ű����(��)���� ���� 
        a. declare 
        b. begin
        c. exception
        d. end
    
    a. declare 
        - �����
        - ���ν��������� ����� ����, ��ü �� �����ϴ� ����
        - �������� 
        
    * begin end�� ������ �Ұ����ϴ�. �̰� �ٽ��̴�. > �̰��ҷ��� ����°ǵ�
    
    b. begin
        - �����, ������
        - begin ~ end
        - begin(������ ����) ~ end(������ ��) 
        - ���� �Ұ���
        - �ٽ���Ʈ
        - ���� �ڵ� > ANSI-SQL + PL/SQL
    
    c. exception
        - ����ó����
        - catch ���� 
        - ���� ó�� �ڵ带 �ۼ�
        - ���� ����
    -- draft> mid
    d. end
        - begin 
        - ���� �Ұ���     
        
    1. �Ϲ����� ���
    declare 
    
        ���� ����
        ��ü ����
        
    begin
    
        ������ �ڵ�(SQL)
        
    end;
    
    2. ���ܰ� �� �� �ֳ�? �ϴ� ���
    
    declare 
        ���� ����
        ��ü ����
        
    begin
    
        ������ �ڵ�(SQL)
        
    exception  
        ����ó�� �ڵ�
    end;
    
    3. ������
    
    begin
        ������ �ڵ�(SQL)
    end
    
    public void test() { > '�̷� ����'?
     
    }
    
    ANSI SQL�� �ְ� PL/SQL�� �پ��ִ�.
    �̰��� ������ ANSI SQL�� �������ϱ� ���� �پ��ִ� ���̴�.
    
    PL/SQL�� ��κ��� ȯ���� > ANSI-SQL�� ȯ��� ���� �����ϰ� �����Ǿ� �ִ�.
    
    PL/SQL �ڷ���
    - ANSI-SQL ���� �����ϴ�. 
     
    
    ���� �����ϱ� 
    - ������ �ڷ��� [ not null ][default ��];
    - �̶� ��������� ������ �ڹ��� ���� ������ ������ �׷� ������ �ƴϴ�. ������ �޶�...
    - �ַ� ����(select)�� ������� �����ϴ� �뵵.. 
    - �Ϲ����� �����͸� �����ϴ� �뵵 
    
    PL/SQL ������
    - ANSI-SQL�� ���� ����
    
    ���� ������
    - ANSI-SQL
        ex) update table set column = ��;
    - PL/SQL 
        ex) ���� := �� ( ���� Ŭ���� =������ �տ� �ٴ´� )
    
*/


-- �޼ҵ�:       ����(����) > ȣ�� 
-- �͸����ν���:  ȣ�� 
begin
    -- System.out.println( )�� �����̴�.
    dbms_output.put_line(100);
    dbms_output.put_line('ȫ�浿'); 
end;
-- ��Ʈ�� �����ؼ� �����Ű�� �Ǵµ� ȣ���� �Ǵ°� ����...(???)
-- �ֳĸ� dbms_output.put_line�� ����� ȭ�鿡 �Ⱥ��̰� ����(�⺻��)

-- �� ����
set serveroutput on;
set serverout on;      -- �̰� �����Ű�� ���� ���ν��� �����Ű�� 100�� ȫ�浿�� ��µȴ�. 

-- �� ����
set serveroutput off;
set serverout off;

-- ������ �� �ɼ��� ������ ������ �Ѿ��Ѵ�. ���������� �ݿ������� �ʴ´�.
-- put_line�� ���Ǹ��� ��������� �Ѵ�. 

-- ���� �����ؼ� > �� ���� ����ϴ� ���ν��� > �ڹٿ� ����ϴ�. 
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
    name := 'ȫ�浿';
    dbms_output.put_line(name);
    today := sysdate;
    dbms_output.put_line(today);
end;



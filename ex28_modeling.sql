/*

    ex28_modeling.sql
    
    ���� > ������ �ٸ� �ý��� or ����Ʈ�� ����غ��鼭 ����ľ� > �䱸���� ���� : ��ȹ�ǵ� ���ϱ� - �⺻���� ��� �ľ� > ������ �𵨸� [> �߰����� ��� ���� ]
    
    �����ͺ��̽� ����
    1. �䱸���� ���� �� �м�
    2. ���� ������ �𵨸�
    3. �� ������ �𵨸�
    4. ���� ������ �𵨸�
    5. �����ͺ��̽� ���� 
    
    ������ �𵨸�
    - �䱸 �м� ��� > ������ ������ > �м� > ���� ���� ���� > ����ȭ > ERD(���⹰) 
    - ������ �����ϱ� ���� ������ ������ �����ϴ� �۾� 
    - DBMS ������ �������� �ʴ´�.
    
    [-> ���� ������ �𵨸� > �����ϰ� ǥ���� ���赵 > ���̺� + �÷� + ���� : �����ϰ� ����ġ ] : �긦 ����� ���� ������. 

    - �� ������ �𵨸� > ������ �����ͺ��̽� ���� �ݿ� > �Ӽ� + ������ + Ű > ����ε� ���赵 
    - ���� ������ �𵨸� > Ư�� DBMS ���� > ����Ŭ > ����Ŭ�� �������� ��� �͵��� �߰��� ���� > ����Ŭ ���� + �ݿ� > ������ ����...
    
    
    1. ERD, Entity Relationship Diagram
    - ����Ƽ���� ���踦 ǥ���� �׸�
    - ������ �����ͺ��̽� �𵨸� ��� �� �ϳ� 
    - ��, ���ǽ�, ����Ʋ(exERD, ER-Win �� ) 
    
    2. Entity, ��ƼƼ
    - �ٸ� Entity�� �з��� �� �ְ�, �ٸ� Entity�� ���� ������ ���踦 ���� �� �ִ� ������ ����
    - �����̼� = ��ü = ���ڵ� = ����Ƽ = ���̺�(��)
        a. �л� ���� ���� ( �������� ������ �ȴ�. 
            - ���� ���� : �ƾƵ�, �л���, ����, �ּ�, ����ó...  �̰� �������� �л� �Ѹ��� �����ʹ�. �̰� ������ ���´�.
            - �л�(_���̵�_, �л���, ����, �ּ�, ����ó) > �̶� �� �л��� Entity��� �θ���. 
            ��׵��� �Ӽ��̶�� �Ѵ�. �ٵ� �� �Ӽ��߿� �ĺ��� ������ �ϴ� �ְ� �ִ�. 
        b. ���ǽ� ���� ���� 
            - ���� ����: ���ǽ� ȣ��, ũ��, �ο���, �뵵, ����...
            - ���ǽ�(���ǽ� ȣ��, ũ��, �ο���, �뵵, ����) 
        - �̷������� ���谡 �ִ� ������ ��Ƶ� ���̴�. 
    3. Attribute, �Ӽ�
    - ��ƼƼ�� �����ϴ� ����
    - �÷�
    4. Entity Relationship, ��ƼƼ ����
    - �л�(�̸�,����...)
    - ����(�̸�,������..)
    - �б�(�г�,��..)
    - �л� <-> �б� <-> ���� : Entity Relationship �̶�� �θ���.
    - ���� �帣, ���� ��Ʈ, ��Ʈ�� ��� ���踦 �ΰ� �ִµ� �̷��� relationship�̴�. 
    
    
    ERD�� �׸��� �� > Entity, Attribute, Relationship ���� ǥ���ϴ� ��� 
    �̷��� ��� �׸������� ���� ����. 
    
    1. Entity 
    - �簢��
    - �̸��� �ۼ�
    - ERD���� ������ ��ƼƼ ���� ������ 
    
    2. Attribute
    - ���׶��
    - ����Ƽ�� ����
    - �߰� ǥ����� (�Ӽ��� ���� ���� ���)
        a. NN, Not null
            - �ش� �Ӽ��� �ݵ�� �ۼ��ؾ� �Ѵ�.
            - �ʼ���
        b. ND, Not Duplicate
            - �ش� �Ӽ��� �ߺ��� �� ����.
            - ���ϰ�(Unique)
        1. �ߺ��Ǹ� �ȵǰ�, �����Ǹ� �ȵȴ�.(NN, ND)
            - #*�Ӽ���
            
        2. �����Ǹ� �ȵȴ�.(NN)
            -*�Ӽ���
            
        3. �ߺ��Ǹ� �ȵȴ�.(ND)
            -#�Ӽ���
        4. �ߺ��ǵ� �ǰ�, �����ǵ� �ȴ�.
            - �Ӽ���
            - o�Ӽ���
            - optional
            
    3. Relationship
    - ������
    - ��ƼƼ�� ��ƼƼ�� ����
    - ���� �߿��� ǥ��(****)
    
        A��ƼƼ : B��ƼƼ
        a. 1:1
            - �ϴ���
        b. 1:0
        c. 1:N
            - �ϴ��
        d. N:M
            - �ٴ��
        
        ���� �뿩�� 
        
        1. ��ƼƼ ����
            - �帣 
            - ����
            - ȸ��
            - �뿩
            
        2. �Ӽ� ����
            -
        3. �ĺ��� ����
            -�⺻Ű
        ------------------------ ������ �𵨸�
        4. �� �𵨸� 
        
            - 1~3�� �ݺ� > ���������� �׸��� 
        ------------------------ �� �𵨸�
        5. ���� ������ �𵨸� > ����Ŭ �°� ��üȭ!!!
            - ������(�ĺ���) ���� > name
            - �ڷ��� > varchar2 
            - ���� > 30 
            - ������ > 2~5�� �̳��� �ѱ� 
            - ������� ����
        ------------------------- �����𵨸�
        
        �𵨸� �۾� > ERD(��, ����) > [����ȭ] > ������ ����, ȿ���� ������ ���� > ERD ����
        ���õǸ� ����ȭ�� �Ȱ��ĵ� �� ������ ������ ���� �����. >>>>> 
        
        ����ȭ, Normalization 
        - �ڷ��� �ս��̳�, ���ʿ��� ������ ���ְ�, �������� �ϰ����� �����ϸ�, ������ ���Ӽ��� �ּ�ȭ�ϱ� ����
        ERD�� �����ϴ� �۾�
        ( ó������ ���ϴ� ����� ����ȭ ���·� �̹� « )
        - �츮�� ���� ���̺�(ERD) > ������, ������ȭ ���� > ����ȭ > ����ȭ�� ���� ERD 
        - �� 1����ȭ > �� 2 ����ȭ > �� 3 ����ȭ 
        - �� 1~3 ����ȭ
            
        -> �̷� ���¸� �����ϸ鼭
        ������ �����ͺ��̽� �ý����� �����ϴ� �����ͺ��̽� ����
        1. ���ڰ��� ������.
        2. �ִ��� null�� ������ �ʴ´�.
        3. �ߺ����� ������ �ʴ´�.
        
        -> �̷� ���¸� �����ϰ��� �Ѵ�. 
        �̻� ����
        1. ���� �̻�, Insertion Anomaly
            - ���̺� �����͸� ������ ��, ������ �ʴ� �����ͱ��� ���� �־�� �ϴ� ��Ȳ
        2. ���� �̻�, Update Anomaly
            - ������ �����Ͱ� 2�� �̻��� ���̺� ���� ���� > �� �� 1���� ���� �߻� 
            -> �� �� ������� �ùٸ��� ? �˼��� ����.
        3. ���� �̻�, Delete Anomaly 
            - ���̺��� �����͸� ������ ��, ������ �ʴ� �����ͱ��� ���� ������ �ϴ� ��Ȳ
        
        -> �ִ��� �����ͺ��̽��� �����ϰ��� �ϴ� ������� �ٲٰ��� �Ѵ�.
        
        �Լ� ����, Functional Dependency 
        - 1���� ���̺� �� �÷������� ���踦 ǥ���Ѵ�.
        - *** ����ȭ�� '�κ� �Լ� ����'�̳� '�����Լ� ����'�� ��� ���ְ�,(3���������� ����)
              ��� �÷� ���踦 '���� �Լ� ����'���� ����� �۾��̴�. 
              
        1. ���� �Լ� ����, Full Functional Dependency
        2. �κ� �Լ� ����, Partial Functional Dependency
        3. ���� �Լ� ����, Transitive Functional Dependency
        
        ����ȭ 
        - ������ȭ > ����ȭ
        - 1NF > 2NF > 3NF(Normal Form)
        
        �� 1����ȭ, 1NF
        - ��� �÷�(�Ӽ�)�� ���ڰ��� ������.
        - ���߰�(�������� �и� ������ ��)�� 1���� �÷��ȿ� ���� �ʴ´�.
        - ���߰��� ������ �÷� ã�� > ���ִ� �۾�
        
        �� 2 ����ȭ, 2NG
        - �⺻Ű(PK)�� �ƴ� ��� ������ Į���� �⺻Ű�� ���� �Լ� ���ӵǾ�� �Ѵ�.
        - �κ� �Լ� ���� �˻�!!> �κ� �Լ� ���� ����!!
        - �ַ� ����Ű�� ������ ���̺��� �߰ߵȴ�.
            - �Ϻ� �÷��� ����Ű �Ϻο��� ���ӵǴ� ������ �����ϴ� ����ȭ��.
            
        ** �ٵ� ����Ű�� �� �����ϱ⵵ �Ѵ�. ����Ű�� �����ؼ� > PK�� �����. > seq ������
        ����Ű�� �Ⱦ��ϴ� ������� ����. �ֳĸ� ������ ¥�� ����ϱ� �׷���.
            
        �� 3 ����ȭ, 3NF
        - �⺻Ű(PK)�� �ƴ� ��� ������ �÷��� �⺻Ű�� ���� �Լ� �����̾�� �Ѵ�.
        - ���� �Լ� ���� �˻�!!> ���� �Լ� ���� ����!!
        - �÷��� �⺻Ű�� �ƴ� �ٸ� Ű�� ���ӵǴ� ������ �����ϴ� ����ȭ.
        
        ������ȭ
        - ����ȭ�� ����� �ٽ� ������� �ǵ����� �۾� 
        - 2���� �������� ���̺��� �ٽ� �ϳ��� ��ġ�� �۾��̴�.
        - ���� �� ��� ����!!
        
*/

-- ����Ű �����ϱ� + ����ϱ�
create table tblStudent (
    seq number primary key,     -- ��ȣ(PK)
    name varchar2(30) not null  -- �л���
);

-- ����
create table tblSubject (
    seq number primary key,       -- ��ȣ
    name varchar2(30) not null    -- ����
);

-- ���� ��û
create table tblRegister (
    -- �÷� ���ؿ����� ����Ű�� ������ �� ����. !!!!
    -- student_seq number primary key, -- �� Į������ pk ����� ���� �� �̰� �ȵȴ�.
    -- subject_seq number primary key, -- �� Į������ pk ����� ���� �� �̰� �ȵȴ�.
    regdate date default sysdate
); --ORA-02260: table can have only one primary key

create table tblRegister (
    -- �÷� ���ؿ����� ����Ű�� ������ �� ����. !!!!
    student_seq number, -- �� Į������ pk ����� ���� �� �̰� �ȵȴ�.
    subject_seq number, -- �� Į������ pk ����� ���� �� �̰� �ȵȴ�.
    regdate date default sysdate,
    
    constraint register_pk primary key(student_seq, subject_seq) -- ����Ű ����
);
-- constraint�� alter�� ����

-- **** �̷��Ը� �ϸ� �ȵǰ� FK�� ������ �Ѵ�.
drop table tblRegister;


create table tblRegister (
    -- �÷� ���ؿ����� ����Ű�� ������ �� ����. !!!!
    student_seq number references tblStudent(seq), 
    subject_seq number references tblSubject(seq), 
    regdate date default sysdate,
    constraint register_pk primary key(student_seq, subject_seq) -- ����Ű ����
);

drop table tblRegister;

create table tblScore(
    seq number primary key,
    score number not null,
    --- ����Ű�� �����ϴ� �ܷ�Ű�� �÷� �������� ������ �� ����.
    student_seq number,
    subject_seq number,
    constraint score_f foreign key(student_seq, subject_seq) references tblRegister(student_seq, subject_seq)
);

-- �л� ������ ���� 
insert into tblStudent values (1, 'ȫ�浿');
insert into tblStudent values (2, '�ƹ���');
insert into tblStudent values (3, '������');

-- �� �л��� �����ϴ� ����� ������ ���� 
insert into tblSubject values (1, '�ڹ�');
insert into tblSubject values (2, '����Ŭ');
insert into tblSubject values (3, 'JDBC');
insert into tblSubject values (4, 'JSP');
insert into tblSubject values (5, 'Spring');

-- ��û��¥
insert into tblRegister values (1, 1, sysdate);
insert into tblRegister values (1, 2, sysdate);
insert into tblRegister values (1, 3, sysdate);
insert into tblRegister values (2, 2, sysdate);
insert into tblRegister values (2, 4, sysdate);
insert into tblRegister values (2, 5, sysdate);
insert into tblRegister values (2, 1, sysdate);
insert into tblRegister values (3, 2, sysdate);
insert into tblRegister values (3, 5, sysdate);

-- ������ ���Ծ� ~
insert into tblScore values (1, 100, 1, 1);
insert into tblScore values (2, 90,  1, 2);
insert into tblScore values (3, 80,  1, 3);
insert into tblScore values (4, 70,  2, 2);
insert into tblScore values (5, 60,  3, 2);

select * from tblStudent;
select * from tblSubject;
select * from tblRegister;
select * from tblScore;

-- �л� + ���� > ���� ��û > ���
select 
    st.name as "�л���",
    sj.name as "�����"
from tblStudent st
    inner join tblRegister r
        on st.seq = r.student_seq
            inner join tblSubject sj
                on sj.seq = r.subject_seq;

-- ���� ��Ϻ��� ������ ������ score�� ���Խ��״��� �پ�� ��
-- �л� + ���� > ���� ��û > ���
select 
    st.name as "�л���",
    sj.name as "�����",
    sc.score as "����"
from tblStudent st
    inner join tblRegister r
        on st.seq = r.student_seq
            inner join tblSubject sj
                on sj.seq = r.subject_seq
                    inner join tblScore sc -- �ΰ��� FK
                        on r.student_seq = sc.student_seq 
                            and r.subject_seq = sc.subject_seq; -- ���� �� ������ �þ

-- ���� ��û�� �ߴµ� ���� ������ �Ⱥ� ģ������ ��������
-- �̷��� �������� ģ���鵵 ���� ���� ���Խ�Ű�� ���� �� left outer join�� �ϸ� �ȴ�. 
select 
    st.name as "�л���",
    sj.name as "�����",
    sc.score as "����"
from tblStudent st
    inner join tblRegister r
        on st.seq = r.student_seq
            inner join tblSubject sj
                on sj.seq = r.subject_seq
                    left outer join tblScore sc -- �ΰ��� FK
                        on r.student_seq = sc.student_seq 
                            and r.subject_seq = sc.subject_seq; -- ���� �� ������ �þ


-- ����Ű�� �� ���� ������ �ִ���? .... �𸣰ڴ�. > �׳� �Ȱ���. ���Ѱ� ��! 


/*

���� �۾��� �غ���
    ������ ���� > 
    
    ������ ����
    
    ���̹� ��ȭ(https://movie.naver.com/)
    
    1. ��ȭ ��ŷ�� ���� � ���������� �ľ� > 50��?? ���� ��ȭ����
    -- ��ȭ������ ��ȭ�� ���� ������ ���´�. �̰͵� �䱸�ϴ� Ÿ���̴�. ��� ��ȭ������ Ÿ������ �Ѵ�.
    -- ��� �����Ϳ� ���� ���踦 �ϴ� ���� �䱸�������� ����
    
    abcdefg~~~~~ > 
    
    1. ������ ���� + �м�
        - ������ �ν�
        - �����ͺ��̽� ������ �����͸� �������� 
        
    2. ERD �ۼ�(****)
        a. ������ �𵨸� > ���⹰(v)
        b. �� �𵨸�   > ���⹰(v)
        c. ���� �𵨸�   > ���⹰(v)
    
    3. DDL �ۼ�
        - create �� �ۼ�
        a. ���̺�
        b. ������
        c. ��
        - ��ũ��Ʈ > ���⹰ (v)
        
    4. DML �ۼ�
        - ������ �߰�
        - insert��
        - ��ũ��Ʈ > ���⹰(v)(x)
        - 50�� ��ȭ
        
   5. select �� > ������
      a. ��ȸ�� ������� �������ÿ�.(����, ��ȭ��, ������)
      b. '�ڼ���' ��찡 �⿬�� ��ȭ�� �������ÿ�.
      c. '����ȯ' ������ ������ ��ȭ�� �������ÿ�.
      d. ���ڵ��� ��ȣ�ϴ� ��ȭ�� �������ÿ�. > 
      e. 20�밡 ��ȣ�ϴ� ��ȭ�� �������ÿ�. >
      f. '���ƿ�'�� 20,000�� �̻� ���� ��ȭ�� �������ÿ�.
      g. ������ ������ 40,000�� �̻� �޸� ��ȭ�� �������ÿ�.
      h. ��Ƽ�� ������ ������ 4.5�̻��� ��ȭ�� �������ÿ�.
      i. ��ȭ�� ���縦 ��ȭ ����� �Բ� �������ÿ�.(���� ���� ����)
      j. ��ϵ� 50���� ��ȭ�� ���� ���� ��ȭ�� ������ ��츦 �������ÿ�.
      k. '���'�� '�ڹ̵�' 2�� �帣�� ���� ��ȭ�� �������ÿ�.
      l. ��Ÿ���� 120�� �̸��� ��ȭ�� �������ÿ�.
      m. ���� ������ ��ȭ�� �������ÿ�.
      n. ���� ���� 100,000���� �Ѵ� ��ȭ�� �������ÿ�.
*/      

desc employees;



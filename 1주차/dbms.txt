*dbms 설치 및 spldeveloper 설치
*필요한 프로그램
1. oracle 11g express(www.oracle.com)
-> 비밀번호 : manager

2. spldeveloper 


*system/manager 계정생성

create user 아이디 identified by 비번;
create user Puri identified by 1234;

--권한 부여
grant 권한내용 to 아이디;
grant connect,resource,unlimited tablespace to Puri;


--테이블 스페이스 설정 변경
alter user Puri default tablespace users temporary tablespace temp;

select username from dba_users;
0823_컴공B_김상범

*system 계정으로 접속
- system/manager

create user comb identified by 1234;

grant connect,resource,unlimited tablespace to comb;

alter user comb default tablespace users temporary tablespace temp;

select username from dba_users;

*comb 계정으로 접속

belouga.blog.me => create.sql 다운로드

@C:\Users\tkdqj\Downloads\create.sql;

select * from tab;


*DBMS (Database Management System)
*SQL (Structure Query Language)

*데이터베이스 언어
1. DDL(데이터 정의어)
- create : 데이터객체 생성
- alter : 객체 변경
- drop : 객체 삭제

2. DML(데이터 조작어)
- select: 데이터 검색)
- insert(데이터 삽입)
- update(데이터 갱신)
- delete(데이터 삭제)

3. DCL(데이터 제어어)
- commit(성공), rollback(실패)
- grant(권한 부여), recoke(권한 철회)


*select : 데이터 조회(검색)
select 속성명(열이름)
from 테이블명;

1. 사원 테이블의 모든 내용 조회
select empno,ename,job,mgr,hiredate,sal,comm,deptno
from emp;

select * from emp;

2. 부서 테이블의 모든 데이터 검색
select deptno,dname,loc
from dept;

select * from dept;

3. 급호 테이블의 전체 정보 보이기
select grade,losal,hisal
from salgrade;

select * from salgrade;

4. 부서 테이블의 부서명과 위치를 보이시오.
select dname,loc from dept;

select dept.dname, dept.loc from dept;

5. 사원의 직무, 사원명, 급여, 보너스를 보이시오.
select job,ename,sal,comm from emp;

*distinct : 중복 데이터는 한번만 표시
6. 사원테이블의 모든 직무를 조회하시오.
select distinct job from emp;

7. 사원테이블에서 사원이 속한 부서번호를 보이시오.(중복제거)
select distinct emp.deptno from emp;

*그룹(집계)함수
count (속성명) - 개수
sum (속성명) - 합계
avg (속성명) - 평균
min (속성명) - 최소값
max (속성명) - 최대값

*alias : 출력되는 열의 이름 변경
8. 사원테이블에 속한 사원은 몇명인가???
select count(*) as 사원수 from emp;

9. 사원테이블에서 직무의 개수를 보이시오.
select count(distinct job) as "직무의 개수" from emp;

10. 사원이 속한 부서번호는 몇개인가???
select count(distinct deptno) as "부서번호의 개수" from emp;

11. 사원테이블에서 사원수, 최소급여, 최대급여, 급여합계, 급여평균을 보이시오.
select count(*) 사원수, min(sal) 최소급여, max(sal) 최대급여, sum(sal) 급여합계,
round(avg(sal)) 급여평균
from emp;
-- 급여합계는 천의자리까지, 급여평균은 소수 둘쨰자리까지 표시
select count(*) 사원수, min(sal) 최소급여, max(sal) 최대급여, round(sum(sal),-3) 급여합계,
round(avg(sal),2) 급여평균
from emp;

12. 사원명, 급여, 급여+500, 급여-700, 급여*2, 급여/2
select ename 사원명, sal 급여, sal+500 "급여+500", sal-700 "급여-700", sal*2 "급여*2", sal/2 "급여/2"
from emp;

13. 사원명, 급여, 7%인상급여, 11%삭감급여
select ename 사원명, sal 급여, sal*1.07 "7%인상급여", sal*(1-0.11) "11%삭감급여"
from emp;

14. 모든 사원의 급여를 22% 증가시켜 사원번호, 사원명, 직무, 급여를 보이시오.
select empno 사원번호, ename 사원명, job 직무, sal*1.22 급여
from emp;

15. 모든 사원의 급여를 10% 감소시켜 사원명, 급여, 입사일자를 보이시오.
select ename 사원명, sal*0.9 급여, hiredate 입사일자
from emp;

*NVL(속성명, 변경값) : 속성명의 값이 null이면 변경값으로 바뀜
16. 사원의 연봉을 계산하여 사원명, 급여, 보너스, 연봉(급여와 보너스 포함)을 보이시오.
select ename 사원명, sal 급여, nvl(comm, 0) 보너스, sal*12+nvl(comm, 0) 연봉
from emp;

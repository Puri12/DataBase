1.사원명이 jones 인 사원의 모든 정보를 보이시오.
select *
from emp
where ename like 'JONES';

2.직무가 manager 이거나 salesman 인 사원의 직무, 사원명, 사원번호를 보이시오.
select job 직무, ename 사원명, empno 사원번호
from emp
where job in ('MANAGER', 'SALESMAN');

3.급여가 2000 이상이고 4000 이하인 사원의 급여, 보너스, 사원번호를 보이시오.
select sal 급여, comm 보너스, empno 사원번호
from emp
where sal between 2000 and 4000;

4.관리자사번이 존재하는 사원의 사원명, 관리자사번을 보이시오.
select ename 사원명, mgr 관리자사번
from emp
where mgr is not null;

5.사원명에 S가 포함된 사원의 사원명, 입사일자, 직무를 보이시오.
select ename 사원명, hiredate 입사일자, job 직무
from emp
where ename like '%S%';

--------------------------------------------------------------------------------
*SELECT 절
select [distinct] 속성명 <=그룹함수 사용 가능
from 테이블명
[where 데이터 조건       <=그룹함수 사용 불가능
group by 그룹할 속성명
having 그룹조건          <=그룹함수 사용 가능
order by 정렬한 속성명 ASC|DESC];
--------------------------------------------------------------------------------
*부속질의문(subquery)
select                          <= main query
from
where 속성명 연산자 (select     <= subquery
                     from       );
--------------------------------------------------------------------------------
*연산자
- 단일행 연산자 : =, !=, <>, >, <, >=, <=
- 다중행 연산자 : in
--------------------------------------------------------------------------------

6.turner 사원과 같은 부서번호에 소속된 사원의 사원번호, 사원명을 보이시오.

(1)
select deptno
from emp
where ename = 'TURNER';

(2)
select empno 사원번호, ename 사원명
from emp
where deptno = 30;

select empno 사원번호, ename 사원명
from emp
where deptno = (select deptno from emp where ename = 'TURNER');

7.martin 사원과 같은 직무를 갖는 사원의 사원명, 급여를 보이시오.

(1)
select job
from emp
where ename = 'MARTIN';

(2)
select ename 사원명, sal 급여
from emp
where job = 'SALESMAN';

select ename 사원명, sal 급여
from emp
where job = (select job from emp where ename = 'MARTIN');

8.allen과 같은 관리자사번을 갖는 사원의 사원번호, 사원명,관리자사번을 보이시오.

select empno 사원번호, mgr 관리자사번
from emp
where mgr = (select mgr from emp where ename = 'ALLEN');

9.blake 사원의 직무와 같지 않은 직무를 갖는 사원의 사원명,직무, 급여를 보이시오.

select ename 사원명, job 직무, sal 급여
from emp
where job != (select job from emp where ename = 'BLAKE');

10.blake 사원의 급여보다 큰 급여를 받는 사원의 사원명, 급여를 보이시오.

select ename 사원명, sal 급여
from emp
where sal > (select sal from emp where ename = 'BLAKE');

11.보너스가 존재하는 사원과 같은 부서번호를 갖는 사원의 사원명,부서번호,사원번호를 보이시오.

select ename 사원명, deptno 부서번호, empno 사원번호
from emp
where deptno in (select deptno from emp where comm is not null);

12.급여가 2000 이상이고 4000 이하인 사원과 같은 직무를 갖는 사원의 직무, 사원명을 보이시오.

select job 직무, ename 사원명
from emp
where job in (select job from emp where sal between 2000 and 4000);

13.급여평균보다 높은 급여를 받는 사원의 사원명, 급여, 직무를 보이시오.

select ename 사원명, sal 급여, job 직무
from emp
where sal > (select avg(sal) from emp);

14.부서번호가 10 또는 30인 사원의 급여평균보다 낮은 급여를 받는 사원의 사원명, 급여, 부서번호를 보이시오.

select ename 사원명, sal 급여, deptno 부서번호
from emp
where sal < (select avg(sal) from emp where deptno in (10, 30));

15.직무가 manager 이거나 clerk인 사원이 소속된 부서의 부서번호, 부서명, 위치를 보이시오.

select deptno 부서번호, dname 부서명, loc 위치
from dept
where deptno in (select deptno from emp where job in ('MANAGER', 'CLERK'));

16.부서명이 research 인 부서에 소속된 사원의 사원번호, 사원명, 급여를 보이시오.

select deptno 사원번호, ename 사원명, sal 급여
from emp
where deptno = (select deptno from dept where dname = ('RESEARCH'));

17. miller 사원이 소속된 부서의 부서명, 위치를 보이시오.

select dname 부서명, loc 위치
from dept
where deptno = (select deptno from emp where ename = 'MILLER');

18. TURNER의 관리자 사번에 해당하는 사원의 사원번호, 사원명을 보이시오.

select empno 사원번호, ename 사원명
from emp
where empno = (select mgr from emp where ename = 'TURNER');

19. 사원의 사원수, 급여합계, 급여평균을 보이시오.

select count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp;

20. 부서번호별 사원의 사원수, 급여합계, 급여평균을 보이시오.

select deptno 부서번호, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp
group by deptno;

21. 직무별 사원의 사원수, 급여합계, 급여평균을 보이시오.

select job 직무, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp
group by job;

22. 부서번호별 직무별 사원의 사원수, 급여합계, 급여평균을 보이시오.

select deptno 부서번호, job 직무, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp
group by deptno, job
order by deptno ASC, job ASC;

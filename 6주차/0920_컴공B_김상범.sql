0920_컴공B_김상범

*SQL로 쓰시오.
a. chicago에 위치하고 있는 부서에 소속된 사원중 사원명이 W로 시작하는
   사원의 사원명, 급여, 부서번호를 보이시오.

select ename 사원명, sal 급여, deptno 부서번호
from emp
where deptno = (select deptno from dept where loc = 'CHICAGO');

b. 부서번호가 10 또는 20 인 사원의 최소급여보다 높은 급여를 받는 사원이 속한
   부서의 부서번호, 부서명, 위치를 보이시오.

select deptno 부서번호, dname 부서명, loc 위치
from dept
where deptno in(select deptno from emp where sal > (select min(sal) from emp where deptno in(10, 20)));

c. 부서명이 sales에 소속된 사원의 급여평균보다 크거나 많은 급여를 받는 사원의
   직무, 사원명, 급여를 보이시오.

select job 직무, ename 사원명, sal 급여
from emp
where sal > (select avg(sal) from emp where deptno = (select deptno from dept where dname = 'SALES'));

--------------------------------------------------------------------------------
*SELECT 절
(5) select [distinct] 속성명 <=그룹함수 사용 가능
(1) from 테이블명
(2) [where 데이터 조건       <=그룹함수 사용 불가능!!
(4) group by 그룹할 속성명
(3) having 그룹조건          <=그룹함수 사용 가능
(6) order by 정렬한 속성명 ASC|DESC];

*그룹함수 : count(*) / sum(속성) / avg(속성) / min(속성) / max(속성)
--------------------------------------------------------------------------------

1. 직무의 수를 중복없이 보이시오. (열별칭: 직무의 수)

select count(distinct job) as "직무의 수"
from emp;

2. 사원수, 최소급여, 최대급여를 보이시오.

select count(*) 사원수, min(sal) 최소급여, max(sal) 최대급여
from emp;

3. 직무별 사원수, 최소급여, 급여합계, 급여평균을 보이시오.

select job 직무, count(*) 사원수, min(sal) 최소급여, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp
group by job;

x. 사원수가 낮은순부터 높은순으로 정렬 - 오름차순 : ASC, 생략가능

select job 직무, count(*) 사원수, min(sal) 최소급여, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp
group by job
order by 사원수 ASC, 직무 ASC;

y. 사원수가 높은순부터 낮은순으로 정렬 - 내림차순 : DESC, 생략 불가능

select job 직무, count(*) 사원수, min(sal) 최소급여, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp
group by job
order by count(*) DESC;

3a. 사원수가 4인 데이터

select job 직무, count(*) 사원수, min(sal) 최소급여, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp
group by job
having count(*) = 4;

3b. 직무가 manager이거나 salesman이거나 clerk인 데이터

select job 직무, count(*) 사원수, min(sal) 최소급여, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp
where job in('MANAGER', 'SALESMAN', 'CLERK')
group by job;
--having job in('MANAGER', 'SALESMAN', 'CLERK');

3c. 급여합계가 5000이상 8300이하인 데이터

select job 직무, count(*) 사원수, min(sal) 최소급여, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp
group by job
having sum(sal) between 5000 and 8300;

3d. 사원수가 3명 미만이고 급여가 3400 이상인 데이터

select job 직무, count(*) 사원수, min(sal) 최소급여, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp
where sal >= 3400
group by job
having count(*) < 3;

3e. 최소급여가 1500 미만이거나 2900 초과인 데이터

select job 직무, count(*) 사원수, min(sal) 최소급여, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp
group by job
having min(sal) not between 1500 and 2900;

3f. 사원명이 A로 시작하지 않고 급여평균이 5000 미만인 데이터

select job 직무, count(*) 사원수, min(sal) 최소급여, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp
where ename not like 'A%'
group by job
having avg(sal) < 5000;

3g. 입사년도가 81년도가 아니거나 관리자사번이 존재하지 않는 데이터

select job 직무, count(*) 사원수, min(sal) 최소급여, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp
where hiredate like '81%' or mgr is null
group by job;

4. 부서번호별 사원수, 급여합계를 보이시오.

select deptno 부서번호, count(*) 사원수, sum(sal) 급여합계
from emp
group by deptno;

5. 직무별 부서번호별 사원수, 최소급여, 최대급여, 급여합계를 보이시오.

select job 직무, deptno 부서번호, count(*) 사원수, min(sal) 최소급여, max(sal) 최대급여, sum(sal) 급여합계
from emp
group by job, deptno;

5-1. 직무로 오름차순, 부서번호로 오름차순 정렬

select job 직무, deptno 부서번호, count(*) 사원수, min(sal) 최소급여, max(sal) 최대급여, sum(sal) 급여합계
from emp
group by job, deptno
order by job ASC, deptno ASC;

5-2. 직무로 오름차순, 부서번호로 내림차순 정렬

select job 직무, deptno 부서번호, count(*) 사원수, min(sal) 최소급여, max(sal) 최대급여, sum(sal) 급여합계
from emp
group by job, deptno
order by job ASC, deptno DESC;

5-3. 직무로 내림차순, 부서번호로 오름차순 정렬

select job 직무, deptno 부서번호, count(*) 사원수, min(sal) 최소급여, max(sal) 최대급여, sum(sal) 급여합계
from emp
group by job, deptno
order by job DESC, deptno ASC;

5-4. 직무로 내림차순, 부서번호로 내림차순 정렬

select job 직무, deptno 부서번호, count(*) 사원수, min(sal) 최소급여, max(sal) 최대급여, sum(sal) 급여합계
from emp
group by job, deptno
order by job DESC, deptno DESC;

5-5. 사원수가 1인 데이터 / 급여합계가 높은순부터 보이기

select job 직무, deptno 부서번호, count(*) 사원수, min(sal) 최소급여, max(sal) 최대급여, sum(sal) 급여합계
from emp
group by job, deptno
having count(*) = 1
-- order by sum(sal) DESC;
order by 급여합계 DESC;

5-6. 부서번호가 20 또는 30이고 직무가 ANALYST 또는 CLERK / 사원수가 낮은순부터 보이기

select job 직무, deptno 부서번호, count(*) 사원수, min(sal) 최소급여, max(sal) 최대급여, sum(sal) 급여합계
from emp
where deptno in(20, 30) and job in('ANALYST', 'CLERK')
group by job, deptno
-- having deptno in(20, 30) and job in('ANALYST', 'CLERK')
-- order by count(*) ASC;
order by 사원수 ASC;

5-7. 부서명이 SALES 또는 ACCOUNTING 인 데이터 / 부서번호 내림차순, 최소급여 오름차순

select job 직무, deptno 부서번호, count(*) 사원수, min(sal) 최소급여, max(sal) 최대급여, sum(sal) 급여합계
from emp
where deptno in(select deptno from dept where dname in('SALES', 'ACCOUNTING'))
group by job, deptno
-- order by deptno ASC, min(sal) DESC;
order by deptno DESC, 최소급여 ASC;

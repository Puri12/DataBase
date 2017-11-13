0927_컴공B_김상범

1. 사원의 모든 정보를 보이시오.
select *
from emp;

2. 부서테이블에서 부서명, 위치를 보이시오.
select dname 부서명, loc 위치
from dept;

3. 급여가 3000 이상이고 사원명에 S가 포함된 사원의 사원명, 직무, 급여를 보이시오.
select ename 사원명, job 직무, sal 급여
from emp
where sal >= 3000 and ename like '%S%';

4. 부서명이 accounting 인 부서에 속한 사원의 사원수, 급여합계를 구하시오.
select count(*) 사원수, sum(sal) 급여합계
from emp
where deptno = (select deptno from dept where dname = 'ACCOUNTING');

5. 부서번호별 사원수, 최소급여를 사원수로 내림차순 정렬하여 보이시오.
select deptno 부서번호, count(*) 사원수, min(sal) 최소급여
from emp
group by deptno
order by count(*) DESC;

6. 급여가 2000 이상이고 4000 이하인 데이터의 부서별 사원수, 최대급여를 최대급여가
  높은 순부터 보이시오.
select deptno, count(*) 사원수, max(sal) 최대급여
from emp
where sal between 2000 and 4000
group by deptno
order by max(sal) DESC;

*그룹함수(집단함수)
count(*), min(sal), max(sal), avg(sal), sum(sal)

7. 직무가 manager이거나 saleman인 사원의 평균급여 이상의 평균급여의 직무별 사원수,
  최소급여,최대급여를 보이시오.
select job 직무, count(*) 사원수, min(sal) 최소급여, max(sal) 최대급여
from emp
group by job
having avg(sal) >= (select avg(sal) from emp where job in ('MANAGER', 'SALESMAN'));

8. 급여합계가 3000 이상인 직무별 사원수, 급여합계, 급여평균을 보이시오.
select job 직무, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp
group by job
having sum(sal) >= 3000;

9. 81년도 6월부터 12월에 입사한 사원의 직무별 부서번호별 사원수, 평균급여를 입사일자로
  오름차순 정렬하여 보이시오.
select  job 직무, deptno 부서번호, count(*) 사원수, avg(sal) 평균급여, hiredate 입사일자
from emp
where hiredate between '81/06/01' and '81/12/31'
group by job, deptno, hiredate
order by hiredate ASC;

10. 부서가 chicago 또는 dallas 에 위치하고 사원명이 A로 시작하는 사원의 평균급여보다
  높은 급여를 받는 데이터에 대해 직무별 사원수, 최소급여,최대급여를 사원수가 높은
  순부터 보이시오.
select job 직무, count(*) 사원수, min(sal) 최소급여, max(sal) 최대급여
from emp
where deptno in(select deptno from dept where loc in('CHICAGO', 'DALLAS')) and sal > (select avg(sal) from emp where ename like 'A%')
group by job
order by count(*) DESC;

11. 직무, 사원명, 급여를 직무를 기준으로 오름차순 정렬하여 보이시오.
select job 직무, ename 사원명, sal 급여
from emp
order by job ASC;

12. 부서가 CHICAGO나 DALLAS에 위치한 사원의 사원명, 직무, 급여를 보이시오. (where 조건포함)
select ename 사원명, job 직무, sal 급여
from emp
where deptno in(select deptno from dept where loc in('CHICAGO', 'DALLAS'));

13. 평균 급여가 2000이상 4000이하인 사원을 부서번호별로 사원수, 급여평균, 부서번호를 구하시오. (group by, having 조건포함)
select count(*) 사원수, avg(sal) 급여평균, deptno 부서번호
from emp
group by deptno
having avg(sal) between 2000 and 4000;

14. 관리자 사번이 존재하고 평균급여가 1000이상인 데이터의 직무, 사원수, 급여평균, 급여합계를 직무별로 오름차순 정렬하시오. (전부포함)
select job 직무, count(*) 사원수, avg(sal) 급여평균, sum(sal) 급여합계
from emp
where mgr is not null
group by job
having avg(sal) >= 1000
order by job ASC;

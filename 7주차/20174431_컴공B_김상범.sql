--학번 : 20174431, 이름 : 김상범
<< 컴공B_레포트#3 >>

--학번 : 20174431, 이름 : 김상범
1.부서번호가 10 또는 20 또는 30이고 사원명이 W로 시작하는 사원의 사원번호,입사일자,사원명을 보이시오.
select empno 사원번호, hiredate 입사일자, ename 사원명
from emp
where deptno in (10, 20, 30) and ename like 'W%';

--학번 : 20174431, 이름 : 김상범
2.직무가 salesman인 사원의 급여평균보다 크거나 같은 급여를 받는 사원의 사원번호, 부서번호, 급여,직무를 보이시오.
select empno 사원번호, deptno 부서번호, sal 급여, job 직무
from emp
where sal >= (select avg(sal) from emp where job like 'SALESMAN');

--학번 : 20174431, 이름 : 김상범
3.부서번호별 사원수,최대급여,급여합계를 사원수가 작은 순부터 보이시오.
select deptno 부서번호, count(*) 사원수, max(sal) 최대급여, sum(sal) 급여합계
from emp
group by deptno
order by deptno desc;

--학번 : 20174431, 이름 : 김상범
4.부서가 chicago 또는 boston에 위치한 부서에 소속된 사원의 입사일자, 직무,사원명, 관리자사번를 보이시오.
select hiredate 입사일자, job 직무, ename 사원명, mgr 관리자사번
from emp
where deptno in (select deptno from dept where loc in ('CHICAGO', 'BOSTON'));

--학번 : 20174431, 이름 : 김상범
5.최대급여가 1900 이상이고 4900 이하인 데이터에 대해 부서번호별 사원수, 급여합계, 최대급여를 데이터를, 사원수가 많은 순부터 보이시오.
select deptno 부서번호, count(*) 사원수, sum(sal) 급여합계, max(sal) 최대급여
from emp
group by deptno
having max(sal) between 1900 and 4900
order by count(*) DESC;

--학번 : 20174431, 이름 : 김상범
6.관리자사번이 존재하고 사원수가 2이상인 데이터에 대해, 부서번호별 직무별 사원수,
  최소급여,최대급여,급여합계,급여평균을 부서번호가 작은 순부터 보이고 같은 부서번호는 직무로 내림차순 정렬하여 보이시오.
select deptno 부서번호, job 직무, count(*) 사원수, min(sal) 최소급여, max(sal) 최대급여, sum(sal) 급여합계, avg(sal) 급여평균
from emp
where mgr is not null
group by deptno, job
having count(*) >= 2
order by job DESC;

--학번 : 20174431, 이름 : 김상범
7.직무가 clerk가 아니고 analyst도 아닌 사원의 직무별 최대급여, 급여합계, 보너스 합계를 급여합계가 5500이상 9900이하인 데이터에 대해 보이되,
  급여합계가 낮은순부터 정렬하여 보이시오.(단, 보너스가 null이면 200으로 계산하시오.)
select job 직무, max(sal) 최대급여, sum(sal) 급여합계, sum(nvl(comm,200)) 보너스합계
from emp
where job not in ('CLERK', 'ANALYST')
group by job
having sum(sal) between 5500 and 9900
order by sum(sal) ASC;

--학번 : 20174431, 이름 : 김상범
8.81년도에 입사한 사원의 직무별 최소급여가 2000 보다 큰 사원의 직무, 최소급여, 최대급여를 직무를 기준으로 오름차순 정렬하여 보이시오.
select job 직무, min(sal) 최소급여, max(sal) 최대급여
from emp
where hiredate like '81%'
group by job
having min(sal) > 2000
order by job ASC;

--학번 : 20174431, 이름 : 김상범
9.부서번호가 30에 속하지 않고 급여합계가 3200 미만이거나 4800 초과인 데이터에 대해 사원의 직무별 사원수, 최대급여, 최소급여,급여합계를 보이시오.
select job 직무, count(*) 사원수, max(sal) 최대급여, min(sal) 최소급여, sum(sal) 급여합계
from emp
where deptno != 30
group by job
having sum(sal) not between 3200 and 4800;

--학번 : 20174431, 이름 : 김상범
10.사원명에 S가 포함되거나 W가 포함된 데이터에 대해 부서번호별 사원수, 급여합계, 급여평균을 부서번호로 내림차순 정렬하여 보이시오.
select deptno 부서번호, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp
where ename like '%S%' or ename like '%W%'
group by deptno;

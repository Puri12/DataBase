1101_컴공B_김상범

* non-equi JOIN
- 조인 조건에 특정범위 내에 있는지를 조사하기 위해서 where 절에 조인 조건을 =연산자 이외의 비교 연산자를 사용하는 조인

* 급호 테이블의 모든 정보 보이기
select * from salgrade;

1. smith 사원의 급여에 대한 등급을 보이시오.

select ename 사원명, sal 급여, grade 등급
from emp, salgrade
where ename = 'SMITH' and sal between losal and hisal;

2. 모든 사원의 사원명, 등급, 급여를 보이시오.

select ename 사원명, grade 등급, sal 급여
from emp, salgrade
where sal between losal and hisal;

2a. 부서명 속성 추가

(1)동일조인1

select ename 사원명, grade 등급, sal 급여, dname 부서명
from emp, salgrade, dept
where sal between losal and hisal and emp.deptno = dept.deptno;

(2)동일조인2

select ename 사원명, grade 등급, sal 급여, dname 부서명
from emp join dept on(emp.deptno = dept.deptno), salgrade
where sal between losal and hisal;

(3)자연조인1

select ename 사원명, grade 등급, sal 급여, dname 부서명
from emp natural join dept, salgrade
where sal between losal and hisal;

(4)자연조인2

select ename 사원명, grade 등급, sal 급여, dname 부서명
from emp join dept using(deptno), salgrade
where sal between losal and hisal;

3. 급여등급별 사원수, 급여합계, 급여평균을 등급이 낮은 순부터 보이시오.

select grade 등급, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp, salgrade
where sal between losal and hisal
group by grade
order by grade ASC;

3a. 사원수가 1 이상 3 이하

select grade 등급, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp, salgrade
where sal between losal and hisal
group by grade
having count(*) between 1 and 3
order by grade ASC;

3b. 부서번호가 10 또는 30 이고 81년도에 입사

select grade 등급, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp, salgrade
where sal between losal and hisal and deptno in(10, 30) and hiredate like '81%'
group by grade
order by grade ASC;

3c. 직무가 manager 또는 analyst 이고 급여가 3000 미만

select grade 등급, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp, salgrade
where sal between losal and hisal and job in('MANAGER', 'ANALYST') and sal < 3000
group by grade
order by grade ASC;

3d. 사원명에 t가 포함되고 급여합계가 1400 이상 3100 이하

select grade 등급, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp, salgrade
where sal between losal and hisal and ename like '%T%'
group by grade
having sum(sal) between 1400 and 3100
order by grade ASC;

3e. 소속된 부서명이 operations가 아니고 sales가 아닌 사원

select grade 등급, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp, salgrade
where sal between losal and hisal and deptno not in(select deptno from dept where dname in('OPERATIONS', 'SALES'))
group by grade
order by grade ASC;

3f. 부서명 속성 추가, 급여합계가 manager 직무를 가진 사원의 급여합계 보다 큰
(1)동일조인1

select grade 등급, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균, dname 부서명
from emp, dept, salgrade
where sal between losal and hisal and emp.deptno = dept.deptno
group by grade, dname
having sum(sal) > (select sum(sal) from emp where job = 'MANAGER')
order by grade ASC;

(2)동일조인2

select grade 등급, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균, dname 부서명
from emp join dept on(emp.deptno = dept.deptno), salgrade
where sal between losal and hisal
group by grade, dname
having sum(sal) > (select sum(sal) from emp where job = 'MANAGER')
order by grade ASC;

(3)자연조인1

select grade 등급, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균, dname 부서명
from emp natural join dept, salgrade
where sal between losal and hisal
group by grade, dname
having sum(sal) > (select sum(sal) from emp where job = 'MANAGER')
order by grade ASC;

(4)자연조인2

select grade 등급, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균, dname 부서명
from emp join dept using(deptno), salgrade
where sal between losal and hisal
group by grade, dname
having sum(sal) > (select sum(sal) from emp where job = 'MANAGER')
order by grade ASC;

4. 급여등급이 3등급인 사원의 직무, 부서번호,부서명을 보이시오.
(1)동일조인1

select job 직무, emp.deptno 부서번호, dname 부서명
from emp, dept, salgrade
where emp.deptno = dept.deptno and sal between losal and hisal and grade = 3;

(2)동일조인2

select job 직무, emp.deptno 부서번호, dname 부서명
from emp join dept on(emp.deptno = dept.deptno), salgrade
where sal between losal and hisal and grade = 3;

(3)자연조인1

select job 직무, deptno 부서번호, dname 부서명
from emp natural join dept, salgrade
where sal between losal and hisal and grade = 3;

(4)자연조인2

select job 직무, deptno 부서번호, dname 부서명
from emp join dept using(deptno), salgrade
where sal between losal and hisal and grade = 3;


5. 직무가 president 인 사원의 등급, 사원명, 부서명을 보이시오.
(1)동일조인1

select grade 등급, ename 사원명, dname 부서명
from emp, dept, salgrade
where sal between losal and hisal and job = 'PRESIDENT' and emp.deptno = dept.deptno;

(2)동일조인2

select grade 등급, ename 사원명, dname 부서명
from emp join dept on(emp.deptno = dept.deptno), salgrade
where sal between losal and hisal and job = 'PRESIDENT';

(3)자연조인1

select grade 등급, ename 사원명, dname 부서명
from emp natural join dept, salgrade
where sal between losal and hisal and job = 'PRESIDENT';

(4)자연조인2

select grade 등급, ename 사원명, dname 부서명
from emp join dept using(deptno), salgrade
where sal between losal and hisal and job = 'PRESIDENT';

6. 2이상 4이하 등급에 속한 사원의 등급별 부서명, 사원수, 최대급여, 급여합계를 보이되,
     급여등급이 낮은 순부터 보이고, 같은 급여등급은 부서명으로 내림차순정렬하여 보이시오.
(1)동일조인1

select grade 등급, dname 부서명, count(*) 사원수, max(sal) 최대급여, sum(sal) 급여합계
from emp, dept, salgrade
where sal between losal and hisal and grade between 2 and 4 and emp.deptno = dept.deptno
group by grade, dname
order by grade ASC, dname DESC;

(2)동일조인2

select grade 등급, dname 부서명, count(*) 사원수, max(sal) 최대급여, sum(sal) 급여합계
from emp join dept on(emp.deptno = dept.deptno), salgrade
where sal between losal and hisal and grade between 2 and 4
group by grade, dname
order by grade ASC, dname DESC;

(3)자연조인1

select grade 등급, dname 부서명, count(*) 사원수, max(sal) 최대급여, sum(sal) 급여합계
from emp natural join dept, salgrade
where sal between losal and hisal and grade between 2 and 4
group by grade, dname
order by grade ASC, dname DESC;

(4)자연조인2

select grade 등급, dname 부서명, count(*) 사원수, max(sal) 최대급여, sum(sal) 급여합계
from emp join dept using(deptno), salgrade
where sal between losal and hisal and grade between 2 and 4
group by grade, dname
order by grade ASC, dname DESC;

--사원수가 1명 초과이고 급여합계가 8000 미만
select grade 등급, dname 부서명, count(*) 사원수, max(sal) 최대급여, sum(sal) 급여합계
from emp, dept, salgrade
where sal between losal and hisal and grade between 2 and 4 and emp.deptno = dept.deptno
group by grade, dname
having count(*) > 1 and sum(sal) < 8000
order by grade ASC, dname DESC;

7.부서번호별 부서명,급여등급, 사원수,급여합계,급여평균을 보이시오.
(1)동일조인1

select emp.deptno 부서번호, dname 부서명, grade 급여등급, count(*) 사원수, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp, dept, salgrade
where sal between losal and hisal and emp.deptno = dept.deptno
group by emp.deptno, dname, grade;

(2)동일조인2

select emp.deptno 부서번호, dname 부서명, grade 급여등급, count(*) 사원수, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp join dept on(emp.deptno = dept.deptno), salgrade
where sal between losal and hisal
group by emp.deptno, dname, grade;

(3)자연조인1

select deptno 부서번호, dname 부서명, grade 급여등급, count(*) 사원수, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp natural join dept, salgrade
where sal between losal and hisal
group by deptno, dname, grade;

(4)자연조인2

select deptno 부서번호, dname 부서명, grade 급여등급, count(*) 사원수, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp join dept using(deptno), salgrade
where sal between losal and hisal
group by deptno, dname, grade;

-- 부서번호가 큰 순부터 보이고, 같은 부서번호에 대해서 등급은 낮은 순부터 보이시오.
(1)동일조인1

select emp.deptno 부서번호, dname 부서명, grade 급여등급, count(*) 사원수, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp, dept, salgrade
where sal between losal and hisal and emp.deptno = dept.deptno
group by emp.deptno, dname, grade
order by emp.deptno DESC, grade ASC;

(2)동일조인2

select emp.deptno 부서번호, dname 부서명, grade 급여등급, count(*) 사원수, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp join dept on(emp.deptno = dept.deptno), salgrade
where sal between losal and hisal
group by emp.deptno, dname, grade
order by emp.deptno DESC, grade ASC;

(3)자연조인1

select deptno 부서번호, dname 부서명, grade 급여등급, count(*) 사원수, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp natural join dept, salgrade
where sal between losal and hisal
group by deptno, dname, grade
order by deptno DESC, grade ASC;

(4)자연조인2

select deptno 부서번호, dname 부서명, grade 급여등급, count(*) 사원수, sum(sal) 급여합계, round(avg(sal)) 급여평균
from emp join dept using(deptno), salgrade
where sal between losal and hisal
group by deptno, dname, grade
order by deptno DESC, grade ASC;


--------------------------------------------------------------------------------
* Self JOIN - 자기 자신과의 조인
--------------------------------------------------------------------------------

1. MILLLER 사원의 관리자의 사원명을 보이시오.

select ename
from emp
where empno = (select mgr from emp where ename = 'MILLER');

(1)동일조인1

select e1.ename
from emp e1, emp e2
where e1.empno = e2.mgr and e2.ename = 'MILLER';

(2)동일조인2

select e1.ename
from emp e1 join emp e2 on (e1.empno = e2.mgr)
where e2.ename = 'MILLER';

2. SCOTT 사원과 같은 직무를 같는 사원의 사원명, 급여를 보이시오.(SCOTT사원 제외)

select ename 사원명, sal 급여
from emp
where job = (select job from emp where ename = 'SCOTT') and ename != 'SCOTT'

(1)동일조인1

select e1.ename, e1.sal
from emp e1, emp e2
where e1.job = e2.job and e2.ename = 'SCOTT' and e1.ename != 'SCOTT';

(2)동일조인2

select e1.ename, e1.sal
from emp e1 join emp e2 on(e1.job = e2.job)
where e2.ename = 'SCOTT' and e1.ename != 'SCOTT';

3. jones사원의 사원번호, 사원명, 관리자 사번, 관리자 사원명을 보이시오.

(1)동일조건1
select e1.empno 사원번호, e1.ename 사원명, e1.mgr 관리자사번, e2.ename 관리자사원명
from emp e1, emp e2
where e1.mgr = e2.empno and e1.ename = 'JONES';

(1)동일조건2
select e1.empno 사원번호, e1.ename 사원명, e1.mgr 관리자사번, e2.ename 관리자사원명
from emp e1 join emp e2 on(e1.mgr = e2.empno)
where e1.ename = 'JONES';

4. BLAKE가 관리자인 사원들의 사원번호, 사원명, 직무를 보이시오.
select empno 사원번호, ename 사원명, job 직무
from emp
where mgr = (select empno from emp where ename = 'BLAKE');

(1)동일조건1
select e1.empno 사원번호, e1.ename 사원명, e1.job 직무
from emp e1, emp e2
where e1.mgr = e2.empno and e2.ename = 'BLAKE';

(1)동일조건2
select e1.empno 사원번호, e1.ename 사원명, e1.job 직무
from emp e1 join emp e2 on(e1.mgr = e2.empno)
where e2.ename = 'BLAKE';

5. MILLER와 같은 부서에 근무하는 사원의 사원명, 부서번호, 부서명을 보이시오.
select ename 사원명, deptno 부서번호
from emp, dept
where deptno = (select deptno from emp where ename = 'MILLER') and emp.deptno = dept.deptno;

(1)동일조인1
select e1.ename 사원명, e1.deptno 부서번호, d.dname 부서명
from emp e1, emp e2, dept d
where e1.deptno = e2.deptno and e1.deptno = d.deptno and e2.ename = 'MILLER';

(2)동일조인2
select e1.ename 사원명, e1.deptno 부서번호, d.dname 부서명
from emp e1 join emp e2 on(e1.deptno = e2.deptno) join dept d on(e1.deptno = d.deptno)
where e2.ename = 'MILLER';

6. 부서번호가 30이 아닌 사원의 급여평균보다 큰 급여를 받는 사원의 사원번호 사원명, 급여, 부서번호, 부서명을 보이시오.
select empno 사원번호, ename 사원명, sal 급여, deptno 부서번호, dname 부서명
from emp natural join dept
where sal > (select avg(sal) from emp where deptno != 30);

7. 부서명이 research인 부서에 소속되지 않은 사원의 직무별 부서번호, 부서명, 사원수,
   급여합계, 급여평균을 사원수가 2명 이상인 데이터에 대해 급여합계가 높은 순부터 보이시오
select job 직무, deptno 부서번호, dname 부서명, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp join dept using(deptno)
where dname != 'RESEARCH'
group by job, deptno, dname
having count(*) >= 2
order by sum(sal) DESC;

select job 직무, deptno 부서번호, dname 부서명, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp join dept using(deptno)
where deptno != (select deptno from dept where dname = 'RESEARCH')
group by job, deptno, dname
having count(*) >= 2
order by sum(sal) DESC;

select job,emp.deptno 부서번호,dname 부서명,count(*) 사원수,sum(sal) 급여합계,avg(sal) 급여평균
from emp join dept on(emp.deptno=dept.deptno)
where dname !='RESEARCH'
group by job,dname,emp.deptno
having count(*) >= 2
order by sum(sal) desc;

--------------------------------------------------------------------------------
* outer join - 외부조인 : 자연조인한 결과에 조인이 안된 튜플을 포함시킴
--------------------------------------------------------------------------------
- 전체 외부조인 full outer JOIN
- 왼쪽 외부조인 left outer JOIN
- 오른쪽 외부조인 right outer JOIN

*본인 정보 삽입
insert into 테이블명 (속성명1, 속성명2, ...)
values(값1, 값2, ...);

* emp 테이블에 empno는 9999, ename 김상범을 삽입하시오.
insert into emp(empno, ename)
  values(9999, '김상범');

* emp 테이블과 dept테이블 자연조인
(1)자연조인1
select *
from emp natural join dept;

(2)자연조인2
select *
from emp join dept using(deptno);

* 전체 외부조인
select *
from emp full outer join dept on(emp.deptno = dept.deptno);
select *
from emp full outer join dept using(deptno);

* emp테이블에서 조인이 안된 튜플 포함한 외부조인
select *
from emp left outer join dept using(deptno);
select *
from dept right outer join emp using(deptno);

* dept테이블에서 조인이 안된 튜플 포함한 외부조인
select *
from dept left outer join emp using(deptno);
select *
from emp right outer join dept using(deptno);

1. 부서번호별 사원수, 급여합계, 급여평균를 부서명과 함께 보이시오. 모든 부서 포함하고 부서번호가 낮은 순부터 보이시오
select deptno 부서번호, dname 부서명, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp right outer join dept using(deptno)
group by deptno, dname
order by deptno;

2. 부서에 소속되지 않은 사원의 사원번호, 사원명을 보이시오.
select empno 사원번호, ename 사원명
from emp left outer join dept using(deptno)
where deptno is null;

3. 소속된 사원이 없는 부서의 부서번호, 부서명, 위치를 보이시오.
select deptno 부서번호, dname 부서명, loc 위치
from dept left outer join emp using(deptno)
where empno is null;

4. 부서명이 sales인 부서에 소속되지 않은 사원의 사원번호, 사원명, 부서명을 소속된 부서가 없는 사원도 함께 보이시오.
select empno 사원번호, ename 사원명, dname
from emp left outer join dept using(deptno)
where dname != 'SALES' or deptno is null;

5. 직무별 평균급여가 직무가 salesman 인 사원의 평균급여보다 높은 사원의 직무별 부서명별, 사원수, 급여합계, 평균급여를 사원수가 낮은 순부터 보이시오.
select job 직무, dname 부서명, count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp join dept using(deptno)
group by job, dname
having avg(sal) > (select avg(sal) from emp where job = 'SALESMAN')
order by 사원수 ASC;

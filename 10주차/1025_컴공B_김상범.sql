*관계대수: what/how 명세 절차적 언어
1. 순수관계 연산자: select, project, join, division
2. 일반집합 연산자: 합집합, 교집합, 차집합, 카테션프로덕트

*관계해석: what 명세 비절차적 언어
1. 튜플관계 해석
2. 도메인관계 해석

*일반집합 연산자
1. 합집합(union)
select empno from emp
UNION
select dname, deptno from dept;
=> 실행 불가능: 차수가 다름

select empno, ename from emp
UNION
select dname, deptno from dept;
=> 실행 불가능: 대응되는 도메인 다름

select empno, ename from emp
UNION --중복 미포함
select deptno, dname from dept;

select distinct deptno from emp -- 10, 20, 30
UNION ALL --중복 포함
select deptno from dept; -- 10, 20, 30, 40

2. 교집합(intersect)
select distinct deptno from emp -- 10, 20, 30
INTERSECT
select deptno from dept; -- 10, 20, 30, 40

3. 차집합(minus) --교환법칙 X
select deptno from dept -- 10, 20, 30
MINUS
select distinct deptno from emp; -- 10, 20, 30, 40

4. 카테션프로덕트(cartesian product)
- 조인 조건이 없는 조인, 크로스 조인
부서 X 사원 => dept X emp
select * from dept, emp;
select * from dept cross join emp;

테이블              차수        카디널리티
-----------------------------------------------------------------------
dept                3           4
emp                 8           14
-----------------------------------------------------------------------
dept X emp          11          56
                    (3+8)       (4*14)

*JOIN
1. 동등조인(equi join)

2. 자연조인(natural join)

3. non-equi join

4. self join

5. 외부조인(outer join)


1. 사원과 부서테이블을 조인하시오
(1)동일조인1

select *
from emp, dept
where emp.deptno = dept.deptno;

(2)동일조인2

select *
from emp join dept on(emp.deptno = dept.deptno);

(3)자연조인1

select *
from emp natural join dept;

(4)자연조인2

select *
from emp join dept using(deptno);

2. 급여가 1000 이상이고 3000 이하인 사원의 사원명, 급여, 보너스,
   급여+보너스(열별칭: 합계)를 보이시오.

select ename 사원명, sal 급여, comm 보너스, sal+nvl(comm,0) 합계
from emp
where sal between 1000 and 3000;

2a. 부서명 속성 포함 / 합계가 많은 것부터 보이기
(1)동일조인1

select ename 사원명, sal 급여, comm 보너스, sal+nvl(comm, 0) 합계, dname 부서명
from emp, dept
where sal between 1000 and 3000 and emp.deptno = dept.deptno
order by 합계 DESC;

(2)동일조인2

select ename 사원명, sal 급여, comm 보너스, sal+nvl(comm, 0) 합계, dname 부서명
from emp join dept on(emp.deptno = dept.deptno)
where sal between 1000 and 3000
order by 합계 DESC;

(3)자연조인1

select ename 사원명, sal 급여, comm 보너스, sal+nvl(comm, 0) 합계, dname 부서명
from emp natural join dept
where sal between 1000 and 3000
order by 합계 DESC;

(4)자연조인2

select ename 사원명, sal 급여, comm 보너스, sal+nvl(comm, 0) 합계, dname 부서명
from emp join dept using(deptno)
where sal between 1000 and 3000
order by 합계 DESC;

3. 사원의 사원번호, 사원명, 부서번호, 부서명을 보이시오.
(1)동일조인1

select empno 사원번호, ename 사원명, emp.deptno 부서번호, dname 부서명
from emp, dept
where emp.deptno = dept.deptno;

(2)동일조인2

select empno 사원번호, ename 사원명, emp.deptno 부서번호, dname 부서명
from emp join dept on(emp.deptno = dept.deptno);

(3)자연조인1

select empno 사원번호, ename 사원명, deptno 부서번호, dname 부서명
from emp natural join dept;

(4)자연조인2

select empno 사원번호, ename 사원명, deptno 부서번호, dname 부서명
from emp join dept using(deptno);

4.사원명에 s가 포함되지 않은 사원의 사원명,부서번호, 직무,급여를 보이시오.

select ename 사원명, deptno 부서번호, job 직무, sal 급여
from emp
where ename not like '%S%';

4a.부서명 속성 포함 / 급여가 낮은 것부터 보이기
(1)동일조인1

select ename 사원명, emp.deptno 부서번호, job 직무, sal 급여, dname 부서명
from emp, dept
where ename not like '%S%' and emp.deptno = dept.deptno
order by sal ASC;

(2)동일조인2

select ename 사원명, emp.deptno 부서번호, job 직무, sal 급여, dname 부서명
from emp join dept on(emp.deptno = dept.deptno)
where ename not like '%S%'
order by sal ASC;


(3)자연조인1

select ename 사원명, emp.deptno 부서번호, job 직무, sal 급여, dname 부서명
from emp natural join dept
where ename not like '%S%'
order by sal ASC;

(4)자연조인2

select ename 사원명, emp.deptno 부서번호, job 직무, sal 급여, dname 부서명
from emp join dept using(deptno)
where ename not like '%S%'
order by sal ASC;


5.사원수가 2이상 4이하인 부서번호별 사원수, 급여합계를 보이시오.

select deptno 부서번호, count(*) 사원수, sum(sal) 급여합계
from emp
group by deptno
having count(*) between 2 and 4;

5a.부서명 속성 추가 / 급여합계가 많은 순부터 보이기
(1)동일조인1

select dname 부서명, emp.deptno 부서번호, count(*) 사원수, sum(sal) 급여합계
from emp, dept
where emp.deptno = dept.deptno
group by dname, emp.deptno
having count(*) between 2 and 4
order by sum(sal) DESC;

(2)동일조인2

select dname 부서명, emp.deptno 부서번호, count(*) 사원수, sum(sal) 급여합계
from emp join dept on(emp.deptno = dept.deptno)
group by dname, emp.deptno
having count(*) between 2 and 4
order by sum(sal) DESC;

(3)자연조인1

select dname 부서명, deptno 부서번호, count(*) 사원수, sum(sal) 급여합계
from emp natural join dept
group by dname, deptno
having count(*) between 2 and 4
order by sum(sal) DESC;

(4)자연조인2

select dname 부서명, deptno 부서번호, count(*) 사원수, sum(sal) 급여합계
from emp join dept using(deptno)
group by dname, deptno
having count(*) between 2 and 4
order by sum(sal) DESC;


6.직무가 manager 또는 clerk 인 사원에 대해 부서번호별 사원수, 보너스가 지정된
  사원수, 급여합계, 급여평균을 보이시오.

select deptno 부서번호, count(*) 사원수, count(comm),
       sum(sal) 급여합계, avg(sal) 급여평균
from emp
where job in('MANAGER', 'CLERK')
group by deptno;

6a.부서명 속성 추가 / 사원수가 많은 순부터 보이기
(1)동일조인1

select emp.deptno 부서번호, count(*) 사원수, count(comm),
       sum(sal) 급여합계, avg(sal) 급여평균, dname 부서명
from emp, dept
where job in('MANAGER', 'CLERK') and emp.deptno = dept.deptno
group by emp.deptno, dname;

(2)동일조인2

select emp.deptno 부서번호, count(*) 사원수, count(comm),
       sum(sal) 급여합계, avg(sal) 급여평균, dname 부서명
from emp join dept on(emp.deptno = dept.deptno)
where job in('MANAGER', 'CLERK')
group by emp.deptno, dname;

(3)자연조인1

select deptno 부서번호, count(*) 사원수, count(comm),
       sum(sal) 급여합계, avg(sal) 급여평균, dname 부서명
from emp natural join dept
where job in('MANAGER', 'CLERK')
group by deptno, dname;

(4)자연조인2

select deptno 부서번호, count(*) 사원수, count(comm),
       sum(sal) 급여합계, avg(sal) 급여평균, dname 부서명
from emp join dept using(deptno)
where job in('MANAGER', 'CLERK')
group by deptno, dname;


7.급여가 부서번호 20 또는 30인 사원의 급여평균보다 크거나 같은 사원의 사원번호,
  사원명,부서번호,부서명,위치,급여를 급여가 많은 순부터 보이시오.

(1)동일조인1

select empno 사원번호, ename 사원명, emp.deptno 부서번호, dname 부서명, loc 위치, sal 급여
from emp, dept
where sal >= (select avg(sal) from emp where deptno in(20, 30)) and emp.deptno = dept.deptno
order by sal DESC;

(2)동일조인2

select empno 사원번호, ename 사원명, emp.deptno 부서번호, dname 부서명, loc 위치, sal 급여
from emp join dept on(emp.deptno = dept.deptno)
where sal >= (select avg(sal) from emp where deptno in(20, 30))
order by sal DESC;

(3)자연조인1

select empno 사원번호, ename 사원명, deptno 부서번호, dname 부서명, loc 위치, sal 급여
from emp natural join dept
where sal >= (select avg(sal) from emp where deptno in(20, 30))
order by sal DESC;

(4)자연조인2

select empno 사원번호, ename 사원명, deptno 부서번호, dname 부서명, loc 위치, sal 급여
from emp join dept using(deptno)
where sal >= (select avg(sal) from emp where deptno in(20, 30))
order by sal DESC;


8.보너스가 지정되지 않고 부서명이 accounting인 부서에 소속되지 않은 사원들에 대해
  직무별 부서명,최소급여, 최대급여를 보이되, 직무로 오름차순 정렬하여 보이고 같은
  직무에 대해 부서명은 내림차순으로 보이시오.

(1)동일조인1

select job 직무, dname 부서명, min(sal) 최소급여, max(sal) 최대급여
from emp, dept
where comm is null and emp.deptno in(select deptno from dept where dname != 'ACCOUNTING')
      and emp.deptno = dept.deptno
group by job, dname
order by job ASC, dname DESC;

(2)동일조인2

select job 직무, dname 부서명, min(sal) 최소급여, max(sal) 최대급여
from emp join dept on(emp.deptno = dept.deptno)
where comm is null and emp.deptno in(select deptno from dept where dname != 'ACCOUNTING')
group by job, dname
order by job ASC, dname DESC;

(3)자연조인1

select job 직무, dname 부서명, min(sal) 최소급여, max(sal) 최대급여
from emp natural join dept
where comm is null and deptno in(select deptno from dept where dname != 'ACCOUNTING')
group by job, dname
order by job ASC, dname DESC;

(4)자연조인2

select job 직무, dname 부서명, min(sal) 최소급여, max(sal) 최대급여
from emp join dept using(deptno)
where comm is null and deptno in(select deptno from dept where dname != 'ACCOUNTING')
group by job, dname
order by job ASC, dname DESC;

9.직무가 clerk이 아닌 사원의 최대급여보다 급여가 크거나 같은 사원에 대해 직무별 사원명,
  사원수, 급여합계, 최대급여를 최대급여가 2500 이상인 것만 사원수가 낮은 순부터 보이시오.

select job 직무, ename 사원명, count(*) 사원수, sum(sal) 급여합계, max(sal) 최대급여
from emp join dept on(emp.deptno = dept.deptno)
where sal >= (select max(sal) from emp where job != 'CLERK')
group by job, ename
having max(sal) >= 2500
order by count(*) ASC;

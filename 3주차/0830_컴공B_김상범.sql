0830_컴공B_김상범
*데이터 모델의 구성요소
1. 구조(structure)
2. 연산(operation)
3. 제약조건(constraint)

*데이터 모델
현실 세계 => 개념적 데이터 모델(정보 모델링) => 논리적 데이터 모델(데이터 모델링) => 컴퓨터 세계

*ER모델
사각형 => 개체(entity)
타원 => 속성(attribute)
마름모 => 관계(relationship)

*카디널리티 종류 :
1 : 1 (일대일)
1 : N (일대다)
N : M (다대다)

*논리적 데이터 모델 종류
1. 계층 데이터 모델 : 트리구조, 부모와 자식 관계
2. 네트워크 데이터 모델 : 그래프구조, 오너와 멤버 관계
3. 관계 데이터 모델 : 테이블구조

*select 구문형식
select 속성명(열이름)
from 테이블명 ;

(5)select 속성명
(1)from 테이블명
(2)[where 데이터 조건
(4)group by 그룹할 속성명
(3)having 그룹에 대한 조건
(6)order by 정렬할 속성명 ] ;

*질의문 -> 질의어
1. 사원테이블에서 직무의 개수와 부서번호의 개수를 중복없이 보이시오. (열별칭 : 직무개수, 부서번호개수)

select count(distinct job) 직무개수, 
		count(distinct deptno) 부서번호개수 
from emp;

2. 사원테이블에서 사원수, 급여합계, 급여평균을 보이시오.

select count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp;

3. 000의 직무는 000 입니다.

select ename || '의 직무는' || job || '입니다.'
from emp;

4. 사원명 : 000 / 급여 : 000 / 연봉 : 000
select '사원명 : ' || ename || ' / 급여 : ' || sal || ' / 연봉 : ' || (sal * 12+nvl(comm,0))
from emp;

-----------------------------------------------------------------------------------------
where 속성명 = [!=, <>, >(초과), <(미만), >=(이상), <=(이하)]값
where 조건1 and | or 조건2
where 속성명 between A(작은값) and B(큰 값) -- and연산자와 동일
where 속성명 in(값1, 값2, 값3,...)-- or연산자와 동일

where 속성명 [not]like 문자 'A%' : A로 시작하는 모든 문자 검색
where 속성명 like 문자 '%A' : A로 끝나는 모든 문자 검색
where 속성명 like 문자 '%A%' : A가 포함된 모든 문자 검색
where 속성명 like 문자 '_A%' : 두번째 문자가 A인 모든 문자 검색
-----------------------------------------------------------------------------------------

5. 부서테이블에서 부서명이 research인 모든 정보 검색
select *
from dept
where dname=upper('research');
--where dname=RESEARCH;

6. 사원테이블에서 직무가 manager가 아닌 사원의 모든 정보 검색
select *
from emp
where job != upper('manager');

7. 사원테이블에서 급여가 2000 미만인 사원의 모든 정보 검색
select *
from emp
where sal < 2000;

8. 사원테이블에서 급여가 3200 초과인 사원의 모든 정보 검색
select *
from emp
where sal > 3200;

9. 사원테이블에서 81년 이후에 입사한 사원의 모든 정보 검색
select *
from emp
where hiredate >= '81/01/01';

10. 사원테이블에서 급여가 1900 이상이고 4900 이하인 사원의 사원명, 급여, 입사일자, 사원번호를 보이시오.
select ename 사원명, sal 급여, hiredate 입사일자, empno 사원번호
from emp
where sal between 1900 and 4900;
--where sal >= 1900 and sal <= 4900;

=>급여가 1900 미만이거나 4900 초과
select ename 사원명, sal 급여, hiredate 입사일자, empno 사원번호
from emp
where sal not between 1900 and 4900;
--where sal < 1900 or sal > 4900;

11. 사원테이블에서 직무가 clerk 이거나 manager 이거나 president인 사원의 직무, 사원명, 부서번호 를 보이시오.
select job 직무, ename 사원명, deptno 부서번호
from emp
where job in('CLERK','MANAGER','PRESIDENT');
--where job = upper('clerk') or job = upper('manager') or job = upper('president');

=> 직무가 clerk가 아니거나 manager가 아니거나 president가 아닌 사원
select job 직무, ename 사원명, deptno 부서번호
from emp
where job not in('CLERK','MANAGER','PRESIDENT');
--where job != upper('clerk') or job != upper('manager') or job != upper('president');

12. 사원테이블에서 81년 이전에 입사하고 급여가 2500 미만인 사원의 사원명, 입사일자, 급여를 보이시오.
select ename 사원명, hiredate 입사일자, sal 급여
from emp
where hiredate <= '81/01/01' and sal < 2500;

13. 81년도에 입사한 사원의 입사일자, 사원명을 보이시오.
select hiredate 입사일자, ename 사원명
from emp
where hiredate between '81/01/01' and '81/12/31';
--where hiredate like '81%';
--where hiredate >= '81/01/01' and hiredate <= '81/12/31';

=>81년도에 입사하지 않은 사원의 입사일자, 사원명을 보이시오.
select hiredate 입사일자, ename 사원명
from emp
where hiredate not between '81/01/01' and '81/12/31';
--where hiredate not like '81%';
--where hiredate <= '81/01/01' and hiredate >= '81/12/31';

14. 사원명이 S로 시작하는 사원의 사원명, 급여를 보이시오.
select ename 사원명, sal 급여
from emp
where ename like 'S%';

15. 사원명의 세번째 글자가 L인 사원의 사원명, 직무를 보이시오.
select ename 사원명, job 직무가
from emp
where ename like '__L%';



















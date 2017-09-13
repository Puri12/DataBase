0906_컴공B_김상범

*용어정리
-----------------------------------------------------------------------------------
개념적 데이터 모델 / 논리적 데이터 모델 / 물리적 데이터 모델
				(관계 데이터 모델)
-----------------------------------------------------------------------------------
개체(entity)		Relation		table
속성(attribute)	attribute		columm(열)
관계(realtion)
개체 인스턴스		tuple(튜플)		row(행)
-----------------------------------------------------------------------------------
속성의 수 : 차수(degree)
튜플의 수 : 카디널리티(cardinality, 기수, 대응수)
도메인(Domain) : 한 속성이 가질숭 있는 같은 데이터 타입의 원자값의 집합
-----------------------------------------------------------------------------------

*릴레이션 = 릴레이션 스키마 + 릴레이션 인스턴스

*릴레이션의 특징
1. 튜플의 유일성
2. 튜플의 무순서성
3. 속성의 무순서성
4. 속성의 원자값

*key : 속성 또는 속성의 집합

*키의 특징: 유일성, 최소성

*키의 종류
1. 후보키 : 유일성○, 최소성○
2. 기본키(PK, Primary Key) : 유일성○, 최소성○
3. 대체키(AK) : 유일성○, 최소성○
4. 수퍼키(SK) : 유일성○, 최소성X
5. 외래키(FK, Foreign Key)

*무결성 제약조건(integrity constraint)
1. 개체 무결성(entity integrity)
- 기본키(PK)값은 언제 어느때고 널값을 가질수 없고 중복될수 없다.

2. 참조 무결성(referential integrity)
- 외래키(FK)값은 널값을 갖거나, 참조 릴레이션의 기본키 값과 같은값을 가져야한다.

3. 도메인 무결성(Domain integrity)
- 현실세계에 존재하는 값으로 구성하거나 정의된 범위의 값을로 사용해야 한다.


*SELECT 절
select [distinct] 속성명 <=그룹함수 사용 가능
from 테이블명
[where 데이터 조건       <=그룹함수 사용 불가능
group by 그룹할 속성명
having 그룹조건          <=그룹함수 사용 가능
order by 정렬한 속성명 ASC|DESC];

*그룹함수 : count(*) / sum(속성) / avg(속성) / min(속성) / max(속성)

*NULL : 아직 알려지지 않았음 / 해당사항 없음 (!=0, !=zero)

-----------------------------------------------------------------------------------
A. where 속성명 = [!=, <>, >, <, >=, <=] 값
B. where [not] 조건1 and|or 조건2
C. where 속성명 [not] between A and B		=>and 연산자와 동일
D. where 속성명 [not] in(값1, 값2, 값3)  =>or 연산자와 동일
E. where 속성명 is [not] null            cf. 속성명 = null(x)
F. where 속성명 [not] like 'A%'					=>속성명의 값이 A로 시작
-----------------------------------------------------------------------------------


1. 부서테이블에서 부서의 수를 보이시오. (열별칭 : 부서의 수)
select count(*) "부서의 수"
from dept;

2. 직무가 manager이고 급여가 2000 이상인 사원의 수, 급여합계, 급여평균을 보이시오.
(열별칭 : 사원수, 급여합계, 급여평균)
select count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp
where job like 'MANAGER' and sal >= 2000;

3. 부서번호가 10 또는 20 또는 30 이고 직무가 clerk이 아니고 analyst 가 아니고
salesman이 아닌 사원의 직무, 부서번호, 사원명을 보이시오.
select job 직무, deptno 부서번호, ename 사원명
from emp
where deptno in (10, 20, 30) and job not in('CLERK', 'ANALYST', 'SALESMAN');

4. 사원명에 E가 포함되거나 A가 포함된 사원의 사원명, 사원번호, 입사일자를 보이시오.
select ename 사원명, empno 사원번호, hiredate 입사일자
from emp
where ename like '%E%' and ename like '%A%';

5. 81년 3월부터 6월에 입사하지 않은 사원중 직무가 CLERK인 사원의 입사일자, 직무,
사원명, 사원번호를 보이시오.
select hiredate 입사일자, job 직무, ename 사원명, empno 사원번호
from emp
where hiredate not between '81/03/01' and '81/06/30' and job = 'CLERK';

6. 사원명 두번째 글자가 A가 아닌 사원중 급여가 2900 이상이고 4900 이하인 사원의
사원명, 급여, 부서번호를 보이시오.
select ename 사원명, sal 급여, deptno 부서번호
from emp
where ename not like '_A' and sal between 2900 and 4900;

7.부서번호가 10 또는 20 이면서 급여가 2900 미만인 사원의 사원수, 급여합계, 급여평균을 보이시오.
select count(*) 사원수, sum(sal) 급여합계, avg(sal) 급여평균
from emp
where deptno in (10, 20) and sal < 2900;

8.사원명에 E를 포함하지 않고 급여가 3000 이상인 사원의 사원명, 급여, 입사일자를 보이시오.
select ename 사원명, sal 급여, hiredate 입사일자
from emp
where ename not like '%E%' and sal >= 3000;

9.급여가 1600 미만 또는 2950 초과인 사원의 사원명, 사원번호, 급여를 보이시오.
select ename 사원명, empno 사원번호,  sal 급여
from emp
where sal not between 1600 and 2950;

10. 81년도에 입사하지 않은 사원 중 직무가 clerk이 아닌 사원의 입사일자, 사원명,
직무, 부서번호를 보이시오.
select hiredate 입사일자, ename 사원명, job 직무, deptno 부서번호
from emp
where hiredate not like '81%' and not job = 'CLERK';
-- where hiredate not between '81/01/01' and '81/12/31'
-- 				and job != 'CLERK'

11.보너스가 존재하지 않는 사원의 사원번호, 직무, 사원명, 급여를 보이시오.
select empno 사원번호, job 직무, ename 사원명, sal 급여
from emp
where comm is null;

12.사원의 직무가 M으로 시작하거나 보너스가 존재하는 사원의 직무, 보너스, 급여를 보이시오.
select job 직무, comm 보너스, sal 급여
from emp
where ename like 'M%' or comm is not null;

13.관리자사번이 존재하지 않거나 사원명 끝에서 두번째 자리가 t 또는 e 인 사원명인
 사원의 모든 정보를 보이시오.
 select *
 from emp
 where mgr is null or ename like '%T_' or ename like '%E_';

14.모든 사원의 사원명, 입사일자, 근무일수, 근무년수를 보이시오.
select ename 사원명, hiredate 입사일자, trunc(SYSDATE - hiredate) 근무일수, trunc((SYSDATE - hiredate) / 365) 근무년수
from emp;

15. 본인의 질의문!!!
보너스가 없고, S로 시작하는 이름을 가지면서 급여가 500이상인 사원의 사원명과 급여, 보너스
입사일자, 근무년수를 보이시오.
select ename 사원명, sal 급여, comm 보너스, hiredate 입사일자, trunc((SYSDATE - hiredate) / 365) 근무년수
from emp
where comm is null and ename like 'S%' and sal >= 500;

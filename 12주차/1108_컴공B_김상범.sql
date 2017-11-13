1108_컴공B_김상범

ex1.blake가 관리자인 사원의 사원번호, 사원명, 직무를 보이시오.
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

ex2.직무가 manager 가 아니고 clerk도 아닌 사원의 직무별 사원수,최대급여,급여
평균을 부서명과 함께 보이되, 급여평균이 높은 순부터 보이시오. 단, 소속된 부서가
없는 사원도 포함하시오.(열별칭 쓰기)

select job 직무, count(*) 사원수, max(sal) 최대급여, avg(sal)급여평균, dname 부서명
from emp e left outer join dept d on(e.deptno = d.deptno)
where job not in('MANAGER', 'CLERK')
group by job, dname
order by 급여평균 DESC;

select job 직무, count(*) 사원수, max(sal) 최대급여, avg(sal)급여평균, dname 부서명
from emp e left outer join dept d using(deptno)
where job not in('MANAGER', 'CLERK')
group by job, dname
order by 급여평균 DESC;

--------------------------------------------------------------------------------
*데이터베이스 언어
1.DDL: 데이터 정의어
- 데이터베이스 생성: create
- 데이터베이스 변경(수정): alter
- 데이터베이스 제거: drop

2.DML: 데이터 조작어
- 데이터 검색: select
- 데이터 삽입: insert
- 데이터 갱신(수정): update
- 데이터 삭제: delete

3.DCL: 데이터 제어어
- 권한 부여: grant
- 권한 철회: revoke
- 트랜잭션 실행 성공: commit
- 트랜잭션 실행 실패: rollback
--------------------------------------------------------------------------------
*DDL - create

create table 테이블명 (
  속성명1 데이터타입 널타입,
  속성명2 데이터타입 널타입,
  .
  .
  .
  constraint 제약조건명1 primary key(속성명),
  constraint 제약조건명2 foreign key(속성명) references 테이블명(속성명),
  constraint 제약조건명3 check(데이터 조건)

);

(문제)
1. deptb 테이블 생성
create table deptb (
  DEPTNO number(2) not null,
  DNAME varchar2(10) null,
  LOC varchar2(10) null,
  constraint d_pk primary key(deptno)
);

2. empb 테이블 생성
create table empb (
  empno number(4) not null,
  ename varchar2(10) not null,
  job varchar2(10) null,
  sal number(7,2) null,
  deptno number(2) null,
  constraint e_pk primary key(empno),
  constraint e_fk foreign key(deptno) references deptb(deptno)
);

--------------------------------------------------------------------------------
*DML - insert

insert into 테이블명(속성명1, 속성명2, 속성명3, ...)
    values(값1, 값2, 값3, ...);

insert into deptb(deptno, dname, loc) values(10, 'computer', 'seoul');
insert into deptb values(20, 'math', 'busan');
insert into deptb(deptno, dname) values(30, 'science');

insert into empb(empno, ename, job, sal, deptno) values(1111, 'jee', 'student', 2500, 20);
insert into empb(empno, ename, job, sal, deptno) values(2222, 'lee', 'prof', 3500, 10);
insert into empb(empno, ename, job, sal, deptno) values(3333, 'an', 'student', 2600, 20);
insert into empb(empno, ename, job) values(5555, 'go', 'student');

(문제)
insert into deptb(deptno, loc) values(20, 'yongin');
  => ORA-00001: unique constraint (COMB.D_PK) violated
     개체무결성 제약조건 위배
     deptno는 기본키 이므로 중복값을 삽입할 수 없다.
     따라서 이미 존재하는 deptno가 20인 값 삽입 불가능
insert into deptb(dname, loc) values('multi', 'banpo');
  => ORA-01400: cannot insert NULL into ("COMB"."DEPTB"."DEPTNO")
     개체무결성 제약조건 & not null 제약조건 위배
     deptno는 기본키 이므로 null값을 삽입할 수 없다.
insert into empb(empno, ename, job, sal, deptno) values(7777, 'lim', 'student', 2600, 50);
  => ORA-02291: integrity constraint (COMB.E_FK) violated - parent key not found
     참조무결성 제약조건 위배
     부모테이블(deptb)의 기본키(deptno)에 존재하지 않는 deptno = 50 을
     자식테이블(empb)의 외래키(deptno)에 삽입 불가능
insert into empb(empno, ename, job, sal, deptno) values(8888, 'park', 'mgr', 3500, null);
  => 실행가능
--------------------------------------------------------------------------------
*DML - update

update 테이블명
set 속성명1 = 변경값[,속성명2 = 변경값]
[where 데이터조건];

update deptb set dname = 'database', loc = 'kang' where deptno = 20;
update empb set deptno = 30, sal = 2000 where job = 'student';

(문제)
update deptb set deptno = 50 where dname = 'science';
  => ORA-02292: integrity constraint (COMB.E_FK) violated - child record found
     참조무결성 제약조건 위배
     부모테이블(deptb)은 자식테이블(empb)에서 참조하고 있는 데이터를 변경 불가능
update deptb set deptno = 50 where deptno = 20;
  => 실행가능
update empb set deptno = 40 where ename = 'an';
  => integrity constraint (COMB.E_FK) violated - parent key not found
     참조무결성 제약조건 위배
     자식테이블(empb)의 외래키는 부모테이블(deptb)의 기본키 값에 존재하는 값으로만 변경가능
update empb set deptno = null where ename = 'an';
  => 실행가능
--------------------------------------------------------------------------------
*DML - delete

delete from 테이블명
[where 데이터조건];

(문제)
delete from deptb where deptno = 10;
  => ORA-02292: integrity constraint (COMB.E_FK) violated - child record found
     참조무결성 제약조건 위배
     부모테이블(deptb)은 자식테이블(empb)에서 참조하고 있는 데이터를 삭제 불가능
delete from deptb where deptno = 20;
  => 실행가능
delete from empb where deptno = 30;
  => 실행가능

--------------------------------------------------------------------------------
*DDL - drop

drop table 테이블명;

drop table empb purge;

drop table deptb;
--------------------------------------------------------------------------------

































































































.

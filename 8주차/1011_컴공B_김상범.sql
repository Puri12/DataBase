*카테션 프로덕트=cross join (조인 조건이 없는 조인)

테이블명          차수          카디널리티
--------------------------------------------------------------------------------
사원              8              14
부서              3              4
--------------------------------------------------------------------------------
사원 X 부서       11             56
(카테션 프로덕트) (8 + 3)        (14 * 4)

과제 24일까지
15번까지


1. select *
from 제품;

2. select 제품번호, 제품명, 단가, 수량, 단가 * 수량 as 재고금액
from 제품;

3. select 거래처번호, count(*), sum(수량)
from 제품
group by 거래처번호;

4. select count(*), max(단가), min(단가)
from 제품
where 제품명 like '%COM%';

5. select 거래처번호, count(*), sum(수량)
from 제품
where 단가 is null
group by 거래처번호;

6. select 제품번호, 제품명, 단가
from 제품
where 단가 between 10000 and 50000 or 거래처번호 in (10,20,40);

7. select count(*), avg(단가)
from 제품
where 제품명 like 'a%';

8. select count(*)
from 제품
where 제품명 like '__s%' or 제품명 like '__a%';

9. select 거래처번호, count(*), sum(수량)
from 제품
where 수량 <= 100
group by 거래처번호
having count(*) >= 10;

10. select 제품번호, 제품명, 수량
from 제품
order by 수량 DESC;

11. select count(*), sum(수량)
from 제품
where 단가 is not null and 수량 <= 10
order by sum(수량) ASC;

12. select 거래처번호, count(*), sum(수량)
from 제품
where 단가 >= (select avg(단가) from 제품)
group by 거래처번호;

13. select distinct 거래처번호
from 제품
where 단가 >= 10000;

14. select 제품번호, 제품명, 수량
from 제품
where 거래처번호 in (select 거래처번호 from 거래처 where 거래처명 in('soongsil'))
order by 수량 DESC;

15. select 거래처번호, max(수량), min(수량)
from 제품
group by 거래처번호
having avg(단가) >= 15000
order by max(수량) DESC;

16. select 거래처번호, count(*), sum(수량), avg(단가)
from 제품
group by 거래처번호
having avg(단가) >= (select avg(단가) from 제품)
order by count(*) DESC;

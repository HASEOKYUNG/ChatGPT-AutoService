-- 질의1. 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice) FROM Orders;

-- 질의2. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice)
FROM Orders
WHERE custid=2;

-- 질의3. 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오.
SELECT SUM(saleprice) AS '총 판매액',
       AVG(saleprice) AS '평균값',
       MIN(saleprice) AS '최저가',
       MAX(saleprice) AS '최고가'
FROM Orders;

-- 질의4. 마당서점의 도서 판매 건수를 구하시오.
SELECT COUNT(*) FROM Orders;

-- 질의5. 고객별 주문한 도서의 총 수량과 총 판매액을 구하시오.
SELECT custid, COUNT(*) AS '총 수량', SUM(saleprice) AS '총 판매액'
FROM Orders
GROUP BY custid;

-- 질의6. 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.
--       단, 두 권 이상 구매한 고객만 구한다.
SELECT custid, COUNT(*) AS 총수량
FROM Orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING 총수량 >= 2;










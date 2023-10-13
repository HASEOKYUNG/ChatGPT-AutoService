-- 질의1. 고객과 고객의 주문에 관한 데이터를 모두 보이시오.
SELECT *
FROM customer AS C, Orders AS O
WHERE C.custid=O.custid;

SELECT *
FROM customer AS C JOIN Orders AS O ON C.custid=O.custid;

-- 질의2. 고객과 고객의 주문에 관한 데이터를 고객번호 순으로 정렬해 보이시오.
SELECT *
FROM customer AS C, Orders AS O
WHERE C.custid=O.custid
ORDER BY C.custid;

-- 질의3. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT name, saleprice
FROM customer AS C, Orders AS O
WHERE C.custid=O.custid;

-- 질의4. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT name, SUM(saleprice) AS '총 판매액'
FROM customer AS C, Orders AS O
WHERE C.custid=O.custid
GROUP BY C.custid
ORDER BY C.name;

-- 질의5. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT name, bookname
FROM customer AS C, Orders AS O, Book AS B
WHERE C.custid=O.custid AND O.bookid=B.bookid;

-- 질의6. 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT name, bookname
FROM customer AS C, Orders AS O, Book AS B
WHERE C.custid=O.custid AND O.bookid=B.bookid AND B.price = 20000;

-- 질의7. 사원 "BLAKE"가 관리하는 부하 사원의 이름과 직급을 출력하시오.
--       단, Table은 Oracle이 제공하는 EMP 테이블을 사용해야 한다.
SELECT STAFF.ENAME, STAFF.JOB
FROM EMP AS STAFF, EMP AS BOSS
WHERE BOSS.ENAME="BLAKE" AND STAFF.MGR = BOSS.EMPNO;

-- 질의8. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
SELECT name, saleprice
FROM customer AS C LEFT OUTER JOIN Orders AS O ON C.custid=O.custid;

-- (추가)6주차 PDF ~ P.8
-- 질의1. 대한민국에서 거주하는 고객의 이름과 도서를 주문한 고객의 이름을 보이시오.
SELECT name
FROM customer
WHERE address LIKE '대한민국%'
UNION
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM Orders);

-- 질의2. 대한민국에서 거주하는 고객의 이름에서 도서를 주문한 고객의 이름을 빼고 보이시오.
SELECT name
FROM customer
WHERE address LIKE '대한민국%' AND
	  custid NOT IN (SELECT custid FROM Orders);

-- 질의3. 대한민국에서 거주하는 고객 중 도서를 주문한 고객의 이름을 보이시오.
SELECT name
FROM customer
WHERE address LIKE '대한민국%' AND
	  custid IN (SELECT custid FROM Orders);

-- 질의4. 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT name, address
FROM customer
WHERE custid IN (SELECT custid FROM Orders);
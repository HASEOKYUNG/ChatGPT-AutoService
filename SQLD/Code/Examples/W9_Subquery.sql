-- 스칼라 부속질의
-- SELECT, UPDATE SET문에 선언해 부속질의 결과값을 단일행, 단일열의 Scalar로 반환한다..
-- 질의1. 마당서점의 고객별 판매액을 보이시오.(고객이름과 고객별 판매액을 출력)
SELECT name, (SELECT SUM(saleprice) FROM Orders WHERE Customer.custid=Orders.custid) AS '고객별 판매액'
FROM Customer;

-- 추가)주문한 고객별 판매액을 보이시오.
SELECT (SELECT name FROM Customer WHERE Customer.custid=Orders.custid) AS 고객이름, SUM(saleprice) AS '고객별 판매액'
FROM Orders
GROUP BY custid;

-- 질의2. Orders 테이블에 각 주문에 맞는 도서이름을 입력하시오.
ALTER TABLE Orders ADD BNAME VARCHAR(40);
UPDATE Orders SET BNAME = (SELECT bookname FROM Book WHERE Orders.bookid = Book.bookid);
-- SELECT * FROM Orders;

-- 인라인 뷰
-- FROM 절에 선언하여 필요한 데이터만 담은 가상테이블(뷰)로 질의하는 방법이다. 이때 반드시 가상테이블에 별칭을 붙여줘야 한다.
-- 질의3. 고객번호가 2 이하인 고객의 판매액을 보이시오.(고객이름과 고객별 판매액 출력)
SELECT CS.name, SUM(saleprice) AS '고객별 판매액'
FROM (SELECT custid, name FROM Customer WHERE custid <= 2) AS CS, Orders
WHERE CS.custid = Orders.custid
GROUP BY CS.custid;

-- 중첩질의
-- WHERE 절에 선언하며 연산자로 다른 테이블 값을 참조해 데이터를 질의하는 방법이다. 
-- 질의4. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
SELECT orderid, saleprice
FROM Orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM Orders);

-- 질의5. 각 고객의 평균 주문금액보다 큰 금액의 주문내역에 대해 주문번호, 고객번호, 금액을 보이시오.
SELECT orderid, custid, saleprice
FROM Orders AS P
WHERE saleprice >= (SELECT AVG(saleprice) FROM Orders AS C WHERE P.custid=C.custid);

-- 질의6. 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
SELECT SUM(saleprice)
FROM Orders
WHERE custid IN (SELECT custid FROM Customer WHERE address LIKE '%대한민국%');

-- 질의7. 3번 고객이 주문한 도서의 최고금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.
SELECT orderid, saleprice
FROM Orders
WHERE saleprice > (SELECT MAX(saleprice) FROM Orders WHERE custid=3);

-- 추가)질의7을 ALL/ANY로 해결하시오.
SELECT orderid, saleprice
FROM Orders
WHERE saleprice > ALL (SELECT saleprice FROM Orders WHERE custid=3);

-- 질의8. EXISTS 연산자로 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice)
FROM Orders
WHERE EXISTS (SELECT custid FROM Customer WHERE address LIKE '%대한민국%' AND Customer.custid=Orders.custid);
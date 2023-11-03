-- 질의1. 주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 country_Customer로 설정하시오.
CREATE VIEW country_customer(custid, name, address, phone)
AS SELECT custid, name, address, phone FROM Customer WHERE address LIKE '%대한민국%';
-- SELECT * FROM country_customer;

-- 질의2. Orders테이블에 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, '김연아' 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.
CREATE VIEW vw_Orders(orderid, custid, csname, bookid, bookname, saleprice, orderdate)
AS SELECT od.orderid, od.custid, cs.name, od.bookid, bk.bookname, od.saleprice, od.orderdate
FROM Orders AS od, Customer AS cs, Book AS bk
WHERE od.custid=cs.custid AND od.bookid=bk.bookid;
-- SELECT * FROM vw_Orders;
SELECT orderid, csname, bookname, saleprice FROM vw_Orders WHERE csname = '김연아';

-- 질의3. 질의1에서 생성한 country_customer을 영국을 주소로 가진 고객으로 변경하시오. 단, phone 속성은 필요없다.
CREATE OR REPLACE VIEW country_customer 
AS SELECT custid, name, address FROM Customer WHERE address LIKE '%영국%';
-- SELECT * FROM country_customer;

-- 질의4. country_customer VIEW를 삭제하세요.
DROP VIEW country_customer;


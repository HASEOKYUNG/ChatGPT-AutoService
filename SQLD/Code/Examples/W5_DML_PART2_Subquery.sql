-- 질의1. 가장 비싼 도서의 이름을 검색하세요.
-- + 한 개의 테이블에서 변수를 추출해오는 거면 부속질의를 사용하는 것이 좋다.
SELECT bookname
FROM Book
WHERE price = (SELECT MAX(price) FROM Book);

-- 질의2. 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM Orders);

-- 질의3. '대한미디어'에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT name
FROM customer
WHERE custid IN (SELECT custid
				 FROM Orders
                 WHERE bookid IN (SELECT bookid FROM Book WHERE publisher='대한미디어'));
                 
SELECT name
FROM customer
WHERE custid IN (SELECT custid
				 FROM Book AS B, Orders AS O
                 WHERE B.bookid=O.bookid AND publisher='대한미디어');                

-- 질의4. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
-- + 두 번째 방법은 * 출력 시 결측치 행까지 출력되기에 특정 테이블의 변수를 출력하도록 정의해야 한다. 
SELECT *
FROM Book AS B, (SELECT publisher, AVG(price) AS 평균 FROM Book GROUP BY publisher) AS PAVG
WHERE B.publisher = PAVG.publisher AND price > 평균;

SELECT B1.bookname
FROM Book AS B1
WHERE B1.price > (SELECT AVG(price) FROM Book AS B2 WHERE B1.publisher=B2.publisher);






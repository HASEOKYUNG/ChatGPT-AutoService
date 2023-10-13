-- 질의1. Book 테이블에 새로운 도서 '스포츠 의학'을 삽입하시오. 스포츠 의학은 한솥의학서적에서 출간했으며 가격은 90000원이다.
INSERT INTO Book 
VALUES (11, '스포츠 의학', '한솔의학서적', 90000);

-- 질의2. Book 테이블에 새로운 도서 '스포츠 의학'을 삽입하시오. 스포츠 의학은 한솥의학서적에서 출간했으며 가격은 미정이다.
-- + 일부 속성만 값을 추가할 수 있다. 그러나 PK는 반드시 값이 입력되어야 한다.
INSERT INTO Book(bookid, bookname, publisher, price) 
VALUES (14, '스포츠 의학', '한솔의학서적', NULL);

INSERT INTO Book(bookid, bookname, publisher) 
VALUES (15, '스포츠 의학', '한솔의학서적');
SELECT * FROM Book;

-- 질의3. 수입도서 목록(Imported_book)을 Book 테이블에 모두 삽입하시오.
INSERT INTO Book(bookid, bookname, publisher, price) 
SELECT bookid, bookname, publisher, price FROM imported_book;
SELECT * FROM Book;

-- 질의4. customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경하시오.
UPDATE customer
SET address='대한민국 부산' WHERE custid=5;
SELECT * FROM customer;

-- 질의5. Book 테이블에서 14번 '스포츠 의학'의 출판사를 Imported_book 테이블의 21번 책의 출판사와 동일하게 변경하시오.
UPDATE Book
SET publisher = (SELECT publisher FROM imported_book WHERE bookid=21) WHERE bookid=14;
SELECT * FROM Book;

-- 질의6. Book 테이블에서 도서번호가 11인 도서를 삭제하시오.
DELETE FROM Book WHERE bookid=11;
DELETE FROM Book WHERE bookid=14;
DELETE FROM Book WHERE bookid=15;

-- 질의7. 모든 고객을 삭제하시오.
-- + Orders 테이블 custid의 PK이기에 삭제할 수 없다.
DELETE FROM customer;
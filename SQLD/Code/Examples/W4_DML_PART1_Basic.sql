-- 질의1. 모든 도서의 이름과 가격을 검색하시오.
SELECT bookname, price FROM book;

-- 질의2. 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
SELECT * FROM book;

-- 질의3. 도서 테이블에 있는 유일한 출판사를 검색하시오.
SELECT DISTINCT publisher FROM book;

-- 질의4. 가격이 20000원 미만인 도서를 검색하시오.
SELECT *
FROM book
WHERE price < 200000;

-- 질의5. 가격이 10000원 이상 20000원 이하인 도서를 검색하시오.
SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;

-- 질의6. 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오.
SELECT *
FROM book
WHERE publisher IN ('굿스포츠', '대한미디어');

-- 질의7. '축구의 역사'를 출간한 출판사를 검색하시오.
SELECT publisher
FROM book
WHERE bookname LIKE '축구의 역사';

-- 질의8. 도서이름에 '축구'가 포함한 출판사를 검색하시오.
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '축구%';

-- 질의9. 도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서를 검색하시오.
SELECT *
FROM book
WHERE bookname LIKE '_구%';

-- 질의10. 축구에 관한 도서 중 가격이 20000원 이상인 도서를 검색하시오.
SELECT *
FROM book
WHERE bookname LIKE '%축구%' AND price >= 20000;

-- 질의11. 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오.
SELECT *
FROM book
WHERE publisher='굿스포츠' OR publisher='대한미디어';

-- 질의12. 영문으로 되어있는 도서명을 검색하시오.
SELECT *
FROM book
WHERE bookname REGEXP '^[A-z]';

-- 질의13. 도서를 이름순으로 검색하시오.
SELECT *
FROM Book
ORDER BY bookname;

-- 질의14. 도서를 가격순으로 검색하고 가격이 같으면 이름순으로 검색하시오.
SELECT *
FROM Book
ORDER BY price, bookname;

-- 질의15. 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 검색하시오.
SELECT *
FROM Book
ORDER BY price DESC, publisher;
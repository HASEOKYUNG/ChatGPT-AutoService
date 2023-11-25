SELECT * FROM Book WHERE publisher = '대한미디어' and price >= 30000;

-- 질의1. Book 테이블의 bookname 열을 대상으로 비 클러스터 인덱스 ix_Book을 생성하라.
CREATE INDEX ix_Book ON Book(bookname);
SHOW INDEX FROM Book;
 
-- 질의2. Book 테이블의 publisher, price열을 대상으로 인덱스 ix_Book2을 생성하라.
CREATE INDEX ix_Book2 ON Book(publisher, price);
SHOW INDEX FROM Book;
SELECT * FROM Book WHERE publisher = '대한미디어' and price >= 30000;

-- 질의3. Book 테이블의 인덱스를 최적화하시오.
ANALYZE TABLE Book;

-- 질의4. 인덱스 ix_Book을 삭제하시오.
DROP INDEX ix_Book ON Book;
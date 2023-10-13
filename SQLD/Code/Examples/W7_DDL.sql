-- 질의1. 다음과 같은 속성을 가진 NewBook 테이블을 생성하시오. 정수형은 INTEGER를 사용하며 문자형은 가변형 문자타입인 VARCHAR를 사용한다.
-- * bookid - INTEGER
-- * bookname - VARCHAR(20), NOT NULL
-- * publisher - VARCHAR(20), UNIQUE
-- * price - INTEGER, DEFAULT 10000 & price > 1000
CREATE TABLE NewBook(
bookid 		INTEGER,
bookname	VARCHAR(20)		NOT NULL,
publisher	VARCHAR(20)		UNIQUE,
price 		INTEGER		DEFAULT 10000 CHECK(price > 1000),
PRIMARY KEY (bookname, publisher));

SELECT * FROM NewBook;

-- 질의2. 다음과 같은 속성을 가진 NewCustomer 테이블을 생성하시오.
-- * custid - INTEGER, PK
-- * name - VARCHAR(40)
-- * address - VARCHAR(40)
-- * phone - VARCHAR(30)
CREATE TABLE NewCustomer(
custid		INTEGER,
name 		VARCHAR(40),
address		VARCHAR(40),
phone		VARCHAR(30),
PRIMARY KEY (custid));

-- 질의3. 다음과 같은 속성을 가진 NewOrders 테이블을 생성하시오.
-- * orderid - INTEGER, PK
-- * custid - INTEGER, FK, NOT NULL
-- * bookid - INTEGER, NOT NULL
-- * saleprice - INTEGER
-- * orderdate - DATE
-- + NewBook에 PK 설정을 안해뒀기에 오류가 난다.
-- + 복합키가 아닌 경우 FOREIGN KEY는 줄별로 설정해야 한다.
CREATE TABLE NewOrders(
orderid		INTEGER,
custid		INTEGER		NOT NULL,
bookid 		INTEGER		NOT NULL,
saleprice 	INTEGER,
orderdate   DATE,
PRIMARY KEY (orderid),
FOREIGN KEY (custid) REFERENCES NewCustomer (custid) ON DELETE CASCADE,
FOREIGN KEY (bookid) REFERENCES NewBook (bookid) ON DELETE CASCADE);

-- 질의4. NewBook 테이블에 VARCHAR(13)의 자료형을 가진 isbn 속성을 추가하시오.
ALTER TABLE NewBook ADD isbn VARCHAR(13);
SELECT * FROM NewBook;

-- 질의5. NewBook 테이블의 isbn 속성의 테이블 타입을 INTEGER형으로 변경하시오.
ALTER TABLE NewBook MODIFY isbn INTEGER;
SELECT * FROM NewBook;

-- 질의6. NewBook 테이블의 isbn 속성을 삭제하시오.
ALTER TABLE NewBook DROP COLUMN isbn;
SELECT * FROM NewBook;

-- 질의7. NewBook 테이블의 bookid 속성에 NOT NULL 제약조건을 적용하시오.
ALTER TABLE NewBook MODIFY bookid INTEGER NOT NULL;
SELECT * FROM NewBook;

-- 질의8. NewBook 테이블의 bookid 속성을 기본키로 변경하시오.
ALTER TABLE NewBook DROP PRIMARY KEY;
ALTER TABLE NewBook ADD PRIMARY KEY(bookid);
SELECT * FROM NewBook;

-- 질의9. NewBook 테이블을 삭제하시오.
DROP TABLE NewBook;

-- 질의10. NewCustomer 테이블을 삭제하시오.
DROP TABLE NewCustomer;
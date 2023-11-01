-- 숫자 함수
-- 1. CEIL(DATA), FLOOR(DATA), ROUND(DATA, N): 올림, 버림, 반올림 반환
-- 2. LOG(DATA): 자연로그 값 반환
-- 3. POWER(DATA, N), SQRT(DATA): DATA**N, DATA**0.5 반환
-- 4. ABS(DATA), SIGN(DATA): 절댓값, 음수/0/양수 여부 반환alter
-- 질의1. -78과 +78의 절댓값을 구하시오.
SELECT ABS(-78), ABS(78);

-- 질의2. 4.875를 소수 첫째 자리까지 반올림한 값을 구하시오.
SELECT ROUND(4.875, 1);

-- 질의3. 고객별 평균 주문 금액을 천 원 단위로 반올림한 값을 구하시오.
SELECT custid, ROUND(AVG(saleprice), -3) AS '평균 주문 금액'
FROM Orders
GROUP BY custid;

-- 텍스트 함수
-- 1. LENGTH(STR), CHAR_LENGTH(STR): STR의 Byte수, len(STR) 반환
-- 2. CONCAT(STR1, STR2): STR1 + STR2 반환
-- 3. LPAD(STR, N, REPLACE), RPAD(STR, N, REPLACE): REPLACE*(N-CHAR_LENGTH(STR))+STR, STR+REPLACE*(N-CHAR_LENGTH(STR)) 반환
-- 4. REPLACE(STR, EXIST, REPLACE): STR내 모든 EXIST를 REPLACE로 대체한 값 반환
-- 5. SUBSTR(STR, N, K): STR[N:N+K] 반환
-- 6. TRIM(EXIST FROM STR): STR 양쪽의 EXIST들을 지운 값 반환(중앙에 있는 EXIST는 제거 불가하다)
-- 질의4. 도서제목에 야구가 포함된 도서를 농구로 변경한 후 도서 목록을 보이시오.
SELECT bookid, REPLACE(bookname, '야구', '농구') AS 'bookname(revised)', publisher, price
FROM Book;

-- 질의5. 굿스포츠에서 출판한 도서의 제목과 제목의 글자 수를 확인하시오.
--      (한글을 2 byte, UNICODE는 3 byte로 아래와 같은 결과가 나온다.)
SELECT bookname, LENGTH(bookname) AS '도서 제목 byte', CHAR_LENGTH(bookname) AS '도서 제목 글자수'
FROM Book
WHERE publisher = '굿스포츠';

-- 질의6. 마당서점의 고객 중에서 같은 성을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
SELECT SUBSTR(name, 1, 1) AS firstname, COUNT(*) AS '성별 인원수'
FROM Customer
GROUP BY firstname;

-- 추가) 마당서점에서 주문한 고객에 대해 성별 인원수를 구하시오.
SELECT SUBSTR(name, 1, 1) AS firstname, COUNT(DISTINCT Orders.custid) AS '성별 인원수'
FROM Orders, (SELECT custid, name FROM Customer) AS Cust
WHERE Orders.custid = Cust.custid
GROUP BY firstname;

-- 날짜/시간 함수
-- 1. STR_TO_DATE(STR, FORMAT): STR을 FORMAT 형식의 DATE 자료형으로 반환
-- 2. DATE_FORMAT(DATE, FORMAT): DATE에서 FORMAT 형식의 STR 자료형 추출
-- 3. ADDDATE(DATE, INTERVAL N UNIT): DATE에 N UNIT만큼 이동한 날짜 반환
-- 4. DATE(DATES): DATES의 날짜 부분만 반환
-- 5. DATEDIFF(DATE1, DATE2): DATE1-DATE2의 일수
-- 6. SYSDATE(): DBMS 시스템 상 오늘 날짜 반환
-- 질의7. 마당서점이 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 단 주문일은 '%Y-%m-%d'로 표시한다.
SELECT orderid, DATE_FORMAT(orderdate, '%Y-%m-%d') AS 주문일, custid, bookid
FROM Orders
WHERE orderdate = STR_TO_DATE('20140707', '%Y%m%d');

-- 추가)요일별로 주문건수를 구하시오.
SELECT DATE_FORMAT(orderdate,'%W') AS 요일, COUNT(*) AS '건수'
FROM Orders
GROUP BY 요일;

-- 질의8. 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
SELECT orderid, orderdate, ADDDATE(orderdate, INTERVAL 10 DAY) AS 확정일자
FROM Orders;

-- 질의9. DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오.
SELECT SYSDATE(), DATE_FORMAT(SYSDATE(), '%Y년 %m월 %d일 %h시 %i분') AS '날짜 정보';

-- 결측치 함수
-- 1. IFNULL(DATA, REPLACE): DATA내 결측치를 REPLACE로 대체해 반환
-- + ) IS NULL: 결측치 조건
-- 질의10. 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 '연락처없음'으로 표시한다.
SELECT name, IFNULL(phone, '연락처없음') AS 전화번호
FROM Customer;

-- 행번호/반복문 함수
-- 1) SET @seq := 0;으로 반복횟수 변수 seq를 선언한다.
-- 2) SELECT문에 @seq의 조건을 선언해 행번호 생성 또는 반복 조건을 지정한다.
-- 질의11. 고객 목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.
SET @seq := 0;
SELECT (@seq := @seq + 1) AS 행번호, custid, name, phone
FROM Customer
WHERE @seq < 2;
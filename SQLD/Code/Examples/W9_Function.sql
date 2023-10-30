-- 질의7.
--     현재 데이터 형식을 WHERE에 지정하고 SELECT에 출력형식을 지정한다.
SELECT orderid, DATE_FORMAT(orderdate, '%Y년 %m월 %d일') AS 주문일, custid, bookid
FROM Orders
WHERE orderdate = STR_TO_DATE('20140707', '%Y%m%d');

-- 추가)요일별로 건수 집계
SELECT DATE_FORMAT(orderdate,'%W') AS '요일', COUNT(*) AS '건수'
FROM Orders
GROUP BY DATE_FORMAT(orderdate,'%W');

-- 추가)오늘부터 100일 뒤
SELECT ADDDATE(SYSDATE(), INTERVAL 100 DAY);


-- 반복문을 사용해 0으로 세팅한 seq에 1씩 더하며 순서대로 출력한다.
SET @seq:=0;
SELECT (@seq:=@seq+1) '순번', custid, name, phone
FROM Customer;

-- 추가)0에서 1씩 더해주는 seq가 2가 될 때까지의 데이터만 출력한다. 즉, 3개 데이터를 출력한다.
SET @seq:=0;
SELECT (@seq:=@seq+1) '순번', custid, name, phone
FROM Customer
WHERE @seq<=2;
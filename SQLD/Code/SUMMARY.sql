-- KleagueDB-SchemaData를 실행해야 한다.
-- KleagueDB에는 STADIUM, TEAM, SCHEDULE, PLAYER 테이블이 있다. 
USE kleague;

-- 1.DML Query
-- 1)데이터 추가하기(모든 행의 값을 VALUES로 입력하면 테이블 뒤에 데이터를 삽입할 column을 따로 지정하지 않아도 된다.)
INSERT INTO 	PLAYER (PLAYER_ID, PLAYER_NAME, TEAM_ID, POSITION, HEIGHT, WEIGHT, BACK_NO) 
VALUES 			('2002007', '박지성', 'K07', 'MF', 178, 73, 7);

-- 2)데이터 삭제하기(WHERE이 없을 경우 테이블 전체가 삭제되어 반드시 WHERE과 같이 쓰여야 한다.)
DELETE FROM 	PLAYER
WHERE 			PLAYER_ID = '2002007';

-- 3)데이터 수정하기(WHERE없이 사용할 경우 모든 행에 SET 명령이 적용되어 테이블 전체가 변경된다.)
--  기존데이터 확인
SELECT *
FROM	PLAYER
WHERE	PLAYER_ID = '2000001';

-- 데이터값 수정
UPDATE	PLAYER
SET		BACK_NO = 99
WHERE	PLAYER_ID = '2000001';

--  변경데이터 확인
SELECT *
FROM	PLAYER
WHERE	PLAYER_ID = '2000001';

-- 4)데이터 출력하기
--  o 기본형
SELECT PlAYER_ID, PLAYER_NAME, BACK_NO
FROM PLAYER;

--   - project 연산에서 AS를 사용해 column 별칭을 붙일 수 있다. 이때 별칭명에 띄어쓰기를 포함하고 싶다면 별칭명을 문자열로 선언해야 한다.
SELECT PLAYER_NAME AS '선수 이름', POSITION AS 위치, HEIGHT AS 키, WEIGHT AS 몸무게
FROM PLAYER;

--   - project 연산에서 DISTINCT 선언 시 중복 튜플을 제거한 테이블을 반환한다. 이때 NULL도 하나의 데이터로 본다.
SELECT DISTINCT POSITION
FROM PLAYER;

--   - project 연산에서 산술연산, 데이터타입별 함수사용이 가능하다.(함수 내용은 3.DML FUNCTION & CONDITION에서 확인하라.)
SELECT PLAYER_NAME AS 이름, 
       ROUND(WEIGHT/((HEIGHT/100)*(HEIGHT*100)), 2) AS 'BMI 비만지수'
FROM PLAYER;

--   - project 연산에 Python의 if elif와 유사한 CASE절을 사용할 수 있다.(CASE절 설명은 3.DML FUNCTION & CONDITION을 확인하라.)
SELECT PLAYER_ID, PLAYER_NAME, TEAM_ID, HEIGHT, 
       CASE WHEN HEIGHT < 170 THEN '160대'
            WHEN HEIGHT < 180 THEN '170대'
            WHEN HEIGHT < 190 THEN '180대'
            WHEN HEIGHT < 200 THEN '190대'
            ELSE '기타' END AS '소속키대'
FROM PLAYER;

--  o 조건출력
SELECT PLAYER_ID, PLAYER_NAME  AS 이름, BACK_NO,
       ROUND(WEIGHT/((HEIGHT/100)*(HEIGHT*100)), 2) AS 'BMI 비만지수'
FROM PLAYER
WHERE TEAM_ID = 'K07';

--   - 사용할 수 있는 연산자의 대부분은 Python과 동일하지만 비교연산자 !=은 <>이고 in|not in은 IN|NOT IN, isna|notna는 IS NULL|IS NOT NULL로 연산자명이 다르다.
SELECT PLAYER_NAME, TEAM_ID, POSITION, NATION, BACK_NO, HEIGHT
FROM PLAYER
WHERE TEAM_ID IN ('K02', 'K04', 'K05', 'K07') AND
	  (POSITION, NATION) NOT IN (('MF', '브라질'), ('FW', '러시아')) AND
      POSITION IS NOT NULL AND
      BACK_NO <> 99;
      
--   - SQL은 구간값의 데이터를 선택하는 BETWEEN|NOT BETWEEN a AND b 연산자를 지원한다.
SELECT PLAYER_NAME, TEAM_ID, POSITION, NATION, BACK_NO, HEIGHT
FROM PLAYER
WHERE HEIGHT BETWEEN 170 AND 180;
      
--   - SQL은 문자열의 패턴을 매치하는 LIKE|NOT LIKE str 연산자를 지원한다.(re의 *|+처럼 %|_를 사용한다.)
SELECT PLAYER_NAME, TEAM_ID, POSITION, NATION, BACK_NO, HEIGHT
FROM PLAYER
WHERE PLAYER_NAME LIKE '장%';

--  o Groupby형태(Groupby열을 project연산의 첫번째로 선언하길 권장하며 집계함수를 적용하지 않을 column은 project연산에 선언하면 안된다.)
SELECT POSITION, COUNT(*) AS 선수수, ROUND(AVG(HEIGHT), 2) AS 평균키
FROM PLAYER
GROUP BY POSITION;

--    - WHERE을 사용할 경우 Groupby할 데이터를 줄일 수 있다.
SELECT POSITION, COUNT(*) AS 선수수, ROUND(AVG(HEIGHT), 2) AS 평균키
FROM PLAYER
WHERE POSITION IS NOT NULL
GROUP BY POSITION;

--     - HAVING을 사용할 경우 조건식에 집계함수를 사용할 수 있다.
SELECT PLAYER_NAME, COUNT(*) AS '동명이인수'
FROM PLAYER
GROUP BY PLAYER_NAME HAVING COUNT(*) >= 2;

--     - CASE절을 사용해 Python Pandas의 pivot_table도 작성할 수 있다.
--     예제1. 생년월별 선수평균키를 팀별로 작성하라.
SELECT TEAM_ID, 
       ROUND(AVG(CASE MONTH(BIRTH_DATE) WHEN 1 THEN HEIGHT END), 2) AS M01,
       ROUND(AVG(CASE MONTH(BIRTH_DATE) WHEN 2 THEN HEIGHT END), 2) AS M02,
       ROUND(AVG(CASE MONTH(BIRTH_DATE) WHEN 3 THEN HEIGHT END), 2) AS M03,
       ROUND(AVG(CASE MONTH(BIRTH_DATE) WHEN 4 THEN HEIGHT END), 2) AS M04,
       ROUND(AVG(CASE MONTH(BIRTH_DATE) WHEN 5 THEN HEIGHT END), 2) AS M05,
       ROUND(AVG(CASE MONTH(BIRTH_DATE) WHEN 6 THEN HEIGHT END), 2) AS M06,
       ROUND(AVG(CASE MONTH(BIRTH_DATE) WHEN 7 THEN HEIGHT END), 2) AS M07,
       ROUND(AVG(CASE MONTH(BIRTH_DATE) WHEN 8 THEN HEIGHT END), 2) AS M08,
       ROUND(AVG(CASE MONTH(BIRTH_DATE) WHEN 9 THEN HEIGHT END), 2) AS M09,
       ROUND(AVG(CASE MONTH(BIRTH_DATE) WHEN 10 THEN HEIGHT END), 2) AS M10,
       ROUND(AVG(CASE MONTH(BIRTH_DATE) WHEN 11 THEN HEIGHT END), 2) AS M11,
       ROUND(AVG(CASE MONTH(BIRTH_DATE) WHEN 12 THEN HEIGHT END), 2) AS M12,
       COUNT(CASE WHEN MONTH(BIRTH_DATE) IS NULL THEN HEIGHT END) AS '생년월 결측수', 
       ROUND(AVG(CASE WHEN MONTH(BIRTH_DATE) IS NULL THEN HEIGHT END), 2) AS '생년월 결측 평균키'
FROM PLAYER
GROUP BY TEAM_ID;

--     예제2. 포지션별 선수수를 팀별로 작성하라.
SELECT TEAM_ID,
       COUNT(CASE POSITION WHEN 'FW' THEN POSITION END) AS FW,
       COUNT(CASE POSITION WHEN 'MF' THEN POSITION END) AS MF,
       COUNT(CASE POSITION WHEN 'DF' THEN POSITION END) AS DF,
       COUNT(CASE POSITION WHEN 'GK' THEN POSITION END) AS GK,
       COUNT(CASE WHEN POSITION IS NULL THEN 1 END) AS UNDECIDED,
       COUNT(*) AS '선수수'
FROM PLAYER
GROUP BY TEAM_ID;

--  o 정렬 형태
--  - Python Pandas의 sort_values method와 유사하며 ASC|DESC로 오름차순|내림차순 정렬이 가능하다. 이때 SQL은 NULL을 가장 작은 값으로 간주한다.
SELECT PLAYER_NAME, POSITION, BACK_NO, HEIGHT
FROM PLAYER
WHERE HEIGHT IS NOT NULL
ORDER BY HEIGHT DESC, BACK_NO;

--  - LIMIT을 사용해 정렬된 테이블의 상위 n개, 상위 a번째 튜플(Pandas iloc과 동일방식)부터 b개 데이터만 출력할 수 있다. LIMIT을 사용할 땐 최소 두 개의 column으로 정렬해야 한다.
SELECT PLAYER_NAME, POSITION, BACK_NO, HEIGHT, WEIGHT
FROM PLAYER
WHERE HEIGHT IS NOT NULL AND WEIGHT IS NOT NULL
ORDER BY HEIGHT DESC, WEIGHT DESC
LIMIT 5, 10;

--  - Groupby와 함께 사용될 경우 Groupby 결과인 임시 테이블로 정렬하기에 Groupby에 관여하는 column만 지정할 수 있다.
SELECT POSITION, AVG(HEIGHT) AS 평균키, AVG(WEIGHT) AS 평균몸무게
FROM PLAYER
WHERE HEIGHT IS NOT NULL AND WEIGHT IS NOT NULL
GROUP BY POSITION
ORDER BY 평균키;

-- 2. DML FUNCTION & CONDITION
-- 1)문자열
--  o Single Row FUNCTION
--   - LENGTH(str): 문자열 길이 반환
--   - LOWER(str), UPPER(str): 문자열을 대문자 또는 소문자로 변환
--   - INSTR(str, substr): str.index(substr) 반환
--   - SUBSTRING(str, index, length): str[index:index+length] 반환
--   - CONCAT(str1, str2, ...): 문자열 병합
--   - REPEAT(str, n): 문자열 n번 반복
--   - REVERSE(str): str[::-1] 반환
--   - TRIM(str): 문자열 양옆 공백 제거
--   - TRIM([BOTH|LEADING|TRAILING] remove_str FROM str): str에서 양옆|앞|뒤의 remove_str 제거
--   - REPLACE(str, exist, new): str내 exist를 new로 대체
SELECT PLAYER_ID, CONCAT(PLAYER_NAME, '선수') AS 선수명
FROM PLAYER;

-- 2)수치형
--  o Single Row FUNCTION
--   - ABS(num): 절댓값 반환
--   - FLOOR(num), TRUNCATE(num, d): 자연수 버림, 소수점 d자리에서 버림
--   - CEILING(num): 자연수 올림
--   - ROUND(num, d): 소수점 d자리에서 반올림
--   - MOD(x, y): x%y 반환
--   - POWER(x, y), SQRT(x): x**y, x**0.5 반환
--  o Multi Row FUNCTION
--   - COUNT(col): DISTINCT사용 시(default) size method와 동일함
-- 3)날짜형(Field Types에서 type을 확인해야 한다.)
--  o Single Row FUNCTION
--   - TIMESTAMP(date), DATE(date), TIME(date): timestamp type, date type, time type으로 변환
--   - YEAR(date), MONTH(date), DAY(date): 년도, 월, 일 반환
--   - MONTHNAME(date), DAYNAME(date): 영어 월명, 일명 반환
--   - WEEKDAY(date): 요일 숫자(MONDAY 0, ... SUNDAY 6) 반환
--   - HOUR(date), MINUTE(date), SECOND(date): 시, 분, 초 반환
--   - EXTRACT([YEAR_MONTH|WEEK|DAY_HOUR|DAY_MINUTE|HOUR_MINUTE|HOUR_SECOND...] FROM date): a단위부터 b단위까지 나열한 정수를 반환
SELECT YEAR('2023-05-22 10:18:00'), MONTH('2023-05-22 10:18:00'), EXTRACT(YEAR_MONTH FROM '2023-05-22 10:18:00');

--   - DATEDIFF(end, begin): type이 같다는 조건 하에 end와 begin 사이 일 수 차이를 반환
--   - TIMEDIFF(end, begin): end와 begin 사이 시간 차이를 반환(최대 40일 차이까지 구함)
SELECT DATEDIFF(20230525101800, 20230523031800);
SELECT TIMEDIFF(20230525101800, 20230523031800);

--   - TIMESTAMPDIFF([SECOND|MINUTE|HOUR|DAY|WEEK|MONTH|QUARTER|YEAR], begin, end): end와 begin 사이 unit 단위 차이를 반환
SELECT PLAYER_NAME, BIRTH_DATE,
       TIMESTAMPDIFF(YEAR, BIRTH_DATE, DATE(NOW())) AS 만나이
FROM PLAYER;

--   - DATE_FORMAT(date, format): Python arrow의 date format형식으로 date 출력
SELECT DATE_FORMAT(20230525101800, '%Y-%M-%D');

--   - STR_TO_DATE(str, format): str을 Python arrow의 date format형식으로 설명해 날짜형 데이터로 변환
SELECT STR_TO_DATE('2023-05-22 10:18:00', '%Y-%m-%d %T');

-- 4)CAST 함수 & CONVERT 함수
--   CAST(exist AS UNSIGNED|REAL|CHAR|BINARY|DATE|TIME|DATETIME)
--   CONVERT(exist, UNSIGNED|REAL|CHAR|BINARY|DATE|TIME|DATETIME)

-- 5)NULL 함수
--   NULLIF(value1, value2): value1과 value2가 같지 않으면 value1, 같으면 NULL 반환

--   COALESCE(na, fillna): 결측치를 fillna로 대체
SELECT PLAYER_ID, PLAYER_NAME, HEIGHT, WEIGHT,
       ROUND(COALESCE(WEIGHT, 60)/((COALESCE(HEIGHT, 165)/100)*(COALESCE(HEIGHT, 165)/100)), 2) AS 'BMI 비만지수'
FROM PLAYER;
       
-- 6)CASE절 & IF함수
--   CASE WHEN con1 THEN return1 WHEN con2 THEN return2 ... END
--   - 조건을 탐색할 값, 열이 하나이며 등가연산 시 CASE con_column WHEN con1_value THEN return1 WHEN con2_value THEN return2 ... END로도 사용한다.
--   - CASE WHEN con THEN return ELSE else_value END로 else도 사용할 수 있다.
SELECT PLAYER_NAME,
       CASE POSITION WHEN 'FW' THEN 'FORWARD' 
                     WHEN 'DF' THEN 'DEFENSE' 
                     WHEN 'MF' THEN 'MIDFIELD' 
                     WHEN 'GK' THEN 'GOALKEEPER' 
                     ELSE 'UNDEFINED' END AS '포지션'
FROM PLAYER;
       
--   IF(con, return_true, return_false): 조건문에 참이면 return_true, 거짓이면 return_false를 반환
SELECT PLAYER_NAME,
       IF(POSITION='FW', 'FORWARD',
          IF(POSITION='DF', 'DEFENSE',
             IF(POSITION='MF', 'MIDFIELD',
				IF(POSITION='GK', 'GOALKEEPER', 'UNDEFINED')))) AS '포지션'
FROM PLAYER;

-- 3. DML Algebra
-- 1)JOIN
--  o 등가조인 시 WHERE에선 데이터 탐색 조건, FROM에는 JOIN 조건을 명시한다. JOIN조건은 JOIN column명이 같으면 USING, 다르면 ON을 사용해 명시한다.
--    단, ON을 사용할 경우 속성 호출 시 테이블명을 접두사로 사용해야 하며 USING을 사용할 경우는 테이블에 공통된 모든 속성이 JOIN조건이 됨에 유의해야 한다.
SELECT PLAYER_NAME, BACK_NO, TEAM_ID, TEAM_NAME, REGION_NAME
FROM PLAYER JOIN TEAM USING (TEAM_ID)
WHERE POSITION = 'GK'
ORDER BY BACK_NO;

SELECT S.STADIUM_ID, 
       SCHE_DATE, TEAM_NAME, HOME_SCORE
FROM SCHEDULE AS S JOIN TEAM AS T ON S.HOMETEAM_ID = T.TEAM_ID;

--  o 비등가조인 시 WHERE에서 JOIN조건을 명시하고 ON을 사용해 JOIN column을 선언한다.
--    예시를 위해 테이블을 추가 작성한다.
USE company;
CREATE TABLE SALARY_GRADE (
	GRADE	TINYINT		NOT NULL,
    LOW		MEDIUMINT	NOT NULL,
    HIGH	MEDIUMINT	NOT NULL,
	CONSTRAINT 	PK_SALARY_GRADE 	PRIMARY KEY (GRADE)
);

INSERT INTO SALARY_GRADE VALUES
(1, 50000, 100000),
(2, 40000, 49999),
(3, 30000, 39999),
(4, 20000, 29999),
(5, 10000, 19999),
(6, 0, 9999);

SELECT 	CONCAT(E.FNAME, ' ', E.MINIT, '. ', E.LNAME) AS 'FULL NAME', E.SALARY, G.GRADE 
FROM 	EMPLOYEE E, SALARY_GRADE G 
WHERE 	E.SALARY BETWEEN G.LOW AND G.HIGH;

DROP TABLE SALARY_GRADE;
USE kleague;

--  o 다중데이블 JOIN시 각 JOIN마다 JOIN 조건을 ON/USING으로 명시해야 한다.
SELECT PLAYER_NAME, REGION_NAME, TEAM_NAME, STADIUM_NAME
FROM PLAYER 
     JOIN TEAM USING (TEAM_ID)
     JOIN STADIUM USING (STADIUM_ID)
WHERE POSITION = 'GK'
ORDER BY PLAYER_NAME;

SELECT ST.STADIUM_NAME, SC.SCHE_DATE, HT.TEAM_NAME, SC.HOME_SCORE, SC.AWAY_SCORE
FROM SCHEDULE AS SC
     JOIN STADIUM AS ST ON SC.STADIUM_ID = ST.STADIUM_ID
     JOIN TEAM AS HT ON SC.HOMETEAM_ID = HT.TEAM_ID
     JOIN TEAM AS AT ON SC.AWAYTEAM_ID = AT.TEAM_ID
WHERE HOME_SCORE >= AWAY_SCORE + 3;

--  o JOIN의 default인 INNER JOIN에서 USING을 사용하면 NATURAL JOIN이다.
SELECT PLAYER_NAME, BACK_NO, TEAM_ID, TEAM_NAME, REGION_NAME
FROM PLAYER NATURAL JOIN TEAM
WHERE POSITION = 'GK'
ORDER BY BACK_NO;

--  o LEFT, RIGHT JOIN은 각 왼쪽 테이블에 오른쪽 테이블을, 오른쪽 테이블에 왼쪽 테이블을 붙이는 JOIN이다.
--    예시를 위해 테이블을 일부 수정한다.
ALTER TABLE 	TEAM
MODIFY COLUMN 	STADIUM_ID	CHAR(3);		/* NOT NULL 제약조건을 제거 */

INSERT INTO TEAM (TEAM_ID, REGION_NAME, TEAM_NAME, STADIUM_ID) VALUES 
('K16','서울','MBC청룡', NULL),
('K17','인천','삼미슈퍼스타즈', NULL);

SELECT 	TEAM_ID, TEAM_NAME, REGION_NAME, TEAM.STADIUM_ID, STADIUM_NAME, SEAT_COUNT 
FROM 	TEAM LEFT JOIN STADIUM USING (STADIUM_ID) 
ORDER 	BY TEAM_ID;

SELECT 	TEAM_ID, TEAM_NAME, REGION_NAME, TEAM.STADIUM_ID, STADIUM_NAME, SEAT_COUNT 
FROM 	TEAM RIGHT JOIN STADIUM USING (STADIUM_ID) 
ORDER 	BY TEAM_ID;

--  o OUTER JOIN을 위해선 UNION연산자로 LEFT JOIN과 RIGHT JOIN을 합친다.
SELECT 	TEAM_ID, TEAM_NAME, REGION_NAME, TEAM.STADIUM_ID, STADIUM_NAME, SEAT_COUNT 
FROM 	TEAM LEFT JOIN STADIUM USING (STADIUM_ID) 
UNION
SELECT 	TEAM_ID, TEAM_NAME, REGION_NAME, TEAM.STADIUM_ID, STADIUM_NAME, SEAT_COUNT 
FROM 	TEAM RIGHT JOIN STADIUM USING (STADIUM_ID) 
ORDER 	BY TEAM_ID;

DESCRIBE employee;
--  o 한 테이블 내 PK/FK관계를 JOIN으로 나타내는 재귀조인은 같은 테이블을 다른 별칭을 사용해 JOIN한다.
USE COMPANY;

SELECT EMP.Ssn, CONCAT(EMP.Fname, ', ', EMP.Minit, '. ', EMP.Lname) AS Employee,
	   MGR.Ssn, CONCAT(MGR.Fname, ', ', MGR.Minit, '. ', MGR.Lname) AS Manager
FROM employee AS EMP JOIN employee AS MGR ON EMP.Super_ssn = MGR.Ssn;

SELECT EMP.Ssn, CONCAT(EMP.Fname, ', ', EMP.Minit, '. ', EMP.Lname) AS Employee,
	   MGR.Ssn, CONCAT(MGR.Fname, ', ', MGR.Minit, '. ', MGR.Lname) AS Manager
FROM employee AS EMP LEFT JOIN employee AS MGR ON EMP.Super_ssn = MGR.Ssn;

SELECT EMP.Ssn, CONCAT(EMP.Fname, ', ', EMP.Minit, '. ', EMP.Lname) AS Employee,
	   MGR.Ssn, CONCAT(MGR.Fname, ', ', MGR.Minit, '. ', MGR.Lname) AS Manager,
       MGROFMGR.Ssn, CONCAT(MGROFMGR.Fname, ', ', MGROFMGR.Minit, '. ', MGROFMGR.Lname) AS ManagerOFManager
FROM employee AS EMP 
     LEFT JOIN employee AS MGR ON EMP.Super_ssn = MGR.Ssn
     LEFT JOIN employee AS MGROFMGR ON MGR.Super_ssn = MGROFMGR.Ssn;

-- 2)CTE
--  o 임시 테이블을 저장하는 WITH으로 CTE하면 연이어 사용할 수 있다.
USE Kleague;
WITH TEMP AS (SELECT TEAM_NAME, STADIUM_ID, STADIUM_NAME
              FROM TEAM JOIN STADIUM USING (STADIUM_ID))
SELECT TEAM_NAME, STADIUM_NAME
FROM TEMP;

WITH TEMP1 AS (SELECT SC.STADIUM_ID, SCHE_DATE, TEAM_NAME AS HOMETEAM_NAME, AWAYTEAM_ID, HOME_SCORE, AWAY_SCORE
               FROM TEAM AS T JOIN SCHEDULE AS SC ON T.TEAM_ID = SC.HOMETEAM_ID),
     TEAM2 AS (SELECT T1.STADIUM_ID, SCHE_DATE, HOMETEAM_NAME, TEAM_NAME AS AWAYTEAM_NAME, HOME_SCORE, AWAY_SCORE
			   FROM TEAM AS T JOIN TEMP1 AS T1 ON T.TEAM_ID = T1.AWAYTEAM_ID)
SELECT STADIUM_NAME, SCHE_DATE, HOMETEAM_NAME, AWAYTEAM_NAME, HOME_SCORE, AWAY_SCORE
FROM TEAM2 AS T2 JOIN STADIUM AS S ON T2.STADIUM_ID = S.STADIUM_ID
WHERE STADIUM_NAME = '인천월드컵경기장'
ORDER BY SCHE_DATE;

--  o CTE를 재귀적으로 사용하면 편리하게 Series를 생성할 수 있다. 두번째 SELECT에 재귀 조건을, WHERE에 재귀 종료 조건을 명시한다.
WITH RECURSIVE FIBONACCI(N, FIB_N, NEXT_FIB_N) AS (SELECT 1,0,1
												   UNION ALL
                                                   SELECT N+1, NEXT_FIB_N, FIB_N + NEXT_FIB_N
                                                   FROM FIBONACCI
                                                   WHERE N < 10)
SELECT *
FROM FIBONACCI;

WITH RECURSIVE DATES(D) AS (SELECT CAST(MIN(SCHE_DATE) AS DATE)
							FROM SCHEDULE
                               UNION ALL
							SELECT D + INTERVAL 1 DAY
							FROM DATES
							WHERE D + INTERVAL 1 DAY <= '2012-03-31')
SELECT DATES.D, COALESCE(COUNT(SCHE_DATE), 0) AS NO_OF_GAMES
FROM DATES LEFT JOIN SCHEDULE ON DATES.D = SCHEDULE.SCHE_DATE
GROUP BY DATES.D
ORDER BY DATES.D;

USE company;
WITH RECURSIVE EMPLOYEE_ANCHOR(SSN, NAME, LEVEL) AS (SELECT Ssn, CONCAT(Fname, ', ', Minit, '. ', Lname) AS name , 1
													 FROM employee
                                                     WHERE Super_ssn IS NULL
                                                     UNION ALL
                                                     SELECT e.Ssn, e.name, LEVEL+1
                                                     FROM EMPLOYEE_ANCHOR AS ea JOIN (SELECT Super_ssn, Ssn, CONCAT(Fname, ', ', Minit, '. ', Lname) AS name FROM employee) AS e ON ea.Ssn=e.Super_ssn)
SELECT *
FROM EMPLOYEE_ANCHOR;

WITH RECURSIVE EMPLOYEE_ANCHOR(SSN, NAME, PATH) AS (SELECT Ssn, CONCAT(Fname, ', ', Minit, '. ', Lname) AS name , CAST(Ssn AS CHAR(200))
													 FROM employee
                                                     WHERE Super_ssn IS NULL
                                                     UNION ALL
                                                     SELECT e.Ssn, e.name, CONCAT(ea.PATH, ':', e.Ssn)
                                                     FROM EMPLOYEE_ANCHOR AS ea JOIN (SELECT Super_ssn, Ssn, CONCAT(Fname, ', ', Minit, '. ', Lname) AS name FROM employee) AS e ON ea.Ssn=e.Super_ssn)
SELECT *
FROM EMPLOYEE_ANCHOR
ORDER BY PATH;

--  o 재귀적 CTE는 데이터 타입 변환에도 유용하다.
WITH RECURSIVE CTE(N, STR) AS (SELECT 1, CAST('ABC' AS CHAR(30))
                               UNION ALL
                               SELECT N+1, CONCAT(STR, STR) FROM CTE
                               WHERE N < 4)
SELECT *
FROM CTE;

-- 4. DML SubQuery
--  o 보통 WHERE절에서 Query조건을 서술하나 SELECT절에서 선언해 column generation이 가능하고 
--    FROM절에서 선언해 Inner Join처럼, HAVING절에서 선언해 GROUP BY와 함께 WHERE 선언처럼 사용가능하다.
SELECT TEAM_ID, TEAM_NAME,
       (SELECT COUNT(*) FROM PLAYER AS Y WHERE X.TEAM_ID = Y.TEAM_ID) AS 팀원수
FROM TEAM AS X
ORDER BY TEAM_ID;
 
 SELECT PLAYER_NAME, POSITION, BACK_NO, HEIGHT
 FROM (SELECT PLAYER_NAME, POSITION, BACK_NO, HEIGHT
       FROM PLAYER
	   WHERE HEIGHT IS NOT NULL
       ORDER BY HEIGHT DESC) AS TEMP
LIMIT 5;

SELECT TEAM_ID, TEAM_NAME, AVG(HEIGHT)
FROM TEAM JOIN PLAYER USING (TEAM_ID)
GROUP BY TEAM_ID
HAVING AVG(HEIGHT) < (SELECT AVG(HEIGHT) FROM PLAYER WHERE TEAM_ID='K02'); 

--  o 비연관 서브쿼리는 메인쿼리에 사용할 scaler나 조건만 제공한다.
--    다중값 서브쿼리에서 ANY|SOME은 조건에 OR, ALL은 조건에 AND인 결과만 반환한다. 다중행 서브쿼리에서 IN은 조건에 OR, EXISTS는 최초의 조건만족 tuple만 탐색한다.
SELECT PLAYER_NAME, POSITION, BACK_NO
FROM PLAYER
WHERE HEIGHT <= (SELECT AVG(HEIGHT) FROM PLAYER)
ORDER BY PLAYER_NAME;

SELECT REGION_NAME, TEAM_NAME, E_TEAM_NAME
FROM TEAM
WHERE TEAM_ID = ANY (SELECT TEAM_ID FROM PLAYER WHERE PLAYER_NAME = '정현수')
ORDER BY TEAM_NAME;

SELECT TEAM_ID, PLAYER_NAME, POSITION, BACK_NO, HEIGHT
FROM PLAYER
WHERE (TEAM_ID, HEIGHT) IN (SELECT TEAM_ID, MIN(HEIGHT)
							FROM PLAYER
                            GROUP BY TEAM_ID)
ORDER BY TEAM_ID, PLAYER_NAME;

--  o 연관 서브쿼리는 두 쿼리간 직접적인 연산을 수행한다. Subquery의 WHERE 절에서 두 쿼리의 Join & Grouping 조건을 선언한다.
--    다중값 서브쿼리에서 ANY|SOME은 조건에 OR, ALL은 조건에 AND인 결과만 반환한다. 다중행 서브쿼리에서 IN은 조건에 OR, EXISTS는 최초의 조건만족 tuple만 탐색한다.
SELECT TEAM_ID, PLAYER_NAME, HEIGHT
FROM PLAYER AS X
WHERE HEIGHT = (SELECT MAX(HEIGHT) FROM PLAYER AS Y WHERE X.TEAM_ID = Y.TEAM_ID)
ORDER BY TEAM_ID;

SELECT TEAM_ID, TEAM_NAME
FROM TEAM AS T
WHERE TEAM_ID = ANY (SELECT TEAM_ID FROM PLAYER AS P WHERE T.TEAM_ID=P.TEAM_ID AND NATION IN ('브라질', '러시아'));

SELECT STADIUM_ID, STADIUM_NAME
FROM STADIUM AS ST
WHERE STADIUM_ID IN (SELECT STADIUM_ID FROM SCHEDULE AS SC WHERE SCHE_DATE BETWEEN '20120501' AND '20120502' AND ST.STADIUM_ID = SC.STADIUM_ID);







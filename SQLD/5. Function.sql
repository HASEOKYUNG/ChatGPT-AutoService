USE Kleague;

-- [DML_SingleRowFunction, P.23] 선수의 이름, 출생년도, 출생월, 출생일을 출력하시오
SELECT PLAYER_NAME, YEAR(BIRTH_DATE), MONTH(BIRTH_DATE), DAY(BIRTH_DATE)
FROM PLAYER;

-- [DML_SingleRowFunction, P.28] 선수의 이름과 나이를 출력하시오
SELECT PLAYER_NAME, TIMESTAMPDIFF(YEAR, BIRTH_DATE, NOW())
FROM PLAYER;

-- [DML_SingleRowFunction, P.46] K08팀의 이름과 포지션, 키를 출력하시오. 단 포지션과 키의 정보가 없을 때는 각각 *****, 0 으로 출력하시오
SELECT PLAYER_NAME, COALESCE(POSITION, '*****'), COALESCE(HEIGHT, 0)
FROM PLAYER
WHERE TEAM_ID = 'K08';

-- [DML_SingleRowFunction, P.47] 선수의 이름과 영어이름을 출력하시오. 영어이름이 없으면 닉네임을 출력하시오
SELECT PLAYER_NAME, COALESCE(E_PLAYER_NAME, NICKNAME)
FROM PLAYER;

-- [DML_Algebra P.17] K02 혹은 K07 팀 선수들을 검색 (UNION 사용)
SELECT *
FROM PLAYER
WHERE TEAM_ID = 'K02'
UNION 
SELECT *
FROM PLAYER
WHERE TEAM_ID = 'K07';

-- [DML_Algebra P.22] 소속이 K02 팀이면서 포지션이 GK인 선수들을 검색
SELECT *
FROM PLAYER
WHERE TEAM_ID = 'K02' AND POSITION = 'GK';

-- [DML_Algebra P.25] K02팀이면서 포지션이 MF가 아닌 선수들을 검색
SELECT *
FROM PLAYER
WHERE TEAM_ID = 'K02' AND POSITION <> 'MF';

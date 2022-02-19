/******************************************
* 경기데이터드림 OpenApi 응답 명세를 분석한다.
******************************************/
-- ------------------------------------------------
-- [A] 계정, 데이터베이스, 테이블 생성
-- ------------------------------------------------
-- 01. 계정 생성(ID: data_analysis / PW: data_analysis)
-- DROP USER 'analysis'@'localhost';-- 계정삭제
CREATE USER 'analysis'@'localhost' IDENTIFIED BY 'analysis';
use analysis;

-- 02. 데이터베이스 생성(이름: DATA_ANALYSIS)
-- DROP DATABASE ANALYSIS;데이터 베이스 삭제
CREATE DATABASE ANALYSIS DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;


-- 03.사용자 권한 부여(전체 권한)
-- grant select on db스키마.* to `계정이름`@`localhost` identified by '비밀번호'; SELECT 권한만 부여
 GRANT ALL PRIVILEGES ON ANALYSIS.* TO 'analysis'@'localhost';
-- GRANT ALL PRIVILEGES ON * TO 'analysis'@'localhost';
FLUSH PRIVILEGES;

-- 04. 테이블 생성
-- 04.01. API_마스터
-- drop table API_MST;
CREATE TABLE API_MST (
  API_MST_ID INT unsigned not null auto_increment COMMENT 'API_마스터_기본키',
  INF_ID CHAR(28) NOT NULL                        COMMENT '공공데이터ID',
  INF_NM VARCHAR(49) not null                     COMMENT '공공데이터명',
  CALL_URL VARCHAR(55) not null                   COMMENT '호출URL',
  PRIMARY KEY (API_MST_ID)
)
COMMENT='API_마스터'
;
-- 04.02. API_상세
drop table API_DTL;
CREATE TABLE API_DTL (
  API_MST_ID INT unsigned not null                COMMENT 'API_마스터_참조키',
  API_DTL_ID INT unsigned not null auto_increment COMMENT 'API_상세_기본키',
  COL_ID CHAR(30) NOT NULL                        COMMENT '항목ID',
  COL_NM VARCHAR(30) not null                     COMMENT '항목명',
  COL_TYPE VARCHAR(6) not null                    COMMENT '항목타입',
  REQ_YN CHAR(1) not null                         COMMENT '요청인자여부',
  PRIMARY KEY (API_DTL_ID),
  foreign KEY(API_MST_ID) references API_MST(API_MST_ID)
)
COMMENT='API_상세'


-- ------------------------------------------------
-- [B] 생정 정보 확인하기
-- ------------------------------------------------
-- 계정 확인하기
select host, user, password from MYSQL.user;

select LENGTH('KE22KP2IJFD15YD0W4BU29615963');

-- ------------------------------------------------
-- [C] 전처리 
-- ------------------------------------------------
-- 01. API_임
CREATE TABLE API_TMP(
  INF_ID CHAR(28) NOT NULL                        COMMENT '공공데이터ID',
  INF_NM VARCHAR(49) not null                     COMMENT '공공데이터명',
  CALL_URL VARCHAR(55) not null                   COMMENT '호출URL',
  COL_ID CHAR(30) NOT NULL                        COMMENT '항목ID',
  COL_NM VARCHAR(30) not null                     COMMENT '항목명',
  COL_TYPE VARCHAR(6) not null                    COMMENT '항목타입',
  REQ_YN CHAR(1) not null                         COMMENT '요청인자여부'
);

-- 02. 데이터 등록
insert into API_TMP (
  INF_ID, INF_NM, CALL_URL, COL_ID, COL_NM, COL_TYPE, REQ_YN
) VALUES (
 %(INF_ID)s, %(INF_NM)s, %(CALL_URL)s, %(COL_ID)s, %(COL_NM)s, %(COL_TYPE)s, %(REQ_YN)s
)
;

-- 03. 데이터 분할 저장 
-- 03.01.중복데이터를 제거하고 api_mst 저장한다.
insert into api_mst(inf_id, inf_nm, call_url) 
  select distinct inf_id, inf_nm, call_url -- distinct: 중복을 제거한다. 
  from api_tmp
;
SELECT COUNT(*) as cnt from api_mst

-- 03.02. api_dt1 저장한다. 
insert into api_dtl(api_mst_id, COL_ID, COL_NM, COL_TYPE, REQ_YN)
select api_mst_id, COL_ID, COL_NM, COL_TYPE, REQ_YN
  from api_tmp a
 inner join api_mst b on a.inf_id = b.inf_id 
; 

select * from api_dtl;
select count(*) as cnt from api_dtl;
truncate table api_dtl; -- 테이블 초기화

-- ------------------------------------------------
-- [D] 데이터 분석 
-- ------------------------------------------------
-- 01. 오픈 API의 총 갯수를 구하시오. 
select count(*) as CNT from API_MST AM;

-- 02. 공공데이터명 별 항목 총 갯수를 구하시오. 
select A.INF_NM, count(*) as CNT
 from API_MST A
 inner join API_DTL B on A.API_MST_ID = B.API_MST_ID 
 Group By A.INF_NM 
 order by count(*)
 
 -- 03. 데이터(항목) 타입별 총 갯수를 구하시오. 
 select COL_TYPE, COUNT(*) as CNT
  from API_DTL 
  Group By COL_TYPE;
 
 -- 04. 공공데이터명을 항목 타입이 텍스트보다 숫자형이 많은 것을 기준으로 내림차순으로 정령 하시오. (단, 텍스트 갯수가 더 많은 것을 빼시오.)
 select INF_NM, TEXT_CNT, NUMBER_CNT, (NUMBER_CNT - TEXT_CNT) as NUMBER_DIFF
 	from (
 	 select A.INF_NM
  		, SUM( case when COL_TYPE = 'TEXT' then 1 else 0 END ) as TEXT_CNT
  		, SUM( case when COL_TYPE = 'NUMBER' then 1 else 0 END ) as NUMBER_CNT
  	  from API_MST A 
	 inner join API_DTL B on A.API_MST_ID = B.API_MST_ID
 	group by A.INF_NM 
 	) A1
   where NUMBER_CNT - TEXT_CNT >= 1
   order by NUMBER_DIFF DESC
;

-- 05. 호출 URL에서 API_KEY를 추출하여 출력하시오. SUBSTRING('문자열', 시작위치_숫자, 종료위치_숫자)
select SUBSTRING(CALL_URL2, INSTR(CALL_URL2, '/')+1, END_IDX) as AKP_KEY
 from (
 select CALL_URL, REPLACE(CALL_URL, '//', '||') as CALL_URL2, LENGTH(CALL_URL) as END_IDX
  from API_MST 
  ) A1
 ;

select replace(CALL_URL, 'https://openapi.gg.go.kr/','') as CALL_URL from API_MST;

SELECT * FROM api_tmp;
SELECT * FROM api_mst;
inser_sql1 = "INSERT INTO PEOPLE VALUES (%s, %s);"
execute(insert_sql1, ('1', '2')) # 튜플 
inser_sql2 = "INSERT INTO PEOPLE VALUES (%(name)s, (%(age)s, (%(age)s;"
execute (inser_sql2, {'name':'1', 'age': '2') # 딕셔너리 

truncate table api_tmp; -- 테이블 초기화
delete table api_tmp; -- 테이블의 데이터 삭제 
SELECT * FROM API_TMP;
rollback; -- 취소 하겠다.
commit; -- 처리 하겠다. 

SELECT COUNT(*) as cnt from api_tmp
/*
영문명	한글명
0	INF_ID	공공데이터ID
1	INF_NM	공공데이터명
2	CALL_URL	호출URL
3	COL_ID	항목ID
4	COL_NM	항목명
5	COL_TYPE	항목타입
6	REQ_YN	요청인자여부
*/

-- ------------------------------------------------
-- [Z] 기본 명령어
-- ------------------------------------------------
show databases;

SELECT * FROM `information_schema`.`COLUMNS` WHERE TABLE_SCHEMA='mysql' AND TABLE_NAME='db' ORDER BY ORDINAL_POSITION;
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

-- 03. 데이터베이스 생성(이름: DATA_ANALYSIS)
-- DROP DATABASE ANALYSIS;데이터 베이스 삭제
CREATE DATABASE ANALYSIS DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;


-- 03.사용자 권한 부여(전체 권한)
-- grant select on db스키마.* to `계정이름`@`localhost` identified by '비밀번호'; SELECT 권한만 부여
 GRANT ALL PRIVILEGES ON ANALYSIS.* TO 'analysis'@'localhost';
--GRANT ALL PRIVILEGES ON * TO 'analysis'@'localhost';
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
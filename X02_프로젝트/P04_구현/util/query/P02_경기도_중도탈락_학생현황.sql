/***************************
* API
***************************/
-- https://data.gg.go.kr/portal/data/service/selectServicePage.do?page=1&sortColumn=&sortDirection=&infId=PKXK9CTFOMGX0A54JQQJ24066729&infSeq=1
-- 중도탈락 학생 현황(대학원,대학원대학) :: 경기도 내에 소재한 대학원과, 대학원 대학교의 중도탈락 학생 현황입니다.
-- 
--drop table api_student_out;
CREATE TABLE api_student_out(
-- [02] 중도탈락_학생_현황
	idx integer PRIMARY KEY,    -- 기본키
	STD_YY char(4) NOT NULL,    -- 기준년도
	SCHOOL_KIND_NM varchar(20), -- 학교종류명
	FOUND_DIV_NM varchar(20),   -- 설립구분명
	SCHOOL_NM varchar(50),      -- 학교명
	MJR_NM varchar(30),         -- 학과명(전공)
	DIV_NM varchar(10),         -- 구분명
	MJR_CHARTR_NM varchar(20),  -- 학과특성명
	MJR_STATE_NM varchar(20),   -- 학과상태명
	ERSTD_CNT int,              -- 재적학생수(A)(명)
	MASTER_SUM int,             -- 석사합계(B)(명)
	MASTER_NON_REGIST_CNT int,  -- 석사미등록수(명)
	MASTER_NON_GBSCHL_CNT int,  -- 석사미복학수(명)
	MASTER_LVSCHL_CNT int,      -- 석사자퇴수(명)
	MASTER_CLGRD_WARN_CNT int,  -- 석사학사경고수(명)
	MASTER_STDNT_ACT_CNT int,   -- 석사학생활동수(명)
	MASTER_FLK_EXPL_CNT int,    -- 석사유급제적수(명)
	MASTER_CLAS_TERM_EXCESS_CNT int, -- 석사수업연한초과수(명)
	MASTER_ETC_CNT int,              -- 석사기타수(명)
	DR_SUM int,                      -- 박사합계(C)(명)
	DR_NON_REGIST_CNT int,           -- 박사미등록수(명)
	DR_NON_GBSCHL_CNT int,           -- 박사미복학수(명)
	DR_LVSCHL_CNT int,               -- 박사자퇴수(명)
	DR_CLGRD_WARN_CNT int,           -- 박사학사경고수(명)
	DR_STDNT_ACT_CNT int,            -- 박사학생활동수(명)
	DR_FLK_EXPL_CNT int,             -- 박사유급제적수(명)
	DR_CLAS_TERM_EXCESS_CNT int,     -- 박사수업연한초과수(명)
	DR_ETC_CNT int,                  -- 박사기타수(명)
	MDR_UNITY_SUM int,               -- 석박사통합합계(D)(명)
	MDR_UNITY_NON_REGIST_CNT int,    -- 석박사통합미등록수(명)
	MDR_UNITY_NON_GBSCHL_CNT int,    -- 석박사통합미복학수(명)
	MDR_UNITY_LVSCHL_CNT int,        -- 석박사통합자퇴수(명)
	MDR_UNITY_CLGRD_WARN_CNT int,    -- 석박사통합학사경고수(명)
	MDR_UNITY_STDNT_ACT_CNT int,     -- 석박사통합학생활동수(명)
	MDR_UNITY_FLK_EXPL_CNT int,      -- 석박사통합유급제적수(명)
	MDR_UNITY_CLAS_TERM_EXCESS_CNT int, -- 석박사통합수업연한초과수(명)
	MDR_UNITY_ETC_CNT int,              -- 석박사통합기타수(명)
	TOTSUM int,                         -- 총계(E)(명)
	HFWY_DROT_STDNT_RT int              -- 중도탈락학생비율(%)((E/A) × 100)(%)
);

-- 데이터 삭제
delete from api_student_out;

-- 데이터 등록
INSERT INTO api_student_out
(STD_YY, SCHOOL_KIND_NM, FOUND_DIV_NM, SCHOOL_NM, MJR_NM, DIV_NM, MJR_CHARTR_NM, MJR_STATE_NM, ERSTD_CNT, MASTER_SUM, MASTER_NON_REGIST_CNT, MASTER_NON_GBSCHL_CNT, MASTER_LVSCHL_CNT, MASTER_CLGRD_WARN_CNT, MASTER_STDNT_ACT_CNT, MASTER_FLK_EXPL_CNT, MASTER_CLAS_TERM_EXCESS_CNT, MASTER_ETC_CNT, DR_SUM, DR_NON_REGIST_CNT, DR_NON_GBSCHL_CNT, DR_LVSCHL_CNT, DR_CLGRD_WARN_CNT, DR_STDNT_ACT_CNT, DR_FLK_EXPL_CNT, DR_CLAS_TERM_EXCESS_CNT, DR_ETC_CNT, MDR_UNITY_SUM, MDR_UNITY_NON_REGIST_CNT, MDR_UNITY_NON_GBSCHL_CNT, MDR_UNITY_LVSCHL_CNT, MDR_UNITY_CLGRD_WARN_CNT, MDR_UNITY_STDNT_ACT_CNT, MDR_UNITY_FLK_EXPL_CNT, MDR_UNITY_CLAS_TERM_EXCESS_CNT, MDR_UNITY_ETC_CNT, TOTSUM, HFWY_DROT_STDNT_RT)
VALUES(:STD_YY,:SCHOOL_KIND_NM,:FOUND_DIV_NM,:SCHOOL_NM,:MJR_NM,:DIV_NM,:MJR_CHARTR_NM,:MJR_STATE_NM,:ERSTD_CNT,:MASTER_SUM,:MASTER_NON_REGIST_CNT,:MASTER_NON_GBSCHL_CNT,:MASTER_LVSCHL_CNT,:MASTER_CLGRD_WARN_CNT,:MASTER_STDNT_ACT_CNT,:MASTER_FLK_EXPL_CNT,:MASTER_CLAS_TERM_EXCESS_CNT,:MASTER_ETC_CNT,:DR_SUM,:DR_NON_REGIST_CNT,:DR_NON_GBSCHL_CNT,:DR_LVSCHL_CNT,:DR_CLGRD_WARN_CNT,:DR_STDNT_ACT_CNT,:DR_FLK_EXPL_CNT,:DR_CLAS_TERM_EXCESS_CNT,:DR_ETC_CNT,:MDR_UNITY_SUM,:MDR_UNITY_NON_REGIST_CNT,:MDR_UNITY_NON_GBSCHL_CNT,:MDR_UNITY_LVSCHL_CNT,:MDR_UNITY_CLGRD_WARN_CNT,:MDR_UNITY_STDNT_ACT_CNT,:MDR_UNITY_FLK_EXPL_CNT,:MDR_UNITY_CLAS_TERM_EXCESS_CNT,:MDR_UNITY_ETC_CNT,:TOTSUM,:HFWY_DROT_STDNT_RT)
;

-- 목록 조회
select * from api_student_out;

-- 등록 건수 조회
select count(*) from api_student_out;


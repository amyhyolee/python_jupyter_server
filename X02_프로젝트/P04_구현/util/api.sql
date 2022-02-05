/***************************
* API
***************************/

-- https://data.gg.go.kr/portal/data/service/selectServicePage.do?page=1&sortColumn=&sortDirection=&infId=K2P9SMVB0O4JL6G9J5O524087836&infSeq=1
-- 졸업생의 취업현황(일반대학원) :: 경기도 소재 일반대학원 졸업생의 취업현황입니다.
-- 
--drop table api_student_status;
CREATE TABLE api_student_status(
-- [01] 졸업생의 취업현황(일반대학원
  idx integer PRIMARY KEY,    -- 기본키
  STD_YY char(4) NOT NULL,    -- 기준년도
  SCHOOL_KIND_NM varchar(20), -- 학교종류명
  FOUND_DIV_NM varchar(20),   -- 설립구분명
  SCHOOL_NM varchar(50),      -- 학교명
  COLGE_UNIV_NM varchar(20),  -- 단과대학명
  MJR_NM varchar(30),         -- 학과명(전공)
  DIV_NM varchar(10),         -- 구분명
  MJR_CHARTR_NM varchar(20),  -- 학과특성명
  MALE_GRA_CNT int,           -- 남자졸업자수(A)(명)
  FEMALE_GRA_CNT int,         -- 여자졸업자수(A)(명)
  HTIR_CONCTN_MALE_EMPLYE_CNT int,   -- 건강보험연계남자취업자수(B)(명)
  HTIR_CONCTN_FEMALE_EMPLYE_CNT int, -- 건강보험연계여자취업자수(B)(명)
  OVSEA_MALE_EMPLYE_CNT int,         -- 해외남자취업자수(B)(명)
  OVSEA_FEMALE_EMPLYE_CNT int,       -- 해외여자취업자수(B)(명)
  FARMJ_MALE_ENFLPSN_CNT int,        -- 영농업남자종사자수(B)(명)
  FARMJ_FEMALE_ENFLPSN_CNT int,      -- 영농업여자종사자수(B)(명)
  INDVDL_CRAT_MALE_ENFLPSN_CNT int,  -- 개인창작활동남자종사자수(B)(명)
  INDVDL_CRAT_FEMALE_ENFLPSN_CNT int,-- 개인창작활동여자종사자수(B)(명)
  PSN1_MALE_FUDR_CNT int,            -- 1인남자창(사)업자수(B)(명)
  PSN1_FEMALE_FUDR_CNT int,          -- 1인여자창(사)업자수(B)(명)
  MALE_FRLAC_CNT int,                -- 남자프리랜서수(B)(명)
  FEMALE_FRLAC_CNT int,              -- 여자프리랜서수(B)(명)
  ETSHP_MALE_CNT int,                -- 진학자남자수(C)(명)
  ETSHP_FEMALE_CNT int,              -- 진학자여자수(C)(명)
  RECR_CNT int,                      -- 입대자수(D)(명)
  EMPLYMT_NO_POSBL_MALE_CNT int,     -- 취업불가능남자수(E)(명)
  EMPLYMT_NO_POSBL_FEMALE_CNT int,   -- 취업불가능여자수(E)(명)
  FRGNR_INTSTD_MALE_CNT int,         -- 외국인유학생남자수(F)(명)
  FRGNR_INTSTD_FEMALE_CNT int,       -- 외국인유학생여자수(F)(명)
  HTIR_JOSUBSE_MALE_TRGTER_CNT int,  -- 건강보험직장가입제외남자대상자수(G)(명)
  HTIR_JOSUBSE_FEMALE_TRGTER_CNT int,-- 건강보험직장가입제외여자대상자수(G)(명)
  MALE_ETC_PSN_CNT int,              -- 남자기타인원수(명)
  FEMALE_ETC_PSN_CNT int,            -- 여자기타인원수(명)
  MALE_UKNWN_PSN_CNT int,            -- 남자미상인원수(명)
  FEMALE_UKNWN_PSN_CNT int,          -- 여자미상인원수(명)
  EMPLYMT_RT int,                    -- 취업률(%) [B/{A-(C+D+E+F+G))]x100(%)
  ENSCHAT_MALE_ATHT_EMPLYE_CNT int,  -- 입학당시남자기취업자수(명)
  ENSCHAT_FEMALE_ATHT_EMPLYE_CNT int,-- 입학당시여자기취업자수(명)
  TSCHGRD_MALE_EMPLYE_CNT int,       -- 교내남자취업자수(명)
  TSCHGRD_FEMALE_EMPLYE_CNT int,     -- 교내여자취업자수(명)
  PRMRY_MAINTNC_SUM_EMPRT int,       -- 1차유지합계취업률(수시)(%)
  PRMRY_MAINTNC_MALE_EMPRT int,      -- 1차유지남자취업률(수시)(%)
  PRMRY_MAINTNC_FEMALE_EMPRT int,    -- 1차유지여자취업률(수시)(%)
  SECND_MAINTNC_SUM_EMPRT int,       -- 2차유지합계취업률(수시)(%)
  SECND_MAINTNC_MALE_EMPRT int,      -- 2차유지남자취업률(수시)(%)
  SECND_MAINTNC_FEMALE_EMPRT int,    -- 2차유지여자취업률(수시)(%)
  TERT_MAINTNC_SUM_EMPRT int,        -- 3차유지합계취업률(수시)(%)
  TERT_MAINTNC_MALE_EMPRT int,       -- 3차유지남자취업률(수시)(%)
  TERT_MAINTNC_FEMALE_EMPRT int,     -- 3차유지여자취업률(수시)(%)
  QUAT_MAINTNC_SUM_EMPRT int,        -- 4차유지합계취업률(수시)(%)
  QUAT_MAINTNC_MALE_EMPRT int,       -- 4차유지남자취업률(수시)(%)
  QUAT_MAINTNC_FEMALE_EMPRT int      -- 4차유지여자취업률(수시)(%)
);

-- 데이터 삭제
delete from api_student_status;

-- 데이터 등록
-- https://www.sqlitetutorial.net/sqlite-insert/
INSERT INTO api_student_status
(STD_YY, SCHOOL_KIND_NM, FOUND_DIV_NM, SCHOOL_NM, COLGE_UNIV_NM, MJR_NM, DIV_NM, MJR_CHARTR_NM, MALE_GRA_CNT, FEMALE_GRA_CNT, HTIR_CONCTN_MALE_EMPLYE_CNT, HTIR_CONCTN_FEMALE_EMPLYE_CNT, OVSEA_MALE_EMPLYE_CNT, OVSEA_FEMALE_EMPLYE_CNT, FARMJ_MALE_ENFLPSN_CNT, FARMJ_FEMALE_ENFLPSN_CNT, INDVDL_CRAT_MALE_ENFLPSN_CNT, INDVDL_CRAT_FEMALE_ENFLPSN_CNT, PSN1_MALE_FUDR_CNT, PSN1_FEMALE_FUDR_CNT, MALE_FRLAC_CNT, FEMALE_FRLAC_CNT, ETSHP_MALE_CNT, ETSHP_FEMALE_CNT, RECR_CNT, EMPLYMT_NO_POSBL_MALE_CNT, EMPLYMT_NO_POSBL_FEMALE_CNT, FRGNR_INTSTD_MALE_CNT, FRGNR_INTSTD_FEMALE_CNT, HTIR_JOSUBSE_MALE_TRGTER_CNT, HTIR_JOSUBSE_FEMALE_TRGTER_CNT, MALE_ETC_PSN_CNT, FEMALE_ETC_PSN_CNT, MALE_UKNWN_PSN_CNT, FEMALE_UKNWN_PSN_CNT, EMPLYMT_RT, ENSCHAT_MALE_ATHT_EMPLYE_CNT, ENSCHAT_FEMALE_ATHT_EMPLYE_CNT, TSCHGRD_MALE_EMPLYE_CNT, TSCHGRD_FEMALE_EMPLYE_CNT, PRMRY_MAINTNC_SUM_EMPRT, PRMRY_MAINTNC_MALE_EMPRT, PRMRY_MAINTNC_FEMALE_EMPRT, SECND_MAINTNC_SUM_EMPRT, SECND_MAINTNC_MALE_EMPRT, SECND_MAINTNC_FEMALE_EMPRT, TERT_MAINTNC_SUM_EMPRT, TERT_MAINTNC_MALE_EMPRT, TERT_MAINTNC_FEMALE_EMPRT, QUAT_MAINTNC_SUM_EMPRT, QUAT_MAINTNC_MALE_EMPRT, QUAT_MAINTNC_FEMALE_EMPRT)
VALUES(:STD_YY, :SCHOOL_KIND_NM, :FOUND_DIV_NM, :SCHOOL_NM, :COLGE_UNIV_NM, :MJR_NM, :DIV_NM, :MJR_CHARTR_NM, :MALE_GRA_CNT, :FEMALE_GRA_CNT, :HTIR_CONCTN_MALE_EMPLYE_CNT, :HTIR_CONCTN_FEMALE_EMPLYE_CNT, :OVSEA_MALE_EMPLYE_CNT, :OVSEA_FEMALE_EMPLYE_CNT, :FARMJ_MALE_ENFLPSN_CNT, :FARMJ_FEMALE_ENFLPSN_CNT, :INDVDL_CRAT_MALE_ENFLPSN_CNT, :INDVDL_CRAT_FEMALE_ENFLPSN_CNT, :PSN1_MALE_FUDR_CNT, :PSN1_FEMALE_FUDR_CNT, :MALE_FRLAC_CNT, :FEMALE_FRLAC_CNT, :ETSHP_MALE_CNT, :ETSHP_FEMALE_CNT, :RECR_CNT, :EMPLYMT_NO_POSBL_MALE_CNT, :EMPLYMT_NO_POSBL_FEMALE_CNT, :FRGNR_INTSTD_MALE_CNT, :FRGNR_INTSTD_FEMALE_CNT, :HTIR_JOSUBSE_MALE_TRGTER_CNT, :HTIR_JOSUBSE_FEMALE_TRGTER_CNT, :MALE_ETC_PSN_CNT, :FEMALE_ETC_PSN_CNT, :MALE_UKNWN_PSN_CNT, :FEMALE_UKNWN_PSN_CNT, :EMPLYMT_RT, :ENSCHAT_MALE_ATHT_EMPLYE_CNT, :ENSCHAT_FEMALE_ATHT_EMPLYE_CNT, :TSCHGRD_MALE_EMPLYE_CNT, :TSCHGRD_FEMALE_EMPLYE_CNT, :PRMRY_MAINTNC_SUM_EMPRT, :PRMRY_MAINTNC_MALE_EMPRT, :PRMRY_MAINTNC_FEMALE_EMPRT, :SECND_MAINTNC_SUM_EMPRT, :SECND_MAINTNC_MALE_EMPRT, :SECND_MAINTNC_FEMALE_EMPRT, :TERT_MAINTNC_SUM_EMPRT, :TERT_MAINTNC_MALE_EMPRT, :TERT_MAINTNC_FEMALE_EMPRT, :QUAT_MAINTNC_SUM_EMPRT, :QUAT_MAINTNC_MALE_EMPRT, :QUAT_MAINTNC_FEMALE_EMPRT);

-- 목록 조회
select * from api_student_status;

-- 등록 건수 조회
select count(*) from api_student_status;


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


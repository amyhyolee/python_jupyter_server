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


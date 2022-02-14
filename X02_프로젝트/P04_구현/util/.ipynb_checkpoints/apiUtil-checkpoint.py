#################################################
# 공공 데이터 API
#
# version: v1.0 
# author(s): shinil.kim
# since: 2022.01.24
#################################################

from re import A
import pandas as pd
import requests, json, sqlite3, sys, time

#################################################
# Api 클래스
#################################################
class Api:
    @staticmethod
    def get(url, pIndex, pSize):
        status = 0
        total_cnt = 0
        data = {}
        name = url[url.rindex("/")+1:url.rindex("?")]
        try:
            url = url+str(pIndex)+"&pSize="+str(pSize)
            res = requests.get(url, timeout=(3, 30))
            status = res.status_code
            if status == 200:
                data = json.loads(res.text)
                total_cnt = data[name][0]['head'][0]['list_total_count']

        except requests.exceptions.Timeout as e:
            print(e)
            status = 500
        return {"status": status, "total_cnt": total_cnt, "data": data[name][1]['row']}

    @staticmethod
    def Grduemplymtgenrlgdhl(mode=None):
        """
        [졸업생의 취업현황(일반대학원)] 공공 데이터 DB 적재
        """
        start = time.time()
        dao = SQLiteDao() if mode is None else SQLiteDao(sys.path[0]+"/api.sqlite3")
        print("기존 데이터가 %d 건 삭제되었습니다." % dao.delete("delete from api_student_status"))

        url = "https://openapi.gg.go.kr/Grduemplymtgenrlgdhl?KEY=d1e335be21894375b7b0a15146dcf761&type=json&pIndex="
        pIndex = 1 # 페이지 번호
        pSize = 300  # 페이지 블럭
        targetCnt = 0 # 대상건수
        recvCnt = 0 # 수신건수

        result = Api.get(url, pIndex, pSize)
        targetCnt = result['total_cnt']
        recvCnt += len(result['data'])
        print("http status: ", result['status'])
        print("총 건수: ", targetCnt)
        # print(json.dumps(result['data'], indent=2, sort_keys=True, ensure_ascii=False))
        affected = 0
        while targetCnt >= recvCnt:
            try:
                sql = """
                    INSERT INTO api_student_status
                    (STD_YY, SCHOOL_KIND_NM, FOUND_DIV_NM, SCHOOL_NM, COLGE_UNIV_NM, MJR_NM, DIV_NM, MJR_CHARTR_NM, MALE_GRA_CNT, FEMALE_GRA_CNT, HTIR_CONCTN_MALE_EMPLYE_CNT, HTIR_CONCTN_FEMALE_EMPLYE_CNT, OVSEA_MALE_EMPLYE_CNT, OVSEA_FEMALE_EMPLYE_CNT, FARMJ_MALE_ENFLPSN_CNT, FARMJ_FEMALE_ENFLPSN_CNT, INDVDL_CRAT_MALE_ENFLPSN_CNT, INDVDL_CRAT_FEMALE_ENFLPSN_CNT, PSN1_MALE_FUDR_CNT, PSN1_FEMALE_FUDR_CNT, MALE_FRLAC_CNT, FEMALE_FRLAC_CNT, ETSHP_MALE_CNT, ETSHP_FEMALE_CNT, RECR_CNT, EMPLYMT_NO_POSBL_MALE_CNT, EMPLYMT_NO_POSBL_FEMALE_CNT, FRGNR_INTSTD_MALE_CNT, FRGNR_INTSTD_FEMALE_CNT, HTIR_JOSUBSE_MALE_TRGTER_CNT, HTIR_JOSUBSE_FEMALE_TRGTER_CNT, MALE_ETC_PSN_CNT, FEMALE_ETC_PSN_CNT, MALE_UKNWN_PSN_CNT, FEMALE_UKNWN_PSN_CNT, EMPLYMT_RT, ENSCHAT_MALE_ATHT_EMPLYE_CNT, ENSCHAT_FEMALE_ATHT_EMPLYE_CNT, TSCHGRD_MALE_EMPLYE_CNT, TSCHGRD_FEMALE_EMPLYE_CNT, PRMRY_MAINTNC_SUM_EMPRT, PRMRY_MAINTNC_MALE_EMPRT, PRMRY_MAINTNC_FEMALE_EMPRT, SECND_MAINTNC_SUM_EMPRT, SECND_MAINTNC_MALE_EMPRT, SECND_MAINTNC_FEMALE_EMPRT, TERT_MAINTNC_SUM_EMPRT, TERT_MAINTNC_MALE_EMPRT, TERT_MAINTNC_FEMALE_EMPRT, QUAT_MAINTNC_SUM_EMPRT, QUAT_MAINTNC_MALE_EMPRT, QUAT_MAINTNC_FEMALE_EMPRT)
                    VALUES(:STD_YY, :SCHOOL_KIND_NM, :FOUND_DIV_NM, :SCHOOL_NM, :COLGE_UNIV_NM, :MJR_NM, :DIV_NM, :MJR_CHARTR_NM, :MALE_GRA_CNT, :FEMALE_GRA_CNT, :HTIR_CONCTN_MALE_EMPLYE_CNT, :HTIR_CONCTN_FEMALE_EMPLYE_CNT, :OVSEA_MALE_EMPLYE_CNT, :OVSEA_FEMALE_EMPLYE_CNT, :FARMJ_MALE_ENFLPSN_CNT, :FARMJ_FEMALE_ENFLPSN_CNT, :INDVDL_CRAT_MALE_ENFLPSN_CNT, :INDVDL_CRAT_FEMALE_ENFLPSN_CNT, :PSN1_MALE_FUDR_CNT, :PSN1_FEMALE_FUDR_CNT, :MALE_FRLAC_CNT, :FEMALE_FRLAC_CNT, :ETSHP_MALE_CNT, :ETSHP_FEMALE_CNT, :RECR_CNT, :EMPLYMT_NO_POSBL_MALE_CNT, :EMPLYMT_NO_POSBL_FEMALE_CNT, :FRGNR_INTSTD_MALE_CNT, :FRGNR_INTSTD_FEMALE_CNT, :HTIR_JOSUBSE_MALE_TRGTER_CNT, :HTIR_JOSUBSE_FEMALE_TRGTER_CNT, :MALE_ETC_PSN_CNT, :FEMALE_ETC_PSN_CNT, :MALE_UKNWN_PSN_CNT, :FEMALE_UKNWN_PSN_CNT, :EMPLYMT_RT, :ENSCHAT_MALE_ATHT_EMPLYE_CNT, :ENSCHAT_FEMALE_ATHT_EMPLYE_CNT, :TSCHGRD_MALE_EMPLYE_CNT, :TSCHGRD_FEMALE_EMPLYE_CNT, :PRMRY_MAINTNC_SUM_EMPRT, :PRMRY_MAINTNC_MALE_EMPRT, :PRMRY_MAINTNC_FEMALE_EMPRT, :SECND_MAINTNC_SUM_EMPRT, :SECND_MAINTNC_MALE_EMPRT, :SECND_MAINTNC_FEMALE_EMPRT, :TERT_MAINTNC_SUM_EMPRT, :TERT_MAINTNC_MALE_EMPRT, :TERT_MAINTNC_FEMALE_EMPRT, :QUAT_MAINTNC_SUM_EMPRT, :QUAT_MAINTNC_MALE_EMPRT, :QUAT_MAINTNC_FEMALE_EMPRT)
                """

                for row in result['data']:
                    affected += dao.insert(sql, row)
                print(pIndex,") ",affected, "건 등록")
                pIndex += 1
                result = Api.get(url, pIndex, pSize)
                recvCnt += len(result['data'])
            except:
                print("완료")
                break
        print( "총 처리시간 = ", round(time.time() - start, 2), "sec") 

    @staticmethod
    def Hfwydrotmasterdr(mode=None):
        """
        [중도탈락 학생 현황] 공공 데이터 DB 적재
        """
        start = time.time()
        dao = SQLiteDao() if mode is None else SQLiteDao(sys.path[0]+"/api.sqlite3")
        # 1단계 : 데이터 삭제
        print("기존 데이터가 %d 건 삭제되었습니다." % dao.delete("delete from api_student_out"))

        url = "https://openapi.gg.go.kr/Hfwydrotmasterdr?KEY=8efbd2b4faaa41d48b9c8328bb455ead&type=json&pIndex="
        pIndex = 1 # 페이지 번호
        pSize = 500  # 페이지 블럭
        targetCnt = 0 # 대상건수
        recvCnt = 0 # 수신건수

        result = Api.get(url, pIndex, pSize)
        targetCnt = result['total_cnt']
        recvCnt += len(result['data'])
        print("http status: ", result['status'])
        print("총 건수: ", targetCnt)
        # print(json.dumps(result['data'], indent=2, sort_keys=True, ensure_ascii=False))
        affected = 0
        while targetCnt >= recvCnt:
            try:
                sql = """
                        INSERT INTO api_student_out
                        (STD_YY, SCHOOL_KIND_NM, FOUND_DIV_NM, SCHOOL_NM, MJR_NM, DIV_NM, MJR_CHARTR_NM, MJR_STATE_NM, ERSTD_CNT, MASTER_SUM, MASTER_NON_REGIST_CNT, MASTER_NON_GBSCHL_CNT, MASTER_LVSCHL_CNT, MASTER_CLGRD_WARN_CNT, MASTER_STDNT_ACT_CNT, MASTER_FLK_EXPL_CNT, MASTER_CLAS_TERM_EXCESS_CNT, MASTER_ETC_CNT, DR_SUM, DR_NON_REGIST_CNT, DR_NON_GBSCHL_CNT, DR_LVSCHL_CNT, DR_CLGRD_WARN_CNT, DR_STDNT_ACT_CNT, DR_FLK_EXPL_CNT, DR_CLAS_TERM_EXCESS_CNT, DR_ETC_CNT, MDR_UNITY_SUM, MDR_UNITY_NON_REGIST_CNT, MDR_UNITY_NON_GBSCHL_CNT, MDR_UNITY_LVSCHL_CNT, MDR_UNITY_CLGRD_WARN_CNT, MDR_UNITY_STDNT_ACT_CNT, MDR_UNITY_FLK_EXPL_CNT, MDR_UNITY_CLAS_TERM_EXCESS_CNT, MDR_UNITY_ETC_CNT, TOTSUM, HFWY_DROT_STDNT_RT)
                        VALUES(:STD_YY,:SCHOOL_KIND_NM,:FOUND_DIV_NM,:SCHOOL_NM,:MJR_NM,:DIV_NM,:MJR_CHARTR_NM,:MJR_STATE_NM,:ERSTD_CNT,:MASTER_SUM,:MASTER_NON_REGIST_CNT,:MASTER_NON_GBSCHL_CNT,:MASTER_LVSCHL_CNT,:MASTER_CLGRD_WARN_CNT,:MASTER_STDNT_ACT_CNT,:MASTER_FLK_EXPL_CNT,:MASTER_CLAS_TERM_EXCESS_CNT,:MASTER_ETC_CNT,:DR_SUM,:DR_NON_REGIST_CNT,:DR_NON_GBSCHL_CNT,:DR_LVSCHL_CNT,:DR_CLGRD_WARN_CNT,:DR_STDNT_ACT_CNT,:DR_FLK_EXPL_CNT,:DR_CLAS_TERM_EXCESS_CNT,:DR_ETC_CNT,:MDR_UNITY_SUM,:MDR_UNITY_NON_REGIST_CNT,:MDR_UNITY_NON_GBSCHL_CNT,:MDR_UNITY_LVSCHL_CNT,:MDR_UNITY_CLGRD_WARN_CNT,:MDR_UNITY_STDNT_ACT_CNT,:MDR_UNITY_FLK_EXPL_CNT,:MDR_UNITY_CLAS_TERM_EXCESS_CNT,:MDR_UNITY_ETC_CNT,:TOTSUM,:HFWY_DROT_STDNT_RT)
                """

                for row in result['data']:
                    affected += dao.insert(sql, row)
                print(pIndex,") ",affected, "건 등록 ==>", round(time.time() - start, 2), "sec")
                pIndex += 1
                result = Api.get(url, pIndex, pSize)
                recvCnt += len(result['data'])
            except:
                print("완료")
                break

        print( "총 처리시간 = ", round(time.time() - start, 2), "sec") 

    @staticmethod
    def get_dataframe(url, pSize=1000):
        start = time.time()
        pIndex = 1 # 페이지 번호
        pSize = 1000  # 페이지 블럭
        targetCnt = 0 # 대상건수
        recvCnt = 0 # 수신건수

        result = Api.get(url, pIndex, pSize)
        targetCnt = result['total_cnt']
        recvCnt += len(result['data'])
        items = []
        items += result['data']
        while targetCnt > recvCnt:
            pIndex += 1
            result = Api.get(url, pIndex, pSize)
            recvCnt += len(result['data'])
            items += result['data']

        print("[처리시간:", round(time.time() - start, 2), "sec] 대상건수: %d, 처리건수: %d" % (targetCnt, recvCnt))
        return pd.DataFrame(items)
        
#################################################
# SQLite 클래스
#################################################
class SQLiteDao:

    db_file = './util/api.sqlite3'

    # 생성자
    def __init__(self, file=None):
        if file is not None:
            self.db_file = file

    # B01. 컨넥션 리턴
    def sql_connection(self):
        return sqlite3.connect(self.db_file)

    # B02. 리스트 조회
    def rows(self, sql, param=None):
        return self.sql_select(sql, param, 'list')

    # B03. 단건 조회
    def row(self, sql, param=None):
        return self.sql_select(sql, param, 'row')

    # B04. 조회
    def sql_select(self, sql, param=None, mode='row'):
        rows = {}
        try:
            conn = self.sql_connection()
            conn.row_factory = dict_factory
            cur = conn.cursor()
            if param is None:
                cur.execute(sql)
            else:
                cur.execute(sql, param)
            if mode == 'row':
                rows = cur.fetchone()
            else:
                rows = cur.fetchall()
        except sqlite3.Error as e:
            print('An error occurred: ', e.args[0])
            print(sql)
            print(e.args[1])
        finally:
            self.sql_close(cur, conn)
        return rows

    # B05. 쿼리 실행
    def sql_query(self, sql, param=None, mode=None):
        affected = 0
        try:
            with self.sql_connection() as conn:
                cur = conn.cursor()
                if param is None:
                    cur.execute(sql)
                else:
                    cur.execute(sql, param)
                affected = cur.rowcount
        except Exception as e:
            affected = -1
            verbose = False
            print(str(e))
            print(sql)
            conn.rollback()
        finally:
            self.sql_close(cur, conn)
        return affected

    def insert(self, sql, param=None):
        return self.sql_query(sql, param, 'insert')

    def delete(self, sql, param=None):
        return self.sql_query(sql, param, 'delete')

    def update(self, sql, param=None):
        return self.sql_query(sql, param, 'update')

    # B06. 자원 해제
    def sql_close(self, cur, conn):
        if cur is not None:
            cur.close()
        if conn is not None:
            conn.close()

# JSON 으로 반환
def dict_factory(cursor, row):
    dic = {}
    for idx, col in enumerate(cursor.description):
        dic[col[0]] = row[idx]
    return dic

###########################################################################
if __name__ == '__main__':
    # Api.Grduemplymtgenrlgdhl(1) # 졸업생의 취업현황(일반대학원)

    Api.Hfwydrotmasterdr(1) # 중도탈락 학생 현황



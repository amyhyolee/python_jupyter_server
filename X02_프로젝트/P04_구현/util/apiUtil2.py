#################################################
# 공공 데이터 API
#
# version: v1.0 
# author(s): shinil.kim
# since: 2022.01.24
#################################################
import pandas as pd
import requests, json, sys, time

#################################################
# Api 클래스
#################################################
class Api:
    @staticmethod
    def get(url, pIndex, pSize):
        # pass
        status = 0
        total_cnt = 0
        data = {}
        name = url[url.rindex("/")+1:url.rindex("?")]
        try:
            url = url + str(pIndex) + "&pSize="+ str(pSize)
            print(url)
            res = requests.get(url)
            status = res.status_code
            print(res)
            if status == 200:
                pass
        except requests.exceptions.Timeout as e:
            print(e)
            status = 500
        return {"status": status, "total_cnt": total_cnt, "data": data[name][1]['row']}

    @staticmethod
    def get_dataframe(url, pSize=1000):
        pass
        # start = time.time()
        # pIndex = 1 # 페이지 번호
        # # pSize = 1000  # 페이지 블럭
        # targetCnt = 0 # 대상건수
        # recvCnt = 0 # 수신건수
        # result = Api.get(url, pIndex, pSize)
        # targetCnt = result['total_cnt']
        # recvCnt = len(result['data'])
        # while targetCnt > recvCnt:
        #     pass
        # print("[처리시간:", round(time.time() - start, 2), "sec] 대상건수: %d, 처리건수: %d" % (targetCnt, recvCnt))
        # return pd.DataFrame(items)
        

###########################################################################
if __name__ == '__main__':
    # Api.Grduemplymtgenrlgdhl(1) # 졸업생의 취업현황(일반대학원)

    # Api.Hfwydrotmasterdr(1) # 중도탈락 학생 현황
    url = "https://openapi.gg.go.kr/CopertnhousngUnsol?KEY=84191f90feac44a1973f7ad3b413cb8b&Type=json&pIndex="
    pSize = 1000
    # print(1)
    df = Api.get(url, 1, 1000)
    # df = Api.get_dataframe(url, pSize)
    print(df)


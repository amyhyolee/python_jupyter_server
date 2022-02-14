REM chcp 65001 UTF-8
chcp 65001

REM pip update
python -m pip install --upgrade pip

REM 01.01. jupyter 설치
pip install jupyterlab

REM 01.02. jupyter 환경 설정 파일 생성
::jupyter lab --generate-config

pip install pandas
pip install tensorflow
pip install requests
pip install matplotlib
pip install pymysql
pip install sqlite3

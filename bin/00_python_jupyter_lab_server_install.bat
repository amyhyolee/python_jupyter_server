REM chcp 65001 UTF-8
chcp 65001

REM 01.01. jupyter 설치
pip3 install jupyterlab

REM 01.02. jupyter 환경 설정 파일 생성
jupyter lab --generate-config

REM 02. pandas 설치(numpy 도 같이 설치된다.)
::pip3 install pandas

REM 03. tensorflow 설치
::pip3 install tensorflow

::pip3 install sqlite3

::pip3 install requests
#  --notebook-dir=../ -p 8888
#jupyter lab --config=config/jupyter_lab_config.py
jupyter lab --notebook-dir=../ -p 8999

# password 0000

# 옵션
# --no-browser 주피터 랩을 실행한 경우, 혹은 실수로 주피터 랩이 실행 중인 브라우저를 닫아버린 경우 콘솔 창에서 주피터 랩에 접속할 수 있는 URL을 확인
# jupyter lab --ip=<ip_addr> --port=<port>
# jupyter lab --config=<config_path>

sh ./01_python_jupyter_lab_server_start.sh
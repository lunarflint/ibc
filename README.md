# Dockerized IBC with VNC server

```
docker build\
    --no-cache\
    --build-arg IB_LOGIN_ID="<your TWS username>"\
    --build-arg IB_PASSWORD="<your TWS password>"\
    --build-arg TRADING_MODE="LIVE|PAPER"\
    -t ibc .
```
Also see build.sh


```
docker run\
    -p 12345:2222\   # VNC port
    -p 7496:3333\    # TWS port
    --name=ibc-0\
    -dt --rm ibc
```

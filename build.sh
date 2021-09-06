read -p    'Enter username: ' UN
read -s -p 'Enter password: ' PW; echo
read -p    'Enter trading mode [live]/paper: ' TM
TM=${TM:-live}
read -p    "Enter image tag [ibc-$UN-$TM]: " IT
IT=${IT:-"ibc-$UN-$TM"}

docker build\
    --no-cache\
    --build-arg IB_LOGIN_ID="$UN"\
    --build-arg IB_PASSWORD="$PW"\
    --build-arg TRADING_MODE="$TM"\
    -t $IT .

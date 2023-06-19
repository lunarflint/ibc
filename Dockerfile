FROM ubuntu:latest

RUN DEBIAN_FRONTEND=noninteractive apt update && apt install -y tzdata wget unzip xvfb x11vnc openbox socat

ARG IB_LOGIN_ID
ARG IB_PASSWORD
ARG TRADING_MODE

WORKDIR /root

RUN \
    wget -O tws.sh https://download2.interactivebrokers.com/installers/tws/latest-standalone/tws-latest-standalone-linux-x64.sh &&\
    chmod +x tws.sh &&\
    yes '' | ./tws.sh &&\
    rm tws.sh

RUN \
    mkdir /opt/ibc &&\
    (\
        cd /opt/ibc &&\
        wget -O IBCLinux.zip https://github.com/IbcAlpha/IBC/releases/download/3.16.2/IBCLinux-3.16.2.zip &&\
        unzip IBCLinux.zip &&\
        rm IBCLinux.zip &&\
        sed -e 's/^TWS_MAJOR_VRSN=.*$/TWS_MAJOR_VRSN='$(ls -1 /root/Jts)/ -e 's@^IBC_INI=.*$@IBC_INI=/root/ibc-config.patched.ini@' twsstart.sh > twsstart.patched.sh &&\
        sed -e 's/^TWS_MAJOR_VRSN=.*$/TWS_MAJOR_VRSN='$(ls -1 /root/Jts)/ -e 's@^IBC_INI=.*$@IBC_INI=/root/ibc-config.patched.ini@' gatewaystart.sh > gatewaystart.patched.sh &&\
        chmod +x scripts/*.sh *.sh\
    )

ADD config.ini /root/ibc-config.ini
ADD jts.ini /root/Jts/jts.ini
ADD cmd.sh cmd.sh

RUN sed -e 's/^IbLoginId=.*$/IbLoginId='$IB_LOGIN_ID/ -e 's/^IbPassword=.*$/IbPassword='$IB_PASSWORD/ -e 's/^TradingMode=.*$/TradingMode='$TRADING_MODE/ ibc-config.ini > ibc-config.patched.ini

ENV TZ=America/New_York
RUN chmod +x cmd.sh
CMD /root/cmd.sh

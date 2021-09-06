Xvfb :0 -ac -screen 0 1280x720x24 &
x11vnc -forever -display :0 -rfbport 2222 &
socat TCP-LISTEN:3333,fork,reuseaddr TCP:0.0.0.0:7496 &
DISPLAY=:0 openbox-session &
DISPLAY=:0 /opt/ibc/twsstart.patched.sh -inline

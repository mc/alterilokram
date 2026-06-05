#!/bin/bash
set -e

export DISPLAY=:1

# virtuelles Display
Xvfb :1 -screen 0 1440x900x24 &
sleep 2

# Fenstermanager
fluxbox &
sleep 1

# set for socks usage in java and downgrade security
#### export _JAVA_OPTIONS="-DsocksProxyHost=<ip> -DsocksProxyPort=12345 -DsocksProxyVersion=5 -Dhttps.protocols=TLSv1" 
#### (...) .1 -Dhttps.cipherSuites=TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA"
# warum socks? weil `ssh -gD 12345` allowlisting probleme löst.

# Firefox 52 ESR starten
firefox-esr &

# VNC-Server auf das Display
x11vnc -display :1 -forever -nopw -shared -rfbport 5900 &
sleep 1

# noVNC -> Browser-Zugang auf Port 6080
websockify --web /usr/share/novnc 6080 localhost:5900

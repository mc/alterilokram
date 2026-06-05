# Legacy-Browser -- ARM64-tauglich
# Debian 8 (Jessie): hier ist icedtea-7-plugin noch fuer arm64 im Archiv (1.5.3-1).
# Stretch scheidet aus, weil icedtea-8-plugin 2019 fuer ALLE Architekturen entfernt wurde.

FROM debian/eol:jessie
ENV DEBIAN_FRONTEND=noninteractive

RUN printf '%s\n' \
    'deb http://archive.debian.org/debian jessie main contrib non-free' \
    > /etc/apt/sources.list \
 && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid

RUN apt-get update && apt-get install -y --no-install-recommends \
        firefox-esr xterm vim	python-setuptools \
        openjdk-7-jre icedtea-7-plugin \
        x11vnc xvfb fluxbox novnc websockify \
        net-tools ca-certificates \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# IcedTea-NPAPI-Plugin fuer Firefox sichtbar machen (Pfad ggf. anpassen, s.u.)
RUN mkdir -p /usr/lib/mozilla/plugins \
 && ln -sf /usr/lib/jvm/java-7-openjdk-arm64/jre/lib/aarch64/IcedTeaPlugin.so \
           /usr/lib/mozilla/plugins/ 2>/dev/null || true

# Java: alte TLS-Ciphers/abgelaufene Zertifikate wieder erlauben
RUN JSEC=/usr/lib/jvm/java-7-openjdk-arm64/jre/lib/security/java.security \
 && sed -i 's/^jdk.tls.disabledAlgorithms=.*/jdk.tls.disabledAlgorithms=/' "$JSEC" 2>/dev/null || true \
 && sed -i 's/^jdk.certpath.disabledAlgorithms=.*/jdk.certpath.disabledAlgorithms=/' "$JSEC" 2>/dev/null || true

EXPOSE 6080

COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]

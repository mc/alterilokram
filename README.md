# what?

Dockerfile builds a debian jessie container and installs some basic stuff.

After starting the dockerimage, it will expose a webserver with a WebVNC Client that exposes 
a (passwordless, see start.sh) VNC Server, that shows the full X11 Server and automatically starts
a firefox.

Which means, you type the url below into your own browser and will get an oldbrowser-in-a-browser
with old JVM (NPAPI, JLNP) to access ancient hardware.

start.sh also contains some environment variables that you may need to set.

If you need to ssh around to get around allowlists, `ssh -gD 12345` will provide a local socks proxy
compatible protocol on your devices port 12345 for traffic forwarding. (But careful, -g makes it
available to all devices that can access that port).


# docker/podman image bauen und starten
```
podman build -t firefox52 .
podman run -d --rm -p 6080:6080 --name ff52 firefox52
```
* => https://localhost:6080


# ilo kommandos um den ilo ausm server zu konfigurieren
```
# 3: Kanal im IPMI, kann zB auch 1 sein
ipmitool user list 2
ipmitool lan print 2

# 3: der index den der user in der liste bekommen soll
ipmitool user set name 3 USERNAME
ipmitool user set password 3 PASSWORD
ipmitool user priv 3 0x4

# ganz alt hponcfg: zum auslesen der config als xml, kann auch xml snippets reindumpen
# neuer: ilorest
```

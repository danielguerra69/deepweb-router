# DeepWeb Router

Creates a secure environment for deepweb browsing.
Includes tor, i2p and privoxy to combine them.
Based on alpine linux edge.
The examples contain a deepweb xrdp server with
firefox to browse the deepweb in a secure way.

![Deepweb Router Schema](https://github.com/danielguerra69/deepweb-router/blob/master/deepweb-router.png)


# Usage

Download the docker-compose file at my [github location](https://raw.githubusercontent.com/danielguerra69/deepweb-router/master/examples/docker-compose.yml)
The best way to use this image is with docker-compose.

Standard usage
```bash
docker-compose up -d
```

# Standard services

Privoxy -> <dockerhost:8118>
Sshd    -> <dockerhost:2522>

Desktop example service

XRDP    -> <dockerhost:3389>

# Example

Download the docker-compose file at my [github location](https://raw.githubusercontent.com/danielguerra69/deepweb-router/master/examples/docker-compose-desktop.yml)
Example deepweb xrdp desktop

```bash
docker-compose -f docker-compose-desktop.yml up -d
```

# Make a container go deepweb

The docker-compose file provides default deepweb
access. To make your own container go deep web add
the following to the docker-compose file

```bash
# MyOwn container
mycontainer:
  image: myrepo/myproject:edge
  network_mode: "service:app"
  depends_on:
   - app
```

If your container provides a service add it to the
app container ports config of your docker-compose file

```bash
ports:
  - "3389:3389" # For Desktop rdp
  - "8118:8118" # For Privoxy proxy
  - "2522:22"   # sshd
  - "7777:80"   # mycontainer webserver
```

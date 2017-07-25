[appurl]: https://lede-project.org/
[hub]: https://hub.docker.com/r/pheoxy/lede/

# pheoxy/lede

[The LEDE Project] (“Linux Embedded Development Environment”) is a Linux operating system based on OpenWrt. It is a complete replacement for the vendor-supplied firmware of a wide range of wireless routers and non-network devices.

## Usage

```
docker run \
-itd \
--name=lede \
-e PUID=<UID> -e PGID=<GID> \
-e TZ=<timezone> \
-v </path/to/config>:/config \
pheoxy/lede
```

## Building

You will need to get shell access `docker exec -it lede /bin/bash` so that you can start building.

Build commands are:

```
make menuconfig
make
```

## Parameters

* `-v /config` - LEDE Source Location. *This can grow very large, 50gb+ is likely for a large collection.*
* `-e VERSION=latest` - see Setting up application section.
* `-e PGID=` for for GroupID - see below for explanation
* `-e PUID=` for for UserID - see below for explanation
* `-e TZ` - for timezone information *eg Europe/London, etc*

* `make menuconfig` - Bring up Build Menu*
* `make` - Make Build*

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" <sup>TM</sup>.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Info

* Shell access whilst the container is running: `docker exec -it lede /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f lede`

## Versions

+ **06.07.17:** Initial Build.

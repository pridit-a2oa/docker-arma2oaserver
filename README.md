> [!IMPORTANT]  
> **Due to the lack of an up-to-date binary to support the latest game version (1.64), and a low likelihood of this ever being produced, this respository is archived and subsequently this method of server hosting is no longer recommended.**
>
> **For a Docker environment to host a 1.64 server using Wine, see [pridit/docker-arma2oaserver-wine](https://github.com/pridit/docker-arma2oaserver-wine).**

This repository contains the files required to build an image with the dependencies to operate an **Arma 2: Operation Arrowhead** Linux server. **Arma 2** data files are also included so missions can make use of the assets.

## Requirements
* [Steam](https://store.steampowered.com/about/) account with an active subscription to both Arma 2 & Arma 2: Operation Arrowhead.

## Setup
```
git clone https://github.com/pridit/docker-arma2oaserver.git
```

Make a copy of the four `.example` files, removing this suffix, and modify parameters with your own preferences and credentials.

## Build
As a built image would contain data files from Arma 2 & Arma 2: Operation Arrowhead (which can only be pulled via [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD) with an active subscription to these packages on Steam) it is not hosted anywhere as not to infringe on copyright.

```
docker build --build-arg RCON_PASSWORD=changeme -t pridit/arma2oaserver .
```

Since `RCON_PASSWORD` is set on build (in order to populate a configuration file) should this need to be changed in the future you must modify the file ending in `.cfg` within the directory `/arma2oaserver/expansion/battleye` inside the container. As the file is automatically renamed it is not feasible to mount.

Without the argument being specified at build the value will default to `secret`.

## Container
```
docker create \
    --name=arma2oaserver \
    --net=host \
    --restart unless-stopped \
    -v $PWD/keys:/arma2oaserver/expansion/keys \
    -v $PWD/mpmissions:/arma2oaserver/mpmissions \
    -v $PWD/params:/arma2oaserver/params \
    -v $PWD/profiles:/arma2oaserver/profiles \
    -v $PWD/basic.cfg:/arma2oaserver/basic.cfg \
    -v $PWD/server.cfg:/arma2oaserver/server.cfg \
    pridit/arma2oaserver
```

## Known Issues
### No support for latest version
At the time of writing the latest version of Arma 2: Operation Arrowhead is **1.64**. This repository contains server files to host a server running version **1.63**. Due to Bohemia Interactive not releasing Linux server files for the latest version it is not possible to host a Linux dedicated server to match this.

## Attribution
With thanks to [timelf123/arma3-docker](https://github.com/timelf123/arma3-docker) & [synixebrett/Arma3Server](https://github.com/synixebrett/Arma3Server) from which this repository is loosely based from.

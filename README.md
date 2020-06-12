## Installing
```
git clone https://github.com/pridit/docker-arma2oa-server.git
```

Make a copy of the four `.example` files, removing this suffix, and modify parameters to your own.

## Build
Since a built image would contain data files from the games **Arma 2** & **Arma 2: Operation Arrowhead**, which can only be pulled via [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD) with a valid subscription to these packages on Steam, it is not hosted anywhere as not to infringe on copyright.

```
docker build --build-arg RCON_PASSWORD=changeme -t pridit/arma2oaserver .
```

Since `RCON_PASSWORD` is set on build (in order to populate a configuration file) should this need to be changed in the future you have to modify the `.cfg` file in the Docker container within the directory `/arma2oaserver/expansion/battleye`. Since the file is automatically renamed it is not feasible to mount.

Without the argument being specified at build the password will default to `secret`.

## Container
```
docker create \
    --name=arma2oaserver \
    -v $PWD/keys:/arma2oaserver/expansion/keys \
    -v $PWD/mpmissions:/arma2oaserver/mpmissions \
    -v $PWD/params:/arma2oaserver/params \
    -v $PWD/profiles:/arma2oaserver/profiles \
    -v $PWD/basic.cfg:/arma2oaserver/basic.cfg \
    -v $PWD/server.cfg:/arma2oaserver/server.cfg \
    -p 2302-2305:2302-2305/udp \
    -p 8766:8766/udp \
    -p 27016:27016/udp \
    pridit/arma2oaserver
```

## Known Issues
### No support for latest version
At the time of writing the latest version of Arma 2: Operation Arrowhead is **1.64**. This repository contains server files to host a dedicated server on version **1.63**. Due to Bohemia Interactive not releasing Linux server files for the latest version it is not possible to host a Linux dedicated server to match this.

## Attribution
With thanks to [timelf123/arma3-docker](https://github.com/timelf123/arma3-docker) & [synixebrett/Arma3Server](https://github.com/synixebrett/Arma3Server) from which this repository is loosely based from.
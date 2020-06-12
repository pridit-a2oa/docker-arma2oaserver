#!/bin/bash

OPTS=""

if [ $VALIDATE == 1 ]; then
	OPTS="validate"
fi

eval "$(/arma2oaserver/credentials.sh)"

/steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +login $STEAM_USERNAME $STEAM_PASSWORD +force_install_dir /arma2oaserver/arma2 +app_update 33900 $OPTS +quit
/steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +login $STEAM_USERNAME $STEAM_PASSWORD +force_install_dir /arma2oaserver/arma2 +app_update 33910 $OPTS +quit
/steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +login $STEAM_USERNAME $STEAM_PASSWORD +force_install_dir /arma2oaserver/arma2oa +app_update 33930 $OPTS +quit

unset OPTS
unset STEAM_USERNAME
unset STEAM_PASSWORD

cp -R ./arma2/AddOns/. ./arma2oa/addons \
	&& cp -R ./arma2/Dta/. ./arma2oa/dta \
	&& cp -R ./arma2oa/* ./

rm -rf ./arma2 \
	&& rm -rf ./arma2oa

gcc -O -o ./tolower ./tolower.c

./tolower

chmod +w ./*

rm -f ./*.bat ./*.exe ./*.chm ./*.dll ./tolower.o \
	&& rm -f ./battleye/*.dll \
	&& rm -f ./expansion/*.dll \
	&& rm -f ./expansion/battleye/*.bat \
	&& rm -f ./expansion/battleye/*.dll \
	&& rm -f ./expansion/battleye/*.exe

ln -s /steamcmd/linux32/steamclient.so ./steamclient.so 
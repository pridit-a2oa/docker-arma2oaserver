FROM ubuntu:18.04

MAINTAINER "Jordan Heale" <webmaster@pridit.co.uk>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        locales \
        gcc \
        libsdl2-dev \
        libsdl2-2.0 \
        libc6-dev \
        lib32gcc1 \
        libstdc++6 \
        libstdc++6:i386 \
        wget \
        gzip \
        ca-certificates \
    && apt-get remove --purge -y \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm /var/lib/apt/lists/* -r

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN mkdir -p /steamcmd \
    && cd /steamcmd \
    && wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz \
    && tar -zxvf steamcmd_linux.tar.gz \
    && rm -f steamcmd_linux.tar.gz

ENV DEBIAN_FRONTEND=noninteractive
ENV VALIDATE=1
ARG RCON_PASSWORD=secret

EXPOSE 2302/udp 2303/udp 2304/udp 2305/udp

WORKDIR /arma2oaserver

VOLUME ./profiles

COPY credentials.sh install.sh serverfiles/tolower.c ./

RUN cd /arma2oaserver \
    && ./install.sh \
    && rm -f ./credentials.sh \
    && rm -f ./install.sh \
    && echo "RConPassword $RCON_PASSWORD" > ./expansion/battleye/beserver.cfg \
    && echo 33930 > ./steam_appid.txt

ADD serverfiles ./

STOPSIGNAL SIGINT

CMD ["./server", "-par=params", "-profiles=profiles"]
FROM ubuntu:xenial
MAINTAINER Pheoxy


# global environment settings
ENV DEBIAN_FRONTEND="noninteractive" \
PLEX_DOWNLOAD="https://downloads.plex.tv/plex-media-server" \
PLEX_INSTALL="https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu" \
PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/config/Library/Application Support" \
PLEX_MEDIA_SERVER_HOME="/usr/lib/plexmediaserver" \
PLEX_MEDIA_SERVER_INFO_DEVICE=docker \
PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS="6" \
PLEX_MEDIA_SERVER_USER=abc

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
	subversion \
	g++ \
	zlib1g-dev \
	build-essential \
	git \
	python \
	rsync \
	libncurses5-dev \
	gawk \
	gettext \
	unzip \
	file \
	libssl-dev \
	wget && \

# lede source
 git clone https://git.lede-project.org/source.git lede \
	cd lede \
	./scripts/feeds update -a \
	./scripts/feeds install -a \
 make defconfig \
 make menuconfig \

# change abc home folder to fix plex hanging at runtime with usermod
 usermod -d /app abc && \

# cleanup
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
#COPY root/ /

# volumes
VOLUME /config /targets
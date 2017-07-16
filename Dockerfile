FROM sdhibit/mono:5.0
MAINTAINER Steve Hibit <sdhibit@gmail.com>

ARG MEDIAINFO_VER="0.7.97"
ARG LIBMEDIAINFO_URL="https://mediaarea.net/download/binary/libmediainfo0/${MEDIAINFO_VER}/MediaInfo_DLL_${MEDIAINFO_VER}_GNU_FromSource.tar.gz"
ARG MEDIAINFO_URL="https://mediaarea.net/download/binary/mediainfo/${MEDIAINFO_VER}/MediaInfo_CLI_${MEDIAINFO_VER}_GNU_FromSource.tar.gz"

#Build libmediainfo
# install build packages
RUN apk add --no-cache --virtual=build-dependencies \
    make \
    g++ \ 
    gcc \
    git \
    sqlite \ 
    sqlite-libs \
    xz \
    unrar \
    zlib \
    zlib-dev \
 && mkdir -p /tmp/libmediainfo \
 && mkdir -p /tmp/mediainfo \
 && curl -kL ${LIBMEDIAINFO_URL} | tar -xz -C /tmp/libmediainfo --strip-components=1 \
 && curl -kL ${MEDIAINFO_URL} | tar -xz -C /tmp/mediainfo --strip-components=1 \
 && cd /tmp/libmediainfo \
 && ./SO_Compile.sh \
 && cd /tmp/libmediainfo/MediaInfoLib/Project/GNU/Library \
 && make install \
 && cd /tmp/libmediainfo/ZenLib/Project/GNU/Library \
 && make install \
 && cd /tmp/mediainfo \
 && ./CLI_Compile.sh \
 && cd /tmp/mediainfo/MediaInfo/Project/GNU/CLI \
 && make install \
 && apk del --purge build-dependencies \
 && rm -rf /tmp/*


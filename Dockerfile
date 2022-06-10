#sudo docker build --build-arg VERSION=<version> --build-arg BUILD_DATE=<date> -t localhost:5000/timeoff:<VERSION> .
FROM node:13-alpine AS node

FROM ghcr.io/linuxserver/baseimage-alpine:3.14 AS base

ARG BUILD_DATE
ARG VERSION

LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="harmanhobbit"

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

EXPOSE 3000

LABEL org.label-schema.schema-version="1.0"

RUN apk add --no-cache \
    git && \
#    nodejs npm && \
#    python \
#    vim
  apk add --no-cache --virtual=build-dependencies \
    make \
    python3
    
#RUN adduser --system app --home /app
#USER app
WORKDIR /app
RUN \
  echo "**** symlink python3 for compatibility ****" && \
  ln -s /usr/bin/python3 /usr/bin/python && \
  echo "***Setting up timeoff***" && \
    git clone https://github.com/timeoff-management/application.git timeoff-management && \
    cd timeoff-management && \
    npm install && \
#    mkdir -p /data && \
    cd /app && \
    mv timeoff-management timeoff-management-tmp

COPY root/ /

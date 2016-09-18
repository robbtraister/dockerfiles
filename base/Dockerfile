FROM alpine

ENV USER="worker" \
    WORKDIR="/workdir"

RUN apk update \
 && apk upgrade \
 && addgroup -S ${USER} \
 && adduser -S ${USER} -G ${USER}

WORKDIR ${WORKDIR}

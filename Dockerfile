FROM robbtraister/base

RUN apk add --update --no-cache \
            nodejs \
 && rm -rf /var/cache/apk/* \
 && node -v

WORKDIR /watcher

ADD ./package.json ./
RUN npm install --production

ADD . ./

WORKDIR /workdir
VOLUME /workdir/src

CMD cd /watcher && npm run watch

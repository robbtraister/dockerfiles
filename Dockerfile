FROM robbtraister/base

RUN apk add --update --no-cache \
            nodejs \
 && rm -rf /var/cache/apk/* \
 && node -v

WORKDIR /watcher

ADD gulpfile.js package.json ./
RUN npm install --production

RUN chown -R ${USER}:${USER} . \
 && chmod u=rwX,go= -R .

WORKDIR /workdir

VOLUME ./src

# Use cd since WORKDIR will be /workdir/src
CMD cd /watcher \
 && npm start

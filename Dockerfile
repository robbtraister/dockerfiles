FROM robbtraister/base

RUN apk add --update --no-cache \
            nodejs \
 && rm -rf /var/cache/apk/* \
 && node -v

# Use cd since WORKDIR will be set to src directory later
CMD cd /watcher && npm start

WORKDIR /watcher

ADD ./package.json ./
RUN npm install --production

ADD ./gulpfile.js ./

WORKDIR /workdir

ONBUILD ADD ./package.json ./
ONBUILD RUN npm install --production

ONBUILD WORKDIR ./src
ONBUILD VOLUME ./src

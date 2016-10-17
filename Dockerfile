FROM robbtraister/base

RUN apk add --update --no-cache \
            nodejs \
 && rm -rf /var/cache/apk/* \
 && node -v

# Use cd since WORKDIR will be set to src directory later
CMD cd /watcher && npm start

WORKDIR /watcher

ADD gulpfile.js package.json ./
RUN npm install --production

RUN chown -R ${USER}:${USER} ./ \
 && chmod u=rwX,go= -R ./

WORKDIR /workdir

ONBUILD ADD package.json ./
ONBUILD RUN npm install --production \
         && npm cache clean

ONBUILD VOLUME ./src

ONBUILD RUN chown -R ${USER}:${USER} ./ \
         && chmod u=rwX,go= -R ./

ONBUILD USER ${USER}

ONBUILD WORKDIR ./src

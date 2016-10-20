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

RUN chown -R ${USER}:${USER} . \
 && chmod u=rwX,go= -R .

WORKDIR /workdir

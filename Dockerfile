FROM robbtraister/base

RUN apk add --update --no-cache \
            nginx \
            nodejs \
 && rm -rf /var/cache/apk/* \
 && nginx -v \
 && node -v \
 && chown -R ${USER}:${USER} /var/lib/nginx \
 && mkdir -p \
             ./logs \
 && ln -sf /dev/stdout ./logs/access.log \
 && ln -sf /dev/stdout ./logs/error.log

# Use cd since WORKDIR will be set to src directory later
CMD cd /watcher && npm start

WORKDIR /watcher

ADD . ./
RUN npm install --production

RUN chown -R ${USER}:${USER} ./ \
 && chmod u=rwX,go= -R ./

WORKDIR /

ONBUILD VOLUME ./workdir

ONBUILD RUN chown -R ${USER}:${USER} ./workdir \
         && chmod u=rwX,go= -R ./workdir

ONBUILD USER ${USER}

ONBUILD WORKDIR /workdir

FROM robbtraister/base

RUN apk add --update --no-cache \
            nginx \
            nodejs \
 && rm -rf /var/cache/apk/* \
 && nginx -v \
 && node -v \
 && chown -R ${USER}:${USER} /var/lib/nginx

WORKDIR /watcher

ADD gulpfile.js package.json ./
RUN npm install --production

RUN chown -R ${USER}:${USER} . \
 && chmod u=rwX,go= -R .

WORKDIR /workdir

# Use cd since WORKDIR will be set to src directory later
CMD mkdir -p \
          ./logs \
 && ln -sf /dev/stdout ./logs/access.log \
 && ln -sf /dev/stdout ./logs/error.log \
 && cd /watcher && npm start

# Docker doesn't like volume of ./
ONBUILD VOLUME /workdir

ONBUILD RUN chown -R ${USER}:${USER} . \
         && chmod u=rwX,go= -R .

ONBUILD USER ${USER}

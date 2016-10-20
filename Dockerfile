FROM robbtraister/watcher

RUN apk add --update --no-cache \
            nginx \
 && rm -rf /var/cache/apk/* \
 && nginx -v \
 && chown -R ${USER}:${USER} /var/lib/nginx

ENV PROCESS="nginx" \
    ARGUMENTS="-p|./|-c|./nginx.conf|-g|daemon off; pid ./nginx.pid;" \
    PROCESS_DIR="/workdir"

CMD ln -sf /workdir/src/* /workdir \
 && cd /watcher && npm start

WORKDIR /workdir

# Use cd since WORKDIR will be set to src directory later
RUN mkdir -p \
          ./logs \
 && ln -sf /dev/stdout ./logs/access.log \
 && ln -sf /dev/stdout ./logs/error.log \

# Docker doesn't like volume of ./
ONBUILD VOLUME /workdir/src

ONBUILD RUN chown -R ${USER}:${USER} . \
         && chmod u=rwX,go= -R .

ONBUILD USER ${USER}

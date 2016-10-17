FROM robbtraister/base

RUN apk add --update --no-cache \
            nodejs \
            supervisor \
 && rm -rf /var/cache/apk/* \
 && node -v \
 && supervisord -v

WORKDIR /supervisor

ADD supervisord.conf ./

RUN chown -R ${USER}:${USER} . \
 && chmod u=rwX,go= -R .

# Use cd since WORKDIR will be set to src directory later
CMD cd /supervisor && supervisord

WORKDIR /workdir

ONBUILD ADD package.json ./
ONBUILD RUN npm install --production \
         && npm cache clean

ONBUILD ADD . ./src

ONBUILD RUN chown -R ${USER}:${USER} . \
         && chmod u=rwX,go= -R .

ONBUILD USER ${USER}

ONBUILD WORKDIR ./src

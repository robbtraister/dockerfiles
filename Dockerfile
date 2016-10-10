FROM robbtraister/base

RUN apk add --update --no-cache \
            nodejs \
            supervisor \
 && rm -rf /var/cache/apk/* \
 && node -v \
 && supervisord -v

ADD supervisord.conf ./

ENTRYPOINT ["supervisord", "-c"]
CMD ["/workdir/supervisord.conf"]

ONBUILD ADD ./package.json ./
ONBUILD RUN npm install --production \
         && npm cache clean

ONBUILD ADD . ./src

ONBUILD RUN chown -R ${USER}:${USER} ./ \
         && chmod u=rwX,go= -R ./

ONBUILD USER ${USER}

ONBUILD WORKDIR ./src

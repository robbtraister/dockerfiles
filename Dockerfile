FROM robbtraister/base

RUN apk add --update --no-cache \
            nodejs \
            supervisor \
 && rm -rf /var/cache/apk/* \
 && node -v \
 && supervisord -v

ADD supervisord.conf ./

ENTRYPOINT ["supervisord", "-c"]
CMD ["./supervisord.conf"]

WORKDIR ./src

ONBUILD ADD ./package.json ./
ONBUILD RUN npm install --production \
         && npm cache clean

ONBUILD ADD ./ ./

ONBUILD WORKDIR ${WORKDIR}

ONBUILD RUN chown -R ${USER}:${USER} ./ \
         && chmod u=rwX,go= -R ./

ONBUILD USER ${USER}

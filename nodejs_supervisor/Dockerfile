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

ONBUILD ADD ./package.json ./
ONBUILD RUN npm install --production \
         && npm cache clear

ONBUILD ADD . ./

ONBUILD RUN chown -R ${USER}:${USER} ./ \
         && chmod u=rwX,go= -R ./

ONBUILD USER ${USER}

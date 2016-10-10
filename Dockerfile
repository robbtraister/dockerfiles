FROM robbtraister/base

RUN apk add --update --no-cache \
            nodejs \
 && rm -rf /var/cache/apk/* \
 && node -v

ENTRYPOINT ["node"]
ONBUILD CMD ["."]

ONBUILD ADD ./package.json ./
ONBUILD RUN npm install --production \
         && npm cache clean

ONBUILD ADD . ./src

ONBUILD RUN chown -R ${USER}:${USER} ./ \
         && chmod u=rwX,go= -R ./

ONBUILD USER ${USER}

ONBUILD WORKDIR ./src

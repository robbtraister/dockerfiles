FROM robbtraister/base

RUN apk add --update --no-cache \
            nginx \
            supervisor \
 && rm -rf /var/cache/apk/* \
 && mkdir -p \
          ./cache \
          ./logs \
          ./tmp \
 && ln -sf /dev/stdout /var/lib/nginx/logs/error.log \
 && ln -sf /dev/stdout ./logs/access.log \
 && ln -sf /dev/stdout ./logs/error.log

ADD supervisord.conf ./

ENTRYPOINT ["supervisor", "-c"]
CMD ["./supervisord.conf"]

ONBUILD ADD . ./

ONBUILD RUN chown -R ${USER}:${USER} ./ \
         && chmod u=rwX,go= -R ./

ONBUILD USER ${USER}

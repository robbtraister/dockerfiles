FROM robbtraister/base

RUN apk add --update --no-cache \
            nginx \
 && rm -rf /var/cache/apk/* \
 && nginx -v \
 && chown -R ${USER}:${USER} /var/lib/nginx \
 && mkdir -p \
             ./logs \
 && ln -sf /dev/stdout ./logs/access.log \
 && ln -sf /dev/stdout ./logs/error.log

ENTRYPOINT ["nginx", "-p", "./", "-c"]
CMD ["./nginx.conf", "-g", "daemon off; pid ./nginx.pid;"]

ONBUILD ADD . ./

ONBUILD RUN chown -R ${USER}:${USER} ./ \
         && chmod u=rwX,go= -R ./

ONBUILD USER ${USER}

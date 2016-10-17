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

ENTRYPOINT ["nginx", "-g", "daemon off; pid ./nginx.pid;", "-p", "./", "-c"]
CMD ["./nginx.conf"]

ONBUILD ADD . ./

ONBUILD RUN chown -R ${USER}:${USER} . \
         && chmod u=rwX,go= -R .

ONBUILD USER ${USER}

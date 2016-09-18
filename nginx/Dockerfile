FROM robbtraister/base

ENTRYPOINT ["nginx", "-p", "./", "-c"]
CMD ["./nginx.conf", "-g", "daemon off; pid ./nginx.pid;"]

RUN apk add --update --no-cache \
            nginx \
 && rm -rf /var/cache/apk/* \
 && mkdir -p \
          ./cache \
          ./logs \
          ./tmp \
 && ln -sf /dev/stdout /var/lib/nginx/logs/error.log \
 && ln -sf /dev/stdout ./logs/access.log \
 && ln -sf /dev/stdout ./logs/error.log

ONBUILD ADD . ./

ONBUILD RUN chown -R ${USER}:${USER} ./ \
         && chmod u=rwX,go= -R ./

ONBUILD USER ${USER}

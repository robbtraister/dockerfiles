FROM robbtraister/phantomjs-base

RUN apk add --update --no-cache \
            supervisor \
 && rm -rf /var/cache/apk/* \
 && supervisord -v

ADD supervisord.conf ./

ENTRYPOINT ["supervisord", "-c"]
CMD ["./supervisord.conf"]

ONBUILD ADD . ./

ONBUILD RUN chown -R ${USER}:${USER} . \
         && chmod u=rwX,go= -R .

ONBUILD USER ${USER}

FROM robbtraister/phantomjs-base

ENTRYPOINT ["phantomjs"]
ONBUILD CMD ["index.js"]

ONBUILD ADD . ./

ONBUILD RUN chown -R ${USER}:${USER} . \
         && chmod u=rwX,go= -R .

ONBUILD USER ${USER}

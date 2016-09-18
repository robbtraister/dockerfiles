FROM ubuntu

ENTRYPOINT ["supervisord", "-c"]
CMD ["./supervisord.conf"]

ENV USER="worker" \
    WORKDIR="/workdir" \
    PHANTOMJS_VERSION="2.1.1"

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
                    bzip2 \
                    libfontconfig \
                    libfreetype6 \
                    wget \
 && wget -q --no-check-certificate -O /phantomjs.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 \
 && apt-get purge -y wget \
 && mkdir -p /usr/local/phantomjs \
 && tar -xjf /phantomjs.tar.bz2 -C /usr/local/phantomjs \
 && rm -f /phantomjs.tar.bz2 \
 && ln -s /usr/local/phantomjs/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64/bin/phantomjs /usr/bin/phantomjs \
 && apt-get autoremove -y \
 && apt-get clean all

WORKDIR ${WORKDIR}

ADD supervisord.conf ./

ONBUILD ADD . ./

ONBUILD RUN chown -R ${USER}:${USER} ./ \
         && chmod u=rwX,go= -R ./

ONBUILD USER ${USER}

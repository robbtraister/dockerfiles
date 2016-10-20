FROM robbtraister/watcher

ENV PROCESS="node" \
    ARGUMENTS="."

ONBUILD ADD package.json ./
ONBUILD RUN npm install --production \
         && npm cache clean

ONBUILD VOLUME ./src

ONBUILD RUN chown -R ${USER}:${USER} . \
         && chmod u=rwX,go= -R .

ONBUILD USER ${USER}

ONBUILD WORKDIR ./src

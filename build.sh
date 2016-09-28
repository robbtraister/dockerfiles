rm -rf phantomjs.tar*
docker build --rm=true -t phantomjs-dockerize -f Dockerfile.dockerize . && \
docker run -ti -v `pwd`:/target phantomjs-dockerize && \
docker build --rm=true -t robbtraister/phantomjs-base .

rm -rf phantomjs.tar*
docker build --rm=true -t robbtraister/debian-phantomjs -f Dockerfile.debian . && \
docker build --rm=true -t phantomjs-dockerizer -f Dockerfile.dockerizer . && \
docker run -ti -v `pwd`:/target phantomjs-dockerizer && \
docker build --rm=true -t robbtraister/phantomjs .

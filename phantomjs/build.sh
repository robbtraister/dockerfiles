rm -r phantomjs.tar.gz
docker build -t robbtraister/debian-phantomjs -f Dockerfile.debian . && \
docker build -t phantomjs-dockerizer -f Dockerfile.dockerizer . && \
docker run -ti -v `pwd`:/target phantomjs-dockerizer && \

# build this base for phantomjs_supervisor
docker build -t robbtraister/phantomjs-base -f Dockerfile.base .
docker build -t robbtraister/phantomjs -f Dockerfile .

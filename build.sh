rm -r phantomjs.tar.gz
docker build -t robbtraister/debian-phantomjs -f Dockerfile.debian . && \
docker build -t phantomjs-dockerizer -f Dockerfile.dockerizer . && \
docker run -ti -v `pwd`:/target phantomjs-dockerizer

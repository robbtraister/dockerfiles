FROM robbtraister/base

ADD phantomjs.tar.bz2 /

RUN phantomjs -v

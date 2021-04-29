FROM node:14.10.1-alpine3.11

RUN apk add --no-cache autoconf curl automake libtool pkgconfig python2 git build-base \
    && npm install -g node-gyp 

RUN git clone https://github.com/openvenues/libpostal 
RUN mkdir /libpostal-data \
    && cd libpostal \
    && ./bootstrap.sh \
    && ./configure --datadir=/libpostal-data \
    && make \
    && make install \
    && cd ..

ENTRYPOINT [ "/libpostal/src/address_parser" ]
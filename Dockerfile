ARG DEBIAN_VERSION

FROM buildpack-deps:${DEBIAN_VERSION}

ARG FREETDS_VERSION=1.1.11
RUN set -ex \
    && wget -O freetds.tar.gz "http://www.freetds.org/files/stable/freetds-${FREETDS_VERSION}.tar.gz" \
    && mkdir -p /usr/src/freetds \
    && tar -xzC /usr/src/freetds --strip-components=1 -f freetds.tar.gz \
    && rm freetds.tar.gz \
    && cd /usr/src/freetds \
    && ./configure \
        --datarootdir=/usr/src/freetds/data \
        --prefix=/usr/local \
    && make -j "$(nproc)" \
    && make install

WORKDIR /root

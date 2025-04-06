FROM postgres:alpine

RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community timescaledb \
 && echo "shared_preload_libraries = 'timescaledb'" >> /usr/share/postgresql/postgresql.conf.sample

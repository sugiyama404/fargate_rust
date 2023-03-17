FROM rust:1-slim-buster as builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    default-libmysqlclient-dev mariadb-client \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src
COPY . .
WORKDIR /usr/src/practice-rust

RUN cargo install --path .

FROM debian:10.13-slim as stage

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    default-libmysqlclient-dev mariadb-client \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

ENV LC_CTYPE=ja_JP.utf8 \
    LANG=ja_JP.utf8

ENV HOST db
ENV DBNAME todoproject
ENV USERNAME rustrust
ENV PASSWORD rustrust

EXPOSE 8080
COPY --from=builder /usr/local/cargo/bin/practice-rust /usr/local/bin/practice-rust
CMD [ "practice-rust"]

FROM unocha/alpine-base-nodejs

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Alpine based docker image.
# Includes git, build-base, python2, nodejs, grunt, karma and ruby bundler.

RUN apk add --update-cache \
      build-base \
      python \
      ruby-bundler && \
    rm -rf /var/cache/apk/* && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools && \
    rm -r /root/.cache && \
    rm -rf /var/lib/apk/*

ENTRYPOINT ["sh"]

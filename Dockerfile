FROM python:3
MAINTAINER Kyle Huang <kyle@yellowaxe.com>

ENV HUGO_VERSION=0.18.1
ENV HUGO_DOWNLOAD=https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}-64bit.deb

RUN apt-get update && apt-get install -y --no-install-recommends rsync \
  && pip install -U pip Pygments \
  && wget ${HUGO_DOWNLOAD} -O /tmp/hugo.deb \
  && dpkg -i /tmp/hugo.deb \
  && rm /tmp/hugo.deb \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /site /public

WORKDIR /site

VOLUME /site
VOLUME /public

EXPOSE 1313

ENTRYPOINT [ "hugo", "-d", "/public" ]


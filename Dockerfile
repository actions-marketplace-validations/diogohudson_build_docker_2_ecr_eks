FROM python:3.10.0a7-alpine3.13

LABEL maintainer="Diogo Hudson Dias"

ENV PYTHONIOENCODING=UTF-8

RUN apk update \
  && apk upgrade \
  && apk add --no-cache --update python3 py-pip coreutils bash curl \
  && rm -rf /var/cache/apk/* \
  && pip install pyyaml==5.3.1 \
  && pip install -U awscli \
  && apk --purge -v del py-pip \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/1.23.6/bin/linux/amd64/kubectl \
  && mv ./kubectl /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl

ADD entrypoint.sh /entrypoint.sh

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]

FROM docker:19.03.4

RUN apk update \
  && apk upgrade \
  && apk add --no-cache --update python py-pip coreutils bash curl \
  && rm -rf /var/cache/apk/* \
  && pip install pyyaml==5.3.1 \
  && pip install -U awscli \
  && apk --purge -v del py-pip \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl \
  && mv ./kubectl /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl

ADD entrypoint.sh /entrypoint.sh

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]

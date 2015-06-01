FROM quay.io/sporkmonger/secure-bootstrap
MAINTAINER Bob Aman <bob@sporkmonger.com>

RUN mkdir -p /opt/bin/

# Get access to edge & testing repositories
COPY repositories /etc/apk/repositories

# Install salt
RUN apk add --update salt-api@testing && rm -rf /var/cache/apk/*

CMD [ "/bin/bash" ]

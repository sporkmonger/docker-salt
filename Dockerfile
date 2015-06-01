FROM quay.io/sporkmonger/secure-bootstrap
MAINTAINER Bob Aman <bob@sporkmonger.com>

RUN mkdir -p /opt/bin/

# Install compiler
RUN apk add --update gcc g++ libgcc make musl-dev libc-dev linux-headers \
  libffi-dev swig=2.0.9-r0

# Get access to edge & testing repositories
COPY repositories /etc/apk/repositories

# Install python & salt
RUN apk add --update openssl openssl-dev python python-dev py-openssl \
  zeromq && rm -rf /var/cache/apk/*

# Install pip
COPY get-pip.py /root/get-pip.py
RUN python /root/get-pip.py && rm /root/get-pip.py

# Install salt & python dependencies
RUN pip install pyyaml jinja2 msgpack-python apache-libcloud requests \
  pyzmq pycrypto m2crypto salt

CMD [ "/bin/bash" ]

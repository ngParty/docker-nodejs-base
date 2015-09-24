FROM phusion/baseimage:0.9.17

MAINTAINER Mario Vejlupek <mario@vejlupek.cz>

LABEL Description="Enriched phusion/baseimage with Nodejs dependencies" Vendor="ngParty" Version="1.0"

# Use baseimage-docker's init system. see http://bit.ly/1j6tz0M
CMD ["/sbin/my_init"]

# Install tools for compiled packages and common certificates
RUN apt-get update -y && \
  apt-get install --no-install-recommends -y \
  build-essential ca-certificates checkinstall git \
  libreadline-gplv2-dev libncursesw5-dev libssl-dev \
  libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev


# Install Python 2.x version necessary for node-gyp
RUN mkdir /python-install && \
  curl https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz | \
  tar xzvf - -C /python-install --strip-components=1 && \
  cd /python-install && \
  ./configure && \
  make install && \
  cd && \
  rm -rf /python-install

# Clean apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

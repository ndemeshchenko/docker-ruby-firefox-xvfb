FROM ruby:2.3

#set env variables
ENV DISPLAY=":99.0" \
    FF_VERSION="44.0"

# install libs, xvfb and firefox
RUN apt-get update && apt-get install -y --no-install-recommends \
                autoconf \
                automake \
                bzip2 \
                file \
                g++ \
                gcc \
                imagemagick \
                libbz2-dev \
                libc6-dev \
                libcurl4-openssl-dev \
                libevent-dev \
                libffi-dev \
                libgeoip-dev \
                libglib2.0-dev \
                libjpeg-dev \
                liblzma-dev \
                libmagickcore-dev \
                libmagickwand-dev \
                libmysqlclient-dev \
                libncurses-dev \
                libpng-dev \
                libpq-dev \
                libreadline-dev \
                libsqlite3-dev \
                libssl-dev \
                libtool \
                libwebp-dev \
                libxml2-dev \
                libxslt-dev \
                libyaml-dev \
                make \
                patch \
                xz-utils \
                zlib1g-dev \
                git \
        && rm -rf /var/lib/apt/lists/*

RUN wget "https://ftp.mozilla.org/pub/firefox/releases/${FF_VERSION}/linux-x86_64/en-US/firefox-44.0.sdk.tar.bz2" \
    -O /tmp/firefox.tar.bz2 && \
    tar xvf /tmp/firefox.tar.bz2 -C /opt && \
    ln -s /opt/firefox/firefox /usr/bin/firefox

# install xvfb init script
COPY xvfb-run /usr/local/bin/
RUN chmod +x /usr/local/bin/xvfb-run

# cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/usr/local/bin/xvfb-run"]
CMD []

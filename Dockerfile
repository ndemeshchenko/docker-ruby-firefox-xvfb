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
		libasound2 \
 		python-ply \
		libgl1-mesa-glx \
		libatk1.0-0 \
		libdbus-1-3 \
		libdbus-glib-1-2 \
		libgtk2.0-0 \
		libhunspell-1.3-0 \
		libstartup-notification0 \
		libxcomposite1 \
        && rm -rf /var/lib/apt/lists/*

#install fake X server
RUN wget http://ftp.us.debian.org/debian/pool/main/x/xorg-server/xvfb_1.17.3-2_amd64.deb
RUN wget http://ftp.us.debian.org/debian/pool/main/libx/libxfont/libxfont1_1.5.1-1_amd64.deb
RUN wget http://ftp.us.debian.org/debian/pool/main/libf/libfontenc/libfontenc1_1.1.2-1+b2_amd64.deb
RUN wget http://ftp.us.debian.org/debian/pool/main/x/xkeyboard-config/xkb-data_2.12-1_all.deb
RUN wget http://ftp.us.debian.org/debian/pool/main/libx/libxmu/libxmu6_1.1.2-2_amd64.deb
RUN wget http://ftp.us.debian.org/debian/pool/main/libx/libxaw/libxaw7_1.0.13-1_amd64.deb
RUN wget http://ftp.us.debian.org/debian/pool/main/libx/libxkbfile/libxkbfile1_1.0.8-1_amd64.deb
RUN wget http://ftp.us.debian.org/debian/pool/main/x/x11-xkb-utils/x11-xkb-utils_7.7+2_amd64.deb
RUN wget http://ftp.us.debian.org/debian/pool/main/x/xorg-server/xserver-common_1.17.3-2_all.deb
RUN dpkg -i libfontenc1_1.1.2-1+b2_amd64.deb
RUN dpkg -i libxfont1_1.5.1-1_amd64.deb
RUN dpkg -i xkb-data_2.12-1_all.deb
RUN dpkg -i libxmu6_1.1.2-2_amd64.deb
RUN dpkg -i libxaw7_1.0.13-1_amd64.deb
RUN dpkg -i libxkbfile1_1.0.8-1_amd64.deb
RUN dpkg -i x11-xkb-utils_7.7+2_amd64.deb
RUN dpkg -i xserver-common_1.17.3-2_all.deb
RUN dpkg -i xvfb_1.17.3-2_amd64.deb

RUN wget http://security.debian.org/debian-security/pool/updates/main/i/iceweasel/iceweasel_38.6.0esr-1~deb8u1_amd64.deb
RUN dpkg -i iceweasel_38.6.0esr-1~deb8u1_amd64.deb

#RUN wget "https://ftp.mozilla.org/pub/firefox/releases/${FF_VERSION}/linux-x86_64/en-US/firefox-44.0.sdk.tar.bz2" \
#    -O /tmp/firefox.tar.bz2 && \
#    tar xvf /tmp/firefox.tar.bz2 -C /opt && \
#    ln -s /opt/firefox/firefox /usr/bin/firefox

# install xvfb init script
COPY xvfb-run /usr/local/bin/
RUN chmod +x /usr/local/bin/xvfb-run

# cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/usr/local/bin/xvfb-run"]
CMD []

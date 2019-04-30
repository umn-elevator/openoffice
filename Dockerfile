FROM        ubuntu:18.04

WORKDIR     /tmp/workdir

RUN     apt-get -yqq update && \
        apt-get --no-install-recommends -yqq install libreoffice libreoffice-script-provider-python unoconv && \
        rm -rf /var/lib/apt/lists/*

RUN     echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections
RUN     apt-get -yqq update && \ 
        apt-get install -y --no-install-recommends fontconfig ttf-mscorefonts-installer && \
        rm -rf /var/lib/apt/lists/*
ADD     localfonts.conf /etc/fonts/local.conf
RUN     fc-cache -f -v

MAINTAINER  Colin McFadden <mcfa0086@umn.edu>

CMD         ["--help"]
ENTRYPOINT  ["unoconv"]
ENV         LD_LIBRARY_PATH=/usr/local/lib

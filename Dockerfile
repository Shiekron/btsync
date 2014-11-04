FROM ubuntu:14.04
MAINTAINER Joe Ortiz

ENV LANG en_US.UTF-8
RUN locale-gen $LANG

ADD http://download-new.utorrent.com/endpoint/btsync/os/linux-x64/track/stable /btsync.tar.gz
RUN tar xf /btsync.tar.gz && \
    rm /btsync.tar.gz

ADD start.sh /start.sh
RUN chmod 755 /start.sh
VOLUME ["/data"]
EXPOSE 3369/udp
EXPOSE 8888
ENTRYPOINT ["/start.sh"]

FROM debian:latest

MAINTAINER Dmitrii Zolotov <dzolotov@herzen.spb.ru>

RUN apt-get -y update && apt-get -y install wget && \
    wget http://packages.lizardfs.com/lizardfs.key && apt-key add lizardfs.key && \
    echo "deb http://packages.lizardfs.com/debian/jessie jessie main" > /etc/apt/sources.list.d/lizardfs.list && \
    echo "deb-src http://packages.lizardfs.com/debian/jessie jessie main" >> /etc/apt/sources.list.d/lizardfs.list && \
    apt-get -y update && apt-get -y install lizardfs-chunkserver && \
    cp /etc/mfs/mfschunkserver.cfg.dist /etc/mfs/mfschunkserver.cfg && \
    sed -i 's/LIZARDFSCHUNKSERVER_ENABLE=false/LIZARDFSCHUNKSERVER_ENABLE=true/g'  /etc/default/lizardfs-chunkserver

ENV MOUNTS=''

ADD run.sh /

CMD [ "/run.sh" ]
FROM mono

LABEL maintainer="humanoidinshell@gmail.com"

ENV SERVER_VERSION=1353 \
    TMODLOADER_VERSION=0.11.3 \
    SERVER_ROOT=/data \
    SERVER_LOG=/logs \
    SERVER_ZIP=terraria-server.zip \
    TMODLOADER_ZIP=tmodl.zip \
    UID=1000 \
    GID=1000 \
    TYPE=VANILLA

RUN groupadd -g $GID terraria && \
    useradd -s /bin/false -d $SERVER_ROOT -u $UID -g terraria terraria

RUN mkdir -m 777 /data /logs /config /world /mods && \
    chown terraria:terraria /data /logs /config /world /mods

RUN apt-get update && apt-get install -y gosu wget bsdtar && apt-get clean 

VOLUME ["/world","/logs","/config","/mods","/data"]
EXPOSE 7777

ADD server.conf /config
ADD run.sh /
ADD launch.sh /
COPY run-* /

RUN chmod a+x /run.sh /launch.sh /run-*
RUN chown -R terraria:terraria /data /logs /config /world /mods

WORKDIR $SERVER_ROOT

ENTRYPOINT ["/run.sh"]

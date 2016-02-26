FROM java:8

MAINTAINER XiNGRZ

ENV JVM_OPTS -Xmx1024M -Xms1024M

EXPOSE 25565

RUN wget -O /forge-1.7.10-10.13.4.1448-1.7.10-installer.jar \
  "http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.7.10-10.13.4.1448-1.7.10/forge-1.7.10-10.13.4.1448-1.7.10-installer.jar"

RUN useradd -M -s /bin/false --uid 1000 minecraft

RUN mkdir /data
RUN mkdir /server

RUN echo "eula=TRUE" > /server/eula.txt

ADD /server.properties /data/server.properties
RUN ln -s /data/server.properties /server/server.properties

ADD /mods /data/mods
RUN ln -s /data/mods /server/mods

RUN echo "[]" > /data/banned-ips.json \
  && ln -s /data/banned-ips.json /server/banned-ips.json

RUN echo "[]" > /data/banned-players.json \
  && ln -s /data/banned-players.json /server/banned-players.json

RUN echo "[]" > /data/ops.json \
  && ln -s /data/ops.json /server/ops.json

RUN echo "[]" > /data/whitelist.json \
  && ln -s /data/whitelist.json /server/whitelist.json

RUN mkdir /data/config \
  && ln -s /data/config /server/config

RUN mkdir /data/crash-reports \
  && ln -s /data/crash-reports /server/crash-reports

RUN mkdir /data/logs \
  && ln -s /data/logs /server/logs

RUN mkdir /data/world \
  && ln -s /data/world /server/world

RUN chown minecraft:minecraft -R /data /server

USER minecraft

VOLUME [ "/data" ]

WORKDIR /server

RUN java -jar /forge-1.7.10-10.13.4.1448-1.7.10-installer.jar --installServer

CMD java -jar /server/forge-1.7.10-10.13.4.1448-1.7.10-universal.jar nogui

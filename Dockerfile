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

ADD /start-server.sh /start-server.sh

ADD /server.properties /server/server.properties
ADD /mods /server/mods

RUN mkdir /server/config
RUN mkdir /server/crash-reports
RUN mkdir /server/logs
RUN mkdir /server/world

RUN echo "[]" > /server/banned-ips.json
RUN echo "[]" > /server/banned-players.json
RUN echo "[]" > /server/ops.json
RUN echo "[]" > /server/whitelist.json

RUN chown minecraft:minecraft -R /data /server /start-server.sh

USER minecraft

VOLUME [ "/data" ]

WORKDIR /server

RUN java -jar /forge-1.7.10-10.13.4.1448-1.7.10-installer.jar --installServer

CMD /start-server.sh

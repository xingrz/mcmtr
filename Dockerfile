FROM java:8

MAINTAINER XiNGRZ

EXPOSE 25565

RUN wget -O /forge-1.7.10-10.13.4.1448-1.7.10-installer.jar \
  "http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.7.10-10.13.4.1448-1.7.10/forge-1.7.10-10.13.4.1448-1.7.10-installer.jar"

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

VOLUME [ "/data" ]

WORKDIR /server

RUN java -jar /forge-1.7.10-10.13.4.1448-1.7.10-installer.jar --installServer

CMD /start-server.sh

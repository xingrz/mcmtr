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

ADD /server.properties /server/server.properties
ADD /mods /server/mods

RUN chown minecraft:minecraft -R /data /server

USER minecraft

VOLUME [ "/data" ]

WORKDIR /server

RUN java -jar /forge-1.7.10-10.13.4.1448-1.7.10-installer.jar --installServer

CMD start-server.sh

FROM craftcloud/forge:latest

MAINTAINER XiNGRZ <xxx@oxo.ooo>

ENV EULA TRUE

ENV VERSION 1.7.10

COPY server.properties /tmp/server.properties

ADD /mods /mods

FROM craftcloud/forge:1.7.10

MAINTAINER XiNGRZ <xxx@oxo.ooo>

ENV EULA TRUE

COPY server.properties /server.properties
COPY mods /mods

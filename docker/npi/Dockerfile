FROM centos:7
MAINTAINER npi

ENV NPI_HOME /opt/npi
RUN useradd -u 1000 netcool
RUN mkdir -p $NPI_HOME

RUN yum install -y nc
RUN yum install -y which

ADD . $NPI_HOME
COPY ./docker/npi/bootstrap.sh $NPI_HOME/

RUN mkdir -p $NPI_HOME/bin
ADD ./bin/scripts $NPI_HOME/bin/scripts
ADD ./bin/npid $NPI_HOME/bin/npid

RUN mkdir -p $NPI_HOME/log $NPI_HOME/work $NPI_HOME/conf

RUN chown -R 1000:1000 $NPI_HOME
USER netcool

EXPOSE 8081/tcp 9081/tcp 9443/tcp 4379/udp 2552/tcp

VOLUME ["$NPI_HOME/log", "$NPI_HOME/work", "$NPI_HOME/conf"]

WORKDIR $NPI_HOME
ENTRYPOINT sh -e ./bootstrap.sh


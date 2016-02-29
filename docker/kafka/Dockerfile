FROM centos:7
MAINTAINER npi

ENV NPI_HOME /opt/npi
ENV JAVA_HOME $NPI_HOME/resources/jre/RHEL/ibm-java-x86_64-80/jre
RUN useradd -u 1000 netcool
RUN mkdir -p $NPI_HOME

RUN yum install -y nc
RUN yum install -y which

ADD ./resources/jre $NPI_HOME/resources/jre
ADD ./services/kafka $NPI_HOME/services/kafka
ADD ./services/conf/kafka $NPI_HOME/services/conf/kafka
ADD ./docker/kafka/bootstrap.sh $NPI_HOME/

RUN mkdir -p $NPI_HOME/bin
ADD ./bin/scripts $NPI_HOME/bin/scripts
ADD ./bin/npid $NPI_HOME/bin/npid

RUN mkdir -p $NPI_HOME/work $NPI_HOME/services/kafka/logs

RUN chown -R 1000:1000 $NPI_HOME
USER netcool

EXPOSE 9092/tcp

VOLUME ["$NPI_HOME/services/kafka/logs", "$NPI_HOME/work"]

WORKDIR $NPI_HOME
ENTRYPOINT sh -e ./bootstrap.sh


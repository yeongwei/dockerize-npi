FROM centos:7
MAINTAINER npi

ENV NPI_HOME /opt/npi
ENV JAVA_HOME $NPI_HOME/resources/jre/RHEL/ibm-java-x86_64-80/jre
RUN useradd -u 1000 netcool
RUN mkdir -p $NPI_HOME

ADD ./resources/jre $NPI_HOME/resources/jre
ADD ./services/kafka $NPI_HOME/services/kafka
ADD ./services/conf/kafka $NPI_HOME/services/conf/kafka
ADD ./docker/zk/bootstrap.sh $NPI_HOME/
ADD ./bin $NPI_HOME/bin
RUN mkdir -p $NPI_HOME/work $NPI_HOME/services/kafka/log

RUN chown -R 1000:1000 $NPI_HOME
USER netcool

EXPOSE 2181/tcp

VOLUME ["$NPI_HOME/services/kafka/log", "$NPI_HOME/work"]

WORKDIR $NPI_HOME
ENTRYPOINT sh -e ./bootstrap.sh

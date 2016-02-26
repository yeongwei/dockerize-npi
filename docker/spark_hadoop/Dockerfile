FROM centos:7
MAINTAINER npi

ENV NPI_HOME /opt/npi
ENV JAVA_HOME $NPI_HOME/resources/jre/RHEL/ibm-java-x86_64-80/jre
RUN useradd -u 1000 netcool
RUN mkdir -p $NPI_HOME

RUN yum install -y nc
RUN yum install -y which

ADD ./resources/jre $NPI_HOME/resources/jre
ADD ./services/hadoop $NPI_HOME/services/hadoop
ADD ./services/conf $NPI_HOME/services/conf
ADD ./services/spark $NPI_HOME/services/spark
ADD ./docker/spark_hadoop/bootstrap.sh $NPI_HOME/
ADD ./bin $NPI_HOME/bin
RUN mkdir -p $NPI_HOME/work $NPI_HOME/services/hadoop/logs

RUN chown -R 1000:1000 $NPI_HOME
USER netcool

VOLUME ["$NPI_HOME/services/hadoop/logs", "$NPI_HOME/work"]

WORKDIR $NPI_HOME
ENTRYPOINT sh -e ./bootstrap.sh

# Name node ports
EXPOSE 9000
# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090
# Mapred ports
EXPOSE 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
EXPOSE 49707 2122   

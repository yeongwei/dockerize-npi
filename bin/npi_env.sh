# Sample template environment file for Docker, source this
# in the user profile that start the Docker service.

export HOSTNAME="sherpa"
export HADOOP_NAMENODE_URL=hdfs://${HOSTNAME}:9000/
export ZOOKEEP_URL=${HOSTNAME}:2181
export KAFKA_BROKER_LIST=${HOSTNAME}:9092
export NPI_STORAGE_HOST=${HOSTNAME}
export NPI_WORK_PATH=/data/work
# export NPI_CONF_PATH=/data/npi-conf    # optional if overriding NPI default /opt/npi/conf

export NAMENODE=true
export USER_CONFIG=false

export HADOOP_PREFIX=${SERVICES_DIR}/hadoop
export STORAGE_URL=$HADOOP_NAMENODE_URL

export JDBC_SERVICE=${JDBC_SERVICE:-"${NPI_STORAGE_HOST}:8091"}

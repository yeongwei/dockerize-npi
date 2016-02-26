#!/bin/sh
#/*--------------------------------------------------------------------------
# * Licensed Materials - Property of IBM
# * 5724-P55, 5724-P57, 5724-P58, 5724-P59
# * Copyright IBM Corporation 2007. All Rights Reserved.
# * US Government Users Restricted Rights- Use, duplication or disclosure
# * restricted by GSA ADP Schedule Contract with IBM Corp.
# *--------------------------------------------------------------------------*/

SCRIPT=$0
if [ "`echo $0 | cut -c1`" = "." ]; then
   SCRIPT="`pwd`/`echo "$0" | sed 's/\.\///g'`"
elif [ "`echo $0 | cut -c1`" != "/" ]; then
   SCRIPT="`pwd`/$0"
fi

BIN_DIR=`dirname $SCRIPT`
PROG_HOME=`dirname $BIN_DIR`

if [ -z "$PROG_HOME" ] ; then
  ## resolve links - $0 may be a link to PROG_HOME
  PRG="$0"

  # need this for relative symlinks
  while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
      PRG="$link"
    else
      PRG="`dirname "$PRG"`/$link"
    fi
  done

  saveddir=`pwd`

  PROG_HOME=`dirname "$PRG"`/..

  # make it fully qualified
  PROG_HOME=`cd "$PROG_HOME" && pwd`

  cd "$saveddir"
fi
export PROG_HOME

export DFS_REPF=${DFS_REPF:-1}

if [ $# -eq 1 ];then
	HADOOP_URL=$1
else
	HADOOP_URL="hdfs://$(hostname):9000"
fi

echo "Configuring config files and environment for hadoop and spark..."

cat $PROG_HOME/services/conf/hadoop/core-site.xml.template | sed -e "s|NPI_WORK|$PROG_HOME/work|g" | \
  sed -e "s|HADOOP_URL|$HADOOP_URL|g" > $PROG_HOME/services/hadoop/etc/hadoop/core-site.xml

cat $PROG_HOME/services/conf/hadoop/hadoop-env.sh | sed -e "s|UPDATE_ME|$PROG_HOME|g" > \
  $PROG_HOME/services/hadoop/etc/hadoop/hadoop-env.sh

cat $PROG_HOME/services/conf/spark/spark-env.sh | sed -e "s|UPDATE_ME|$PROG_HOME|g" > \
  $PROG_HOME/services/spark/conf/spark-env.sh
chmod u+x $PROG_HOME/services/spark/conf/spark-env.sh

. $PROG_HOME/services/hadoop/etc/hadoop/hadoop-env.sh

echo "Copying site config to hadoop conf folder..."

cat $PROG_HOME/services/conf/hadoop/hdfs-site.xml.template | sed -e "s|DFS_REPF|$DFS_REPF|g" > \
  $PROG_HOME/services/hadoop/etc/hadoop/hdfs-site.xml
YARN_APP_CLASSPATH=$($HADOOP_HOME/bin/hadoop classpath |sed -e 's/:/, /g')
YARN_APP_CLASSPATH="$YARN_APP_CLASSPATH, $PROG_HOME/services/spark/lib/*"
cat $PROG_HOME/services/conf/hadoop/yarn-site.xml.template | sed -e "s|NPI_CLASSPATH|$YARN_APP_CLASSPATH|g" | \
 sed -e "s|HOSTNAME|$HOSTNAME|g" > $PROG_HOME/services/hadoop/etc/hadoop/yarn-site.xml

echo "Done."
echo
echo "Please initialize new namenode using \"$PROG_HOME/services/hadoop/bin/hdfs namenode -format\""
echo "Then start Hadoop and YARN service using start-dfs.sh and start-yarn.sh"
echo "Hadoop environment is in $PROG_HOME/services/hadoop/etc/hadoop/hadoop-env.sh and "
echo "Spark environment is in $PROG_HOME/services/spark/conf/spark-env.sh"

      
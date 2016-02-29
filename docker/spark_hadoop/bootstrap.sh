#!/bin/sh
#/*--------------------------------------------------------------------------
# * Licensed Materials - Property of IBM
# * 5724-P55, 5724-P57, 5724-P58, 5724-P59
# * Copyright IBM Corporation 2007. All Rights Reserved.
# * US Government Users Restricted Rights- Use, duplication or disclosure
# * restricted by GSA ADP Schedule Contract with IBM Corp.
# *--------------------------------------------------------------------------*/

export NPI_HOME=${NPI_HOME:-"/opt/npi"}
export START_DELAY=${START_DELAY:-3}
export PATH=$PATH:/usr/bin

echo "Starting Hadoop services"
sleep $START_DELAY

term_handler() {
	echo "Signal received, stopping process"
	(cd $NPI_HOME/bin && ./npid stop hadoop)
}

trap "term_handler;exit" SIGTERM SIGINT

(cd $NPI_HOME/bin && ./npid start hadoop)

readPids() {	
	cat ${1} | tr '\n' ' '	
}
PIDS="`readPids $NPI_HOME/var/hadoop*.pid`"
PIDS="${PIDS}`readPids $NPI_HOME/var/yarn*.pid`"

while [ $(ps ${PIDS} 2&> /dev/null;echo $?) -eq 0 ];do sleep 1;done

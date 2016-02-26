#!/bin/sh
#/*--------------------------------------------------------------------------
# * Licensed Materials - Property of IBM
# * 5724-P55, 5724-P57, 5724-P58, 5724-P59
# * Copyright IBM Corporation 2007. All Rights Reserved.
# * US Government Users Restricted Rights- Use, duplication or disclosure
# * restricted by GSA ADP Schedule Contract with IBM Corp.
# *--------------------------------------------------------------------------*/

export NPI_HOME=${NPI_HOME:-"/opt/npi"}
export PROG_NAME=npi
export START_DELAY=${START_DELAY:-3}
export PATH=$PATH:/usr/bin

term_handler() {
	echo "Stopping NPI"
	(cd $NPI_HOME/bin && ./npid stop npi)
}

trap "term_handler; exit" SIGTERM SIGINT

echo "Staring NPI"
sleep $START_DELAY

(cd $NPI_HOME/bin && ./npid start npi)
sleep $START_DELAY

pidFiles=("storage.pid" "analytics.pid" "collector.pid" "ui.pid")
PID=""
for pidFile in "${pidFiles[@]}"; do
	PID="$PID `head -1 ${NPI_HOME}/var/${pidFile}`"
done

while [ $(ps ${PID} 2&> /dev/null;echo $?) -eq 0 ];do sleep 1;done

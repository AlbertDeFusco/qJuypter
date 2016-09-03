#!/usr/bin/env bash

if [ "$PBS_JOBID" == "" ]
then
  echo "Please run qjupyter.sh from an interactive Torque PBS job"
  exit 1
fi

which jupyter 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]
then
  echo "The jupyter or ipython command was not found in your \$PATH"
  exit 1
else
  port=$(($RANDOM%63000+2001))
  echo
  echo
  echo "Launching Jupyter Notebook with port $port on $HOSTNAME"
  echo
  echo "If you cannot access http://$HOSTNAME:$port then you will need an SSH tunnel"
  echo "Your SSH tunnel command on your desktop should look like the following"
  echo "  ssh -L 9999:localhost:8888 $USER@\$GATEWAY ssh -L 8888:localhost:$port $HOSTNAME"
  echo
  echo "  This job was submitted from $PBS_O_HOST and it may be able to serve as the \$GATEWAY node"
  echo
  echo "Then visit http://localhost:9999 on your desktop."
  echo
  echo "To terminate this notebook session press ctrl-C twice."
  echo
  jupyter notebook --no-browser --port=$port
fi

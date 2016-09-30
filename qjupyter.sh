#!/usr/bin/env bash


which jupyter 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]
then
  echo "The jupyter or ipython command was not found in your \$PATH"
  exit 1
else
  port=$(($RANDOM%63000+2001))
  echo
  echo
  echo "Launching Jupyter Notebook with port 9999 on $HOSTNAME"
  echo
  echo "If you cannot access http://$HOSTNAME:$port then you will need an SSH tunnel"
  echo "Your SSH tunnel command on your desktop should look like the following"
  echo "  ssh -L $port:$HOSTNAME:9999 -f -N $USER@peregrine.hpc.nrel.gov"
  echo
  echo "  This job was submitted from $PBS_O_HOST and it may be able to serve as the \$GATEWAY node"
  echo
  echo "Then visit http://localhost:$port on your desktop."
  echo
  echo "To terminate this notebook session press ctrl-C twice."
  echo
  jupyter notebook --no-browser --port=9999 --ip=*
fi

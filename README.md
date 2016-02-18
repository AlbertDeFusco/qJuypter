# qJupyter

This script can be used to launch Jupyter notebooks directly from an interactive job using Torque PBS.
It will select a random port number and suggest an SSH tunnel command if necessary.

##Submit interactive job
You can submit an interactive job for iPython just like a normal job.

* NOTE: even though it is possible to request more than one core in a job there is no guarantee that Python will be able to run your tasks in parallel.

```
defusco@login0a:~>qsub -I -q shared -l nodes=1:ppn=1,walltime=2:00:00
qsub: waiting for job 3060579.clusman0a.frank.sam.pitt.edu to start
qsub: job 3060579.clusman0a.frank.sam.pitt.edu ready

defusco@n4:~>
```

##Launch iPython notebook
Once the interactive job is running run `qjupyter.sh` to launch the notebook and receive further instructions.

```
defusco@n4:~>./qjupyter.sh


Launching Jupyter Notebook with port 4922 on n4

If you cannot access http://n4:4922 then you will need an SSH tunnel
Your SSH tunnel command on your desktop should look like the following
  ssh -L 9999:localhost:8888 defusco@$GATEWAY ssh -L 8888:localhost:4922 -N n4

    This job was submitted from login0a-priv and it may be able to serve as the $GATEWAY node

  Then visit http://localhost:9999 on your desktop.

  To terminate this notebook session press ctrl-C twice.
```


## SSH Tunnels
If you cannot access the compute resource directly from your desktop you will need to setup an SSH tunnel.

At this time the procedure is known to work on Mac OS X and Linux desktops where SSH can be run on the command line.
For Windows desktops there may be [several](https://code.google.com/p/putty-tunnel-manager/) [ways](http://www.ytechie.com/2008/05/set-up-a-windows-ssh-tunnel-in-10-minutes-or-less/) [to](http://superuser.com/questions/235395/automatic-ssh-tunneling-from-windows) [create](http://www.vpnreactor.com/windows_ssh_tunnel.html) [SSH tunnels](http://nemesis2.qx.net/pages/MyEnTunnel)


On your desktop computer running either Linux or Mac OS X open a second terminal and run the SSH tunnel command shown in your `qjupyter.sh` output.
If little to no output is shown then the tunnel has been established.

* NOTE: do not stop the SSH tunnel process or you will loose your connection to the Jupyter notebook

```
albert@laptop:~>ssh -L 9999:localhost:8888 defusco@frank.sam.pitt.edu ssh -L 8888:localhost:4922 -N n4
Warning: Permanently added 'n4,10.201.1.4' (RSA) to the list of known hosts.
```

Once the tunnel has been established you can connect directly to your Jupyter notebook running on the compute node by navigating your browser to `http://localhost:9999`.

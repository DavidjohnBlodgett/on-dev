## DOCUMENTATION

Currently this is a staging area for a WIP conversion of our example demo back into a development enviorment.


## WINDOWS SETUP

Install the latest Vagrant & Virtual Box programs onto your host.

	https://www.vagrantup.com/downloads.html
    https://www.virtualbox.org/wiki/Downloads

Git clone the on-dev repo onto your system.

    $ cd /<pathToYourWorkSpace>/
    $ git clone https://github.com/DavidjohnBlodgett/on-dev.git

Enter the build directory & /bin folder that holds the batch script (this will import into Virtual box a monorail server VM and some number of PXE clients).

    $ cd on-dev/build/bin
	
Execute the monorail_rack setup.

    $ monorail_rack.bat

see section below to change the number of PXE clients created at runtime.


## UBUNTU / LINUX / MAC SETUP

Install Vagrant & Virtual Box onto your host.

	https://www.vagrantup.com/downloads.html
    https://www.virtualbox.org/wiki/Downloads

Clone RackHD repo to your local git directory.

    $ cd /<pathToYourWorkSpace>/
    $ git clone https://github.com/DavidjohnBlodgett/on-dev.git


Enter the build directory and create a new config.

    $ cd on-dev/build/
    $ cp config/monorail_rack.cfg.example config/monorail_rack.cfg

Enter the /bin folder that holds the batch script (this will import into Virtual box a monorail server VM and some number of PXE clients).

    $ cd bin/

Edits can be made to this new file to adjust the number of pxe clients created.

    $ monorail_rack



## GIT FORK & GIT CLONE REPOSITORIES

The monorail server currently will mount the on-dev directory found on your host to the /home/vagrant/src directory on the VM.

    /<pathToYourWorkSpace>/on-dev == /home/vagrant/src
	
This being said, it is currently a manual process to place the expected monorail repositories within on-dev so they will be reflected inside the VM.
The goal of this section is to provide a clear basic explination of each step needed to set up your git repositories with a common workflow.

1.Git fork each repository to your Github account.

 - login to Github and click fork within each repository listed below.

> - https://github.com/RackHD/on-http
> - https://github.com/RackHD/on-core
> - https://github.com/RackHD/on-taskgraph
> - https://github.com/RackHD/on-tasks
> - https://github.com/RackHD/on-tftp
> - https://github.com/RackHD/on-dhcp-proxy
> - https://github.com/RackHD/on-imagebuilder
> - https://github.com/RackHD/on-statsd
> - https://github.com/RackHD/on-syslog
> - https://github.com/RackHD/on-tools


2.Git clone each repository from your forks.

 - login to Github and copy the HTTPS URL from each of the repositories you have just forked, example URLs below.
 - From the on-dev directory, for each repository URL execute the following command.
```
     /<pathToYourWorkSpace>/on-dev/$ git clone <URLtoYourFork> 
```
> - https://github.com/yourAccount/on-http
> - https://github.com/yourAccount/on-core
> - https://github.com/yourAccount/on-taskgraph
> - https://github.com/yourAccount/on-tasks
> - https://github.com/yourAccount/on-tftp
> - https://github.com/yourAccount/on-dhcp-proxy
> - https://github.com/yourAccount/on-imagebuilder
> - https://github.com/yourAccount/on-statsd
> - https://github.com/yourAccount/on-syslog
> - https://github.com/yourAccount/on-tools


3.Set up the upstream/master for each repository.
 - Navigate to the repository we wish to setup upstream, for this example we will do on-http.
```
     /on-dev/on-http/$ git remote add upstream https://github.com/RackHD/on-http 
```
 - Repeat the above step for each repository using the respective URL found in the list for step 1.
```
     /on-dev/<eachRepo>/$ git remote add upstream <RackHD_Repo_URL>
``` 
The advantage of setting up this upstream relationship, from your local repositories to the RackHD repositories, will be explained later under Use Cases.

4.Copy static files from Monorail server to repective locations within on-http & on-tftp
 - Ssh into the Monorail server.
```
     /<pathToYourWorkSpace>/on-dev/build/bin/$ vagrant ssh dev
```
 - Make the common directory for on-http.
```
     /home/vagrant/$ mkdir /home/vagrant/src/on-http/static/http/common/
```
 - Copy files to thier expected locations.
```
     /home/vagrant/$ cp /home/vagrant/tmp/common/* /home/vagrant/src/on-http/static/http/common/
```
 
```
     /home/vagrant/$ cp /home/vagrant/tmp/tftp/* /home/vagrant/src/on-tftp/static/tftp/
```

5.Install dependicies
 - Ssh into the Monorail server.
```
     /<pathToYourWorkSpace>/on-dev/build/bin/$ vagrant ssh dev
```
 - For each repository found below, within the /home/vagrant/src directory on the Monorail server install the node dependicies (node_modules), below we install for on-http.
```
     /home/vagrant/src/on-http/$ npm install
```

> - on-http
> - on-taskgraph
> - on-tasks
> - on-tftp
> - on-dhcp-proxy
> - on-syslog

6.Use nodeforman to turn on monorail (from monorail server) /home/vagrant/.

    /home/vagrant/$ sudo nf start
	
## USE CASES
1.stuff will go here...
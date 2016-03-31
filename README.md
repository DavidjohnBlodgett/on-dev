## DOCUMENTATION

Currently this is a staging area for a WIP conversion of our example demo back into a development enviorment.


## WINDOWS SETUP

Install the latest Vagrant & Virtual Box programs onto your host.

	[Vagrant](https://www.vagrantup.com/downloads.html)
    [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

Git clone the on-dev repo onto your system.

    $ git clone https://github.com/DavidjohnBlodgett/on-dev.git

Enter the build directory & /bin folder that holds the batch script (this will import into Virtual box a monorail server VM and some number of PXE clients).

    $ cd on-dev/build/bin
	
Execute the monorail_rack setup.

    $ monorail_rack.bat

see section below to change the number of PXE clients created at runtime.


## UBUNTU / LINUX SETUP

Install Vagrant & Virtual Box onto your host.


Clone RackHD repo to your local git directory.

    $ git clone https://github.com/RackHD/RackHD
    $ cd RackHD


Change into the directory `example`, create config and run the setup command:

    $ cd example
    $ cp config/monorail_rack.cfg.example config/monorail_rack.cfg


Edits can be made to this new file to adjust the number of pxe clients created.

    $ bin/monorail_rack



## GIT FORK & GIT CLONE REPOSITORIES

The monorail server currently will mount the on-dev directory found on your host to the /home/vagrant/src directory on the VM

    /<pathToYourWorkSpace>/on-dev == /home/vagrant/src
	
This being said, it is currently a manual process to place the expected monorail repositories within on-dev so they will be reflected inside the VM.
The goal of this section is to provide a clear basic explination of each step needed to set up your git repositories with a common workflow.

1. git fork each repository.
..* on-http
..* on-core
..* on-taskgraph
..* on-tasks
..* on-tftp
..* on-dhcp-proxy
..* on-imagebuilder
..* on-statsd
..* on-syslog
..* on-tools

2. git clone each repository from your forks.

3. set up the upstream/master for each repository.

4. collect static files from bintray and place them into on-http & on-tftp (script this into ansible run, and have it placed onto VM)

5. Install dependicies (form VM, npm install in each repo)

6. Use nodeforman to turn on monorail.


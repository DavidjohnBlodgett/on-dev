## SUMMARY

This repository is a down-stream, personal test environment, I use for my contributions to the RackHD project.

It leverages the Vagrant Virtual machine I delivered to this group. The original project is used for demonstrating the basic functionality of the RachHD bare-metal deployments
by quickly orchestrating a simple RackHD management server and n number of PXE clients, complete with virtual networking under a VirtualBox environment.

If you are interested in the RackHD project and would like to learn more, visit our github page here: https://github.com/RackHD/RackHD where you can find
contact information and access to our slack community!

This is freely available for anyone to use and I will be updating it as my needs change.

## UPDATES

__Warning:__ At this time windows does not support the ability to create a shared directory between the host and the Monorail server.
We discovered issues when attempting dependency installation, there appears to be a known issue.

http://blog.prolificinteractive.com/2015/01/21/getting-vagrant-nodejs-windows-play-well-together/

https://harvsworld.com/2015/how-to-fix-npm-install-errors-on-vagrant-on-windows-because-the-paths-are-too-long/

Attempts have been made to implement fixes suggested, but was unable to resolve the errors.  

## UBUNTU / LINUX / MAC SETUP

Install the latest Vagrant & Virtual Box programs onto your host.
(we expect at least Vagrant 1.8.1 and Virtual Box 5.0)

https://www.vagrantup.com/downloads.html

https://www.virtualbox.org/wiki/Downloads

Clone RackHD repo to your local git directory.

    $ cd /<pathToYourWorkSpace>/
    $ git clone https://github.com/DavidjohnBlodgett/on-dev.git


Enter the build directory and create a new config.

    $ cd on-dev/build/
    $ cp config/monorail_rack.cfg.example config/monorail_rack.cfg

__Note:__ Edits can be made to this new file to adjust the number of pxe clients created.

Enter the /bin folder that holds the batch script

    $ cd bin/
    $ monorail_rack

__Note:__ This will import into Virtual box a monorail server VM and some number of PXE clients.

## WINDOWS SETUP

Install the latest Vagrant & Virtual Box programs onto your host.
(we expect at least Vagrant 1.8.1 and Virtual Box 5.0)

https://www.vagrantup.com/downloads.html

https://www.virtualbox.org/wiki/Downloads

Git clone the on-dev repo onto your system.

    $ cd /<pathToYourWorkSpace>/
    $ git clone https://github.com/DavidjohnBlodgett/on-dev.git

Enter the build directory & /bin folder that holds the batch script (this will import into Virtual box a monorail server VM and some number of PXE clients).

    $ cd on-dev/build/bin

Execute the monorail_rack setup.

    $ monorail_rack.bat

__Note:__ To change the number of PXE clients created at runtime, edit the monorail_rack.bat script and change the value for pxe_count.

Ssh into the monorail server.

    $ vagrant ssh dev_windows

Remove existing "demo" repositories.

    $ rm -rf /home/vagrant/src/*

Continue to the next section.

__Note:__ You will need to remain on the monorail server and ignore references to installing anything from the host's perspective. In addition, any references to "dev"
are to be replaced with "dev_windows"

## GIT FORK & GIT CLONE REPOSITORIES

For a Mac or Linux enviorment,the monorail server currently mounts your workspace directory found on your host to the /home/vagrant/src directory on the VM.

    /home/<user>/<pathToYourWorkSpace>/ == /home/vagrant/src

It is expected that this is the same directory you have downloaded the on-dev repository.

This being said, it is currently a manual process to place the expected monorail repositories within your workspace, so they will be reflected correctly inside the Virtual Machine.


The goal of this section is to provide a clear basic explanation of each step needed to set up your git repositories with a common workflow.

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
 - From the workspace directory, for each repository URL execute the following command. __Warning:__ Windows users must perform the below steps while logged into the monorail server and not from the host.
```
/home/<user>/<pathToYourWorkSpace>/$ git clone <URLtoYourFork>
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
$ cd /home/<user>/<pathToYourWorkSpace>/on-http/
$ git remote add upstream https://github.com/RackHD/on-http
```
 - Repeat the above step for each repository using the respective URL found in the list for step 1.
```
/<pathToYourWorkSpace>/<eachRepo>/$ git remote add upstream <RackHD_Repo_URL>
```
The advantage of setting up this upstream relationship, from your local repositories to the RackHD repositories, will be explained later under Use Cases.

4.Copy static files from Monorail server to respective locations within on-http & on-tftp
 - Ssh into the Monorail server.
```
/<pathToYourWorkSpace>/on-dev/build/bin/$ vagrant ssh dev
```
 - Make the common directory for on-http.
```
/home/vagrant/$ mkdir /home/vagrant/src/on-http/static/http/common/
```
 - Copy files to their expected locations.
```
$ cp /home/vagrant/tmp/common/* /home/vagrant/src/on-http/static/http/common/
```
```
$ cp /home/vagrant/tmp/tftp/* /home/vagrant/src/on-tftp/static/tftp/
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

6.Use nodeforman to turn on monorail (from the monorail server) /home/vagrant/.
 - From the home directory run nodeforman.
```
/home/vagrant/$ sudo nf start
```

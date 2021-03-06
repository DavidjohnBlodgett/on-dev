######################
# Vagrant File Start #
######################

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # RackHD SERVER
    config.vm.define "dev" do |target|
        target.vm.box = "rackhd/rackhd"
        target.vm.box_version = "0.16"
        target.vm.provider "virtualbox" do |v|
            v.memory = 2048
            v.cpus = 1
            v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all", "--ioapic", "on"]
        end

        target.vm.synced_folder "../", "/home/vagrant/src", type: "nfs"

        # NOTE: virtualbox shared folder syncing can be quite slow, but shared folders
        # can be configured as NFS mounts to the host instead.
        # To do so, append: `, type: "nfs"` to all of the target.vm.synced_folder commands
        # below, then on the host system, run `sudo nfsd start`.
        # Additionally, uncomment the below the other network configurations.

        # Create a public network, which generally matched to bridged network.
        # Bridged networks make the machine appear as another physical device on
        # your network.
        # target.vm.network :public_network

        # Specify optional interface to bridge when wanting to expose the instance to an
        # external network.  Useful for when discovering nodes externally.
        if ENV['BRIDGE_INTF']
           target.vm.network "public_network", ip: "172.31.128.1", bridge: "#{ENV['BRIDGE_INTF']}"
        else
           target.vm.network "private_network", ip: "172.31.128.1", virtualbox__intnet: "closednet"
        end
        target.vm.network "forwarded_port", guest: 8080, host: 9090
        target.vm.network "forwarded_port", guest: 5672, host: 9091
        target.vm.network "forwarded_port", guest: 9080, host: 9092
        target.vm.network "forwarded_port", guest: 8443, host: 9093
        config.vm.network "forwarded_port", guest: 3001, host: 3001 #node-inspector


        # For NFS mounts, a host only network is needed. Feel free to change the IP.
        target.vm.network "private_network", ip: "192.168.50.4"

        # If true, then any SSH connections made will enable agent forwarding.
        # Default value: false
        target.ssh.forward_agent = true

        target.vm.provision "shell", inline: <<-SHELL
        service isc-dhcp-server start
        service rsyslog stop
        echo manual | sudo tee /etc/init/rsyslog.override
        # sudo apt-get -y install python-software-properties
        # sudo apt-add-repository ppa:ansible/ansible
        # sudo apt-get -y update
        # sudo apt-get -y install ansible
        # ansible-playbook -i "local," -c local /home/vagrant/src/on-dev/dev.yml
        # sudo npm install -g n
        SHELL

    end
end

# vi: set ft=ruby

Vagrant.configure(2) do |config|
    config.vm.box = "cgc-linux-dev"
    config.vm.box_url = 'https://archive.darpa.mil/CyberGrandChallenge_Repo/release-cqe/boxes/cgc-linux-dev.box'

    # avoids 'stdin: is not a tty' error.
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" 

    # if you have a ~/.vimrc or ~/.gdbinit, copy those to the default user
    [".profile", ".bashrc", ".vimrc", ".gdbinit", ".quilt-dpkg"].each { |filename|
        local_path = "#{ ENV['HOME'] }/#{filename}"
        vm_path = "/home/vagrant/#{filename}"
        if File.file?(local_path)
            config.vm.provision "file", source: local_path, destination: vm_path
        end
    }

    config.vm.provision "shell", inline: "sudo su -c 'echo deb http://ftp.us.debian.org/debian/ wheezy main non-free contrib >> /etc/apt/sources.list'"
    config.vm.provision "shell", inline: "sudo su -c 'echo deb-src http://ftp.us.debian.org/debian/ wheezy main non-free contrib >> /etc/apt/sources.list'"
    
#    config.vm.provision :puppet do |puppet|
#        puppet.manifests_path  = "manifests"
#        puppet.manifest_file   = "site.pp"
#        puppet.module_path     = "modules"
#    end

    config.vm.provider :virtualbox do |vb|
        # vb.gui = true
        # vb.customize ["modifyvm", :id, "--cpus", "2"]
        vb.customize ["modifyvm", :id, "--memory", "1024"]
     end
end

# Vagrant 1.5 does not deal well with the SSH agent storing signed keys.
# This monkey-patch removes support for the agent until Vagrant 1.6 is
# available.
require 'net/ssh'
class Net::SSH::Authentication::KeyManager
    def use_agent?; false; end
    def use_agent=(agent); @use_agent = false; end
    def agent; nil; end
end
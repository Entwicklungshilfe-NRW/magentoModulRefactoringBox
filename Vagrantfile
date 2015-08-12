# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "deimosfr/debian-wheezy"

  config.vm.forward_port 80, 8080

    config.vm.share_folder "v-data", "/vagrant_data/www", "data"
    config.vm.share_folder "modman", "/vagrant_data/.modman", "modman"

  config.vm.provision :shell, :inline => "sudo apt-get update && sudo apt-get install puppet -y"

  config.vm.provision 'shell' do |s|
    s.path = 'puppet/shell/initial-setup.sh'
    s.args = '/vagrant/puppet'
  end
  config.vm.provision :shell do |s|
    s.path = 'puppet/shell/execute-files.sh'
    s.args = ['exec-once']
  end
  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file  = "base.pp"
     puppet.module_path    = "puppet/modules"
     #puppet.options        = "--verbose --debug"
  end

end

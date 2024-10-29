# -*- mode: ruby -*-
# vi: set ft=ruby :

$rhel = <<EOF
yum update -y
yum install -y https://yum.puppet.com/puppet8-release-el-9.noarch.rpm
yum install -y puppet-agent
yum install -y rubygems
yum install -y git
EOF

$debian = <<EOF
dpkg -s puppet-agent >/dev/null
if [ $? -ne 0 ]; then
  wget http://apt.puppet.com/puppet8-release-bullseye.deb
  dpkg -i puppet8-release-bullseye.deb
  apt-get update
  apt-get install -y puppet-agent
fi
EOF

$git = <<EOF
dpkg -s puppet-agent >/dev/null
if [ $? -ne 0 ]; then
  wget http://apt.puppet.com/puppet8-release-bullseye.deb
  dpkg -i puppet8-release-stretch.deb
  apt-get update
  apt-get install -y puppet-agent
fi
EOF
Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_guest = true

  config.vm.define "ol" do |ol|
    ol.vm.box = "bento/oracle-9"
    ol.vm.provision "shell", inline: $rhel
    ol.vm.hostname = "ol.example.com"
    ol.vm.network "private_network", ip: "10.12.1.10", netmask: "255.255.255.0"
  end

  config.vm.define "websrv" do |websrv|
    websrv.vm.box = "bento/oracle-9"
    websrv.vbguest.auto_update = false
    websrv.vm.provision "shell", inline: $rhel
    websrv.vm.hostname = "websrv.example.com"
    websrv.vm.network "forwarded_port", guest: 80, host: 8080
    websrv.vm.network "private_network", ip: "10.12.1.21", netmask: "255.255.255.0"
  end

  config.vm.define "git" do |git|
    git.vm.box = "debian/bullseye64"
    git.vm.provision "shell", inline: $git
    git.vm.hostname = "git.example.com"
    git.vm.network "private_network", ip: "10.12.1.5", netmask: "255.255.255.0"
  end

  config.vm.define "testnode" do |testnode|
    testnode.vm.box = "bento/oracle-9"
    testnode.vm.provision "shell", inline: $rhel
    testnode.vm.hostname = "testnode.example.com"
    testnode.vm.network "private_network", ip: "10.12.1.20", netmask: "255.255.255.0"
  end

  config.vm.define "puppet" do |puppet|
    puppet.vm.box = "bento/oracle-9"
    puppet.vm.provision "shell", inline: $rhel
    puppet.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "install/manifests"
      puppet.manifest_file = "puppetserver.pp"
    end
    puppet.vm.hostname = "puppet.example.com"
    puppet.hostmanager.aliases = %w(puppet puppetserver.example.com)
    puppet.vm.network "private_network", ip: "10.12.1.11", netmask: "255.255.255.0"
    puppet.vm.provider "vmware_desktop" do |v|
      v.memory = 3072
    end
  end
end

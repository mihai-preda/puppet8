# -*- mode: ruby -*-
# vi: set ft=ruby :

$rhel = <<EOF
yum install -y https://yum.puppet.com/puppet8-release-el-8.noarch.rpm
yum install -y puppet-agent
yum install -y rubygems
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

$ubuntu = <<EOF
dpkg -s puppet-agent >/dev/null
if [ $? -ne 0 ]; then
  wget http://apt.puppet.com/puppet8-release-jammy.deb
  dpkg -i puppet8-release-jammy.deb
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
    ol.vm.box = "oraclelinux/8"
    ol.vm.provision "shell", inline: $rhel
    ol.vm.hostname = "ol.example.com"
    ol.vm.network "private_network", ip: "10.11.1.10",
      virtualbox__intnet: "puppet"
  end

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "bento/ubuntu-22.04"
    ubuntu.vbguest.auto_update = false
    ubuntu.vm.provision "shell", inline: $ubuntu
    ubuntu.vm.hostname = "ubuntu.example.com"
    ubuntu.vm.network "forwarded_port", guest: 80, host: 8080
    ubuntu.vm.network "private_network", ip: "10.11.1.21",
      virtualbox__intnet: "puppet"
  end

  config.vm.define "git" do |git|
    git.vm.box = "debian/bullseye64"
    git.vm.provision "shell", inline: $git
    git.vm.hostname = "git.example.com"
    git.vm.network "private_network", ip: "10.11.1.5",
      virtualbox__intnet: "puppet"
  end

  config.vm.define "testnode" do |testnode|
    testnode.vm.box = "oraclelinux/8"
    testnode.vm.provision "shell", inline: $rhel
    testnode.vm.hostname = "testnode.example.com"
    testnode.vm.network "private_network", ip: "10.11.1.20",
      virtualbox__intnet: "puppet"
  end

  config.vm.define "puppet" do |puppet|
    puppet.vm.box = "oraclelinux/8"
    puppet.vm.provision "shell", inline: $rhel
    puppet.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "install/manifests"
      puppet.manifest_file = "puppetserver.pp"
    end
    puppet.vm.hostname = "puppet.example.com"
    puppet.hostmanager.aliases = %w(puppet puppetserver.example.com)
    puppet.vm.network "private_network", ip: "10.11.1.11",
      virtualbox__intnet: "puppet"
    puppet.vm.provider "virtualbox" do |v|
      v.memory = 4096
    end
  end
end

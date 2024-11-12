# Hands-On-Infrastructure-Automation-with-Puppet-8
Based on the course "Hands On Infrastructure Automation with Puppet 6" from Packt Publishing.

## [Section 1: Getting Started with Puppet](section1)

## [Section 2: Idempotence](section2)

## [Section 3: Trifecta](section3)

## [Section 4: Modules and Puppet Forge](section4)

## [Section 5: Installing a Website](section5)

## [Section 6: Extending Puppet](section6)

## [Section 7: Puppet Lookup](section7)

## [Conclusion / Summary](summary)

Create a local dev env by installing Vagrant, WMware Workstation Pro (free for personal use), git, and VSCode.
1. Install vagrant manually.
2. Install Vagrant VMware Utility 
  - https://developer.hashicorp.com/vagrant/docs/providers/vmware/vagrant-vmware-utility
3. Install vagrant plugins: 
  - vagrant plugin install vagrant-hostmanager
  - vagrant plugin install vagrant-vmware-desktop
### Switched from Virtual Box which fails to create networks, and is also buggy and slow causing vagrant up
### to time out if the process takes too long. I assume delays are caused by the bugginess of VB.
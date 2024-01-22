#purge packages instead of just removing one
#purging will remove all deps as well as conf files
package { ['httpd', 'httpd-tools', 'apr']:
  ensure => 'purged',
}

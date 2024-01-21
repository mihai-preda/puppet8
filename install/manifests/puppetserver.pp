package { 'puppetserver':
  ensure => installed,
}

service { 'puppetserver':
  ensure  => true,
  enable  => true,
  require => Package['puppetserver'],
}

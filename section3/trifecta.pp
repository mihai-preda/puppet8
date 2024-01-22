package { 'httpd':
  ensure => true,
}

service { 'httpd':
  ensure  => true,
  enable  => true,
  require => [Package['httpd'],File['index.html']],
}

file { 'index.html':
  ensure  => 'file',
  path    => '/var/www/html/index.html',
  content => epp('/home/vagrant/puppet8/section3/hello.epp'),
  require => Package['httpd'],
}

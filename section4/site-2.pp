# oracle renames EPEL to oracle-epel
# fact host name is not present in PP8. It's actually Host (stdlib)
concat { '/etc/motd': }

package { 'oracle-epel-release-el9':
  ensure => 'installed',
}

package { 'figlet':
  ensure  => 'installed',
  require => Package['oracle-epel-release-el9'],
}

exec { 'motd.host':
  path    => '/bin:/usr/bin',
  command => "figlet ${Host} >/etc/motd.host",
  creates => '/etc/motd.host',
  require => Package['figlet'],
}

exec { 'motd.warning':
  path    => '/bin:/usr/bin',
  command => "figlet '* WARNING *'>/etc/motd.warning",
  creates => '/etc/motd.warning',
  require => Package['figlet'],
}

concat::fragment { 'host':
  target  => '/etc/motd',
  source  => '/etc/motd.host',
  order   => '01',
  require => Exec['motd.host'],
}

concat::fragment { 'info':
  target  => '/etc/motd',
  content => "${fact('os.name')} ${fact('os.release.major')}\n",
  order   => '05',
}

$disclaimer = @(END)
  -----------------------------------------------------------
  This system is for the use of authorized users only.
  Individuals using this computer system without authority,
  or in excess of their authority, are subject to having all
  of their activities on the system monitored and recorded.
  This information will be shared with law enforcement should
  any wrong doing be suspected.
  -----------------------------------------------------------

  | END

concat::fragment { 'warning':
  target => '/etc/motd',
  source => '/etc/motd.warning',
  order  => '10',
}
concat::fragment { 'disclaimer':
  target  => '/etc/motd',
  content => $disclaimer,
  order   => '20',
}

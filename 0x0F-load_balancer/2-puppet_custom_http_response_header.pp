# Configures Nginx to add X-Served-By header with hostname
package { 'nginx':
  ensure => installed,
}

exec { 'update_apt':
  command => '/usr/bin/apt-get update',
  before  => Package['nginx'],
}

file_line { 'add_custom_header':
  path    => '/etc/nginx/nginx.conf',
  after   => 'http {',
  line    => "    add_header X-Served-By $::hostname;",
  require => Package['nginx'],
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
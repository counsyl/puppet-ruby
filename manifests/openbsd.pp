# == Class: ruby::openbsd
#
# Symbolic links to make Ruby easier on OpenBSD.
#
class ruby::openbsd inherits ruby::params {
  File {
    owner   => 'root',
    group   => 'wheel',
    require => Package['ruby'],
  }
  # OpenBSD leaves out nice things like symbolic links to
  # the default Ruby interpreter.
  file { '/usr/local/bin/ruby':
    ensure  => link,
    target  => "/usr/local/bin/ruby${suffix}",
  }
  file { '/usr/local/bin/erb':
    ensure  => link,
    target  => "/usr/local/bin/erb${suffix}",
  }
  file { '/usr/local/bin/irb':
    ensure  => link,
    target  => "/usr/local/bin/irb${suffix}",
  }
  file { '/usr/local/bin/rdoc':
    ensure  => link,
    target  => "/usr/local/bin/rdoc${suffix}",
  }
  file { '/usr/local/bin/ri':
    ensure  => link,
    target  => "/usr/local/bin/ri${suffix}",
  }
  file { '/usr/local/bin/testrb':
    ensure  => link,
    target  => "/usr/local/bin/testrb${suffix}",
  }
  file { '/usr/local/bin/gem':
    ensure  => link,
    target  => "/usr/local/bin/gem${suffix}",
  }
}

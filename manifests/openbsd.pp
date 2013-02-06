class ruby::openbsd {
  File {
    owner   => 'root',
    group   => 'wheel',
    require => Package['ruby'],
  }
  # OpenBSD leaves out nice things like symbolic links to
  # the default Ruby interpreter.
  file { '/usr/local/bin/ruby':
    ensure  => link,
    target  => '/usr/local/bin/ruby18',
  }
  file { '/usr/local/bin/erb':
    ensure  => link,
    target  => '/usr/local/bin/erb18',
  }
  file { '/usr/local/bin/irb':
    ensure  => link,
    target  => '/usr/local/bin/irb18',
  }
  file { '/usr/local/bin/rdoc':
    ensure  => link,
    target  => '/usr/local/bin/rdoc18',
  }
  file { '/usr/local/bin/ri':
    ensure  => link,
    target  => '/usr/local/bin/ri18',
  }
  file { '/usr/local/bin/testrb':
    ensure  => link,
    target  => '/usr/local/bin/testrb18',
  }
  file { '/usr/local/bin/gem':
    ensure  => link,
    target  => '/usr/local/bin/gem18',
    require => Package['gems'],
  }
}

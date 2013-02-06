# == Class: ruby::devel
#
# Installs the Ruby development headers.
#
class ruby::devel {
  include ruby::params
  if $ruby::params::devel {
    include sys::gcc
    package { $ruby::params::devel:
      ensure  => installed,
      alias   => 'ruby-devel',
      require => Class['sys::gcc'],
    }
  }
}

# == Class: ruby::devel
#
# Installs the Ruby development headers.
#
class ruby::devel(
  $package = $ruby::params::devel,
) inherits ruby::params {
  if $package {
    include sys::gcc
    package { $package:
      ensure  => installed,
      alias   => 'ruby-devel',
      require => Class['sys::gcc'],
    }
  }
}

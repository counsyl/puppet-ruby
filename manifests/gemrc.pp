# == Class: ruby::gemrc
#
# Creates a system-wide gem resource file.
#
class ruby::gemrc(
  $path='/etc/gemrc',
  $rdoc=false,
  $ri=false,
) {
  # Set the binary directory for ruby gems so they are in the system PATH.
  include sys
  case $::operatingsystem {
    openbsd: {
      $bindir = '/usr/local/bin'
    }
    default: {
      $bindir = '/usr/bin'
    }
  }

  # Default gem resource file.
  file { $path:
    ensure    => file,
    owner     => 'root',
    group     => $sys::root_group,
    mode      => '0644',
    content   => template('ruby/gemrc.erb'),
    require   => Package['ruby'],
  }
}

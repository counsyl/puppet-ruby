# == Define: ruby::debian::alternative
#
# Defined type (not a public API) for managing the Ruby distribution
# alternatives on Debian.  The name of the resource is the version
# of the Ruby C Runtime to make the default.
#
define ruby::debian::alternative(
  $gem_path  = "/usr/bin/gem${name}",
  $ruby_path = "/usr/bin/ruby${name}",
  $exec_path = ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
) {
  exec { "update-alternative gem${name}":
    command => "update-alternatives --set gem ${gem_path}",
    unless  => "test /etc/alternatives/gem -ef '${gem_path}'",
    path    => $exec_path,
  }

  exec { "update-alternative ruby${name}":
    command => "update-alternatives --set ruby ${ruby_path}",
    unless  => "test /etc/alternatives/ruby -ef '${ruby_path}'",
    path    => $exec_path,
  }
}

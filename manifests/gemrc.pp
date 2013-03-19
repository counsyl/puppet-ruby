# == Class: ruby::gemrc
#
# Creates a system-wide gem resource file.
#
class ruby::gemrc(
  $bindir   = $ruby::params::gem_bindir,
  $path     = $ruby::params::gem_conf,
  $rdoc     = $ruby::params::gem_rdoc,
  $ri       = $ruby::params::gem_ri,
  $owner    = 'root',
  $sources  = ['https://rubygems.org/'],
  $template = 'ruby/gemrc.erb',
) inherits ruby::params {
  # So we can know the root group of the platform.
  include sys

  # Default gem resource file.
  file { $path:
    ensure  => file,
    owner   => $owner,
    group   => $sys::root_group,
    mode    => '0644',
    content => template($template),
    require => Package['ruby'],
  }
}

# === Class: ruby::rake
#
# Installs Rack: a Ruby Webserver interface
#
class ruby::rack(
  $package  = 'rack',
  $version  = 'installed',
  $provider = 'gem',
) {
  include ruby
  package { $package:
    ensure   => $version,
    provider => $provider,
    require  => Class['ruby'],
  }
}

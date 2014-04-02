# == Class: ruby::passenger
#
# This class installs Phusion Passenger, which is used to deploy Ruby web
# applications.
#
class ruby::passenger(
  $package  = 'passenger',
  $provider = 'gem',
  $version  = '4.0.40',
) {
  include ruby::rack
  include ruby::rake

  # Root location of where passenger gem is installed.
  $root = "${ruby::gemhome}/passenger-${version}"

  # Locations of shared library changed between 3.x and 4.x.
  if versioncmp($version, '4.0.0') >= 0 {
    $apache_module = "${root}/buildout/apache2/mod_passenger.so"
  } else {
    $apache_module = "${root}/ext/apache2/mod_passenger.so"
  }

  package { $package:
    ensure   => $version,
    provider => $provider,
    require  => Class['ruby', 'ruby::rack', 'ruby::rake'],
  }
}

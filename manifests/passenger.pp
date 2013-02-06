# == Class: ruby::passenger
#
# This class installs Phusion Passenger, which is used to deploy ruby web
# applications.
#
class ruby::passenger(
  $package  = 'passenger',
  $provider = 'gem',
  $version  = '3.0.19',
) {
  include ruby::rack
  include ruby::rake
  $root = "${ruby::gemhome}/passenger-${version}"
  package { $package:
    ensure   => $version,
    provider => $provider,
    require  => [ Class['ruby'],
                  Package['rack'],
                  Package['rake'],
                  ]
  }
}

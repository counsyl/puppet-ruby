# === Class: ruby::rake
#
# Installs RAKE, a simple ruby build program similar to make.
#
class ruby::rake(
  $package='rake',
  $version='installed',
  $provider='gem',
) {
  include ruby
  package { $package:
    ensure   => $version,
    provider => $provider,
    require  => Class['ruby'],
  }
}

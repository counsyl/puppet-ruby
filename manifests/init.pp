# == Class: ruby
#
# Installs the Ruby language runtime.  Defaults to the most stable version
# for the platform, preferring 1.8.7.
#
# === Parameters
#
# Overriding any of these parameters is considered advanced usage.
#
# [*gems*]
#  The name of the Ruby Gems package.
#
# [*gemhome*]
#  The location of GEM_HOME.
#
# [*package*]
#  The name of the Ruby runtime package.
#
# [*extras*]
#  Any extra packages to install along with the Ruby runtime.
#
# [*provider*]
#  The package provider.
#
# [*source*]
#  The package source.
#
class ruby (
  $gems     = $ruby::params::gems,
  $gemhome  = $ruby::params::gemhome,
  $package  = $ruby::params::package,
  $extras   = $ruby::params::extras,
  $provider = $ruby::params::provider,
  $source   = $ruby::params::source,
) inherits ruby::params {

  if $::operatingsystem == 'OpenBSD' {
    $ensure = $ruby::params::ensure
  } else {
    $ensure = 'installed'
  }

  # The main Ruby package.
  package { $package:
    ensure   => $ensure,
    alias    => 'ruby',
    provider => $provider,
    source   => $source,
  }

  # Ruby gems.
  if $gems {
    package { $gems:
      ensure    => installed,
      alias     => 'gems',
      provider  => $provider,
      source    => $source,
      require   => Package['ruby'],
    }
  }

  # Any extras to round out the installation.
  if $extras {
    package { $extras:
      ensure   => installed,
      provider => $provider,
      source   => $source,
      require  => Package['ruby'],
    }
  }

  # OpenBSD needs some extra files to complete the experience.
  if $::operatingsystem == 'OpenBSD' {
    include ruby::openbsd
  }

  # Finally, create a default gem resource file.
  include ruby::gemrc
}

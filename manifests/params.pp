# == Class: ruby::params
#
# Default parameters for the Ruby runtime.
#
class ruby::params {
  case $::osfamily {
    openbsd: {
      include sys::openbsd::pkg
      $package = 'ruby'
      $gems = false

      case $::kernelmajversion {
        '5.9': {
          $ensure = '2.2.4'
          $gemhome = '/usr/local/lib/ruby/gems/2.2/gems'
        }
        '5.8': {
          $ensure = '2.2.2p0'
          $gemhome = '/usr/local/lib/ruby/gems/2.2/gems'
        }
        '5.7': {
          $ensure = '2.1.5p0'
          $gemhome = '/usr/local/lib/ruby/gems/2.1/gems'
        }
        '5.6': {
          $ensure = '2.0.0.481'
          $gemhome = '/usr/local/lib/ruby/gems/2.0/gems'
        }
        '5.5': {
          $ensure = '1.9.3.484p0'
          $gemhome = '/usr/local/lib/ruby/gems/1.9.1/gems'
        }
        '5.4': {
          $ensure = '1.9.3.484'
          $gemhome = '/usr/local/lib/ruby/gems/1.9.1/gems'
        }
        default: {
          fail("Unsupported version of OpenBSD: ${::kernelmajversion}.\n")
        }
      }
      $suffix = inline_template("<%= @ensure.split('.')[0..1].join('') %>")
    }
    solaris: {
      include sys::solaris
      $package  = 'runtime/ruby-18'
      $provider = 'pkg'
      $gemhome  = '/var/ruby/1.8/gem_home/gems'
    }
    debian: {
      # There have been multiple changes to default Ruby packages over
      # the years, set up different comparison variables based on LSB
      # major release numbers.
      if $::operatingsystem == 'Ubuntu' {
        $libruby_compare = '11'
        $ruby18_compare = '11'
        $ruby23_compare = '16'
      } else {
        $libruby_compare = '6'
        $ruby18_compare = '6'
      }

      # Facter 2.2+ changed lsbmajdistrelease fact, e.g., now returns
      # '12.04' instead of '12' for Ubuntu precise.
      $lsb_major_release = regsubst($::lsbmajdistrelease, '^(\d+).*', '\1')

      if versioncmp($lsb_major_release, $ruby18_compare) > 0 {
        if versioncmp($lsb_major_release, $ruby23_compare) >= 0 {
          $package_version = '2.3'
        } else {
          $package_version = '1.9.1'
        }
        $gems = false
        $libruby = 'libruby'
        $extras = [$libruby]
      } else {
        $package_version = '1.8'
        $gems = 'rubygems'
        $libshadow = "libshadow-ruby${package_version}"
        # The `libopenssl-ruby` package was merged into `libruby`
        # in Debian 6/Ubuntu 11.
        if versioncmp($lsb_major_release, $libruby_compare) >= 0 {
          $libruby = 'libruby'
        } else {
          $libruby = 'libopenssl-ruby'
        }
        $extras = [$libruby, $libshadow]
      }

      $package = "ruby${package_version}"
      $gemhome = "/var/lib/gems/${package_version}/gems"
      $devel   = "${package}-dev"
    }
    redhat: {
      $package = 'ruby'
      $gems    = 'rubygems'
      $gemhome = '/usr/lib/ruby/gems/1.8/gems'
      $devel   = 'ruby-devel'
    }
    default: {
      fail("Do not know how to install/configure Ruby on ${::osfamily}.\n")
    }
  }

  # Default parameters for gems.
  $gem_bindir  = '/usr/local/bin'
  $gem_conf    = '/etc/gemrc'
  $gem_rdoc    = false
  $gem_ri      = false
  $gem_sources = ['https://rubygems.org/']
}
